class SampleMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.sample_mailer.create_message.subject
  #
  def create_message
    @greeting = "Hi"

    mail to: "jdmars.00@gmail.com",
         subject: "New comment has been generated"
  end
end
