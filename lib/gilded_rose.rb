def legendary?(item)
  item.name == "Conjured Mana Cake"
end

def decreases_in_quality(item)
  item.name != 'Sulfuras, Hand of Ragnaros'
end

def decreases_in_quality_approaching_sellin(item)
  item.name != 'Aged Brie' && item.name != 'Backstage passes to a TAFKAL80ETC concert'
end

def past_sellin_date(item)
  item.sell_in < 0
end

def quality_can_increase(item)
  item.quality < 50
end

def item_increases_in_value_then_collapses?(item)
  item.name == 'Backstage passes to a TAFKAL80ETC concert'
end

def increase_quality(item)
  item.quality += 1
end

def decrease_quality(item)
  if legendary?(item)
    item.quality -= 2
  else
    item.quality -= 1
  end
end

def update_quality(items)
  items.each do |item|
    if decreases_in_quality_approaching_sellin(item)
      decrease_quality(item) if decreases_in_quality(item) && item.quality > 0
    else
      if quality_can_increase(item)
        item.quality += 1
        if item_increases_in_value_then_collapses?(item)
          if item.sell_in <= 10
            increase_quality(item) if quality_can_increase(item)
          end
          if item.sell_in <= 5
            increase_quality(item) if quality_can_increase(item)
          end
        end
      end
    end
    if decreases_in_quality(item)
      item.sell_in -= 1
    end
    if past_sellin_date(item)
      if item.name != "Aged Brie"
        if !item_increases_in_value_then_collapses?(item)
          if item.quality > 0
            if decreases_in_quality(item)
              item.quality -= 1
            end
          end
        else
          item.quality = 0
        end
      else
        if quality_can_increase(item)
          item.quality += 1
        end
      end
    end
  end
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
