Rails.application.routes.draw do
  get 'pinouts/pinout_project'
  get 'test/shutdown'
#  get 'pinouts/show'
#  get 'pinouts/new'
#  get 'pinouts/edit'
#  get 'pinouts/create'
# get 'tester/main'
# get 'tester/test'

get 'tester' => 'tester#main', as: :mainpage
get 'test' =>'tester#test', as: :start
 get 'static/manual'
# post 'pinouts/create'

root to: "projects#index"
resources :projects, only: [:index, :show]
resources :pinouts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
