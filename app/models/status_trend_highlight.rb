# frozen_string_literal: true

# == Schema Information
#
# Table name: status_trend_highlights
#
#  id         :bigint(8)        not null, primary key
#  period     :datetime         not null
#  status_id  :bigint(8)        not null
#  account_id :bigint(8)        not null
#  score      :float            default(0.0), not null
#  language   :string
#

class StatusTrendHighlight < ApplicationRecord
  belongs_to :status
  belongs_to :account
end
