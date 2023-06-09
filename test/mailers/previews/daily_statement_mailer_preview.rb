# Preview all emails at http://localhost:3000/rails/mailers/daily_statement_mailer
class DailyStatementMailerPreview < ActionMailer::Preview
  def export
    DailyStatementMailer.export(5, "monthly")
  end
end
