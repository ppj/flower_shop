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
        allow(Catalogue).to receive(:available_bundle_sizes).with("roses")
          .and_return(available_rose_bundle_sizes)
        allow(Catalogue).to receive(:available_bundle_sizes).with("violets")
          .and_return(available_violet_bundle_sizes)
      end
      let(:available_rose_bundle_sizes) { double }
      let(:available_violet_bundle_sizes) { double }

      before do
        allow(PackageMaker).to receive(:make).with(
          ordered_quantity: 10,
          available_bundle_sizes: available_rose_bundle_sizes,
        ).and_return(rose_package)
        allow(PackageMaker).to receive(:make).with(
          ordered_quantity: 15,
          available_bundle_sizes: available_violet_bundle_sizes,
        ).and_return(violet_package)
      end
      let(:rose_package) { double }
      let(:violet_package) { double }

      before do
        allow(PrettyPrinter).to receive(:print)
      end

      it "reads the catalogue" do
        expect(Catalogue).to receive(:available_bundle_sizes).with("roses")
        expect(Catalogue).to receive(:available_bundle_sizes).with("violets")

        process
      end

      it "asks to make packages" do
        expect(PackageMaker).to receive(:make).with(
          ordered_quantity: 10,
          available_bundle_sizes: available_rose_bundle_sizes,
        )
        expect(PackageMaker).to receive(:make).with(
          ordered_quantity: 15,
          available_bundle_sizes: available_violet_bundle_sizes,
        )

        process
      end

      it "pretty prints packages" do
        expect(PrettyPrinter).to receive(:print).with(
          product_code: "roses",
          package: rose_package
        )
        expect(PrettyPrinter).to receive(:print).with(
          product_code: "violets",
          package: violet_package
        )

        process
      end

      after do
        File.delete("./temp")
      end
    end
  end
end
