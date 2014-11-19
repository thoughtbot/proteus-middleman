class Middleman::Extensions::ViewsDirectory < Middleman::Extension
  register :views
  option   :views_dir, 'views', 'Directory for site views'

  def manipulate_resource_list resources
    views_dir = normalise options.views_dir

    # Build an array of resources from the directory
    views = Dir.glob(views_dir + '/**/*', File::FNM_DOTMATCH).map do |sourcepath|
      filename = sourcepath.sub(views_dir + ?/, '')
      next if File.directory?(sourcepath) || filename[0] == "_"
      buildpath = app.sitemap.extensionless_path filename
      Middleman::Sitemap::Resource.new app.sitemap, buildpath, sourcepath
    end

    # Remove views directory
    resources.reject! do |dir|
      Dir.glob(views_dir + '/*', File::FNM_DOTMATCH).include? dir.source_file
    end

    # Add the new views to the resource list
    resources.concat views.compact
  end

  private

  def normalise(directory)
    if Pathname(directory).relative?
      File.expand_path File.join app.source_dir, directory
    else
      File.expand_path directory
    end
  end
end
