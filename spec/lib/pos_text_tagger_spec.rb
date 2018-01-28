require 'rails_helper'

require 'pos_text_tagger'

RSpec.describe PosTextTagger do
  let(:file) { Rails.root.join('spec/fixtures/test.txt') }

  let(:pos_tagger) { described_class.new(file) }
  let(:results) { pos_tagger.text_summary }

  describe '#text_summary' do
    it 'has verbs, adjectives, nouns, and proper nouns' do
      expect(results.keys).to eq(%i[proper_nouns nouns adjectives verbs])
    end

    it 'returns all proper nouns in the text' do
      expect(results[:proper_nouns]).to eq(
        'Cyclone' => 2,
        "Fla'neiel" => 1,
        'Flana' => 1,
        'King' => 5,
        'Farrco' => 1,
        'Spellbinder' => 1
      )
    end

    it 'returns all nouns in the text' do
      expect(results[:nouns]).to eq(
        'Cyclone' => 2, 'Farrco' => 1, 'Spellbinder' => 1,
        'King' => 5, 'lead' => 1, 'name' => 2, 'speech' => 1, 'times' => 2,
        'magic' => 1, 'pondered' => 1
      )
    end

    it 'returns all verbs in the text' do
      expect(results[:verbs]).to eq(
        'care' => 1, 'did' => 1,
        'know' => 1, 'mulling' => 1, 'said' => 2, 'tag' => 1, 'wanted' => 1, 'was' => 5,
        'performing' => 1
      )
    end

    it 'returns all adjectives in the text' do
      expect(results[:adjectives]).to eq('many' => 2, 'own' => 2, 'curious' => 2)
    end
  end

  describe 'ordering' do
    let(:pos_tagger) { described_class.new(file, order_by: 'count') }

    it 'orders by count with option' do
      expect(results[:proper_nouns].keys).to eq(['King', 'Cyclone', "Fla'neiel", 'Flana', 'Farrco', 'Spellbinder'])
      expect(results[:verbs].keys).to eq(%w[was said care wanted did mulling tag performing know])
    end
  end

  describe 'limiting' do
    context 'if provided limit is -1' do
      let(:pos_tagger) { described_class.new(file, limit: -1) }

      it 'takes all words' do
        expect(results[:nouns]).to eq(
          'Cyclone' => 2, "Fla'neiel" => 1, 'Flana' => 1, 'Farrco' => 1, 'Spellbinder' => 1,
          'King' => 5, 'lead' => 1, 'name' => 2, 'speech' => 1, 'times' => 2, 'way' => 1,
          'magic' => 1, 'pondered' => 1
        )
      end
    end

    context 'more than limit' do
      let(:pos_tagger) { described_class.new(file, limit: 2) }

      it 'only pulls top N words from summary' do
        expect(results[:proper_nouns].keys).to eq(%w[King Cyclone])
        expect(results[:verbs].keys).to eq(%w[was said])
      end
    end

    context 'if word count is less than limit' do
      let(:pos_tagger) { described_class.new(file, limit: 7) }

      it 'takes all words' do
        expect(results[:proper_nouns].keys).to eq(['King', 'Cyclone', "Fla'neiel", 'Flana', 'Farrco', 'Spellbinder'])
        expect(results[:verbs].keys).to eq(%w[was said care wanted did mulling tag])
      end
    end
  end
end
