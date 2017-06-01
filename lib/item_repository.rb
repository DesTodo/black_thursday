require 'pry'
require "csv"
require "./lib/item"
require "bigdecimal"
require 'bigdecimal/util'

class ItemRepository
  attr_reader :items 
  
  def initialize
    @items = []
  end 
  
  def from_csv(file_path)
    contents = CSV.open file_path, headers: true, header_converters: :symbol
    contents.each do |row|
      attributes ={}
      attributes[:id]         = row[:id].to_i
      attributes[:name]         = row[:name]
      attributes[:description]  = row[:description]
      attributes[:unit_price]   = row[:unit_price].to_d
      attributes[:merchant_id]   = row[:merchant_id].to_i
      attributes[:created_at]   = DateTime.parse(row[:created_at].chomp("UTC"))
      attributes[:updated_at]   = DateTime.parse(row[:updated_at].chomp("UTC"))
      @items << Item.new(attributes)
    end 
  end 
  
  def all
    @items
  end 
  
  def find_by_id(id_number)
    item = @items.find do |item|
      item.id == id_number
    end 
    return item
  end 
  
  def find_by_name(name)
    item = @items.find do |item|
      item.name.downcase == name.downcase
    end 
    return item
  end 
  
  def find_all_with_description(keyword)
    matching_items = @items.find_all do |item|
      item.description.downcase.include?(keyword.downcase)
    end 
    return [] if matching_items.nil?
    return matching_items
  end 
  
  
end 

