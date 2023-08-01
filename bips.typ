#import "@preview/polylux:0.2.0": *


#let BIPS_en = [Leibniz Institute for Prevention Research and Epidemiology -- BIPS]
#let BIPS_de = [Leibniz-Institut für Präventionsforschung und Epidemiologie -- BIPS]

#let bips-colors = (
  white: rgb(253, 253, 253),
  blue: rgb(23, 99, 170),
  gray: rgb(66, 66, 66),
  orange: rgb(250, 133, 55),
  green: rgb(49, 210, 57)
  )

#let base-size = 22pt
#let title-size = 42pt
#let header-size = 28pt

//#let base-size = 2em
//#let title-size = 1em
//#let header-size = 1.05em

#let bips-author-main = state("bips-author-main", none)
#let bips-author-main-email = state("bips-author-main-email", none)
#let bips-lang = state("bips-lang", "english")
#let bips-institute-name = state("bips-institute-name", none)
#let bips-institute-web = state("bips-institute-web", none)
#let bips-contact-header = state("bips-contact-header", none)
#let bips-logo = state("bips-logo", none)

// #let divider = line.with(length: 90%, stroke: rgb("e4e5ea"))

#let gradient(height: 2pt) = {
  box(width: 90%,
    for x in range(150, 250, steps: 1) {
      box(rect(width: 1%, height: height, fill: luma(x)))
    }
  )
}

#let title-case(string) = {
  string.replace(
    regex("[A-Za-z]+('[A-Za-z]+)?"),
    word => upper(word.text.first()) + lower(word.text.slice(1)),
  )
}

// Pre-set block of logo in top right, with or without numbering (for title slide)
// This feels pretty weird syntactically.
#let logoblock(number: true) = {
  locate(loc => {
    let logo_img = image(bips-logo.at(loc), height: 15%, width: auto)

    // Workaround until polylux is updated to export logic module
    // https://github.com/andreasKroepelin/polylux/issues/61#issuecomment-1654348478
    let slide_num = themes.simple.logic.logical-slide.display()

    set align(top + right)
    set text(size: 20pt)

    if (number) {
      pad(rest: 30pt)[
        #logo_img
        #pad(right: 35pt, top: -14pt, slide_num)
      ]
    } else {
      pad(rest: 30pt, logo_img)
    }
  })
}

// This feels poorly thought out. It is.
#let logo(height: 100%, width: auto) = {
  locate(loc => {
    image(bips-logo.at(loc), height: height, width: width)
  })

  //image(logo, height: height, width: width)
}

#let bips-theme(
  aspect-ratio: "16-9",
  author_corresponding: (name: none, email: none),
  logo: "logo.png",
  lang: "english",
  body) = {

  set page(
    paper: "presentation-" + aspect-ratio,
    fill: bips-colors.white,
    margin: (x: 10%, top: 0%, bottom: 5%)
  )

  // Not sure if necessary to adapt text
  // language and region settings
  let text-lang = (lang: none, region: none)

  if (lang == "english") {
    text-lang = (lang: "en", region: "US")
  } else if (lang == "german") {
    text-lang = (lang: "de", region: "DE")
  }

  // Default text options for slide contents
  set text(
    fill: bips-colors.gray,
    size: base-size,
    font: "Fira Sans",
    weight: "light",
    lang: text-lang.lang,
    region: text-lang.region
  )



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
    #set text(size: title-size, fill: bips-colors.blue, weight: "regular")
    #block(it.body)
  ]

  show heading.where(level: 2): it => [
    #set align(center)
    #set text(size: header-size, fill: bips-colors.blue, weight: "regular")
    #block(it.body)
  ]

  show raw.where(block: true): it => {
    set text(font: "Fira Mono", size: base-size - 7pt)
    it
  }

  bips-author-main.update(author_corresponding.name)
  bips-author-main-email.update(author_corresponding.email)
  bips-lang.update(lang)
  bips-logo.update(logo)

  body
}

