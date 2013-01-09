require 'mongoid'

module ReTrack
  class Engine < ::Rails::Engine
    isolate_namespace ReTrack
  end
end
