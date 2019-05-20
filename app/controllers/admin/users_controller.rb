class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path, notice: "ユーザー「#{@user.name}」登録"
    else
      render :new
    end
  end
  
  def update
    @user = User.fing(params[:id])

    if @user.update(user_params)
      redirect_to admin_users_path, notice: "ユーザー「#{@user.name}」更新"
    else
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "ユーザー「#{@user.name}」削除"
  end


  private
  
  def user_params
    params.require(:user).permit(:name,:email,:admin,:password,:password_confirmation)
  end
end
