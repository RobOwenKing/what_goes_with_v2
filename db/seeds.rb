# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Ingredient.create(
  [
    { name: 'Courgette',    slug: 'courgette',    aka: 'Zucchini' },
    { name: 'Hard Cheese',  slug: 'hard-cheese',  eg: 'Cheddar, Parmesan' },
    { name: 'Blue Cheese',  slug: 'blue-cheese',  eg: 'Stilton' },
    { name: 'Onion',        slug: 'onion',        eg: 'Red onion, white onion, leek, spring onion, green onion, scallion' },
    { name: 'Chocolate',    slug: 'chocolate',    eg: 'Dark chocolate, milk chocolate' },
    { name: 'White Chocolate', slug: 'white-chocolate' },
    { name: 'Cinnamon',     slug: 'cinnamon' },
    { name: 'Mint',         slug: 'mint' }
  ]
)
