require 'rails_helper'

require 'pos_text_tagger'

RSpec.describe MainController, type: :controller do
  describe '#index' do
    it 'renders index page' do
      get :index

      expect(response).to render_template(:index)
    end
  end

  describe '#parse' do
    it 'parses text and renders results template' do
      file = double(tempfile: 'test.txt')

      allow(controller).to receive(:params).and_return(file: file)

      expect_any_instance_of(PosTextTagger).to receive(:text_summary).and_return({})

      post :parse

      expect(response).to render_template(:results)
      expect(assigns(:result)).to eq({})
    end
  end
end
