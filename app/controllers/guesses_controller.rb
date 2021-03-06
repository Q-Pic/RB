class GuessesController < ApplicationController

  before_action :authenticate_with_token!
  
  def index
    @guesses = Guess.all
  end

  def create
    post_id = params[:id]
    user_id = current_user.id
    guess = params[:guess].downcase.gsub(' ','')
    guess.gsub!(/[^0-9A-Za-z]/,'') if guess =~ /[^0-9A-Za-z]/

    solved_posts = current_user.guesses.where(correct:true).map {|guess| guess.post}  
  
    @guess = Guess.new(user_id: user_id, post_id: post_id, guess: guess)

    solved = solved_posts.include?(@guess.post)
    owns = current_user.posts.all.include?(@guess.post)

    if !solved && !owns
      if @guess.save
        @guess.check_solution
        render 'create.json.jbuilder'
      else
        render json: { errors: @guess.errors.full_messages}, status: :unprocessable_entity
      end
    else
      render json: {message: "This user is not allowed to guess."}, status: :forbidden
    end

  end

  def on_post
    @post = Post.find(params[:id])
  end
  
end
