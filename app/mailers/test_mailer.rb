class TestMailer < ApplicationMailer
  default from: 'support@gatecitysoftware.com'

  def hello
    mail(
      subject: 'Hello from Postmark',
      to: 'support@gatecitysoftware.com',
      from: 'support@gatecitysoftware.com',
      html_body: '<strong>Hello</strong> dear Postmark user.',
      track_opens: 'true',
      message_stream: 'outbound'
    )
  end
end
