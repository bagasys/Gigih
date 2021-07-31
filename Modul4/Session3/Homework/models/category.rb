require_relative "../db/mysql_connector"

class Category
  attr_reader :id
  attr_accessor :name
  def initialize(params)
    @id = params[:id]
    @name = params[:name]
  end


  def valid?
    return false if @name == ""
    true
  end

  def save
    return false unless valid?
    
    client = create_db_client
    client.query(
      "INSERT INTO categories (name) VALUES ('#{@name}')"
    )
    @id = client.last_id
    client.close

    return true
  end

  def update
    return false unless valid?
    
    client = create_db_client
    client.query(
      "UPDATE categories SET name='#{@name}' WHERE id=#{@id}"
    )
    client.close
  end

  def delete
    return false unless valid?
    
    client = create_db_client
    client.query(
      "DELETE FROM items_categories WHERE category_id=#{@id}"
    )
    client.query(
      "DELETE FROM categories WHERE id=#{@id}"
    )
    client.close
  end

  def self.find_all
    client = create_db_client
    rows = client.query("SELECT name, id FROM categories")
    client.close
    categories = []
    rows.each do |row|
      category = Category.new({
        id: row["id"],
        name: row["name"]
      })
      categories.push(category)
    end
    categories
  end

  def self.find_by_id(id)
    client = create_db_client
    rows = client.query("SELECT name, id FROM categories WHERE id = #{id}")
    client.close
    category = nil
    rows.each do |row|
      category = Category.new({
        id: row["id"],
        name: row["name"]
      })
      break
    end
    category
  end

  def self.find_by_item_id(item_id)
    client = create_db_client
    
    raw_data = client.query("SELECT c.name AS 'category_name', c.id AS 'category_id' FROM items AS i LEFT JOIN items_categories AS i_c ON i.id = i_c.item_id LEFT JOIN categories AS c ON c.id = i_c.category_id WHERE i.id=#{item_id}")
    client.close
    categories = []
    raw_data.each do |data|
      category = Category.new({
        id: data["category_id"], 
        name: data["category_name"]
      })
      categories << category
    end
    categories
  end


  
end