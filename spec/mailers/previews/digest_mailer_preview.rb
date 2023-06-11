# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/digest_mailer

class DigestMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/digest_mailer/weekly
  def weekly
    DigestMailer.with(account: Account.local.first).weekly
  end
end