#let title-slide(
  title: [],
  subtitle: [],
  author: none,
  institute: none,
  date: datetime.today().display(),
  occasion: none
) = {
  polylux-slide({
  // Setting this inside here messes up layout by introducing empty space,
  // setting it outside polylux-slide() also causes issues down the line.
  // set page(background: logoblock(number: false))

  // This is scuffed.
    pad(top: 30pt, right: -50pt, align(right + top, logo(height: 15%)))

    if (author == none) {
      author = bips-author-main.display()
    }

    if (institute == none) {
      locate(loc => {
        if (bips-lang.at(loc) == "english") {
          bips-institute-name.update(BIPS_en)
        } else if (bips-lang.at(loc) == "german") {
          bips-institute-name.update(BIPS_de)
        }
      })
    } else {
      bips-institute-name.update(institute)
    }

    set align(center + horizon)

    heading(level: 1, title-case(title))
    set text(fill: bips-colors.blue)
    text(subtitle, weight: "regular")

    v(5%)

    set text(size: 20pt)

    author
    parbreak()

    set text(fill: bips-colors.gray)

    bips-institute-name.display()
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
        pad(right: 8%, heading(level: 2, title))
      },
      align(horizon, gradient()),
      //cell()
      {
        set align(left + horizon)
        text(body, fill: bips-colors.gray)
      },
    )
  })
}


#let thanks(thankstext: [], body) = {
  polylux-slide({

    locate(loc => {
      if (bips-lang.at(loc) == "english") {
        bips-contact-header.update("Contact")
        bips-institute-web.update(link("https://leibniz-bips.de/en")[www.leibniz-bips.de/en])
      } else if (bips-lang.at(loc) == "german") {
        bips-contact-header.update("Kontakt")
        bips-institute-web.update(link("https://leibniz-bips.de")[www.leibniz-bips.de])
      }
    })


    // One large area above and two columns below, resulting in 3 cells
    // But need two grids I guess. Probably possible to do with just one 2 column
    // situation below a normal area with some fixed vertical spacing.

    grid(
      columns: 1,
      rows: (10%, 40%, 10%, 40%),
      gutter: 0em,
      [], // Should have maybe set a top margin instead
      //cell()
      [
        #set align(center + horizon)
        #set text(fill: bips-colors.blue)
        #text(weight: "regular", size: 25pt)[#thankstext]

        #body
      ],
      //cell()
      [
        #set align(center + top)
        #set text(size: 1em)
        #bips-institute-web.display()
      ],
      //cell()
      [
        #grid(
          columns: (55%, 45%), rows: 100%, gutter: 0em,
          //cell()
          [
            #set align(right + horizon)
            #set text(size: 0.85em)
            #set par(leading: 0.75em) // Default 0.7em I think

            #text(weight: "regular")[#bips-contact-header.display()] \
            #text(fill: bips-colors.blue)[#bips-author-main.display()] \
            #bips-institute-name.display() \
            Achterstraße 30 \
            D-28359 Bremen \
            #bips-author-main-email.display()

          ],
          //cell()
          [
            #set align(right + horizon)
            #logo(height: 80%)
          ]
        )
      ]
    )
  })
}

#let slide-references(
  title: none,
  bib: "references.bib",
  style: "apa",
  text_size: base-size - 10pt,
  body) = {

  set page(background: logoblock(number: false))

  polylux-slide({

    let bib = bibliography(bib, title: none, style: style)

    grid(
      columns: (100%),
      rows: (20%, 1%, 79%),
      gutter: 0pt,
      [
        #set align(horizon)
        #set pad(right: 8%)
        #heading(level: 2, title)
      ],
      align(horizon, gradient()),
      //cell()
      [
        #set align(left + horizon)
        #set text(fill: bips-colors.gray, size: text_size)
        #bib
      ],
    )
  })
}
