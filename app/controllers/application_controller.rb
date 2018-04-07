class ApplicationController < ActionController::Base
  # Change from :exception to :null_session to avoid CSRF issues w/ API
  protect_from_forgery with: :null_session
end
