module JekyllImport
  module Importers
    class Steem < Importer
      def self.require_deps
        JekyllImport.require_with_fallback(%w[
          safe_yaml
          radiator
        ])
      end

      def self.specify_options(c)
        c.option 'author', '--author <author>', 'Blog Author'
        c.option 'permlink', '--permlink <permlink>', 'Blog Permlink'
      end

      def self.process(opts)
        options = {
          author: opts.fetch('author', ''),
          permlink: opts.fetch('permlink', ''),
        }

        api = Radiator::Api.new
        api.get_content(*options.values) do |content|
          if content.nil?
            puts "Unknown post: #{options}"
            return
          end
          
          formatted_date = Time.parse(content.created + 'Z')
          post_name = "#{content.author}_#{content.permlink.gsub('-', '_')}"
          header = {
            "title"  => content.title,
            "layout" => "default",
            "tag" => content.parent_permlink
          }
          
          FileUtils.mkdir_p("_posts")
          
          File.open("_posts/#{post_name}.md", "w") do |f|
            f.puts header.to_yaml
            f.puts "---\n\n"
            f.puts content.body
          end
        end
      end
    end
  end
end
