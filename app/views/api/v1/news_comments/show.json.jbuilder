json.id @news_comment.id
json.content @news_comment.content
json.date @news_comment.created_at
json.user do
    json.id @news_comment.user.id
    json.name @news_comment.user.name
end