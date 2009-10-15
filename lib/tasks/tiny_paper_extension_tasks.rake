namespace :radiant do
  namespace :extensions do
    namespace :tiny_paper do
      
      desc "Runs the migration of the Tiny Paper extension"
      task :migrate => :environment do
        puts "This extension does not affect the database. Nothing done."
      end
      
      desc "Copies public assets of the Tiny Paper to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        puts "Copying assets from TinyPaperExtension"
        Dir[TinyPaperExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(TinyPaperExtension.root, '')
          directory = File.dirname(path)
          mkdir_p RAILS_ROOT + directory, :verbose => false
          cp file, RAILS_ROOT + path, :verbose => false
        end
      end  
    end
  end
end
