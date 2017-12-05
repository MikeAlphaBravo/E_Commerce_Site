User.destroy_all
Product.destroy_all

User.create(email: 'admin@admin.com', password: '123456', admin: true)

p "Created #{User.count} user"

product_list = [
  [ "Grass Honey", 20.00, File.new("#{Rails.root}/public/programmer.png") ],
  [ "Flower Honey", 22.00, File.new("#{Rails.root}/public/programmer.png") ],
  [ "Wild Honey", 23.00, File.new("#{Rails.root}/public/programmer.png") ]
]

product_list.each do |name, price, image |
  Product.create( name: name, price: price, image: image )
end

p "Created #{Product.count} products"
