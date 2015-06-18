json.array! @users do |user|
	json.id user.id
	json.username user.username
	json.email user.email
	json.access_token user.access_token
	json.first user.first
	json.last user.last
	json.posts user.count_posts
end