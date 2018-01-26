category_list = ["Van hoa su kien", "Nhac song - san khau", "Hoi thao",
  "Vui choi giai tri", "Ngoai troi", "Mua sam giam gia"]
category_list.each do |cate_name|
  Category.create name: cate_name
end

city_list = ["Ha Noi", "Da Nang", "Ho Chi Minh"]
city_list.each do |city_name|
  City.create city_name: city_name
end

50.times do |n|
  title = Faker::Name.title
  content = Faker::Lorem.paragraphs(1)
  date_start = Faker::Date.backward(8)
  date_end = Faker::Date.forward(7)
  user_id = 4
  category_id = [Faker::Number.between(1, 6)]
  city_id = [Faker::Number.between(1, 3)]
  picture = File.open(File.join(Rails.root, "app/assets/images/42CA1B.jpg"))
  Event.create!(title: title, content: content, date_start: date_start,
    date_end: date_end, picture: picture, user_id: user_id,
    category_ids: category_id, city_ids: city_id)
end
