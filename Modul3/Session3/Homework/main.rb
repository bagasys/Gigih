require "sinatra"
require_relative "./controllers/item"
require_relative "./controllers/category"

get "/" do
  redirect "/items"
end

get "/items" do
  controller = ItemController.new
  controller.list_items(params)
end

post "/items" do
  controller = ItemController.new
  controller.create_item(params)
  redirect "/items"
end

get "/items/new" do
  controller = ItemController.new
  controller.new_item
end

get "/items/:id/edit" do
  controller = ItemController.new
  controller.edit_item(params)
end

post "/items/:id/update" do
  controller = ItemController.new
  controller.update_item(params)
  redirect "/items"
end

post "/items/:id/delete" do
  controller = ItemController.new
  controller.delete_item(params)
  redirect "/items"
end

get "/items/:id/show" do
  controller = ItemController.new
  controller.show_item(params)
end

get "/categories" do
  controller = CategoryController.new
  controller.list_categories
end

post "/categories" do
  controller = CategoryController.new
  controller.create_category(params)
  redirect "/categories"
end

get "/categories/new" do
  controller = CategoryController.new
  controller.new_category
end

get "/categories/:id/show" do
  controller = CategoryController.new
  controller.show_category(params)
end

post "/categories/:id/delete" do
  controller = CategoryController.new
  controller.delete_category(params)
  redirect "/categories"
end

get "/categories/:id/edit" do
  controller = CategoryController.new
  controller.edit_category(params)
end

post "/categories/:id/update" do
  controller = CategoryController.new
  controller.update_category(params)
  redirect "/categories"
end