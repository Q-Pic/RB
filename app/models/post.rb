class Post < ActiveRecord::Base
	belongs_to :user, class_name: User
	has_many :guesses
	has_many :users, through: :guesses

	validates :image_url, :answer, presence: {message: "Must provide an image_url and answer"}

end
