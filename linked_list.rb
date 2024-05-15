class Link
  attr_accessor :val, :succ

  def initialize(val = nil, link = nil)
    @val = val
    @succ = link
  end
end

class List
  attr_accessor :start

  def initialize(link = nil)
    @start = link
  end

  def append(val)
    return @start = Link.new(val) if @start.nil?

    curr = @start
    curr = curr.succ until curr.succ.nil?
    curr.succ = Link.new(val)
  end

  def prepend(val)
    @start = Link.new(val, @start)
  end

  def size
    return 0 if @start.nil?

    i = 1
    curr = @start
    until curr.succ.nil?
      curr = curr.succ
      i += 1
    end
    i
  end

  def head
    @start
  end

  def tail
    return nil if @start.nil?

    curr = @start
    curr = curr.succ until curr.succ.nil?
    curr
  end

  def at(idx)
    return nil if @start.nil? || idx.negative? || idx >= size

    curr = @start
    i = 0
    while i < idx
      curr = curr.succ
      i += 1
    end
    curr
  end

  def pop
    return if @start.nil?

    if @start.succ.nil?
      temp = @start
      @start = nil
      return temp
    end

    n = size - 2
    i = 0
    curr = @start
    while i < n
      curr = curr.succ
      i += 1
    end
    temp = curr.succ
    curr.succ = nil
    temp
  end

  def contains?(val)
    return false if @start.nil?

    curr = @start
    return true if curr.val == val

    until curr.succ.nil?
      curr = curr.succ
      return true if curr.val == val
    end
    false
  end

  def find(val)
    return nil if @start.nil?

    curr = @start
    return 0 if curr.val == val

    i = 0
    until curr.succ.nil?
      curr = curr.succ
      i += 1
      return i if curr.val == val
    end
    nil
  end

  def to_s
    return 'nil' if @start.nil?

    s = ''
    curr = @start
    until curr.succ.nil?
      s += "(#{curr.val}) -> "
      curr = curr.succ
    end
    s + "(#{curr.val}) -> nil"
  end

  def insert_at(val, idx)
    return nil if idx > size || idx.negative?

    if idx.zero?
      @start = Link.new(val, @start)
    else
      prev = at(idx - 1)
      prev.succ = Link.new(val, prev.succ)
    end
  end

  def remove_at(idx)
    return nil if idx >= size || idx.negative?

    if idx.zero?
      @start = @start.succ
    else
      prev = at(idx - 1)
      prev.succ = prev.succ.succ
    end
  end
end

test = List.new
test.append(0)
test.append(1)
test.append(2)
test.append(3)

test.insert_at(4, 1).val
puts test
test.remove_at(-1)
test.remove_at(4)
puts test
