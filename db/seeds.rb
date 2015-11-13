def create_params0_set
  size_x = [1,2,5,10].sample
  size_y = [1,3,7,12].sample
  size_z = [1,2,3].sample
  volume = [128,256,512,1024,2048,4096].sample

  ProductParams0Set.create(
    size_x: size_x,
    size_y: size_y,
    size_z: size_z,
    volume: volume,
    volume_text: "#{ volume } Megabytes"
  )
end

def create_params1_set
  processor_type = %w[ Atom A8 A7 A31s CoreM i7Core i5Core CoreDuo ].sample
  display_size   = [ 17, 19, 21, 22.5 ].sample
  weight         = [ 1, 1.3, 1.5, 2.1 ].sample

  ProductParams1Set.create(
    processor_type: processor_type,
    display_size:   display_size,
    weight: weight
  )
end

def create_params_set
  [true,false].sample ? create_params0_set : create_params1_set
end

100.times do |i|
  price  = [ 1, 5, 10, 20, 50, 100, 150, 200, 300, 1000 ].sample
  amount = [ 0, 1, 2, 5, 10, 20 ].sample
  state  = %w[ draft published deleted ].sample

  Product.create!(
    title: "Product #{ i.next }",
    price:  price,
    amount: amount,
    state:  state,

    product_params_set: create_params_set
  )

  puts "Product #{ i.next } created"
end

100.times do |i|
  state = %w[ draft published deleted ].sample

  Brand.create!(
    title:   "Brand #{ i.next }",
    content: "Brand #{ i.next } content",
    state:   state
  )

  puts "Brand #{ i.next } created"
end

20.times do |i|
  ProductCategory.create!(
    title: "Product Category #{ i.next }"
  )

  puts "Product Category #{ i.next } created"
end

products   = Product.all.to_a
brands     = Brand.all.to_a
categories = ProductCategory.all.to_a

100.times do
  product = products.sample

  # ADD BRANDS
  _times = [1,2,3].sample

  _times.times do
    brand = brands.sample
    rel   = product.products_brands_rels.new(brand: brand)

    rel_text = "Product #{ product.id }/Brand #{ brand.id }"

    if rel.save
      puts "#{ rel_text } -- relation created"
    else
      puts "#{ rel_text } -- relation duplication"
    end
  end # times

  # ADD PRODUCT CATEGORY
  _times = [1,2,3].sample

  _times.times do
    category = categories.sample
    rel = product.product_category_relations.new(product_category: category)

    rel_text = "Product #{ product.id }/ProductCategory #{ category.id }"

    if rel.save
      puts "#{ rel_text } -- relation created"
    else
      puts "#{ rel_text } -- relation duplication"
    end
  end # times
end