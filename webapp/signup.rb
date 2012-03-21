require 'rubygems'
require 'sinatra'
require 'net/smtp'

get '/' do
  erb :index
end

post '/send_mail' do
  date = Time.now
  to = params['email']
  name = params['name']
  if (params['pub_key'])
    pub_key = params['pub_key']
  else
    pub_key = "User did not provide a public key"
  end
  subject = "#{name} has requested an account on OSTel"
  body = <<EOF
"\"#{name}\" <#{to}> has requested an account on OSTel at #{date} from #{request.ip}"
\n
#{pub_key}
EOF
  smtp = Net::SMTP.new 'smtp.gmail.com', 587
  smtp.enable_starttls
  smtp.start("gmail.com", GMAIL_USERNAME, GMAIL_PASSWORD, :login) do
      smtp.send_message("Subject: #{subject}\n\n#{body}", DESTINATION_EMAIL, CONTACT_EMAIL)
  end
  redirect to('/thanks'), 303
end

get '/thanks' do
  erb :thanks
end
