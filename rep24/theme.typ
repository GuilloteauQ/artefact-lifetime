#import "@preview/polylux:0.3.1": *


#let unibas-mint = rgb("#a5d7d2")
#let unibas-mint-light = rgb("#c0e3df")

#let unibas-theme(aspect-ratio: "16-9", body) = {
  set page(
    paper: "presentation-" + aspect-ratio,
    fill: white,
    margin: 0em,
    header: none,
    footer: none,
  )
  let unibas-marker = image("marker.svg", width: 4mm)
  set text(fill: white.darken(90%), size: 30pt, font: "Inconsolata")
  set list(marker: unibas-marker)
  body
}

#let title-slide(title: [], authors: (), date: [], event: []) = {
  let array_affiliations = authors.map(d => d.affiliation).dedup()
  let affiliations_str = array_affiliations.enumerate().map(x => {
     let (i, a) = x
     super(str(i + 1)) + a
  }).join("\n")
  let authors_str = authors.map(d => {
     let affiliation_index = array_affiliations.position(a => a == d.affiliation)
     if d.is_presenter { underline(d.name) } else { d.name } + super(str(affiliation_index + 1))
  }).join(", ", last: ", ")
  let content = {
    stack(
        block(width: 100%, height: 20%, fill: unibas-mint, place(horizon+left, dx: 2.5%, image("logo.svg", width: 20%))),
        block(width: 100%, inset: 0.8em, above: 0pt, below: 0pt, breakable: false, text(fill: black, size: 1.2em, title)),
        line(start: (2.5%, 0%), length: 95%, stroke: (paint: unibas-mint, thickness: 2pt, dash: "loosely-dashed")),
        block(width: 100%, height: 10%, inset: 0.8em, above: 0pt, below: 0pt, breakable: false, text(fill: black, size: 0.7em, authors_str)),
        block(width: 100%, inset: 0.8em, above: 0pt, below: 0pt, breakable: false, text(fill: black, size: 0.55em, date + " - " + emph(event))),
        parbreak(),
        block(width: 100%, inset: 0.8em, above: 0pt, below: 0pt, breakable: false, text(fill: black, size: 0.59em, affiliations_str)),
    )
  }
  polylux-slide(content)
}

#let m-cell = block.with(
  width: 100%,
  height: 100%,
  above: 0pt,
  below: 0pt,
  breakable: false
)

#let m-progress-bar = utils.polylux-progress( ratio => {
  grid(
    columns: (ratio * 100%, 1fr),
    m-cell(fill: unibas-mint, height: 200%),
    m-cell(fill: unibas-mint-light)
  )
})

#let new-section-slide(name) = {
  let content = {
    utils.register-section(name)
    set align(horizon)
    show: pad.with(20%)
    set text(size: 1.5em)
    name
    block(height: 2pt, width: 100%, spacing: 0pt, m-progress-bar)
  }
  polylux-slide(content)
}

#let slide(title: none, 
           presentation-title: [],
           presenter: [],
           body) = {
  let header = {
    set align(top)
    if title != none {
        block(width: 100%, inset: 0.8em, above: 0pt, below: 0pt, breakable: false, text(fill: black, size: 1.2em, title))
        line(start: (2.5%, 0%), length: 95%, stroke: (paint: unibas-mint, thickness: 2pt, dash: "loosely-dashed"))
    } else { [] }
  }

  let footer = stack(
      block(width:100%, height: 100%, breakable:false, 
              grid(columns: (65%, 25%, 10%), gutter: 0cm,
                      block(fill: unibas-mint, width: 100%, height: 100%, inset: 0.4em, align(horizon, text(fill: black, presentation-title, size: 0.6em))),
                      block(fill: unibas-mint-light, width: 100%, height: 100%, align(center+horizon, text(fill: black, presenter, size: 0.6em))),
                      block(fill: unibas-mint, width: 100%, height: 100%, align(center+horizon, text(fill: black, logic.logical-slide.display() + [/] + utils.last-slide-number, size: 0.6em))),
  )))

  set page(
    header: header,
	footer: footer,
    margin: (top: 3em, bottom: 1em),
  )

  let content = {
    show: align.with(horizon)
    show: pad.with(1em)
    set text(fill: black)
    body 
  }
  polylux-slide(content)
}

