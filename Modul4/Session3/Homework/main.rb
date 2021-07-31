require 'sinatra'
require './controllers/category'
require './controllers/item'


get "/items" do
  controller = ItemController.new
  controller.list(params)
end

post "/items" do
  controller = ItemController.new
  controller.create(params)
  redirect "/items"
end

get "/items/new" do
  controller = ItemController.new
  controller.new_form
end

get "/items/:id/edit" do
  controller = ItemController.new
  controller.edit(params)
end

post "/items/:id/update" do
  controller = ItemController.new
  controller.update(params)
  redirect "/items"
end

post "/items/:id/delete" do
  controller = ItemController.new
  controller.delete(params)
  redirect "/items"
end

get "/items/:id/show" do
  controller = ItemController.new
  controller.show(params)
end

post "/categories" do
  controller = CategoryController.new
  controller.create(params)
  redirect "/categories"
end

get "/categories" do
  controller = CategoryController.new
  controller.list
end

get "/categories/new" do
  controller = CategoryController.new
  controller.new_form
end


get "/categories/:id/show" do
  controller = CategoryController.new
  controller.show(params)
end

get "/categories/:id/edit" do
  controller = CategoryController.new
  controller.edit(params)
end

post "/categories/:id/update" do
  controller = CategoryController.new
  controller.update(params)
  redirect "/categories"
end

post "/categories/:id/delete" do
  controller = CategoryController.new
  controller.delete(params)
  redirect "/categories"
end