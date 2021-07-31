require_relative "../../controllers/item"

describe ItemController do
  describe "list" do
    it "s" do
      item1 = double()
      items = [item1]
      allow(item1).to receive(:id).and_return(1)
      allow(item1).to receive(:name).and_return("Es Teh")
      allow(item1).to receive(:price).and_return(1000)
      allow(item1).to receive(:categories).and_return([])
      allow(Item).to receive(:find_all).and_return(items)

      category1 = double()
      categories = [category1]
      allow(category1).to receive(:id).and_return(1)
      allow(category1).to receive(:name).and_return("Dessert")
      allow(Category).to receive(:find_all).and_return(categories)

      expected_renderer = ERB.new(File.read("./views/items/index.erb"))
      expected_view = expected_renderer.result_with_hash(
        items: items,
        categories: categories 
      )
      params = {}

      controller = ItemController.new
      expect(controller.list(params)).to eq expected_view
    end

    it "s" do
      item1 = double()
      items = [item1]
      allow(item1).to receive(:id).and_return(1)
      allow(item1).to receive(:name).and_return("Es Teh")
      allow(item1).to receive(:price).and_return(1000)
      allow(item1).to receive(:categories).and_return([])
      allow(Item).to receive(:find_by_category_id).and_return(items)

      category1 = double()
      categories = [category1]
      allow(category1).to receive(:id).and_return(1)
      allow(category1).to receive(:name).and_return("Dessert")
      allow(Category).to receive(:find_all).and_return(categories)

      expected_renderer = ERB.new(File.read("./views/items/index.erb"))
      expected_view = expected_renderer.result_with_hash(
        items: items,
        categories: categories 
      )
      params = {"category_id" => 1}

      controller = ItemController.new
      expect(controller.list(params)).to eq expected_view
    end
  end

  describe "show" do
    it "s" do
      item1 = double()
      allow(item1).to receive(:id).and_return(1)
      allow(item1).to receive(:name).and_return("Es Teh")
      allow(item1).to receive(:price).and_return(1000)
      allow(item1).to receive(:categories).and_return([])
      allow(Item).to receive(:find_by_id).and_return(item1)

      expected_renderer = ERB.new(File.read("./views/items/show.erb"))
      expected_view = expected_renderer.result_with_hash(
        item: item1,
      )
      params = {"id" => 1}

      controller = ItemController.new
      expect(controller.show(params)).to eq expected_view
    end
  end

  describe "create" do
    it "s" do
      item1 = double()
      expect(item1).to receive(:save)
      allow(Item).to receive(:new).and_return(item1)

      categories_ids = [1]

      category1 = double()
      allow(category1).to receive(:id).and_return(1)
      allow(category1).to receive(:name).and_return("Dessert")
      allow(Category).to receive(:find_by_id).and_return(category1)

      
      params = {
        "categories_ids" => categories_ids
      }

      controller = ItemController.new
      controller.create(params)
    end
  end

  describe "new_form" do
    it "s" do
      category1 = double()
      categories = [category1]
      allow(category1).to receive(:id).and_return(1)
      allow(category1).to receive(:name).and_return("Dessert")
      allow(Category).to receive(:find_all).and_return(categories)

      expected_renderer = ERB.new(File.read("./views/items/new.erb"))
      expected_view = expected_renderer.result_with_hash(
        categories: categories 
      )
      params = {}

      controller = ItemController.new
      expect(controller.new_form()).to eq expected_view
    end
  end

  describe "delete" do
    it "s" do
      item1 = double()
      expect(item1).to receive(:delete)
      allow(Item).to receive(:find_by_id).and_return(item1)

      params = {"id" => 1}

      controller = ItemController.new
      controller.delete(params)
    end
  end

  describe "edit" do
    it "s" do
      item1 = double()
      allow(item1).to receive(:id).and_return(1)
      allow(item1).to receive(:name).and_return("Es Teh")
      allow(item1).to receive(:price).and_return(1000)
      allow(item1).to receive(:categories).and_return([])
      allow(Item).to receive(:find_by_id).and_return(item1)


      category1 = double()
      categories = [category1]
      allow(category1).to receive(:id).and_return(1)
      allow(category1).to receive(:name).and_return("Dessert")
      allow(Category).to receive(:find_all).and_return(categories)

      current_categories_ids = []

      expected_renderer = ERB.new(File.read("./views/items/edit.erb"))
      expected_view = expected_renderer.result_with_hash(
        item: item1,
        categories: categories,
        current_categories_ids: current_categories_ids
      )
      params = {"id" => 1}

      controller = ItemController.new
      expect(controller.edit(params)).to eq expected_view
    end
  end

  describe "update" do
    it "s" do
      item1 = double()
      allow(item1).to receive(:id)
      allow(item1).to receive(:name=)
      allow(item1).to receive(:price=)
      allow(item1).to receive(:categories=)
      allow(item1).to receive(:update)
      allow(Item).to receive(:find_by_id).and_return(item1)

      categories_ids = [1]

      category1 = double()
      allow(category1).to receive(:id).and_return(1)
      allow(category1).to receive(:name).and_return("Dessert")
      allow(Category).to receive(:find_by_id).and_return(category1)

      
      params = {
        "id" => 1,
        "name" => "Baso",
        "price" => 15000,
        "categories_ids" => [1]
      }

      controller = ItemController.new
      controller.update(params)
    end
  end

  
end