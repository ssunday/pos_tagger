require 'pos_text_tagger'
require 'json'

namespace :pos_tagger do
  desc 'Given a file path, returns tag information for text'
  task :tag_text, [:path, :order_by, :limit] do |_t, args|
    path = args[:path]

    if File.exist?(path)
      tagger = PosTextTagger.new(
        args[:path],
        order_by: args[:order_by],
        limit: args.fetch(:limit, 10).to_i
      )
      data = tagger.text_summary
      puts JSON.pretty_generate(data)
    else
      puts 'File does not exist. Aborting!'
    end
  end

  task :proper_nouns, [:path, :order_by, :limit] do |_t, args|
    path = args[:path]

    if File.exist?(path)
      tagger = PosTextTagger.new(
        path,
        order_by: args[:order_by],
        limit: args.fetch(:limit, 10).to_i
      )
      data = tagger.text_summary
      puts JSON.pretty_generate(data[:proper_nouns])
    else
      puts 'File does not exist. Aborting!'
    end
  end
end
