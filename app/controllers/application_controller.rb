# frozen_string_literal: true

class ApplicationController < ActionController::Base
    # TODO Implement user auth
    protect_from_forgery with: :null_session
end
