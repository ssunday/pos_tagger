import 'lib/pos_tagger.rb'
require 'json'

namespace :pos_tagger do
  desc 'Given a file path, returns tag information for text'
  task :tag_text, [:path, :order_by] do |t, args|
    path = args[:path]
    order_by = args[:order_by]

    if File.exist?(path)
      data = PosTagger.new(path, order_by: order_by).text_summary
      puts JSON.pretty_generate(data)
    else
      puts 'File does not exist. Aborting!'
    end
  end
end
