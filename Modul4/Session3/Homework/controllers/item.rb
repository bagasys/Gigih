require './models/item.rb'
require './models/category.rb'

class ItemController
  def list(params)
    items = []
    if params["category_id"] && params["category_id"] != ""
      items = Item::find_by_category_id(params["category_id"])
    else
      items = Item::find_all({
        category_id: params["category_id"] != "" ? params["category_id"] : nil 
      })
    end
    
    categories = Category::find_all
    renderer = ERB.new(File.read("./views/items/index.erb"))
    renderer.result(binding)
  end

  def show(params)
    id = params["id"]
    item = Item::find_by_id(id)
    renderer = ERB.new(File.read("./views/items/show.erb"))
    renderer.result(binding)
  end

  def create(params)
    id = nil
    categories = []
    categories_ids = params["categories_ids"] ? params["categories_ids"] : []
    categories_ids.each do |category_id|
      category = Category::find_by_id(category_id.to_i)
      categories << category
    end
    item = Item.new({
      id: nil, 
      name: params["name"], 
      price: params["price"],
      categories: categories
    })
    item.save
  end

  def new_form
    categories = Category::find_all
    renderer = ERB.new(File.read("./views/items/new.erb"))
    renderer.result(binding)
  end

  def edit(params)
    id = params["id"]
    item = Item::find_by_id(id)
    categories = Category::find_all
    current_categories_ids = item.categories.map {|category| category.id}
    renderer = ERB.new(File.read("./views/items/edit.erb"))
    renderer.result(binding)
  end

  def update(params)
    id = params["id"]
    name = params["name"]
    price = params["price"]
    categories = []
    categories_ids = params["categories_ids"] ? params["categories_ids"] : [] 
    categories_ids.each do |category_id|
      category = Category::find_by_id(category_id.to_i)
      categories << category
    end


    item = Item::find_by_id(id)
    item.name = name
    item.price = price
    item.categories = categories
    item.update
  end

  def delete(params)
    id = params["id"]
    item = Item::find_by_id(id)
    item.delete
  end
end