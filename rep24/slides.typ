#import "theme.typ": *

#show: unibas-theme.with()
#let unibas-mint = rgb("#a5d7d2")
#let unibas-badge = rgb("#006e6e")

#show figure.caption: it => [
  #text(size: 15pt)[#it.supplement: #it.body]
]


#let takeaway(body, slide: 2) =  {
  only(slide)[
    #place(
	top + left,
	dx: -10%,
	dy: -50%,
	rect(
	    width: 120%,
	    height: 200%,
	    fill: rgb(100, 100, 100).transparentize(50%)
	)
     )
    #place(
	center + horizon,
	rect(
	    width: 100%,
    	    radius: 10pt,
	    height: 20%,
	    stroke: 3pt+unibas-mint,
	    fill: white
	)[#sym.arrow.r #body]
     )
  ]
}


// #set text(font: (
//   "Segoe UI Emoji"
// ))


#let pres_title = "Longevity of Artifacts in Leading Parallel and Distributed Systems Conferences:\nA Review of The State of the Practice in 2023"
#let short_title = "Longevity of Artifacts: Review of the State of the Practice in 2023 (hal-04562691)"
#let presenter = "Quentin Guilloteau"
#let date = "June 19th 2024"
#let event = "ACM Conference on Reproducibility and Replicability 2024"

#let authors = (
  (name: [Quentin Guilloteau], affiliation: [University of Basel, Switzerland], is_presenter: true), 
  (name: [Florina M. Ciorba],  affiliation: [University of Basel, Switzerland], is_presenter: false), 
  (name: [Millian Poquet],     affiliation: [Univ. Toulouse, CNRS, IRIT], is_presenter: false), 
  (name: [Dorian Goepp],       affiliation: [Univ. Grenoble Alpes, Inria, CNRS, LIG], is_presenter: false), 
  (name: [Olivier Richard],    affiliation: [Univ. Grenoble Alpes, Inria, CNRS, LIG], is_presenter: false)
)

#let dslide(raw-font-size: 20pt, ..args) = {
  show raw: set text(font: "Inconsolata", weight: "semibold", size: raw-font-size)
  // show raw: set text(font: "Segoe UI Emoji", weight: "semibold", size: raw-font-size)
  slide(presenter: presenter, presentation-title: short_title, ..args)
}


#title-slide(title: pres_title, authors: authors, date: date, event: event)
#set text(22pt)

#dslide(title: "Reproducibility Crisis (in Parallel/Distributed Computing)")[
#align(center)[
    #only(1)[#figure(image("figs/hunold.png", width: 100%), caption: [From Hunold 2015 @hunold2015survey])]
    #only(2)[#figure(image("figs/hunold2.png", height: 100%), caption: [From Hunold 2015 @hunold2015survey])]
    #only((beginning: 3))[
	#figure(
		image("figs/hunold2.png", height: 100%),
		caption: [From Hunold 2015 @hunold2015survey]
	)
	#place(
	    top + left,
	    dx: 22%,
	    dy: 60%,
	    rect(
		width: 52%,
		height: 20pt,
		stroke: 3pt + red
	    ),
	 )
      ]
    ]
    #takeaway(slide: 4)[But this was 10 years ago, surely it has changed]
]

#dslide(title: "Community Answer: Artifact Description/Evaluation and Badges")[
#side-by-side(columns: (60%, 40%))[
- Validate/Promote/#underline[Reward]
- First: 2011 at the ESC/FSE conference
- In computer science: ACM gave definitions @acm-badges
  - #emoji.medal.third  _Repeatability_ (Same team, same setup)
  - #emoji.medal.second _Reproducibility_ (Different team, same setup)
  - #emoji.medal.first  _Replicability_ (Different team, different setup)

#align(center)[
#image("figs/badges.png", height: 32%)
]
][
#align(center)[
#figure(
image("figs/ad_sc24.png", width: 100%),
caption: [Artifact description template (SC24)]
)
]
]
]

#dslide(title: "Benefits of the Artifact Evaluation")[
// == For who is the artifact evaluation beneficial?
// == Benefits of Artifact Evaluation
- Authors of the article? #sym.arrow.r Reward, visibility
- Publication venue (Journals/Conferences)? #sym.arrow.r Advertisment/Promotion (?)
- Future researchers? #sym.arrow.r Easier access to artifact, can audit/reproduce/extend

== Our claim
#align(center)[
	*All of the above, but mainly for #underline[future researchers]* (including oneself)
]

- #underline[Science]: self-correcting process, _"standing on the shoulders of giants"_
- This requires #text(unibas-badge, weight: "bold")[Longevous Artifacts]
- The dream: #emoji.sparkles precise introduction of Variation #emoji.sparkles
]


#dslide(title: "Research Questions (in the context of Parallel/Distributed Computing)")[
== #text(unibas-badge)[RQ1]: What are the current practices in research artifacts?
== #text(unibas-badge)[RQ2]: Is the reproducibility of the current practices satisfactory?
#v(20%)
#align(center)[
#sym.arrow.r *Let's review of the state of the practice!*
]

]

