Rails.application.routes.draw do
  # ユーザー管理機能用ルーティング
  devise_for :users

  # ルートにアクセスするとprototypesコントローラーの
  # indexアクションを呼び出す
  root to: "prototypes#index"

  # prototypesコントローラーのアクション全てを定義
  # prototypesとcommentsのネスト
  resources :prototypes do
    # commentsコントローラーのアクション全てを定義
    resources :comments
  end
  resources :users, only: :show
end