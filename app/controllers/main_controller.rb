require 'pos_text_tagger'

class MainController < ApplicationController
  def index
    render :index
  end

  def parse
    @result = text_tag_results

    render :results
  end

  private

  def text_tag_results
    tagger = PosTextTagger.new(params[:file].tempfile, limit: 10, order_by: :count)
    tagger.text_summary
  end
end
