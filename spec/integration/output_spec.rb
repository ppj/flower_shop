# frozen_string_literal: true

require_relative "../../lib/processor"

RSpec.describe "Order processing" do
  context "given the customer order" do
    it "prints the cost & bundle breakdown for optimal shipping size" do
      expect(Processor.process(order_file: "./spec/integration/fixtures/example1")).to eq(
        [
          "10 x R12 $12.99",
          "\t1 x 10 $12.99",
          "15 x L09 $41.90",
          "\t1 x 9 $24.95",
          "\t1 x 6 $16.95",
          "13 x T58 $25.85",
          "\t2 x 5 $9.95",
          "\t1 x 3 $5.95",
        ].join("\n")
      )
    end
  end
end
