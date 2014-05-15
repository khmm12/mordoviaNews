json.array! @news_comments do |comment|
    json.id comment.id
    json.content comment.content
    json.date comment.created_at
    json.user do
        json.id comment.user.id
        json.name comment.user.name
    end
end