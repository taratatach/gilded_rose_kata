Sulfuras = "Sulfuras, Hand of Ragnaros"
Backstage = "Backstage passes to a TAFKAL80ETC concert"
Aged_Brie = "Aged Brie"
Conjured = "Conjured Mana Cake"

def update_quality(items)
  items.each do |item|
    modify_quality(item)
    decrease_sellin(item)
  end
end

def modify_quality(item)
  amount = modifier(item)

  return if amount.nil?

  new_quality = (amount == 0) ? 0 : item.quality + amount
  new_quality = 50 if new_quality > 50
  new_quality = 0 if new_quality < 0

  item.quality = new_quality
end

def decrease_sellin(item)
  return if item.name == Sulfuras

  item.sell_in -= 1
end

def modifier(item)
  case item.name
  when Sulfuras
    sulfuras_modifier(item)
  when Backstage
    backstage_modifier(item)
  when Aged_Brie
    aged_brie_modifier(item)
  when Conjured
    conjured_modifier(item)
  else
    default_modifier(item)
  end
end

def sulfuras_modifier(item)
  nil
end

def aged_brie_modifier(item)
  item.sell_in > 0 ? 1 : 2
end

def backstage_modifier(item)
  if item.sell_in <= 0
    0
  elsif item.sell_in < 6
    3
  elsif item.sell_in < 11
    2
  else
    1
  end
end

def conjured_modifier(item)
  default_modifier(item) * 2
end

def default_modifier(item)
  item.sell_in > 0 ? -1 : -2
end

# DO NOT CHANGE THINGS BELOW -----------------------------------------

Item = Struct.new(:name, :sell_in, :quality)

# We use the setup in the spec rather than the following for testing.
#
# Items = [
#   Item.new("+5 Dexterity Vest", 10, 20),
#   Item.new("Aged Brie", 2, 0),
#   Item.new("Elixir of the Mongoose", 5, 7),
#   Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
#   Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
#   Item.new("Conjured Mana Cake", 3, 6),
# ]

