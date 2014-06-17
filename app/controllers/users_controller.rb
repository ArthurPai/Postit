class UsersController <ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "Yor are register success."
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      flash[:notice] = "Your profile is updated."
      redirect_to profile_path
    else
      render :edit
    end
  end

  private

    def user_params
      params.require(:user).permit(:username, :password)
    end
end