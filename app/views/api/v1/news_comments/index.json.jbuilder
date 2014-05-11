json.array! @news_comments do |comment|
    json.id comment.id
    json.name comment.name
    json.content comment.content
    json.date comment.created_at
end