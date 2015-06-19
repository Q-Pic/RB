class UsersController < ApplicationController
  before_action :authenticate_with_token!, only: [:index, :find, :posts, :logged_in_user]

  def register
    passhash = Digest::SHA1.hexdigest(params[:password])
    @user = User.new(username: params[:username], email: params[:email], password: passhash)
    if @user.save
      render "register.json.jbuilder", status: :created
    else
      render json: { errors: @user.errors.full_messages },
        status: :unprocessable_entity
    end
  end

  def login
    passhash = Digest::SHA1.hexdigest(params[:password])
    @user = User.find_by(username: params[:username])
    if @user && @user.password == passhash
      render "login.json.jbuilder"
    else
      render json: { msg: "User is not authenticated" }, status: :unauthorized
    end
  end

  def index
    @users = User.all
    render "index.json.jbuilder"
  end

  def find
    @user = User.find_by(username: params[:username])
  end

  def posts
    @user = User.find_by(username: params[:username])
  end

  def logged_in_user
    render json: current_user, status: :ok
  end

  def destroy
    user = User.find(params[:id])
    if current_user.id == user.id
      user.destroy
      render json: {msg: "user deleted"}, status: :accepted
    else
      render json: {msg: "not authenticated to delete"}, status: :unauthorized
    end 
  end

  def solved
    user = User.find_by(username: params[:username])
    @solved = get_solved(user)
    render json: @solved, status: :ok
  end

  def unsolved
    user = User.find_by(username: params[:username])
    @unsolved = Post.all - get_solved(user)
    render json: @unsolved, status: :ok
  end

  def get_solved(user)
    guesses = user.guesses
    solved = []
    guesses.each do |guess|
      if guess.correct 
        solved << guess.post
      end
    end
    solved
  end

  def leaderboard
    @users = User.order(points: :desc)
  end
 

  # def update
  #   if current_user
  #     current_score = current_user.score
  #     current_user.update(score: current_score +100 )
  #   else
  #     authenticated
  #   end
  # end

end
