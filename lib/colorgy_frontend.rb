require "colorgy_frontend/version"

module ColorgyFrontend
  class << self
    def load!
      require "bourbon"
      require "neat"
      require "bootstrap-sass"
      if defined?(::Sprockets)
        Sprockets.append_path(stylesheets_path)
        Sprockets.append_path(fonts_path)
        Sprockets.append_path(javascripts_path)
        Sprockets.append_path(images_path)
      end

    end

    # Paths
    def gem_path
      @gem_path ||= File.expand_path '..', File.dirname(__FILE__)
    end

    def assets_path
      @assets_path ||= File.join gem_path, 'assets'
    end

    def stylesheets_path
      File.join assets_path, 'stylesheets'
    end

    def fonts_path
      File.join assets_path, 'fonts'
    end

    def javascripts_path
      File.join assets_path, 'javascripts'
    end

    def images_path
      File.join assets_path, 'images'
    end
  end

  module Rails
    if defined?(::Rails)
      class Engine < ::Rails::Engine
        initializer 'frontend.assets.precompile' do |app|
          %w(stylesheets fonts javascripts images).each do |sub|
            app.config.assets.paths << root.join('assets', sub).to_s
          end

          app.config.assets.precompile << %r(colorgy/.+\.(?:png|gif|jpg|eot|svg|ttf|woff)$)
        end
      end
    end
  end
end

ColorgyFrontend.load!
