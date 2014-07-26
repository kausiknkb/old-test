require 'minitest/spec'

describe_recipe 'httpd::_httpd' do

  include MiniTest::Chef::Assertions
  include MiniTest::Chef::Context
  include MiniTest::Chef::Resources

  describe "files" do
    # Test all the settings specific to the Example httpd.conf first
    [
      "ServerTokens OS",
      "Timeout 60",
      "KeepAlive On",
      "MaxKeepAliveRequests 0",
      "KeepAliveTimeout 20",
      "IfModule worker.c",
      "MaxClients 300",
      "MinSpareThreads 25",
      "MaxSpareThreads 75",
      "ThreadsPerChild 25",
      "ExtendedStatus On",
      "UseCanonicalName Off",
      "DocumentRoot \"/blah/html/live\"",
    ].each do |conf|
    it "sets **** #{conf} **** in the httpd.conf" do
        file("/etc/httpd/conf/httpd.conf").must_include(conf)
    end
  end
    it "creates the htgroup file" do
      file("/etc/httpd/htgroup").must_include("blah:blah")
    end

    it "creates the dav file" do
      file("/etc/httpd/conf.d/dav.conf").must_include("<Location /live/>")
    end
    it "creates the rewrites file" do
      file("/etc/httpd/conf.d/rewrites.conf").must_include("RewriteEngine On")
    end
    it "creates the cache-control file" do
      file("/etc/httpd/conf.d/cache-control.conf").must_exist
    end
    describe "creates the origin docroot of /blah/html/live" do
      let(:config) { directory("/blah/html/live") }
      it { config.must_have(:mode, "775") }
      it { config.must_have(:owner, "root") }
      it { config.must_have(:group, "apache") }
    end
  end
end
