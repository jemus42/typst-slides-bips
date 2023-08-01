#import "bips.typ": *

#show: bips-theme.with(
  aspect-ratio: "4-3",
  author_corresponding: (
    name: [Author McAuthorson],
    email: link("mailto:mcauthorson@leibniz-bips.de")[mcauthorson\@leibniz-bips.de]
  ),
  lang: "german",
  //logo: "logo.png"
)

#title-slide(
  title: "An impressive display of confusion in a 4D manifold",
  subtitle: "An exercise in futility",
  //author: "Author McAuthorson",
  institute: [Institute of Impressive Demos],
  //date: [],
  occasion: "Conference of Things and Stuff"
)

#polylux-slide({
  set page(
    paper: "presentation-4-3",
    fill: bips-colors.white,
    margin: (x: 10%, top: 0%, bottom: 8%)
  )

  [
    Hello
  ]
})


#slide(title: "Fun for the whole family")[

  Guess where I've been debugging the gradient line thingy.
  #rect(width: 75%, height: 2%, fill: luma(150))

  Here's some state:

  - #locate(loc => {bips-author-main-email.at(loc)})
  - #bips-lang.display()
  - #locate(loc => {bips-logo.at(loc) == "bips-logo.png"})
  - #bips-logo.display()
]

#slide(title: "A non-tight list: Doing things for the sake of it")[
  - A variety of reasons are available

  - Most of them kind of bad tbh

  - An assortment of opportunities

  - An abundance of alternatives

  - A country mile of miscellany, only comparable to a non-imperial mile of metric proportions

  - What's up with this list spacing
]

#slide(title: "A tight list: Doing things for the sake of it")[
  - A variety of reasons are available
  - Most of them kind of bad tbh
  - An assortment of opportunities
  - An abundance of alternatives
  - A country mile of miscellany, only comparable to a non-imperial mile of metric proportions
  - What's up with this list spacing
]

#slide(title: "A bit of math")[
  $ hat(sigma)^2(X) = 1/(n - 1) sum_(i = 1)^n (macron(x) - x_i)^2 $
  $ Y = X beta + epsilon quad | epsilon tilde.op cal(N)(0, sigma^2) $

  $ hat(Y) = X hat(beta) $
  $ hat(beta) = (X^top X)^(-1) X^top Y $
]

#slide(title: "An overlong title because people just can't have nice things")[
  - #lorem(2)

  - #lorem(6)

  - #text(lorem(3), fill: red)

  - #text(lorem(9), size: 42pt)
]

#slide(title: [Something with `code` I guess])[
  ```r
  all_slide_check <- all_slide_check |>
  dplyr::mutate(dplyr::across(dplyr::where(is.logical), \(x) {
    dplyr::case_when(
      x ~ "\u2705",  # Green check symbol
      !x ~ "\u274c", # Red X symbol
      is.na(x) ~ ""
    )
  })) |>
  dplyr::mutate(
    # Insert red question mark emoji instead of red X for easier visual parsing maybe
    compare_check = ifelse(grepl("dissimilar pages", compare_check_note), "\u2753", compare_check)
  )
  ```
]

#slide(title: "Something with references")[
  Hey you like trees? @ishwaran2008randomsurvival

  //#cite("ishwaran2008randomsurvival", style: "alphanumerical")

  The elastic net is given as
  $ 1/n thin norm(hat(y)_i - y_i)_2^2 + lambda (alpha abs(beta_j) + (1-alpha)/2 beta_j^2) $ @zou2005regularizationvariable

  This is another citation. @bender2005generatingsurvival

]

#thanks(thankstext: "Thank you for your attention!")[
  // You can add additional text here
]

#slide-references(title: "References")[

]

//#hide(bibliography("references.bib"))
