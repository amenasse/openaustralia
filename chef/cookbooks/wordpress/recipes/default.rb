include_recipe "apache"

# Currently wordpress must be installed manually, as the package provider doesn't support multiple packages with the
# same name.
#package "www/wordpress" do
#  source "ports"
#end

template "/usr/local/www/data/wordpress/wp-config.php" do
  source "wp-config.php.erb"
  mode 0644
end

directory "/www/blog"

link "/www/blog/html" do
  to "/usr/local/www/data/wordpress"
end

template "site.conf" do
  path "/usr/local/etc/apache22/sites-available/blog"
  source "httpd.conf.erb"
  mode 0644
  owner "root"
  group "wheel"
end
  
apache_site "blog"

# Install Greenway 3c theme.
# Currently this has to be done manually, due to chef-solo not handling the remote_directory resource correctly
#remote_directory "/usr/local/www/data/wordpress/wp-content/themes/greenway-3c" do
#  source "default/greenway-3c"
#end
