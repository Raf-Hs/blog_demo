json.extract! post, :id, :title, :body, :image, :rating, :created_at, :updated_at
json.url post_url(post, format: :json)
