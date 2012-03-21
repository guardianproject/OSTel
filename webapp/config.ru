$: << './'
require "signup"
CONTACT_EMAIL = ''
DESTINATION_EMAIL = ''
GMAIL_USERNAME = ''
GMAIL_PASSWORD = ''

use Rack::ShowExceptions

run Sinatra::Application
