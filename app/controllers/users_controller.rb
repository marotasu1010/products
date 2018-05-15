class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :edit]
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザを登録しました'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザ登録できませんでした'
      render :new
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
      
      if @user == current_user
        if @user.update(user_params)
          flash[:success] = 'ユーザ情報は正常に更新されました。'
          redirect_to @user
        else
          flash.now[:danger] = 'ユーザ情報は更新できませんでした。'
          render :edit
        end
      end
  end
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
