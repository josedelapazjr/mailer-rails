1. Create a new rails projects

		rails new mailer --skip-active-record

2. In development.rb, change the settings from
 
		FROM: 		
 		config.action_mailer.raise_delivery_errors = false
 		TO:
 		config.action_mailer.raise_delivery_errors = true
 	
3. Create a config file under config/smtp.yml.

		development:
  			gmail_username: <gmail username>
  			gmail_password: <gmail password> 

4. Load the file in environment.rb, before the Rails.application.initialize line:

		SMTP_CONFIG = YAML.load_file("#{Rails.root}/config/smtp.yml")[::Rails.env]
		
		# Initialize the Rails application.
		Rails.application.initialize!   			

5. In development.rb, add the following SMTP settings:

		# SMTP settings for gmail
	  	config.action_mailer.smtp_settings = {
		    :address              => "smtp.gmail.com",
		    :port                 => 587,
		    :user_name            => SMTP_CONFIG['gmail_username'],,
		    :password             => SMTP_CONFIG['gmail_password'],
		    :authentication       => "plain",
		    :enable_starttls_auto => true,
		    :openssl_verify_mode  => 'none'
		}
	
	  	config.action_mailer.default_url_options = {host: "localhost:3000"}		
	 	
6. Generate a mailer

 		rails g mailer SampleMailer create_message	
7. Under the create_message message of the SampleMailer, write the following:

		@greeting = "Hi"

    	mail to: "jdmars.00@gmail.com",
         	subject: "New comment has been generated" 
         	
8. You can check the preview by access the following link:

		http://localhost:3000/rails/mailers/sample_mailer      
		
9. Now you can test the mailer by using rails console.

		rails console
		
10. Create a new message

		COMMAND:
		new_mail = SampleMailer.create_message
		
		OUTPUT:
	  	Rendered sample_mailer/create_message.html.erb within layouts/mailer (0.1ms)
	  	Rendered sample_mailer/create_message.text.erb within layouts/mailer (0.1ms)
	
		SampleMailer#create_message: processed outbound mail in 36.8ms
	 	=> #<Mail::Message:70195998331660, Multipart: true, Headers: <From: ehardware.merkado@gmail.com>, <To: jdmars.00@gmail.com>, <Subject: New comment has been generated>, <Mime-Version: 1.0>, <Content-Type: multipart/alternative; boundary="--==_mimepart_578b56286558c_43e33fd7c485e1f899d3"; charset=UTF-8>>
		
11. Send the created message.		 		
		
		COMMAND:
		new_mail.deliver_now
		
		OUTPUT:
		Sent mail to jdmars.00@gmail.com (81.4ms)
		Date: Sun, 17 Jul 2016 19:59:29 +1000
		From: ehardware.merkado@gmail.com
		To: jdmars.00@gmail.com
		Message-ID: <578b5701dfe20_43e33fd7c485e1f81002c@Joe-PC.local.mail>
		Subject: New comment has been generated
		Mime-Version: 1.0
		Content-Type: multipart/alternative;
		 boundary="--==_mimepart_578b56286558c_43e33fd7c485e1f899d3";
		 charset=UTF-8
		Content-Transfer-Encoding: 7bit
		
		
		----==_mimepart_578b56286558c_43e33fd7c485e1f899d3
		Content-Type: text/plain;
		 charset=UTF-8
		Content-Transfer-Encoding: 7bit
		
		SampleMailer#send_message
		
		Hi, find me in app/views/sample_mailer/send_message.text.erb
		
		
		----==_mimepart_578b56286558c_43e33fd7c485e1f899d3
		Content-Type: text/html;
		 charset=UTF-8
		Content-Transfer-Encoding: 7bit
		
		<html>
		  <body>
		    <h1>Sample mail</h1>
		
		<p>
		  Hi, find me in app/views/sample_mailer/send_message.html.erb
		</p>
		
		  </body>
		</html>
		
		----==_mimepart_578b56286558c_43e33fd7c485e1f899d3--
		
		 => #<Mail::Message:70195998331660, Multipart: true, Headers: <Date: Sun, 17 Jul 2016 19:59:29 +1000>, <From: ehardware.merkado@gmail.com>, <To: jdmars.00@gmail.com>, <Message-ID: <578b5701dfe20_43e33fd7c485e1f81002c@Joe-PC.local.mail>>, <Subject: New comment has been generated>, <Mime-Version: 1.0>, <Content-Type: multipart/alternative; boundary="--==_mimepart_578b56286558c_43e33fd7c485e1f899d3"; charset=UTF-8>, <Content-Transfer-Encoding: 7bit>>	