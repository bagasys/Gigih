class PaymentGateway
  def charge(total_cents)
    puts "THIS HITS THE PRODUCTION API AND ALTERS PRODUCTION DATA. THAT'S BAD!"

    { payment_id: rand(1000) }
  end
end

