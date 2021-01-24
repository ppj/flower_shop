# frozen_string_literal: true

require_relative "../lib/pretty_printer"
require_relative "../lib/catalogue"

RSpec.describe PrettyPrinter do
  describe "#print" do
    subject(:print) { described_class.new(product_code, package).print }
    let(:product_code) { "DAF08" }

    before do
      allow(Catalogue).to receive(:bundles).and_return(
        product_code => {
          10 => 399,
          3 => 149,
        },
      )
    end

    context "when package contains 1 bundle of 10" do
      let(:package) { { 10 => 1 } }

      it "returns a nicely formatted string" do
        expected_output = ["10 x #{product_code} $3.99", "\t1 x 10 $3.99"].join("\n")

        expect(print).to eq(expected_output)
      end
    end

    context "when package contains 2 bundle of 10 and 1 bundle of 3" do
      let(:package) { { 10 => 2, 3 => 1 } }

      it "returns a nicely formatted string" do
        expected_output = [
          "23 x #{product_code} $9.47",
          "\t2 x 10 $7.98",
          "\t1 x 3 $1.49",
        ].join("\n")

        expect(print).to eq(expected_output)
      end
    end
  end
end
