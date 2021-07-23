require "sinatra"
require_relative "./models/item"
require_relative "./models/category"

get "/" do
  return "Hello!"
end

get "/items" do
  items = Item::get_all_items
  erb :items, locals: {
    items: items,
  }
end

post "/items" do
  id = nil
  name = params["name"]
  price = params["price"]
  category_id = params["category_id"]
  category = Category::get_category_by_id(category_id)
  item = Item.new(id, name, price, category)
  item.save
  redirect "/items"
end

get "/items/new" do
  categories = Category::get_all_categories
  erb :items_new, locals: {
    categories: categories
  }
end

get "/items/:id/edit" do
  id = params["id"]
  item = Item::get_item_by_id(id)
  categories = Category::get_all_categories
  erb :items_edit, locals: {
    categories: categories,
    item: item
  }
end

post "/items/:id/update" do
  id = params["id"]
  category_id = params["category_id"]
  name = params["name"]
  price = params["price"]

  category = Category::get_category_by_id(category_id)
  item = Item::get_item_by_id(id)
  puts item.name
  item.name = name
  item.price = price
  item.category = category
  item.update
  redirect "/items/#{id}/edit"
end

post "/items/:id/delete" do
  id = params["id"]

  item = Item::get_item_by_id(id)
  item.delete
  redirect "/items"
end

get "/items/:id/show" do
  id = params["id"]
  item = Item::get_item_by_id(id)
  erb :items_show, locals: {
    item: item
  }
end