require "sinatra"
require_relative "./models/item"
require_relative "./models/category"
require_relative './controllers/item_controller'

get "/" do
  redirect "/items"
end

get "/items" do
  controller = ItemController.new
  controller.list_items
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