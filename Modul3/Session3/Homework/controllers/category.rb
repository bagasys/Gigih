require './models/item.rb'
require './models/category.rb'

class CategoryController
  def list_categories
    categories = Category::get_all_categories
    renderer = ERB.new(File.read("./views/categories/index.erb"))
    renderer.result(binding)
  end

  def new_category
    renderer = ERB.new(File.read("./views/categories/new.erb"))
    renderer.result(binding)
  end

  def create_category(params)
    id = nil
    name = params["name"]
    category = Category.new(id, name)
    category.save
  end

  def delete_category(params)
    id = params["id"]
    category = Category::get_category_by_id(id)
    category.delete
  end

  def edit_category(params)
    id = params["id"]
    category = Category::get_category_by_id(id)
    renderer = ERB.new(File.read("./views/categories/edit.erb"))
    renderer.result(binding)
  end

  def update_category(params)
    id = params["id"]
    name = params["name"]

    category = Category::get_category_by_id(id)
    category.name = name
    category.update
  end

  def show_category(params)
    id = params["id"]
    category = Category::get_category_by_id(id)
    renderer = ERB.new(File.read("./views/categories/show.erb"))
    renderer.result(binding)
  end
end