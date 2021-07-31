require_relative "../db/mysql_connector"
require_relative "./category"
class Item
  attr_reader :id
  attr_accessor :name, :price, :categories

  def initialize(params)
    @id = params[:id]
    @name = params[:name]
    @price = params[:price]
    @categories = params[:categories]
  end

  def valid?
    return false if @name.nil?
    return false if @price.nil?
    true
  end

  def save
    return false unless valid?
    client = create_db_client
    client.query(
      "INSERT INTO items (name, price) VALUES ('#{@name}', #{@price})"
    )
    @id = client.last_id

    if @categories.length > 0
      query_text = "INSERT INTO items_categories (item_id, category_id) VALUES"
      @categories.each_with_index do |category, index|
        query_text += " (#{@id}, #{category.id})"
        if index < @categories.length - 1
          query_text += ","
        end
      end
      client.query(query_text)
    end
    client.close
  end

  def delete
    return false unless valid?
    
    client = create_db_client
    client.query(
      "DELETE FROM items_categories WHERE item_id=#{@id}"
    )
    client.query(
      "DELETE FROM items WHERE id=#{@id}"
    )
    client.close
    return true
  end

  def update
    return false unless valid?
    client = create_db_client
    client.query(
      "UPDATE items SET name='#{@name}', price='#{@price}' WHERE id=#{@id}"
    )

    client.query(
      "DELETE FROM items_categories WHERE item_id=#{@id}"
    )
    
    if @categories.length > 0
      query_text = "INSERT INTO items_categories (item_id, category_id) VALUES" 
      @categories.each_with_index do |category, index|
        query_text += " (#{@id}, #{category.id})"
        if index < @categories.length - 1
          query_text += ","
        end
      end
      client.query(query_text)
    end
    client.close
    true
  end

  def self.find_by_id(id)
    client = create_db_client
    rows = client.query("SELECT i.id ,i.name, i.price FROM items AS i WHERE i.id=#{id}")
    client.close

    item_data = nil
    rows.each do |row|
      item_data = row
      break
    end

    categories = Category::find_by_item_id(id)

    item = Item.new({
      id: item_data["id"], 
      name: item_data["name"], 
      price: item_data["price"], 
      categories: categories
    })
    item
    
  end

  def self.find_all
    client = create_db_client
    rows = client.query("SELECT i.id ,i.name, i.price FROM items AS i LEFT JOIN items_categories AS i_c ON i.id = i_c.item_id GROUP BY i.id")
    client.close
    items = Array.new
    rows.each do |row|
      categories = Category::find_by_item_id(row["id"])
      item = Item.new({
        id: row["id"], 
        name: row["name"], 
        price: row["price"], 
        categories: categories
      })
      items << item
    end
    items
  end

  def self.find_by_category_id(category_id)
    client = create_db_client
    rows = client.query("SELECT i.id ,i.name, i.price FROM items AS i LEFT JOIN items_categories AS i_c ON i.id = i_c.item_id WHERE i_c.category_id=#{category_id} GROUP BY i.id")
    client.close
    items = Array.new
    rows.each do |row|
      categories = Category::find_by_item_id(row["id"])
      item = Item.new({
        id: row["id"], 
        name: row["name"], 
        price: row["price"], 
        categories: categories
      })
      items << item
    end
    items
  end
end