require_relative "../src/array_incrementer"

RSpec.describe ArrayIncrementer do
  it 'increments single digit' do
    # given
    ai = ArrayIncrementer.new()

    #when
    incremented_arr = ai.increment([0])

    # then
    expect(incremented_arr).to eq ([1])
  end

  it 'increments single digit of 9' do
    # given
    ai = ArrayIncrementer.new()

    #when
    incremented_arr = ai.increment([9])

    # then
    expect(incremented_arr).to eq ([1, 0])
  end

  it 'increments two digits' do
    # given
    ai = ArrayIncrementer.new()

    #when
    incremented_arr = ai.increment([1, 1])

    # then
    expect(incremented_arr).to eq ([1, 2])
  end

  it 'increments two digits of 9s' do
    # given
    ai = ArrayIncrementer.new()

    #when
    incremented_arr = ai.increment([9, 9])

    # then
    expect(incremented_arr).to eq ([1, 0, 0])
  end

  it 'receives empty array' do
    # given
    ai = ArrayIncrementer.new()

    #when
    incremented_arr = ai.increment([])

    # then
    expect(incremented_arr).to eq ([0])
  end
end