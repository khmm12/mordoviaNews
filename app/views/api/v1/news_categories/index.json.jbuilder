json.array! @news_categories do |category|
    json.id category.id
    json.title category.title
    json.title_latin category.title_latin
end