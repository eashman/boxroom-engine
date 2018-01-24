module Boxroom
  class Engine < ::Rails::Engine
    isolate_namespace Boxroom

    initializer 'boxroom.assets.precompile' do |app|
      app.config.assets.precompile += %w( boxroom/*.png )
    end
  end
end
