class Mailer < ActionMailer::Base
  default from: "redesocialinf@heroku.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mailer.regconfirmation.subject
  #
  def regconfirmation(person)
    @person = person

    mail to: person.email, subject: "Hello"
  end
end
