require './linked_list'

class Pair
  attr_accessor :first, :second

  def initialize(key, val)
    @first = key
    @second = val
  end
end

class HashMap
  attr_accessor :array, :space, :size

  INITIAL_CAPACITY = 16
  LOAD_FACTOR = 0.75

  def initialize
    @array = Array.new(space = INITIAL_CAPACITY)
    @space = space
    @size = 0
  end

  def hash(key)
    hash_code = 0
    prime_number = 31
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    hash_code
  end

  def index(key)
    hash(key) % @space
  end

  def set(key, val)
    idx = index(key)

    if @array[idx].nil?
      @array[idx] = List.new
      @array[idx].append(Pair.new(key, val))
      @size += 1
      check_capacity
    else
      curr = @array[idx].head
      updated = false
      while curr
        if curr.val.first == key
          curr.val.second = val
          updated = true
          break
        end
        curr = curr.next
      end
      @array[idx].append(Pair.new(key, val)) unless updated
    end
  end

  def get(key)
    idx = index(key)
    return nil if array[idx].nil?

    curr = array[idx].head
    while curr
      return curr.val.second if curr.val.first == key

      curr = curr.succ
    end

    nil
  end

  def has?(key)
    array[index(key)].empty? ? false : true
  end

  def remove(key)
    idx = index(key)
    return if array[idx].nil?

    curr = array[idx].head
    i = 0
    while curr
      return array[idx].remove_at(i) if curr.val.first == key

      curr = curr.succ
      i += 1
    end
  end

  def length
    array.each.reduce(0) { |a, list| a + (list.nil? ? 0 : list.size) }
  end

  def clear
    array.each_with_index { |_, idx| array[idx] = nil }
  end

  def keys
    array.each.reduce([]) do |a, list|
      if list
        curr = list.head
        while curr
          a.push(curr.val.first)
          curr = curr.succ
        end
      end
      a
    end
  end

  def values
    array.each.reduce([]) do |a, list|
      if list
        curr = list.head
        while curr
          a.push(curr.val.second)
          curr = curr.succ
        end
      end
      a
    end
  end

  def entries
    array.each.reduce([]) do |a, list|
      if list
        curr = list.head
        while curr
          a.push([curr.val.first, curr.val.second])
          curr = curr.succ
        end
      end
      a
    end
  end

  def check_capacity
    return if size.zero?

    resize if (size / space.to_f) >= LOAD_FACTOR
  end

  def resize
    old_array = @array
    @space *= 2
    @array = Array.new(@space)

    old_array.each do |list|
      next if list.nil?

      curr = list.head
      while curr
        set(curr.val.first, curr.val.second)
        curr = curr.succ
      end
    end
  end
end

test = HashMap.new

p test.set('hello', 5)
p test.set('hello', 77) # setting multiple elements

p test.get('hello') # retrieving elements by key

p test.remove('hell') # removing elements with incorrect key

p test.get('hello')
p test.length # number of keys

test.clear # removing every key
p test.get('hello')

test.set('hello', 5)
test.set('world', 3)

p test.get('hello')

p test.keys # array of keys
p test.values # array of values
p test.entries # array of key, value pairs

test.resize # resizing to double space if load factor reached
p test.space # correctly resizes
p test.entries # all elems intact
