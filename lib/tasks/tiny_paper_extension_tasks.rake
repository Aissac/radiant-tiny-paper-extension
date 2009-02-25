namespace :radiant do
  namespace :extensions do
    namespace :tiny_paper do
      
      desc "Runs the migration of the Tiny Paper extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          TinyPaperExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          TinyPaperExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Tiny Paper to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        puts "Copying assets from TinyPaperExtension"
        Dir[TinyPaperExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(TinyPaperExtension.root, '')
          directory = File.dirname(path)
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end  
    end
  end
end
