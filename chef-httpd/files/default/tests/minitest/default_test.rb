require 'minitest/spec'

describe_recipe 'httpd::default' do

  # It's often convenient to load these includes in a separate helper along with
  # your own helper methods, but here we just include them directly:
  include MiniTest::Chef::Assertions
  include MiniTest::Chef::Context
  include MiniTest::Chef::Resources

  describe "packages" do
    it "installs httpd" do
      package("httpd").must_be_installed
    end
  end

  describe "files" do
    it "configures /etc/httpd/conf/httpd.conf" do
      file("/etc/httpd/conf/httpd.conf").must_exist
    end

    it "sets the correct binary type" do
      file("/etc/sysconfig/httpd").must_include("httpd.worker")
    end

    it 'creates the conf.d directory' do
      directory("#{node['httpd']['dir']}/conf.d").must_exist.with(:mode, "755")
    end

    it 'creates the logs directory' do
      directory(node['httpd']['log_dir']).must_exist
    end

    it 'creates the document root' do
      directory(node['httpd']['docroot']).must_exist
    end

    #it 'creates the htaccess file' do
    #  file("/etc/httpd/.htaccess").must_exist.with()
    #end

    it 'creates the sysconfig-httpd file' do
      file("etc/sysconfig/httpd").must_exist.must_include(node['httpd']['binary'])
    end
  end

  describe "services" do
    it "configures the httpd services"do
      service("httpd").must_be_running
    end
    it "starts on boot" do
      service("httpd").must_be_enabled
    end
  end
end

