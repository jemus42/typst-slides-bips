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

      for i in range(10, steps: 1) {
        box(rect(width: 0.1%, height: height, fill: luma(x)))
      }
    }
  )
}

#let title-case(string) = {
  return string.replace(
    regex("[A-Za-z]+('[A-Za-z]+)?"),
    word => upper(word.text.first()) + lower(word.text.slice(1)),
  )
}

#let logoblock(logo: "bips-logo.png") = {
  [
      #let logo_img = image(logo, height: 15%)

      #set align(top + right)
      #set text(size: 20pt)
      #pad(rest: 30pt,
        box([
          #logo_img
            #pad(right: 35pt, top: -14pt, logic.logical-slide.display())
          ])
      )
    ]
}

#let bips-theme(
  aspect-ratio: "16-9", logo: "bips-logo.png", german: false,
  body) = {

  set page(
    paper: "presentation-" + aspect-ratio,
    fill: background-color,
    margin: (x: 10%, top: 0%, bottom: 8%)
  )


  set text(
    fill: BIPSgray, size: base_size, font: "Fira Sans", weight: "light"
  )

  show heading: set text(weight: "light")

  show heading.where(level: 1): it => [
    #set align(center)
    #set text(size: title_size, fill: BIPSblue, weight: "light")
    #block(it.body)
  ]

  show heading.where(level: 2): it => [
    #set align(center)
    #set text(size: header_size, fill: BIPSblue, weight: "light")
    #block(it.body)
  ]

  body
}

#let title-slide(
  title: [],
  subtitle: [],
  author: none,
  institute: BIPS_en,
  date: datetime.today().display(),
  occasion: none
) = {
  polylux-slide({

    set align(center + horizon)

    heading(level: 1, title-case(title))
    set text(fill: BIPSblue)
    subtitle

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
  inset: 8pt,
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
