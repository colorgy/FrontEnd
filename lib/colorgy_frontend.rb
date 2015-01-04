require "colorgy_frontend/version"

module ColorgyFrontend
  module Rails
    if !defined? Middleman
      class Engine < ::Rails::Engine
      end
    end
  end
end
