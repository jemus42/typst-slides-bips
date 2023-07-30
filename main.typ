#import "bips.typ": *

#show: bips-theme.with(
  aspect-ratio: "4-3"
)

#title-slide(
  title: "An extrordinary presentation",
  subtitle: "An exercise in futility",
  author: "Author McAuthorson",
  institute: BIPS_en,
  //date: [],
  occasion: "Conference of Things and Stuff"
)

#slide(title: "A hilarious slide")[
  You didn't expect that!
  #rect(width: 25%, height: 2%, fill: luma(150))

  Hello
]

#slide(title: "A Grid")[
  #{
    calc.round(digits: 2,  calc.pi)
  }
]

#slide(title: "An overlong title because people just can't have nice things")[
  $ hat(sigma)^2(X) = 1/(n - 1) sum_(i = 1)^n (macron(x) - x_i)^2 $
  $ Y = X beta + epsilon quad | epsilon tilde.op cal(N)(0, sigma^2) $

  $ hat(Y) = X hat(beta) $
  $ hat(beta) = (X^top X)^(-1) X^top Y $
]

#slide(title: "A list")[
  - #lorem(6)
  - #text(lorem(3), fill: red)
  - #text(lorem(9), size: 42pt)
]
