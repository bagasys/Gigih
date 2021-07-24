require_relative "../db/db_connector"

class Category
  attr_reader :id
  attr_accessor :name

  def initialize(id, name)
    @id = id
    @name = name
  end

  def self.get_all_categories
    client = create_db_client
    raw_data = client.query("SELECT * FROM categories")
    categories = Array.new
    raw_data.each do |data|
      category = Category.new(data["id"], data["name"])
      categories << category
    end
    categories
  end

  def self.get_category_by_id(id)
    client = create_db_client
    raw_data = client.query("SELECT * FROM categories WHERE id=#{id}")
    category = nil
    raw_data.each do |data|
      category = Category.new(data["id"], data["name"])
      break
    end
    category
  end

  def self.get_categories_by_item_id(item_id)
    client = create_db_client
    
    raw_data = client.query("SELECT c.name AS 'category_name', c.id AS 'category_id' FROM items AS i LEFT JOIN items_categories AS i_c ON i.id = i_c.item_id LEFT JOIN categories AS c ON c.id = i_c.category_id WHERE i.id=#{item_id}")
    categories = []
    raw_data.each do |data|
      category = Category.new(data["category_id"], data["category_name"])
      categories << category
    end
    categories
  end

  def valid?
    return false if @name.nil?
    true
  end

  def save
    return false unless valid?
    client = create_db_client
    client.query(
      "INSERT INTO categories (name) VALUES ('#{@name}')"
    )
    @id = client.last_id
  end

  def delete
    return false unless valid?
    client = create_db_client
    client.query(
      "DELETE FROM categories WHERE id=#{@id}"
    )
  end

  def update
    return false unless valid?
    client = create_db_client
    client.query(
      "UPDATE categories SET name='#{@name}' WHERE id=#{@id}"
    )
  end
end