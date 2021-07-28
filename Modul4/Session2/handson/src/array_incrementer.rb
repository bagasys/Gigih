class ArrayIncrementer
  def increment(arr)
    newArr = arr
    if newArr[0] == 9
      newArr = [1, 0]
    else
      newArr[0] += 1
    end
    newArr
  end
end