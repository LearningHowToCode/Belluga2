Belluga2::Application.routes.draw do

  scope "(:locale)", locale: /en|cn|ja|kn/ do

    resources :reviews # to save code in controller
    resources :lessons, except: [:index, :show] do
      resources :orders
      resources :reviews
    end
    resources :students, except: [:new, :create, :index]
    resources :tutors, except: [:new, :create]

    devise_for :users, :controllers => { :registrations => "registrations" }
    devise_scope :user do
      get ':profile/sign_up', to: 'devise/registrations#new', as: 'new_registration',
          constraints: { profile: /tutor|student/ }
    end

    get 'sales', to: "orders#sales"
    get 'purchases', to: "orders#purchases"
    get 'how_it_works', to: 'pages#how_it_works'
    get 'faqs', to: 'pages#faqs'
    get 'prepare', to: 'pages#prepare'
    get 'english', to: 'pages#english'
    get "college" => "pages#college"
    get "graduate_school" => "pages#graduate_school"
    get "free_lesson_confirmation" => "pages#free_lesson_confirmation"
    get "lesson_confirmation" => "pages#lesson_confirmation"
    get "message_confirmation" => "pages#message_confirmation"
    get "business" => "pages#business"

    post 'contact', to: 'messages#contact', as: :contact
    post 'contact_us', to: 'messages#contact_us', as: :contact_us

    root "pages#home"
  end
end
