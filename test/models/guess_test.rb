require 'test_helper'

class GuessTest < ActiveSupport::TestCase

	test "correct changes to true if guess is same as answer" do 
		user = User.find_or_create_by(email:"test2@email.com", username:"test2", password:"test", access_token: "8f8f6513553acb816da66077486f370b")
		post = Post.find_or_create_by(answer:"testing", image_url:"test.jpg",user_id:user.id)
		guess = Guess.create(guess: "testing", post_id:post.id, user_id:user.id)
		guess.check_solution
		assert guess.correct
	end

	test "guess does not exit without a guess" do
		guess = Guess.new(post_id:2, user_id:3)
		refute guess.save
	end

	test "guess belongs to a user" do 
		user = User.find_or_create_by(email:"test2@email.com", username:"test2", password:"test", access_token: "8f8f6513553acb816da66077486f370b")
		post = Post.find_or_create_by(answer:"testing", image_url:"test.jpg",user_id:user.id)
		guess = Guess.create(guess: "testing", post_id:post.id, user_id:user.id)
		assert guess.user
	end

end
