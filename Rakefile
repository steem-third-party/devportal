require 'jekyll'
require 'jekyll-import'
load '_plugins/steem_importer.rb'

namespace :scrape do
  desc "Scrape steemjs docs"
  task :javascript do

  end

  desc "Scrape pysteem docs"
  task :python do
  end
end

namespace :import do
  desc "Import Steem Post"
  task :steem, [:author, :permlink] do |t, args|
    JekyllImport::Importers::Steem.run({
      "author" => args[:author],
      "permlink" => args[:permlink],
    })
  end
end
