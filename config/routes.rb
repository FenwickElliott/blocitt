Rails.application.routes.draw do

  get 'questions/index'

  get 'questions/show'

  get 'questions/new'

  get 'questions/edit'

    resources :questions
    resources :advertisements
	resources :topics do
		resources :posts, except: [:index]
	end


	get 'about' => 'welcome#about'

	root 'welcome#index'
end
