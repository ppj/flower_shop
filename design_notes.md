# Design Notes

## Objects/classes with properties & behaviour

- Processor: order processing
  - takes an input stream/file with lines representing orders
  - processes the orders


- Catalogue: maintains a product catalogue
  - provides the available bundles sizes with prices for a product
  - provides the available bundle sizes for a product


- PackageMaker
  - creates a package optimised for shipping (minimum # of bundles required to fulfil the order)


- PrettyPrinter
  - provides a formatted output string ready to be displayed


## Testing output
```
Order processing
  given the customer order
    prints the cost & bundle breakdown for optimal shipping size

PackageMaker
  .make
    when available bundle sizes are [10]
      when packaging for 3 pieces
        returns an empty package
      when packaging for 10 pieces
        returns the bundle as {10 => 1}
      when packaging for 20 pieces
        returns the bundle as {10 => 2}
      when packaging for 24 pieces
        returns an empty package
    when available bundle sizes are [5, 10]
      when packaging for 3 pieces
        returns the bundle as {}
      when packaging for 5 pieces
        returns the bundle as { 5 => 1 }
      when packaging for 10 pieces
        returns the bundle as { 10 => 1 }
      when packaging for 15 pieces
        returns the bundle as { 10 => 1, 5 => 1 }
      when packaging for 25 pieces
        returns the bundle as { 10 => 2, 5 => 1 }
    when available bundle sizes are [3, 6, 9]
      when packaging for 3 items
        returns the bundle as { 3 => 1 }
      when packaging for 15 items
        returns the bundle as { 9 => 1, 6 => 1 }
      when packaging for 21 items
        returns the bundle as { 9 => 2, 3 => 1 }
      when packaging for 24 items
        returns the bundle as { 9 => 2, 6 => 1 }
    when available bundle sizes are [5, 3, 9]
      when packaging for 3 items
        returns the bundle as { 3 => 1 }
      when packaging for 6 items
        returns the bundle as { 3 => 2 }
      when packaging for 12 items
        returns the bundle as { 9 => 1, 3 => 1 }
      when packaging for 13 items
        returns the bundle as { 5 => 2, 3 => 1 }
      when packaging for 16 items
        returns the bundle as { 5 => 2, 3 => 2 }
      when packaging for 22 items
        returns the bundle as { 9 => 1, 5 => 2, 3 => 1 }

PrettyPrinter
  #print
    when package contains 1 bundle of 10
      returns a nicely formatted string
    when package contains 2 bundle of 10 and 1 bundle of 3
      returns a nicely formatted string

Processor
  .process
    when the input order file is not found
      raises a file not found error
    when the input is a file with an order
      reads the catalogue
      asks to make packages
      pretty prints packages

Finished in 0.01922 seconds (files took 0.07756 seconds to load)
26 examples, 0 failures

```
