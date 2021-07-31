require_relative "../../models/item"

describe Item do
  describe "valid?" do
    context "having valid state" do
      it "should return true when there is all state" do
        allow(Category).to receive(:new).and_return(double())
        categories = [ Category.new({name: "dessert"}) ]
        item = Item.new({
          id: 1,
          name: "Nasi Goreng",
          price: 10000,
          categories: categories
        }) 
        expect(item.valid?).to be true
      end

      it "should return true when there is no id" do
        allow(Category).to receive(:new).and_return(double())
        categories = [ Category.new({name: "dessert"}) ]
        item = Item.new({
          name: "Nasi Goreng",
          price: 10000,
          categories: categories
        }) 
        expect(item.valid?).to be true
      end

      it "should return true when there is no categories" do
        item = Item.new({
          id: 1,
          name: "Nasi Goreng",
          price: 10000,
        }) 
        expect(item.valid?).to be true
      end

      it "should return true when there are no categories and id" do
        item = Item.new({
          name: "Nasi Goreng",
          price: 10000,
        }) 
        expect(item.valid?).to be true
      end
    end

    context "having invalid state" do
      it "should return false when there is no name" do
        allow(Category).to receive(:new).and_return(double())
        categories = [ Category.new({name: "dessert"}) ]
        item = Item.new({
          id: 1,
          price: 10000,
          categories: categories
        }) 
        expect(item.valid?).to be false
      end

      it "should return false when there is no price" do
        allow(Category).to receive(:new).and_return(double())
        categories = [ Category.new({name: "dessert"}) ]
        item = Item.new({
          id: 1,
          name: "Nasi Goreng",
          categories: categories
        }) 
        expect(item.valid?).to be false
      end
    end
  end

  
  describe "update" do
    it "should execute the queries" do
      category1 = double()
      category2 = double()
      allow(category1).to receive(:id).and_return(2)
      allow(category2).to receive(:id).and_return(3)
      categories = [category1, category2]

      item = Item.new({
        id: 1,
        name: "Nasi Goreng",
        price: 15000,
        categories: categories
      })
      
      query1 = "UPDATE items SET name='#{item.name}', price='#{item.price}' WHERE id=#{item.id}"
      query2 = "DELETE FROM items_categories WHERE item_id=#{item.id}"
      query3 = "INSERT INTO items_categories (item_id, category_id) VALUES (#{item.id}, #{category1.id}), (#{item.id}, #{category2.id})"
      
      client = double
      expect(client).to receive(:query).with(query1)
      expect(client).to receive(:query).with(query2)
      expect(client).to receive(:query).with(query3)
      expect(client).to receive(:close)
      allow(Mysql2::Client).to receive(:new).and_return(client)

      item.update()
    end
  end

  describe "save" do
    it "should execute the queries" do
      category1 = double()
      category2 = double()
      allow(category1).to receive(:id).and_return(2)
      allow(category2).to receive(:id).and_return(3) # STUB
      categories = [category1, category2]

      new_item_id = 1

      item = Item.new({
        name: "Nasi Goreng",
        price: 15000,
        categories: categories
      })
      

      query1 = "INSERT INTO items (name, price) VALUES ('#{item.name}', #{item.price})"
      query2 = "INSERT INTO items_categories (item_id, category_id) VALUES (#{new_item_id}, #{category1.id}), (#{new_item_id}, #{category2.id})"

      client = double
      expect(client).to receive(:query).with(query1) # MOCK
      expect(client).to receive(:query).with(query2)
      expect(client).to receive(:close)
      allow(client).to receive(:last_id).and_return(new_item_id)
      
      
      allow(Mysql2::Client).to receive(:new).and_return(client)
      item.save()
    end
  end

  describe "delete" do
    it "should executes the queries" do
      category1 = double()
      category2 = double()
      allow(category1).to receive(:id).and_return(2)
      allow(category2).to receive(:id).and_return(3)
      categories = [category1, category2]

      item = Item.new({
        id: 1,
        name: "Nasi Goreng",
        price: 15000,
        categories: categories
      })

      query1 = "DELETE FROM items_categories WHERE item_id=#{item.id}"
      query2 = "DELETE FROM items WHERE id=#{item.id}"
        
      client = double
      expect(client).to receive(:query).with(query1)
      expect(client).to receive(:query).with(query2)
      expect(client).to receive(:close)
      allow(Mysql2::Client).to receive(:new).and_return(client)

      item.delete
    end
  end

  describe "find by id" do
    it "should executes the queries and return a value" do
      item_id = 1
      client = double
      query1 = "SELECT i.id ,i.name, i.price FROM items AS i WHERE i.id=#{item_id}"
      item_data = {"id" => 1, "name" => "Nasi Goreng", "price" => 15000}


      expect(client).to receive(:query).with(query1).and_return([item_data])
      expect(client).to receive(:close)
      allow(Mysql2::Client).to receive(:new).and_return(client)
      allow(Category).to receive(:find_by_item_id).and_return([])

      item = Item::find_by_id(item_id)
      expect(item.id).to eq 1
      expect(item.name).to eq "Nasi Goreng"
      expect(item.price).to eq 15000
      expect(item.categories).to eq []

    end
  end

  describe "find all" do
    it "should execute" do
      query1 = "SELECT i.id ,i.name, i.price FROM items AS i LEFT JOIN items_categories AS i_c ON i.id = i_c.item_id GROUP BY i.id"

      client = double()
      expect(client).to receive(:query).with(query1).and_return([])
      expect(client).to receive(:close)
      allow(Mysql2::Client).to receive(:new).and_return(client)
      
      category1 = double()
      category2 = double()
      allow(Category).to receive(:find_by_item_id).and_return([category1, category2])

      Item::find_all
    end

    it "should execute" do
      query1 = "SELECT i.id ,i.name, i.price FROM items AS i LEFT JOIN items_categories AS i_c ON i.id = i_c.item_id GROUP BY i.id"
      item_data = [
        {
          "id" => 1,
          "name" => "Nasi Goreng",
          "price" => 15000
        }
      ]
      client = double()
      expect(client).to receive(:query).with(query1).and_return(item_data)
      expect(client).to receive(:close)
      allow(Mysql2::Client).to receive(:new).and_return(client)
      
      category1 = double()
      category2 = double()
      allow(Category).to receive(:find_by_item_id).and_return([category1, category2])
      expect(Category).to receive(:find_by_item_id)

      Item::find_all
    end
  end


  describe "find_by_category_id" do
    it "should execute queries" do
      category_id = 1
      query1 = "SELECT i.id ,i.name, i.price FROM items AS i LEFT JOIN items_categories AS i_c ON i.id = i_c.item_id WHERE i_c.category_id=#{category_id} GROUP BY i.id"
      item_data = [
        {
          "id" => 1,
          "name" => "Nasi Goreng",
          "price" => 15000
        }
      ]

      client = double()
      expect(client).to receive(:query).with(query1).and_return(item_data)
      expect(client).to receive(:close)
      allow(Mysql2::Client).to receive(:new).and_return(client)
      
      category1 = double()
      category2 = double()
      allow(Category).to receive(:find_by_item_id).and_return([category1, category2])
      expect(Category).to receive(:find_by_item_id)
      Item::find_by_category_id(category_id)
    end

    it "should execute queries" do
      category_id = 1
      query1 = "SELECT i.id ,i.name, i.price FROM items AS i LEFT JOIN items_categories AS i_c ON i.id = i_c.item_id WHERE i_c.category_id=#{category_id} GROUP BY i.id"
      item_data = []

      client = double()
      expect(client).to receive(:query).with(query1).and_return(item_data)
      expect(client).to receive(:close)
      allow(Mysql2::Client).to receive(:new).and_return(client)
      
      category1 = double()
      category2 = double()
      allow(Category).to receive(:find_by_item_id).and_return([category1, category2])
      expect(Category).not_to receive(:find_by_item_id)
      Item::find_by_category_id(category_id)
    end
  end
end