require_relative "../db/db_connector"
require_relative "./category"
class Item
  attr_reader :id
  attr_accessor :name, :price, :category

  def initialize(id=nil, name, price, category)
    @id = id
    @name = name
    @price = price
    @category = category
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
      "UPDATE items_categories SET item_id=#{@id}, category_id=#{@category.id} WHERE item_id=#{@id}"
    )
  end

  def save
    return false unless valid?
    client = create_db_client
    client.query(
      "INSERT INTO items (name, price) VALUES ('#{@name}', #{@price})"
    )
    @id = client.last_id
    client.query(
      "INSERT INTO items_categories (item_id, category_id) VALUES (#{@id}, #{@category.id})"
    )
  end

  def valid?
    return false if @name.nil?
    return false if @price.nil?
    return false if @category.nil?
    true
  end

  def self.get_item_by_id(id)
    client = create_db_client
    raw_data = client.query("SELECT i.id ,i.name, i.price, c.name AS 'category_name', c.id AS 'category_id' FROM items AS i JOIN items_categories AS i_c ON i.id = i_c.item_id JOIN categories AS c ON c.id = i_c.category_id WHERE i.id=#{id}")
    item = nil
    raw_data.each do |data|
      category = Category.new(data["category_id"], data["category_name"])
      item = Item.new(data["id"], data["name"], data["price"], category)
      break
    end
    item
  end

  def self.get_all_items
    client = create_db_client
    raw_data = client.query("SELECT i.id ,i.name, i.price, c.name AS 'category_name', c.id AS 'category_id' FROM items AS i JOIN items_categories AS i_c ON i.id = i_c.item_id JOIN categories AS c ON c.id = i_c.category_id")
    items = Array.new
    raw_data.each do |data|
      category = Category.new(data["category_id"], data["category_name"])
      item = Item.new(data["id"], data["name"], data["price"], category)
      items << item
    end
    items
  end

  def self.insert_item(name, price, category_id)
    client = create_db_client
    client.query(
      "INSERT INTO items (name, price) VALUES ('#{name}', #{price})"
    )
    id = client.last_id
    client.query(
      "INSERT INTO items_categories (item_id, category_id) VALUES (#{id}, #{category_id})"
    )
  end

end