require_relative "../../models/category"

describe Category do
  describe "valid?" do
    context "having valid state" do
      it "should return true when there is all state" do
        category = Category.new({
          id: 1,
          name: "Dessert"
        })
        
        expect(category.valid?).to be true
      end

      it "should return true when there is no id" do
        category = Category.new({
          id: nil,
          name: "Dessert"
        })
        
        expect(category.valid?).to be true
      end
    end

    context "having invalid state" do
      it "should return true when there is no name" do
        category = Category.new({})
        
        expect(category.valid?).to be true
      end
    end
  end

  describe "save" do
    it "it should execute query" do
      category = Category.new({name: "Dessert"})
      new_category_id = 1
      query1 = "INSERT INTO categories (name) VALUES ('#{category.name}')"
  
      client = double()
      expect(client).to receive(:query).with(query1) 
      expect(client).to receive(:close)
      allow(client).to receive(:last_id).and_return(new_category_id)
  
      allow(Mysql2::Client).to receive(:new).and_return(client)
      category.save()  
    end
  end

  describe "update" do
    it "it should execute query" do
      category = Category.new({id: 1, name: "Dessert"})
      query1 = "UPDATE categories SET name='#{category.name}' WHERE id=#{category.id}"
  
      client = double()
      expect(client).to receive(:query).with(query1) 
      expect(client).to receive(:close)
      allow(Mysql2::Client).to receive(:new).and_return(client)
      
      category.update()  
    end
  end

  describe "delete" do
    it "it should execute query" do
      category = Category.new({id: 1, name: "Dessert"})
      query1 = "DELETE FROM items_categories WHERE category_id=#{category.id}"
      query2 = "DELETE FROM categories WHERE id=#{category.id}"
      
      client = double()
      expect(client).to receive(:query).with(query1) 
      expect(client).to receive(:query).with(query2) 
      expect(client).to receive(:close)
      allow(Mysql2::Client).to receive(:new).and_return(client)
      
      category.delete()  
    end
  end

  describe "find by id" do
    it "should executes the queries and return a value" do
      category_id = 1
      query1 = "SELECT name, id FROM categories WHERE id = #{category_id}"
      item_data = [{"id" => 1, "name" => "Dessert"}]
      
      client = double
      expect(client).to receive(:query).with(query1).and_return(item_data)
      expect(client).to receive(:close)
      allow(Mysql2::Client).to receive(:new).and_return(client)

      item = Category::find_by_id(category_id)
    end
  end

  describe "find by item id" do
    it "should executes the queries" do
      item_id = 1
      query1 = "SELECT c.name AS 'category_name', c.id AS 'category_id' FROM items AS i LEFT JOIN items_categories AS i_c ON i.id = i_c.item_id LEFT JOIN categories AS c ON c.id = i_c.category_id WHERE i.id=#{item_id}"
      item_data = [{"id" => 1, "name" => "Dessert"}, {"id" => 2, "name" => "Beverage"}]
      
      client = double
      expect(client).to receive(:query).with(query1).and_return(item_data)
      expect(client).to receive(:close)
      allow(Mysql2::Client).to receive(:new).and_return(client)

      item = Category::find_by_item_id(item_id)
    end
  end

  describe "find all" do
    it "should executes the queries" do
      item_id = 1
      query1 = "SELECT name, id FROM categories"
      item_data = [{"id" => 1, "name" => "Dessert"}, {"id" => 2, "name" => "Beverage"}, {"id" => 3, "name" => "Main Dish"}]
      client = double
      expect(client).to receive(:query).with(query1).and_return(item_data)
      expect(client).to receive(:close)
      allow(Mysql2::Client).to receive(:new).and_return(client)

      item = Category::find_all()
    end
  end
end