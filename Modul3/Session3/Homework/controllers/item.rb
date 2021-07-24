require './models/item.rb'
require './models/category.rb'

class ItemController
  def list_items(params)
    items = Item::get_all_items({
      category_id: params["category_id"] != "" ? params["category_id"] : nil 
    })
    categories = Category::get_all_categories
    renderer = ERB.new(File.read("./views/items/index.erb"))
    renderer.result(binding)
  end

  def show_item(params)
    id = params["id"]
    item = Item::get_item_by_id(id)
    renderer = ERB.new(File.read("./views/items/show.erb"))
    renderer.result(binding)
  end

  def create_item(params)
    id = nil
    categories = []
    categories_ids = []
    params["categories_ids"].each do |category_id|
      category = Category::get_category_by_id(category_id.to_i)
      categories << category
    end
    item = Item.new(id, params["name"], params["price"], categories)
    item.save
  end

  def new_item
    categories = Category::get_all_categories
    renderer = ERB.new(File.read("./views/items/new.erb"))
    renderer.result(binding)
  end

  def edit_item(params)
    id = params["id"]
    item = Item::get_item_by_id(id)
    categories = Category::get_all_categories
    current_categories_ids = item.categories.map {|category| category.id}
    renderer = ERB.new(File.read("./views/items/edit.erb"))
    renderer.result(binding)
  end

  def update_item(params)
    id = params["id"]
    name = params["name"]
    price = params["price"]
    categories = []
    params["categories_ids"].each do |category_id|
      category = Category::get_category_by_id(category_id.to_i)
      categories << category
    end


    item = Item::get_item_by_id(id)
    item.name = name
    item.price = price
    item.categories = categories
    item.update
  end

  def delete_item(params)
    id = params["id"]
    item = Item::get_item_by_id(id)
    item.delete
  end
end