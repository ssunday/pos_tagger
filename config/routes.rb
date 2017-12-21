Rails.application.routes.draw do

  get '/', to: 'main#index'
  post '/parse', to: 'main#parse'

end
