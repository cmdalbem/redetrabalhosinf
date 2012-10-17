require 'test_helper'

class MailerTest < ActionMailer::TestCase
  test "regconfirmation" do
    mail = Mailer.regconfirmation
    assert_equal "Regconfirmation", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
