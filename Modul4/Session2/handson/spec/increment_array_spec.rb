require_relative "../src/array_incrementer"

RSpec.describe ArrayIncrementer do
  it 'is delicious' do
    # given
    ai = ArrayIncrementer.new()

    #when
    incremented_arr = ai.increment([0])

    # then
    expect(incremented_arr).to eq ([1])
  end
end