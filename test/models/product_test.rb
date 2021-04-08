# frozen_string_literal: true

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products
  # test "the truth" do
  #   assert true
  # end

  test 'product attributes must be not empty' do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
  end

  test 'product price must be positive' do
    product = Product.new(
      title: 'My Book Title',
      description: 'Description of my Book',
      image_url: 'chatbot.png'
    )
    product.price = -1
    assert product.invalid?
    assert_equal ['must be greater than or equal to 0.01'],
                 product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ['must be greater than or equal to 0.01'],
                 product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  def new_product(img_url)
    Product.new(
      title: 'My Book Title',
      description: 'Description of my Book',
      image_url: img_url,
      price: 1
    )
  end

  test 'image url' do
    ok = %w[chatbot.jpg chatbot.jpeg chatbot.png chatbot.gif http://a.b.c/x/y/z/fred.gif]
    bad = %w[chatbot.doc chatbot.gif/more chatbot.gif.more]

    ok.each do |image_url|
      assert new_product(image_url).valid?,
             "#{image_url} shouldn't be invalid"
    end

    bad.each do |image_url|
      assert new_product(image_url).invalid?,
             "#{image_url} shouldn't be valid"
    end
  end

  test 'product is not valid without a unique title - i18n' do
    product = Product.new(
      title: products(:ruby).title,
      description: 'ruby description',
      price: 1000,
      image_url: 'crystal.png'
    )
    assert product.invalid?
    # assert_equal ['has already been taken'],
    assert_equal [I18n.t('errors.messages.taken')],
                 product.errors[:title]
  end
end