#new-section-slide("Study Design")


#dslide(title: "Study Design")[
- *Leading* Parallel and Distributed systems conferences//("This is what we know/can judge")
- 5 conferences of 2023 (CORE ranking):
  - CCGrid (A), EuroSys (A), OSDI (A\*), PPoPP (A), SC (A) 
  - with a Artifact Description (AD) / Artifact Evaluation (AE) process #emoji.hands.clap
  //- #sym.arrow.r 296 total papers
#side-by-side(columns: (52%, 48%))[
- 4 dimensions
  - AD and badges (available & reproduced)
  - Artifact availability
  - Software environment
  - Experimental platforms
][
#align(center)[
  #block(
    width: 90%,
    stroke: unibas-mint,
    fill: luma(230),
    inset: 8pt,
    radius: 10pt,
    stack(
	spacing: 4%,
	stack(
	    dir: ltr,
	    spacing: 2mm,
	    image("figs/ccgrid23.png", height: 13%),
	    image("figs/eurosys23.png", height: 13%)
	),
	stack(
	    dir: ltr,
	    spacing: 2mm,
	    image("figs/sc23.png", height: 13%),
	    image("figs/osdi23.png", height: 13%)
	),
	text(white, font: "PT Sans", size: 35pt, weight: "semibold")[PPoPP]
    )
  )
]
]
]

#dslide(title: "Study Questions")[
#pause
#grid(
  columns: (50%, 50%),
  gutter: 10pt,
  block(
    width: 100%,
    stroke: unibas-mint,
    inset: 8pt,
    radius: 10pt,
    stack(
        spacing: 5%,
	text[*1. Artifact Badges*:],
	list([How many badges?], [Which badges?], [How many AD sections?]),
	pause
    )
  ),
  block(
    width: 100%,
    stroke: unibas-mint,
    inset: 8pt,
    radius: 10pt,
    stack(
        spacing: 5%,
	text[*2. Artifact Availability*:],
	list([URL available? Valid?], [GitHub, Zenodo, ...?], [Fixed commit hash?]),
	pause
    )
  ),
  block(
    width: 100%,
    stroke: unibas-mint,
    inset: 8pt,
    radius: 10pt,
    stack(
        spacing: 5%,
	text[*3. Software Environment*:],
	list([How was the software environment described and shared?]),
	pause
	)
    ),
  block(
    width: 100%,
    stroke: unibas-mint,
    inset: 8pt,
    radius: 10pt,
    stack(
        spacing: 5%,
	text[*4. Experimental Platform*:],
	list([Which machines/platforms were used?])//, [Still alive?])
    )
  )
)

]

#new-section-slide("Observations and Findings")

#dslide(title: "1. Artifact Descriptions and Badges")[
#side-by-side(columns: (60%, 40%))[
- 296 papers
- 157 Artifact Descriptions
  - 53% of papers
- 168 artifact links, 154 valid at the time of the study
- 161 "Artifacts Available" Badges
  - 54% of papers, 102% of ADs #emoji.face.think
- 101 got the top badge #emoji.medal.first 
  - 34% of papers, 64% of ADs
][
#figure(
image("figs/retracted.jpg", width: 90%),
caption: [Retracted link]
)
#figure(
image("figs/screenshot.png", width: 80%),
caption: [Screenshot as proof]
)
]
]

#dslide(title: "2. Artifacts Sharing")[
  #align(center)[
    #image("figs/how_repo_shared.svg", height: 75%)
  ]
  - mostly a Git(Hub|Lab) URL and/or a Zenodo archive 
  - when only using `git`, 93% do not report the commit
  #takeaway[What if GitHub disappears? Partial exploration of the Artifacts?]
]

#dslide(title: "Number of commits in the shared repository")[
  #align(center)[
    #image("figs/number_commits_repo.svg", height: 72%)
  ]
  - A lot of repositories are a "dump" of the artifact #sym.arrow.r no history / transparency?
#side-by-side(columns: (35%, 65%))[
- What about `.git` in Zenodo?
][
  #align(center)[
    #stack(dir: rtl,
           spacing: 2%,
	   emoji.face.teeth,
    	   image("figs/single_commit.png", height: 6%)
	   )
  ]
]
  #takeaway[Is the preparation of the Artifacts an "after-thought" for the authors?]
]


#dslide(title: "3. How are the software environments captured/described?")[
  #align(center)[
    #image("figs/sw_envs.svg", height: 100%)
  ]
  #takeaway[Software environments are _partially_ described, difficult to exactly rebuild]
]

