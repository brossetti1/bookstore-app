# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Author.create!(first_name: 'Agatha', last_name: 'Christie')
Author.create!(first_name: 'James', last_name: 'Chase')
Author.create!(first_name: 'Sydney', last_name: 'Sheldon')
Author.create!(first_name: 'Obie', last_name: 'Fernandez')
Author.create!(first_name: 'cloves', last_name: 'Carneiro')
Author.create!(first_name: 'Rida', last_name: 'Al Barazi')

Publisher.create!([
  {name: 'Wiley'},
  {name: 'Addison Wesley'},
  {name: 'Peachpit Press'},
  {name: 'Manning publications'},
  {name: 'McGraw-Hill'},
  {name: 'No Starch Press'}
  ])

Book.create!(title: 'Gnuplot in Action', isbn: '978-1-933-98839-9',
             page_count: 360, price: 66.37, description: 'A book on the awesome
             opensource plotting software', published_at: '2010-11-04',
             publisher_id: 4,
             book_cover: File.open(File.join(Rails.root, 'app/assets/images/gnuplot.jpg')))

 Book.create!(title: 'The Rails 3 Way', isbn: '978-0-321-60166-7',
              page_count: 708, price: 49.99, description: 'A authoritative book on Rails 3',
              published_at: '2011-08-22', publisher_id: 2,
              book_cover: File.open(File.join(Rails.root, 'app/assets/images/rails3_way.jpg')))

  Book.create!(title: 'Practical Database Programming with Java', isbn: '978-0-470-88940-4',
               page_count: 919, price: 120.37, description: 'Covers the Practical considerations
               and applications in database Programming using Java Netbeans IDE, JSP, JSF and
               Java Beans', published_at: '2011-11-04', publisher_id: 1,
               book_cover: File.open(File.join(Rails.root, 'app/assets/images/practical_db.jpg')))
