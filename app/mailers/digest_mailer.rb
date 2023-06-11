# frozen_string_literal: true

class DigestMailer < ApplicationMailer
  helper :accounts
  helper :statuses
  helper :routing

  before_action do
    @account = params[:account]
  end

  def weekly
    @weekly_highlights = weekly_highlights(@account)

    locale_for_account @account do
      mail to: email_address_with_name(@account.user_email, @account.username)
    end
  end

  private

  def weekly_highlights(account)
    Status.joins(:trend_highlight, :account)
          .merge(Account.discoverable)
          .where(StatusTrendHighlight.arel_table[:period].gteq(10.days.ago))
          .not_excluded_by_account(account)
          .not_domain_blocked_by_account(account)
          .reorder(Arel::Nodes::Case.new.when(StatusTrendHighlight.arel_table[:language].in(account.chosen_languages || account.user_locale)).then(1).else(0).desc, score: :desc)
          .limit(20)
  end
end
