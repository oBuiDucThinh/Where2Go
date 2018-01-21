category_list = ["Van hoa su kien", "Nhac song - san khau", "Hoi thao",
  "Vui choi giai tri", "Ngoai troi", "Mua sam giam gia"]
category_list.each do |cate_name|
  Category.create name: cate_name
end

city_list = ["Ha Noi", "Da Nang", "Ho Chi Minh"]
city_list.each do |city_name|
  City.create city_name: city_name
end

User.create(name: "ThinhBui", email: "thinhducbui94@gmail.com", phone: 123456789,
  role: "creator", password: "test123", password_confirmation: "test123")

User.create(name: "ThinhAdmin", email: "thinhducbui311@gmail.com", phone: 123456789,
  role: "admin", password: "admin123", password_confirmation: "admin123")
