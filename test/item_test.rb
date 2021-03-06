require_relative 'test_helper'
require_relative '../lib/item'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'

class ItemTest < Minitest::Test
  def test_it_initializes_with_instance_variables
    item = Item.new({
      :id          => "20",
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => "1099",
      :created_at  => "2016-01-11 11:30:34 UTC",
      :updated_at  => "2017-01-11 11:30:34 UTC",
      :merchant_id => "56"}, "repo_placeholder")

    assert_equal 20, item.id
    assert_equal "Pencil", item.name
    assert_equal "You can use it to write things", item.description
    assert_equal 0.1099e2, item.unit_price
    assert_instance_of Time, item.created_at
    assert_instance_of Time, item.updated_at
    assert_equal 56, item.merchant_id
  end

  def test_unit_price_to_dollars_returns_float
    item = Item.new({
      :id          => "20",
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => "1099",
      :created_at  => "2016-01-11 11:30:34 UTC",
      :updated_at  => "2017-01-11 11:30:34 UTC",
      :merchant_id => "56"}, "repo_placeholder")

      assert_equal 10.99, item.unit_price_to_dollars
  end

  def test_items_returns_list_of_items_with_matching_merchant_id
    se =  SalesEngine.from_csv({
                            :items     => "./data/items.csv",
                            :merchants => "./data/merchants.csv",
                            })
    #item = Item.new({:merchant_id => "12335819"}, ItemRepository.new(se))
    item = se.items.find_by_id(263436239)

    assert_equal "BlaaRose", item.merchant.name

  end

end