#dslide(title: "3. The case of Containers")[
  #side-by-side(columns: (40%, 60%))[
    #align(center)[
	#image("figs/how_packaged.svg", width: 100%)
    ]
  ][
    #align(center)[
	#image("figs/image_cache_bin.svg", width: 90%)
    ]
  ]
  - Binary cache #sym.arrow.r e.g., DockerHub; Long-term binary cache #sym.arrow.r e.g., Zenodo
  #only((beginning: 2))[
    #place(
	center + horizon,
	rect(
	    width: 100%,
	    stroke: 3pt+unibas-mint,
	    fill: white
	)[#image("figs/nvidia.png", width: 95%)]
     )
    #place(
	top + left,
	dx: 46%,
	dy: 42%,
	rect(
	    width: 41.5%,
	    height: 23pt,
	    stroke: 3pt + red
	),
	)
  ]
  #takeaway(slide: 3)[Containers are used in 20% of artifacts, but only 56% of them might be reusable...]
]

#dslide(title: "4. Where are the experiments executed?")[
  #align(center)[
    #image("figs/experimental_setup.svg", width: 65%)
  ]
  - How to get access to *those* machines? #sym.arrow Azure/AWS/Google Cloud .... #emoji.money.wings
  #takeaway[Difficult to get access to the same machines, and if so: for *how long*?]
]


#dslide(title: "Experiments and Workflow Managers")[
#side-by-side(columns: (61%, 39%))[
- #text(weight: "semibold")[Not part of the study design]
- How is the execution of the experiments managed?
    - Large bash files
    - Copy-pasting commands from the README
- #text(weight: "semibold", unibas-mint)[No usage of Workflow managers]
  - (Snakemake, Nextflow, Luigi, etc.)
][
#align(center)[
#image("figs/snakemake.svg", width: 35%)
#image("figs/nextflow.svg", width: 80%)
#image("figs/luigi.png", width: 50%)
]
]
]

//#dslide(title: "Observation")[
//- some kind of conclusion
//]

#new-section-slide("Proposal for Artifact Longevity and Recommendations")

#dslide(title: [A Needed Badge?: #box(height: 23pt, emoji.sparkles) Artifact Longevity #box(height: 23pt, emoji.sparkles)])[
  #align(center)[
    // #emoji.sparkles #text(weight: "semibold")[A new badge!] #emoji.sparkles
    #image("figs/acm_badge.svg", height: 80%)


    #text(size: 20pt)[Do you agree? Let's discuss!]
  ]
]

#dslide(title: [What is the Artifact Longevity (AL) Badge?])[
#stack(
  side-by-side(columns: (45%, 55%))[
    - 3 dimensions of AD
      - Artifact availibility
      - Software environment
      - Experimental platform
    - 0 to 4-point scale per dimension
    - Overal score = avg. per dimension
    #text(weight: "semibold")[Overall score #sym.gt.eq 3 #sym.arrow.r.double Badge awarded]
  ][
    #align(center)[
	#image("figs/lifetime_score.svg", height: 95%)
    ]
  ],
align(center)[
#sym.arrow.r 2 out of 168 of the reviewed artifacts potentially awarded the #text(unibas-badge)[_AL_] badge
]
)
]


#dslide(title: "Recommendations to Improve Artifact Longevity")[

#side-by-side(columns: (50%, 50%))[

=== Source code availability

  - For source code: Software Heritage
  - For data: Zenodo

=== Software environments

  - Functional Package Managers
    - (Nix, Guix)

=== Experimental platforms

  - Shared Testbeds
    - (Grid'5000, Chameleon, CloudLab, etc.)
][
#align(center)[
	#stack(
	    dir: ltr,
	    spacing: 2mm,
	    image("figs/swh_logo.svg", height: 13%),
	    image("figs/zenodo_logo.svg", height: 13%)
	)

	#stack(
	    dir: ltr,
	    spacing: 2mm,
	    image("figs/logo_nix.svg", height:  20%),
	    image("figs/Guix_logo.svg", height: 20%)
        )

	#stack(
	    dir: ltr,
	    spacing: 2mm,
	    image("figs/g5k_logo.png", height: 15%),
	    image("figs/chameleon_logo.jpg", height: 12%)
        )
	    #image("figs/cloudlab_logo.png", height: 8%)

	]
]
]

// #dslide(title: "TODO")[
// - explain a bit for each of the previous recommendations
// - one slide each
// ]



#new-section-slide("Conclusion and Perspectives")

#dslide(title: "Conclusion and Perspectives")[
#side-by-side(columns: (75%, 25%))[
== Conclusion
- AD/AE good for Science, but can be improved!
// - AD/AE good for Open Science/Reproducibility
//   - but can be improved!
- State of the practice unsatisfactory #sym.arrow.r #text(unibas-badge)[*Lacks _"Longevity"_*]
- Proposed a much #text(unibas-badge, weight: "semibold")[needed badge]
== Perspectives
//- Exposing variations in SW environment from `Dockerfile`s
- Longitudinal study (from recent past to near term!)
  - *We need #underline[your help] to re(de)fine the study questions!*
- Is the existing badging system _really_ enough?
- Environmental cost of AE?

][
  #align(center)[
    #image("figs/acm_badge.svg", height: 45%)

    #image("figs/qr-code-survey.svg", height: 25%)
    Take our survey! #emoji.face.happy
  ]
]

]


#bibliography("references.bib")

