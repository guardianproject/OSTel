$: << './'
require "signup"
FROM_ADDRESS = ''
TO_ADDRESS = ''
GMAIL_USERNAME = ''
GMAIL_PASSWORD = ''

use Rack::ShowExceptions

run Sinatra::Application
