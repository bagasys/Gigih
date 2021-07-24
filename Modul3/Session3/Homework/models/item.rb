require_relative "../db/db_connector"
require_relative "./category"
class Item
  attr_reader :id
  attr_accessor :name, :price, :categories

  def initialize(id=nil, name, price, categories)
    @id = id
    @name = name
    @price = price
    @categories = categories
  end

  def delete
    return false unless valid?
    client = create_db_client
    client.query(
      "DELETE FROM items WHERE id=#{@id}"
    )
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

    @categories.each do |category|
      client.query(
        "INSERT INTO items_categories (item_id, category_id) VALUES (#{@id}, #{category.id})"
      )
    end
  end

  def save
    return false unless valid?
    client = create_db_client
    client.query(
      "INSERT INTO items (name, price) VALUES ('#{@name}', #{@price})"
    )
    @id = client.last_id
    @categories.each do |category|
      client.query(
        "INSERT INTO items_categories (item_id, category_id) VALUES (#{@id}, #{category.id})"
      )
    end
  end

  def valid?
    return false if @name.nil?
    return false if @price.nil?
    true
  end

  def self.get_item_by_id(id)
    client = create_db_client
    raw_data = client.query("SELECT i.id ,i.name, i.price FROM items AS i WHERE i.id=#{id}")
    
    item_data = nil
    raw_data.each do |data|
      item_data = data
      break
    end

    categories = Category::get_categories_by_item_id(id)

    item = Item.new(item_data["id"], item_data["name"], item_data["price"], categories)
    item
  end

  def self.get_all_items(params)
    where_clause = ""
    if params[:category_id]
      where_clause = " WHERE i_c.category_id=#{params[:category_id]}" 
    end

    client = create_db_client
    raw_data = client.query("SELECT i.id ,i.name, i.price FROM items AS i LEFT JOIN items_categories AS i_c ON i.id = i_c.item_id" + where_clause + " GROUP BY i.id")
    items = Array.new
    raw_data.each do |data|
      categories = Category::get_categories_by_item_id(data["id"])
      item = Item.new(data["id"], data["name"], data["price"], categories)
      items << item
    end
    items
  end

end