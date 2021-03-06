# Rails::Generators::Base dont need a name
# Rails::Generators::NamedBase need a name
module WeixinRailsMiddleware
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../../templates', __FILE__)

      desc 'Creates a Dashing initializer for your application.'

      def install
        route 'mount WeixinRailsMiddleware::Engine, at: WeixinRailsMiddleware.config.engine_path'
      end

      def copy_initializer
        template 'initializer.rb', 'config/initializers/weixin_rails_middleware.rb'
      end

      def configure_application
        application <<-APP
    config.to_prepare do
      # Load application's model / class decorators
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end
        APP
      end

      def copy_decorators
        template 'weixin_controller.rb', 'app/decorators/controllers/weixin_rails_middleware/weixin_controller_decorator.rb'
      end

    end
  end
end