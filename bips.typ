//#import "@preview/polylux:0.2.0": *

#import "polylux/helpers.typ": *
#import "polylux/logic.typ": *

#let BIPS_en = [Leibniz Institute for Prevention Research and Epidemiology -- BIPS]
#let BIPS_de = [Leibniz-Institut für Präventionsforschung und Epidemiologie -- BIPS]

#let background-color = white.darken(1%)
#let BIPSblue = rgb(23, 99, 170)
#let BIPSgray = rgb(66, 66, 66)
#let BIPSorange = rgb(250, 133, 55)
#let BIPSgreen = rgb(49, 210, 57)

#let base_size = 22pt
#let title_size = 42pt
#let header_size = 28pt

#let divider = line.with(length: 90%, stroke: rgb("e4e5ea"))

#let gradient(height: 2pt) = {
  box(width: 90%,
    for x in range(150, 250, steps: 1) {
      box(rect(width: 1%, height: height, fill: luma(x)))
    }
  )
}

#let title-case(string) = {
  return string.replace(
    regex("[A-Za-z]+('[A-Za-z]+)?"),
    word => upper(word.text.first()) + lower(word.text.slice(1)),
  )
}

// Pre-set block of logo in top right, with or without numbering (for title slide)
// This feels pretty weird syntactically.
#let logoblock(logo: "bips-logo.png", number: true) = {
  [
      #let logo_img = image(logo, height: 15%)
      #let slide_num = logic.logical-slide.display()

      #set align(top + right)
      #set text(size: 20pt)

      #if (number) {
        pad(rest: 30pt)[
            #logo_img
            #pad(right: 35pt, top: -14pt, slide_num)
        ]
      } else {
        pad(rest: 30pt, logo_img)
      }

    ]
}

// This will maybe make sense once the logo path is global state
#let logo(logo: "bips-logo.png", height: 100%, width: auto) = {
  image(logo, height: height, width: width)
}


#let bips-theme(
  aspect-ratio: "16-9", logo: "bips-logo.png", german: false,
  body) = {

  set page(
    paper: "presentation-" + aspect-ratio,
    fill: background-color,
    margin: (x: 10%, top: 0%, bottom: 8%)
  )

  // Default text options for slide contents
  set text(fill: BIPSgray, size: base_size, font: "Fira Sans", weight: "light")

  // Widen spacing in lists
  // Tight lists use par(leading: ) which is annoying as it also changes line spacing withing
  // list items. Ideally I'd like to convert all tight lists to non-tight lists.
  show list.where(tight: true): it => [
    #set list(marker: "\u{25CF}")
    #set par(leading: 1.1em)
    #it
  ]
  show list.where(tight: false): set list(marker: "\u{25CF}", spacing: 1.5em)

  // Override heading defaults just so I can use semantic elements rather than showing text around
  show heading.where(level: 1): it => [
    #set align(center)
    #set text(size: title_size, fill: BIPSblue, weight: "regular")
    #block(it.body)
  ]

  show heading.where(level: 2): it => [
    #set align(center)
    #set text(size: header_size, fill: BIPSblue, weight: "regular")
    #block(it.body)
  ]

  body
}

#let title-slide(
  title: [],
  subtitle: [],
  author: none,
  author_corresponding: none,
  institute: BIPS_en,
  date: datetime.today().display(),
  occasion: none
) = {

  set page(background: logoblock(number: false))

  polylux-slide({

    set align(center + horizon)

    heading(level: 1, title-case(title))
    set text(fill: BIPSblue)
    text(subtitle, weight: "regular")

    v(5%)

    set text(size: 20pt)

    author
    parbreak()

    set text(fill: BIPSgray)

    institute
    parbreak()

    v(2cm)
    date
    parbreak()

    occasion

  })
}

// Cell with outline to debug grid arrangements
#let cell = rect.with(
  inset: 5pt,
//  fill: rgb("efefef"),
  width: 100%, height: 100%,
  radius: 0pt
)

#let slide(title: [], body) = {
  set page(background: logoblock())

  polylux-slide({

    grid(
      columns: (100%),
      rows: (20%, 1%, 79%),
      gutter: 0pt,
      //cell()
      {
        set align(horizon)
        pad(right: 7.5%, heading(level: 2, title))
      },
      align(horizon, gradient()),
      //cell()
      {
        set align(left + horizon)
        text(body, fill: BIPSgray)
      },
    )
  })
}


#let thanks(thankstext: [Thank you for your attention!], body) = {
  polylux-slide({

    // One large area above and two columns below, resulting in 3 cells
    // But need two grids I guess. Probably possible to do with just one 2 column
    // situation below a normal area with some fixed vertical spacing.

    grid(
      columns: (100%),
      rows: (50%, 33%),
      gutter: 0pt,
      //cell()
      [
        #set align(center + horizon)
        #set text(fill: BIPSblue)
        #text(weight: "regular", size: 25pt)[#thankstext]

        #body

        #v(30%)
        #set text(size: 17pt)
        www.leibniz-bips.de/en
      ],
      //cell()
      [
        #grid(
          columns: (50%, 50%), rows: 1, gutter: 1em,
          //cell()
          [
            #set align(right + horizon)
            #set text(size: 17pt)
            #text(weight: "regular")[Contact] \
            #text(fill: BIPSblue)[Lukas Burk] \
            #BIPS_en \
            Achterstraße 30 \
            D-28359 Bremen \
            #link("burk@leibniz-bips.de")[burk\@leibniz-bips.de]
          ],
          //cell()
          [
            #set align(horizon + center)
            #logo()
          ]
        )
      ]
    )
  })
}
