class PrototypesController < ApplicationController
  # indexアクション、showアクションを除く全てのアクションで
  # 事前に実行される
  before_action :move_to_index, except: [:index, :show]
  # editアクション、updateアクション呼び出し時のみ事前に実行される
  before_action :correct_user, only: [:edit, :update]


  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @prototype = Prototype.new(prototype_params)
    # if Prototype.create(prototype_params)
    if @prototype.save
      # ルートへのリダイレクト
      redirect_to '/'
    else
      render :_form, status: :unprocessable_entity
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    # ログアウト状態の時に実行される
    unless user_signed_in?
      # ユーザーログインページにリダイレクトする
      redirect_to user_session_path
      # redirect_to action: :index
    end
  end

  def correct_user
    # 変数@prototypeに
    @prototype = Prototype.find(params[:id])
    @user = @prototype.user
    # プロトタイプのユーザーIDと現在ログインしているユーザーのIDが
    # 一致しない時に実行される
    unless @prototype.user_id == current_user.id
      redirect_to user_session_path
    end
  end

end