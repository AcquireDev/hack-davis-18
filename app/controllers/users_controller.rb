class UsersController < BaseController
  before_action :set_user, only: [:update, :destroy]
  skip_before_action :authenticate_user, only: [:create]

  # GET /users
  def index
    @users = User.all
  end

  # GET /current_user
  def show
    @user = authorized_user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      jwt = Auth.issue(user: @user.id)
      render json: {jwt: jwt}, status: :created
    else
      render json: {msg: "Unable to create user", errors: @user.errors}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render :show, status: :ok
    else
      render json: {msg: "Unable to update user", errors: @user.errors}, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.permit(:email, :password)
    end
end
