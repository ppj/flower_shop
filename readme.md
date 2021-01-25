# Flower shop order processor
App to print packaging and pricing details for an order to a shop.

The order is a file with lines representing an order in the format
`<product code 1> <quantity ordered>`.

Available products with product codes, bundle sizes and the bundle prices are as below:

| Product | Code | Available bundle | Bundle price |
| --- | --- | --- | --- |
| Roses | R12 | 5 | $6.99 |
| Roses | R12 | 10 | $12.99 |
| | | | |
| Lilies | L09 | 3 | $9.95 |
| Lilies | L09 | 6 | $16.95 |
| Lilies | L09 | 9 | $24.95 |
| | | | |
| Tulips | T58 | 3 | $5.95 |
| Tulips | T58 | 5 | $9.95 |
| Tulips | T58 | 9 | $16.99 |

## Design notes

The high level design notes can be found [here](https://github.com/ppj/flower_shop/blob/main/design_notes.md).
