class ArrayIncrementer
  def increment(arr)
    newArr = arr
    n = arr.length

    if n < 1
      return arr
    end


    i = n - 1
    sisa = 1
    
    while i >= 0 && sisa == 1
      if newArr[i] == 9
        newArr[i] = 0
        sisa = 1
      else
        newArr[i] += sisa
        sisa = 0
      end
      i -= 1
    end

    if sisa == 1
      newArr = [1] + newArr
    end
    newArr
  end
end