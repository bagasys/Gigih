require_relative '../models/category'

class CategoryController
  def list
    categories = Category::find_all
    renderer = ERB.new(File.read("./views/categories/index.erb"))
    renderer.result(binding)
  end

  def show(params)
    category = Category::find_by_id(params["id"])
    renderer = ERB.new(File.read("./views/categories/show.erb"))
    renderer.result(binding)
  end

  def create(params)
    category = Category.new({
      id: nil,
      name: params["name"]
    })
    category.save
  end

  def delete  (params)
    id = params["id"]
    category = Category::find_by_id(id)
    category.delete
  end

  def edit(params)
    category = Category::find_by_id(params["id"])
    renderer = ERB.new(File.read("./views/categories/edit.erb"))
    renderer.result(binding)
  end

  def update(params)
    id = params["id"]
    name = params["name"]
    category = Category::find_by_id(id)
    category.name = name
    category.update
  end

  def new_form
    renderer = ERB.new(File.read("./views/categories/new.erb"))
    renderer.result(binding)
  end
end