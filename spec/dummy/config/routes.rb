Rails.application.routes.draw do

  resources :users


  mount ReTrack::Engine => "/re_track"
end
