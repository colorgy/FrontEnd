require "colorgy_frontend/version"

module ColorgyFrontend
  class << self
    def load!
      require "bourbon"
      require "neat"
      require "bootstrap-sass"
    end
  end

  module Rails
    if !defined? Middleman
      class Engine < ::Rails::Engine
      end
    end
  end
end

ColorgyFrontend.load!
