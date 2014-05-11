json.id @new.id
json.category_id @new.news_category_id
json.date @new.created_at
json.title @new.title
json.content @new.content
json.avatar_full_url @new.avatar.url
json.avatar_medium_url @new.avatar.url(:medium)
json.avatar_thumbnail_url @new.avatar.url(:thumbnail)