require './models/item.rb'
require './models/category.rb'

class ItemController
  def list_items
    items = Item::get_all_items
    renderer = ERB.new(File.read("./views/items.erb"))
    renderer.result(binding)
  end

  def show_item(params)
    id = params["id"]
    item = Item::get_item_by_id(id)
    renderer = ERB.new(File.read("./views/items_show.erb"))
    renderer.result(binding)
  end

  def create_item(params)
    id = nil
    category_id = params["category_id"]
    category = Category::get_category_by_id(category_id)
    item = Item.new(id, params["name"], params["price"], category)
    item.save
  end

  def create_item_form
    categories = Category::get_all_categories
    renderer = ERB.new(File.read("./views/items_new.erb"))
    renderer.result(binding)
  end

  def edit_item(params)
    id = params["id"]
    item = Item::get_item_by_id(id)
    categories = Category::get_all_categories
    renderer = ERB.new(File.read("./views/items_edit.erb"))
    renderer.result(binding)
  end

  def update_item(params)
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
  end

  def delete_item(params)
    id = params["id"]

    item = Item::get_item_by_id(id)
    item.delete
  end
end