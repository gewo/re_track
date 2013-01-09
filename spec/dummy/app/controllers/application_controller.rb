class ApplicationController < ActionController::Base
  protect_from_forgery

  include ReTrack::Tracker
end
