class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, except: :show
  def index
    users = User.all
    @q = users.ransack(params[:q])
    @users = @q.result(distinct: true).page(params[:page]).per(15)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params) 
    if @user.save
      redirect_to @user, flash: { success: "スタッフ#{@user.name}を登録しました" }
    else
      render :new    
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, flash: { success: "#スタッフ情報を更新しました" }
    else
      render :edit
    end
  end

  def show
  end

  def destroy 
    @user.destroy
    redirect_to users_path, flash: { success: "#{@user.name}を削除しました" }
  end

  private
    def user_params
      params.require(:user).permit(:name, :phone, :email, :password, :password_confirmation)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def require_admin
      redirect_to root_url unless current_user.admin?
    end
end
