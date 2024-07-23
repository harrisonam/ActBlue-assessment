class UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]

  # GET /users or /users.json
  def index
    @users = User.all
    render json: { data: @users }, status: :ok
  end

  # GET /users/1 or /users/1.json
  def show
    render json: { data: @user }, status: :ok
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      render json: { data: @user }, status: :ok 
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
      if @user.update(user_params)
        render :show, status: :ok, location: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy!

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :role)
    end
end
