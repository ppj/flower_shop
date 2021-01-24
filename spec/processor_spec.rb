# frozen_string_literal: true

require_relative "../lib/processor"

RSpec.describe Processor do
  describe ".process" do
    subject(:process) { described_class.process(order_file: order_file) }
    let(:order_file) { "./temp" }

    context "when the input order file is not found" do
      it "raises a file not found error" do
        expect { process }.to raise_error(Errno::ENOENT)
      end
    end

    context "when the input is a file with an order" do
      before do
        File.open("./temp", "w") do |file|
          file.write(
            ["10 roses", "15 violets"].join("
")
          )
        end
      end

      before do
        allow(Catalogue).to receive(:bundles).and_return(bundles)
      end
      let(:bundles) do
        {
          "roses" => bundles1,
          "violets" => bundles2,
        }
      end
      let(:bundles1) { double(:bundle, keys: available_bundle_sizes1) }
      let(:bundles2) { double(:bundle, keys: available_bundle_sizes2) }
      let(:available_bundle_sizes1) { double }
      let(:available_bundle_sizes2) { double }

      before do
        allow(PackageMaker).to receive(:make).with(
          ordered_quantity: 10,
          available_bundle_sizes: available_bundle_sizes1,
        ).and_return(package1)
        allow(PackageMaker).to receive(:make).with(
          ordered_quantity: 15,
          available_bundle_sizes: available_bundle_sizes2,
        ).and_return(package2)
      end
      let(:package1) { double }
      let(:package2) { double }

      before do
        allow(PrettyPrinter).to receive(:print)
      end

      it "reads the catalogue" do
        expect(Catalogue).to receive(:bundles)

        process
      end

      it "asks to make packages" do
        expect(PackageMaker).to receive(:make).with(
          ordered_quantity: 10,
          available_bundle_sizes: available_bundle_sizes1,
        )
        expect(PackageMaker).to receive(:make).with(
          ordered_quantity: 15,
          available_bundle_sizes: available_bundle_sizes2,
        )

        process
      end

      it "pretty prints packages" do
        expect(PrettyPrinter).to receive(:print).with(product_code: "roses", package: package1)
        expect(PrettyPrinter).to receive(:print).with(product_code: "violets", package: package2)

        process
      end

      after do
        File.delete("./temp")
      end
    end
  end
end
