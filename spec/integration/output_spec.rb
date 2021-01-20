# frozen_string_literal: true

RSpec.describe "Order processing" do
  context "given the customer order" do
    xit "prints the cost & bundle breakdown for optimal shipping size" do
      expect(Processor.process(order_file: "./spec/integration/fixtures/example1")).to eq(
        %(
        10 R12 $12.99
          1 x 10 $12.99
        15 L09 $41.90
          1 x 9 $24.95
          1 x 6 $16.95
        13 T58 $25.85
          2 x 5 $9.95
          1 x 3 $5.95
        )
      )
    end
  end
end
