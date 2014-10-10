activate :bourbon
activate :neat
activate :directory_indexes
activate :relative_assets

set :relative_links, true
set :css_dir, 'assets/stylesheets'
set :js_dir, 'assets/javascripts'
set :images_dir, 'assets/images'
set :layout, 'layouts/application'

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

configure :development do
 activate :livereload
end

# Relative assets needed to deploy to Github Pages
configure :build do
  activate :relative_assets
end

# Configuration options: https://github.com/karlfreeman/middleman-deploy
# Deploys to 'origin' on a 'gh-pages' branch
activate :deploy do |deploy|
  deploy.build_before = true
  deploy.method = :git
end
