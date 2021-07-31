require_relative "../../controllers/category"

describe CategoryController do
  describe "list" do
    it "s" do
      controller = CategoryController.new
      category1 = double()
      categories = [category1]
      allow(category1).to receive(:id).and_return(1)
      allow(category1).to receive(:name).and_return("Dessert")
      allow(Category).to receive(:find_all).and_return(categories)

      renderer = ERB.new(File.read("./views/categories/index.erb"))

      expect(controller.list).to eq renderer.result_with_hash(
        categories: categories
      )
    end
  end

  describe "show" do
    it "s" do
      controller = CategoryController.new
      category1 = double()
      allow(category1).to receive(:id).and_return(1)
      allow(category1).to receive(:name).and_return("Dessert")
      allow(Category).to receive(:find_by_id).and_return(category1)


      renderer = ERB.new(File.read("./views/categories/show.erb"))

      expect(controller.show({"id" => 1})).to eq renderer.result_with_hash(
        category: category1
      )
    end
  end

  describe "create" do
    it "s" do
      category1 = double()
      expect(category1).to receive(:save)
      allow(Category).to receive(:new).and_return(category1)
      controller = CategoryController.new
      controller.create({
        name: "Bagas"
      })
    end
  end

  describe "delete" do
    it "s" do
      category_id = 1
      category1 = double()
      expect(category1).to receive(:delete)
      allow(Category).to receive(:find_by_id).and_return(category1)
      controller = CategoryController.new
      controller.delete({
        id: category_id
      })
    end
  end

  describe "edit" do
    it "s" do
      controller = CategoryController.new
      category1 = double()
      allow(category1).to receive(:id).and_return(1)
      allow(category1).to receive(:name).and_return("Dessert")
      allow(Category).to receive(:find_by_id).and_return(category1)


      renderer = ERB.new(File.read("./views/categories/edit.erb"))

      expect(controller.edit({"id" => 1})).to eq renderer.result_with_hash(
        category: category1
      )
    end
  end

  describe "update" do
    it "s" do
      controller = CategoryController.new
      category1 = double()
      allow(category1).to receive(:name=)
      allow(category1).to receive(:update)
      allow(Category).to receive(:find_by_id).and_return(category1)

      controller.update({"id" => 1, "name": "Dessert"})
    end
  end

  describe "new_form" do
    it "s" do
      

      renderer = ERB.new(File.read("./views/categories/new.erb"))

      controller = CategoryController.new
      expect(controller.new_form()).to eq renderer.result
    end
  end
end