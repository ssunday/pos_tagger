require 'engtagger'

class PosTextTagger
  def initialize(file_path, order_by: nil, limit: nil)
    @file_path = file_path
    @order_by = order_by
    @limit = limit
  end

  def text_summary
    ordered_summary = order(tag_summary)

    limit_to_use = limit || LIMIT

    return ordered_summary unless limit_to_use.positive?

    ordered_summary.map do |type, result|
      [type, result.first(limit || LIMIT).to_h]
    end.to_h
  end

  private

  attr_reader :file_path, :order_by, :limit

  ALPHA_ORDER = :alpha
  COUNT_ORDER = :count

  LIMIT = 10

  def tag_summary
    tagged = tag_text(file_path)

    {
      proper_nouns: tagger.get_proper_nouns(tagged),
      nouns: tagger.get_nouns(tagged),
      adjectives: tagger.get_adjectives(tagged),
      verbs: tagger.get_verbs(tagged)
    }
  end

  def order(summary)
    summary.map do |type, result|
      sorted = result.sort_by { |word, count| sort_by(word, count) }
      [type, sorted.to_h]
    end.to_h
  end

  def sort_by(word, count)
    case order_by&.to_sym
    when ALPHA_ORDER
      word
    when COUNT_ORDER
      -count
    else
      -count
    end
  end

  def tag_text(file_path)
    text = File.read(file_path).force_encoding('UTF-8')
    tagger.add_tags(text)
  end

  def tagger
    @tagger ||= EngTagger.new
  end
end
