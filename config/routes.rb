Rails.application.routes.draw do
  get '/test' => 'application#test'

  get 'pinouts/pinout_project'
  get 'tester/shutdown'
#  get 'pinouts/show'
#  get 'pinouts/new'
#  get 'pinouts/edit'
#  get 'pinouts/create'
# get 'tester/main'
 #get 'tester/testtest'

get 'tester' => 'tester#main', as: :mainpage
get 'test' =>'tester#test', as: :start
 get 'static/manual'
 get 'static/maintanance'
# post 'pinouts/create'

root to: "projects#index"
resources :projects, only: [:index, :show]
resources :pinouts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
