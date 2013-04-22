require 'rubygems'
require 'sitemap_generator'

SitemapGenerator::Sitemap.default_host = "http://" + SITE_URL
SitemapGenerator::Sitemap.create do
  add '/', :changefreq => 'daily', :priority => 1
  add '/about', :changefreq => 'monthly', :priority => 0.9
  add '/projetos', :changefreq => 'daily', :priority => 0.8
  add '/pessoas', :changefreq => 'daily', :priority => 0.7
end
SitemapGenerator::Sitemap.ping_search_engines # called for you when you use the rake task