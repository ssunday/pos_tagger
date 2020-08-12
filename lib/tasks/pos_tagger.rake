require 'pos_text_tagger'
require 'json'

namespace :pos_tagger do
  desc 'Given a file path, returns tag information for text'
  task :tag_text, [:path, :order_by, :limit] do |_t, args|
    data = tag_speech(args)

    if data
      puts JSON.pretty_generate(data)
    else
      puts 'File does not exist. Aborting!'
    end
  end

  task :proper_nouns, [:path, :order_by, :limit] do |_t, args|
    data = tag_speech(args)

    if data
      puts JSON.pretty_generate(data[:proper_nouns])
    else
      puts 'File does not exist. Aborting!'
    end
  end
end

def tag_speech(args)
  path = args[:path]

  return unless File.exist?(path)

  tagger = PosTextTagger.new(
    path,
    order_by: args[:order_by],
    limit: args.fetch(:limit, 10).to_i
  )
  tagger.text_summary
end
