RSpec.describe PosTagger do
  let(:file) { File.join(Dir.pwd, 'spec/fixtures', 'test.txt') }

  describe '#text_summary' do
    let(:pos_tagger) { described_class.new(file) }
    let(:results) { pos_tagger.text_summary }

    it 'has verbs, adjectives, nouns, and proper nouns' do
      expect(results.keys).to eq(%i[proper_nouns nouns adjectives verbs])
    end

    it 'returns all proper nouns in the text' do
      expect(results[:proper_nouns]).to eq('Cyclone' => 1, "Fla'neiel" => 1, 'Flana' => 1, 'King' => 3)
    end

    it 'returns all nouns in the text' do
      expect(results[:nouns]).to eq(
        'Cyclone' => 1, "Fla'neiel" => 1, 'Flana' => 1,
        'King' => 3, 'lead' => 1, 'name' => 2, 'speech' => 1, 'times' => 2, 'way' => 1
      )
    end

    it 'returns all verbs in the text' do
      expect(results[:verbs]).to eq(
        'know' => 1, 'mulling' => 1, 'said' => 2, 'tag' => 1, 'wanted' => 1, 'was' => 2
      )
    end

    it 'returns all adjectives in the text' do
      expect(results[:adjectives]).to eq('many' => 2, 'own' => 2)
    end
  end

  describe 'ordering' do
    let(:pos_tagger) { described_class.new(file, order_by: 'count') }

    let(:results) { pos_tagger.text_summary }

    it 'orders by count with option' do
      expect(results[:proper_nouns].keys).to eq(['King', "Fla'neiel", 'Flana', 'Cyclone'])
      expect(results[:verbs].keys).to eq(%w[was said tag know wanted mulling])
    end
  end
end
