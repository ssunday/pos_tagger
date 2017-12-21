require 'engtagger'

class PosTagger
  def initialize(file_path, order_by: nil)
    @file_path = file_path
    @order_by = order_by
  end

  def text_summary
    order(tag_summary)
  end

  private

  attr_reader :file_path, :order_by

  ALPHA_ORDER = :alpha
  COUNT_ORDER = :count

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
    case order_by&.to_sym
    when ALPHA_ORDER
      order_by_alpha(tag_summary)
    when COUNT_ORDER
      order_by_count(summary)
    else
      order_by_count(summary)
    end
  end

  def order_by_count(summary)
    summary.map do |type, result|
      [type, result.sort_by { |_word, count| -count }.to_h]
    end.to_h
  end

  def order_by_alpha(summary)
    summary.map do |type, result|
      [type, result.sort_by { |word, _count| word }.to_h]
    end.to_h
  end

  def tag_text(file_path)
    text = File.read(file_path).force_encoding('UTF-8')
    tagger.add_tags(text)
  end

  def tagger
    @tagger ||= EngTagger.new
  end
end
