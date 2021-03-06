class UsersController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # LOGIN /login
  def login
    @user = User.validate_login(params[:username], params[:password])

    respond_to do |format|
      if @user
        format.html { redirect_to @user, notice: 'User was successfully logged in.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :show, notice: 'Login failed.' }
        format.json { render json: '', status: :unprocessable_entity }
      end
    end
  end

  # VOTEUP /voteup
  def voteUp
    @username = params[:username]
    @user     = User.find_by_username(@username)

    @user.voteUp = @user.voteUp + 1
    if @user.voteDown != 0
      @user.reputation = @user.voteUp / @user.voteDown
    else
      @user.reputation = @user.voteUp
    end

    @user.save
  end

  # VOTEDOWN /votedown
  def voteDown
    @username = params[:username]
    @use      = User.find_by_username(@username)

    @user.voteDown = @user.voteDown + 1
    if @user.voteDown != 0
      @user.reputation = @user.voteUp / @user.voteDown
    else
      @user.reputation = @user.voteUp
    end

    @user.save
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :password, :number, :credits, :cash, :reputation, :requested, :received, :voteUp, :voteDown)
    end
end
