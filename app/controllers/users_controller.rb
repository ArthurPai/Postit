class UsersController <ApplicationController
  before_action :customer, only: [:new, :create]
  before_action :login_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @show_post_tab = params[:tab] != 'comments'
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "Yor are register success."
      session[:user_id] = @user.id
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