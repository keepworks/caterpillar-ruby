module Caterpillar
  class InstallGenerator < Rails::Generators::Base
    source_root(File.expand_path(File.dirname(__FILE__)))

    def copy_initializer
      copy_file 'initializer.rb', 'config/initializers/caterpillar.rb'
    end
  end
end
