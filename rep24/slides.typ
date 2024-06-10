#import "theme.typ": *

#show: unibas-theme.with()
#let unibas-mint = rgb("#a5d7d2")

// #set text(font: (
//   "Segoe UI Emoji"
// ))


#let pres_title = "Longevity of Artifacts in Leading Parallel and Distributed Systems Conferences: A Review of The State of the Practice in 2023"
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

#dslide(title: "Reproducibility Crisis")[
- TODO
- some baker et al
- in HPC: Hunold
]

#dslide(title: "Answer of the Community: Artifacts and Badges")[
- TODO: summary of the goal of AD/AE
- TODO: and some history
- In computer science: ACM gave some definitions @acm-badges
  - #emoji.medal.third  _Repeatability_ (Same team, same experimental setup)
  - #emoji.medal.second _Reproducibility_ (Different team, same experimental setup)
  - #emoji.medal.first  _Replicability_ (Different team, different experimental setup)

#align(center)[
#image("figs/badges.png", height: 32%)
]
]


#dslide(title: "Research Questions")[
#align(center)[
- RQ1: What are the current practices in Artifact Descriptions?
- RQ2: Is the reproducibility of the current practices satisfactory?
]


#sym.arrow.r *Let's review of the State of the Practice!*

]

#new-section-slide("Design of the Study")


#dslide(title: "Design of the study")[
- Parallel and Distributed systems conferences ("This is what we know/can judge")
- 5 Conferences of 2023 (with their CORE rank):
  - CCGrid (A), EuroSys (A), OSDI (A\*), PPoPP (A), SC (A) 
  - #sym.arrow.r 296 total papers
- 4 dimensions
  - Artifact badges and availability
  - Source code availability
  - Experimental platforms
  - Software environment
]

#dslide(title: "Survey Questions")[
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
	text[*Artifact badges*:],
	list([How many badges?], [Which badges?], [How many AD sections?])
    )
  ),
  block(
    width: 100%,
    stroke: unibas-mint,
    inset: 8pt,
    radius: 10pt,
    stack(
        spacing: 5%,
	text[*Artifact Availability*:],
	list([URL available? Valid?], [Git, Zenodo, ...?], [Fixed commit?])
    )
  ),
  block(
    width: 100%,
    stroke: unibas-mint,
    inset: 8pt,
    radius: 10pt,
    stack(
        spacing: 5%,
	text[*Experimental Platform*:],
	list([Which machines/platforms were used?])
    )
  ),
  block(
    width: 100%,
    stroke: unibas-mint,
    inset: 8pt,
    radius: 10pt,
    stack(
        spacing: 5%,
	text[*Software Environment*:],
	list([How was the software environment described and shared?])
	)
    )
)

]

// #dslide(title: "RQs: Artifact badges and availability")[
//     #align(center)[
// 	How many reproducibility badges were awarded and which badges were awarded to the article?
//     ]
// 
//     #align(center)[
// 	Does the article have an AD section?
//     ]
// ]
// 
// #dslide(title: "RQs: Source code availability")[
// 
// #align(center)[
// Whether the article shared the URL of the artifact (it does not have to be in the AD), and whether the URL is still valid?
// ]
// 
// #align(center)[
// How was the source code shared: git repository (e.g., GitHub, GitLab), Zenodo, or a combination of solutions?
// ]
// 
// #align(center)[
// If the source code has been shared via a git repository, we record the number of commits and check whether a precise commit was specified by the authors.
// ]
// ]
// 
// #dslide(title: "RQs: Experimental platforms")[
//     #align(center)[
// 	How were the experiments performed (e.g., local machines, shared test-beds, proprietary machines, supercomputers, simulation)?
//     ]
// ]
// 
// #dslide(title: "RQs: Software environment")[
//     #align(center)[
// 	How was the software environment described and shared?
//     ]
// ]

#new-section-slide("Observations and Findings")

#dslide(title: "Artifact badges")[
- TODO
- report number of paper
- how many with badges
- how many with AD
- how many with URL
- how many with invalid URL
- ...
]

#dslide(title: "Sharing the code/data")[
  #align(center)[
    #image("figs/how_repo_shared.svg", height: 75%)
  ]
  - mostly just a Git(Hub|Lab) URL and/or a Zenodo archive 
  - when just using `git`, 93% do not report the commit
]

#dslide(title: "Number of commits in the shared repository")[
  #align(center)[
    #image("figs/number_commits_repo.svg", height: 80%)
  ]
  - A lot of repositories are a "dump" of the artifact #sym.arrow.r no history / transparency
]

// #dslide(title: "Was the commit fixed?")[
//   #align(center)[
//     #image("figs/was_commit_fixed.svg", height: 100%)
//   ]
// ]

#dslide(title: "Where are the experiments done?")[
  #align(center)[
    #image("figs/experimental_setup.svg", width: 70%)
  ]
  - How to get access to *those* machines? #sym.arrow Azure/AWS/Google Cloud .... #emoji.money.wings
]


#dslide(title: "How is the software environment captured/described?")[
  #align(center)[
    #image("figs/sw_envs.svg", height: 100%)
  ]
]

#dslide(title: "The case of Containers")[
  #side-by-side(columns: (45%, 55%))[
    #align(center)[
	#image("figs/how_packaged.svg", width: 100%)
    ]
  ][
    #align(center)[
	#image("figs/image_cache_bin.svg", width: 100%)
    ]
  ]
    #align(center)[
	Containers are used in 12% of artifacts, but only 55% of them might be reusable...
    ]
]

#dslide(title: "Observation")[
- some kind of conclusion
]

#new-section-slide("Recommendations and Proposal for Artifact Longevity")

#dslide(title: "Recommendations for Artifact Longevity")[

#side-by-side(columns: (50%, 50%))[

=== Source code availability

  - For source code: Software Heritage
  - For data: Zenodo

=== Experimental setup

  - Shared Testbeds
    - (Grid'5000, Chameleon, CloudLab, etc.)

=== Software environments

  - Functional Package Managers (Nix, Guix)
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
	    image("figs/g5k_logo.png", height: 15%),
	    image("figs/chameleon_logo.jpg", height: 12%)
        )
	    #image("figs/cloudlab_logo.png", height: 8%)

	#stack(
	    dir: ltr,
	    spacing: 2mm,
	    image("figs/logo_nix.svg", height:  20%),
	    image("figs/Guix_logo.svg", height: 20%)
        )
	]
]
]

//#new-section-slide("Our Proposal")


#dslide(title: "Artifact Longevity Badge")[
  #align(center)[
    #emoji.sparkles #text(weight: "semibold")[A new badge!] #emoji.sparkles
    #image("figs/acm_badge.svg", height: 80%)
  ]
]

#dslide(title: "How to award the Artifact Longevity Badge?")[
#stack(
  side-by-side(columns: (45%, 55%))[
    - 0 to 4-point scale
    - 3 dimensions
      - Source code
      - Experimental setup
      - Software environment
    - Overal score = avg. per dimension
    - #text(weight: "semibold")[Award badge if overall score #sym.gt.eq 3]
  ][
    #align(center)[
	#image("figs/lifetime_score.svg", height: 95%)
    ]
  ],
align(center)[
#sym.arrow.r 1.2% (2) of the reviewed artifacts would have received the _Artifact Longevity_ badge
]
)
]

#new-section-slide("Conclusion and Perspectives")

#dslide(title: "Conclusion and Perspectives")[
#side-by-side(columns: (70%, 30%))[
== Conclusion
- State of the practive not satisfactory
- Artifacts lack longevity
- _Proposition_ of a new badge 
== Perspectives
- Exposing the variations in software environment from `Dockerfile`s
- Longitudinal study (in the past and future!)
  - *We need your feedback to refine the form!*

][
  #align(center)[
    #image("figs/acm_badge.svg", width: 100%)
  ]
]


]




// 
// 
// #dslide(title: "The Reproducibility Crisis")[
//   - Baker @baker2016reproducibility @baker500ScientistsLift2016 raised awarness about the issue
//   - since then all the fields of science are getting concerned/interested in repro
// 
//   === What is "Reproducibility"?
//   - It depends who you ask .... No consensus between sciences
//   - In computer science: ACM gave some definitions @acm-badges
//     - #emoji.medal.first _Repeatability_ (Same team, same experimental setup)
//     - #emoji.medal.first _Reproducibility_ (Different team, same experimental setup)
//     - #emoji.medal.first _Replicability_ (Different team, different experimental setup)
//   - some sciences use also the term "Robustness"
// 
// ]
// 
// #dslide(title: "What is the goal of Reproducibility?")[
//   - should not all research work be reproducible?
//   - is it a proof of the correctness of the work?
//   - restore trust in science
//   - or an effort so that future researchers can use the work?
//     - _"Standing on the shoulders of giants"_
//     - the objective: #emoji.sparkles precise introduction of Variation #emoji.sparkles
//   === Open Science and FAIR @openscience_unesco
//   - *F* indable, *A* ccessible, *I* nteroperable, *R* eusable
//   - Open Science: one key concept is "*Transparency*"
// ]
// 
// 
// #dslide(title: "What about in Computer Science?")[
//   #align(center)[_"Computers are deterministic, hence no reproducibility issues"_ -- a fool]
// 
//   //well.... #emoji.face.teeth
//   - floating point associativity ($round(a + round(b+c)) #sym.eq.not round(round(a+b)+c)$)
//   - order of compilation flags has an impact on the performance
//   - the size of the environment variable has an impact on performance @mytkowicz2009producing
//   - computers are physical machines: heat, noise?! #link("https://www.youtube.com/watch?v=tDacjrSCeq4")[#emoji.camera.movie]
//   - Experiments are _"quick"_ and _"free"_ #sym.arrow leads to some quick and dirty work
//   - Programming errors, mistakes (Excel #emoji.face.clown @lewis2021autocorrect)
//   - How to compare 2 solutions?
//   - many more...
// ]
// 
// #dslide(title: "Simulation of a drop of water " + cite(label("nheili2016first")))[
//     #only(1)[#align(center+horizon)[#image("figs/goutte1.svg", height:100%)]]
//     #only(2)[#align(center+horizon)[#image("figs/goutte2.svg", height:100%)]]
//     #only(3)[#align(center+horizon)[#image("figs/goutte3.svg", height:100%)]]
//     #only(4)[#align(center+horizon)[#image("figs/goutte4.svg", height:100%)]]
// ]
// 
// #dslide(title: "What does the community think?")[
//   - Hunold @hunold2015survey : Surveyed the HPC community in 2015
//     - 94% think the state of reproducibility needs to be improved
//     - 58% think that 10% of the papers in HPC are reproducible
//     - why not sharing code/data/scripts?
//       - 84% to retain a "competitive" advantage
//       - 87% it is not rewarding
//       - 90% irrelevant because evolution is too fast
//     - 42% think that their own work are mostly not reproducible
// ]
// 
// #dslide(title: text[_\"My dog ate my code_\"])[
//   #side-by-side(columns: (30%, 70%))[
//     - Collberg et al. @collberg_repeatability_2015 (2015)
//     - looked at 600 papers and try to get the code and reproduce the results
//     - and contacted the authors
//     - funny responses from the authors
//     ][
//     #align(center)[
//       #image("figs/collberg.png", width: 80%)
//     ]
//   ]
// ]
// 
// #dslide(title: "Some answers")[
// _"I am just hoping that it is
// a stable working version of the code, and matches the implementation
// we finally used for the paper. Unfortunately, *I have lost some data
// when my laptop was stolen last year*. The bad news is that *the code is
// not commented and/or clean*. So, I cannot really guarantee that you
// will enjoy playing with it."_
// 
// _"〈STUDENT〉was a graduate student in our program but *he left* a
// while back so I am responding instead. For the paper we used a
// prototype that included many moving pieces that *only 〈STUDENT〉
// knew how to operate* and we did not have the time to integrate them in
// a ready-to-share implementation before he left"_
// 
// _"Most importantly, *I do not have the bandwidth* to help anyone come up to
// speed on this stuff."_
// ]
// 
// 
// // #dslide(title: "How to compare two solutions?")[
// //   Imagine you are working on Problem $P$ and you find a solution $S_1$ and now you need to compare it to the state of the art (solution $S_0$).
// // 
// //   #align(center)[*How to compare the solutions?*]
// // 
// //   - if you reimplement $S_0$ and do not find the same results
// //     - did you do something wrong?
// //     - is the initial work not reproducible?
// //   - frameworks: benchopts, benchpress, kheops, ...
// // ]
// 
// 
// 
// #new-section-slide("Some recent findings")
// 
// #dslide(title: "Artifact Evaluation")[
//   - Conferences and journals are now having an \"Artifact Evaluation\" process to make sure that the accepted papers are \"reproducible\"
//   - Authors send their code, scripts, data and a description of how to use it
//   - then reviewers will try to rerun experiments
//   #side-by-side(columns: (60%, 40%))[
//   - the goals:
//     - validate results
//     - restore trust
//     - promote artifact sharing
//   //- If not reproduced, do the papers get rejected? No.
//   //- What is there to gain for the authors? Some badges!
//   ][
//   #align(center+horizon)[
//     #image("flake.png", width: 100%)
//   ]
//   ]
// ]
// 
// #dslide(title: "How are authors sharing their artifacts?")[
//   - Guilloteau, Ciorba  et al.
//   - Looked at 5 _top conferences_ of 2023 in HPC/distributed systems
//   - 296 papers in total
//   - 157 had an artifact description
//   - 101 had the top badge
//   - 168 URLs to code in the papers
//   - 154 URLs valid at the time of the study
// ]
// 
// #dslide(title: "Sharing the code/data")[
//   #align(center)[
//     #image("figs/how_repo_shared.svg", width: 70%)
//   ]
//   - mostly just a Git(Hub|Lab) URL and/or a Zenodo archive 
// ]
// 
// #dslide(title: "The worst case scenario")[
//   #align(center)[
//   What if GitHub closes?
//   What if the authors delete the repository?
// 
//   ]
// 
//   _"Bah! GitHub will never close!"_ (#emoji.face.teeth Google Code, Forge Inria)
// 
//   Can you imagine if the proof of a math paper disappears? (Fermat #emoji.face.inv)
// 
//   === Recommendation for long term archiving:
// 
//   - For source code: Software Heritage (UNESCO) #box(image("figs/swh.jpeg", width: 6%))
//   - For data: Zenodo (CERN)
// ]
// 
// #dslide(title: "Where are the experiments done?")[
//   #align(center)[
//     #image("figs/experimental_setup.svg", width: 70%)
//   ]
//   - How to get access to *those* machines? #sym.arrow Azure/AWS/Google Cloud .... #emoji.money.wings
// ]
// 
// #dslide(title: "How is the software environment captured/described?")[
//   #align(center)[
//     #image("figs/sw_envs.svg", height: 100%)
//   ]
// ]
// 
// #dslide(title: "Some software environments problems")[
// 
// - `requirements.txt` #sym.arrow.r what about the *other* dependencies?
// - List of packages (`apt install`) #sym.arrow.r what if forgotten packages? install *specific* version?
// - Module #sym.arrow.r what is their lifetime? how to share? how to modify?
// - Virtual Machines and Containers
//   - Binary format #sym.arrow.r no transparency! #sym.arrow.r better: the recipe (e.g., Dockerfile)
//   - Container #sym.arrow.r what about the OS/Kernel/Drivers ?
// - Spack ? #sym.arrow.r better but not (totally) reproducible
// - Perennity of the shared artifact?
// - Non-free software?
// ]
// 
// #dslide(title: "What is wrong with this Dockerfile?")[
// 
// ```Dockerfile
// FROM ubuntu
// RUN apt-get update -y && \
//     apt-get install -y \
//       build-essential\
//       ...\
//       simgrid
// RUN git clone https://github.com/JohnDoe/chord.git
// WORKDIR chord
// RUN curl -L https://tinyurl.com/patchchord -o increase-timeout.patch
// RUN git apply increase-timeout.patch
// RUN cmake .
// RUN make
// ENTRYPOINT ["./chord"]
// ```
// ]
// 
// #dslide(title: "What a \"complex\" software environment looks like")[
//   CiGri: a single component of the system during my PhD
//   #align(center)[
//     #image("figs/cigri_deps.svg", width: 100%)
//   ]
// 
//   #align(center)[
//     How to manage such software environments in a _reproducible_ way?
//   ]
// ]
// 
// #dslide(title: "Functional Package Managers")[
//   #side-by-side(columns: (55%, 45%))[
//   - Nix @dolstra_nix_2004, Guix @courtes_functional_2013: reproducible by design!
//   - packages = functions
//     - inputs = dependencies
//     - body = commands to build the package
//   //- base packages defined in Git
//   - sandbox, no side effect
//   - `/nix/store/hash(inputs)-my-pkg`
//   - immutable, read-only
//   - precise definition of \$PATH
//   - can build: container, VM, etc.
//   ][
//   #only(1)[#align(center+horizon)[#image("figs/func1_shape.svg", height:100%)]]
//   #only(2)[#align(center+horizon)[#image("figs/func2_shape.svg", height:100%)]]
//   ]
// 
// ]
// 
// #new-section-slide("Workflow")
// 
// 
// #dslide(title: "Doing experiments")[
// 
//   #align(center)[
//     #alternatives[Never][NEVER][*NEVER*][#text(fill: red)[*NEVER*]] do experiments by hand
//   ]
// 
//   #align(center)[
//     #image("figs/phdc_expes.gif")
//   ]
// ]
// 
// #dslide(title: "State of the Practice")[
// 
//   The state of the practice:
//   #align(center)[
//     copy-paste commands from a readme or long bash scripts #emoji.face.teeth
//   ]
// 
//   - error-prone
//   - not robust
//   - not extensible
//   - not scalable
// 
//   === Then what to use?
// 
//   #align(center)[#emoji.sparkles #text(size: 30pt)[Workflow Managers] #emoji.sparkles]
// ]
// 
// #dslide(title: "Workflow Managers")[
// 
// - For example: Snakemake @koster2012snakemake, Nextflow @di2017nextflow
// - Like Make, but better
// - express the workflow as `rule`s that take `input`s and give `output`s
// - manages the dependencies 
//   - if an input is updated, will re-run everything that depended on this input, and so on
// - great expressiveness
// - scalable, integration with SLURM, K8S, etc.
// - shareable (CWL)
// - extendable
// ]
// 
// #dslide(title: "An example")[
// 
// #side-by-side(columns: (30%, 70%))[
//   === Scenario
//   - parallel matrix multiplication code
//   - several input matrices
//   - several number of threads
//   - several scheduling strategies (LB4OMP)
// ][
// ```
// rule expe:
//   input:
//     bin="my_mat_mult",
//   output:
//     "data/{matrix}/{sched}/{nb_threads}/{iter}.csv"
//   shell:
//     "OMP_SCHEDULE={wildcards.sched}\
//      OMP_NUM_THREADS={wildcards.nb_threads}\
//      {input.bin} {wildcards.matrix} > {output}"
// ```
// ]
// 
// #align(center)[#sym.arrow "I want `data/webbase01/VISS/20/1.csv`"]
// 
// ]
// 
// #new-section-slide("Conclusion")
// 
// #dslide(title: "Checklist for your future")[
//   - Use Git
//   - Do not be shy to share everything (code, data, metadata)
//   - Automatize as much as possible
//   - Pay attention to your plots #link("https://github.com/cxli233/FriendsDontLetFriends")[#emoji.chart.bar]
//   - Pay attention to your statistical analysis
//   - Benchmarking crimes @van2018benchmarking
//   - Statistical dances #link("https://videos.univ-grenoble-alpes.fr/video/18432-statistical-dances-why-no-statistical-analysis-is-reliable-and-what-to-do-about-it/")[#emoji.camera.movie]
// 
// ]
// 
// 
// #dslide(title: "Conclusion")[
//   
//   - Reproducibility is gaining in importance in the scientific community
//   - Computer Science and HPC are also victims
//   - The state of the practice is not good enough!
//   - It is also *your* role to educate your peers on these problematics
//   - Machine Learning? #link("https://www.youtube.com/watch?v=Kee4ch3miVA")[#emoji.camera.movie]
// 
//   
//   MOOCS:
//     - MOOC RR1 #link("https://www.fun-mooc.fr/fr/cours/recherche-reproductible-principes-methodologiques-pour-une-science-transparente/")[#emoji.books]
//     - MOOC RR2 #link("https://www.fun-mooc.fr/en/courses/reproducible-research-ii-practices-and-tools-for-managing-comput/")[#emoji.books] (starting in a few days)
// 
//   #pause
//   #align(center)[What about the environmental cost of Reproducibility?]
// ]
// 
// #dslide(title: "Next week (2nd of May)")[
//   #align(center+horizon)[
//     _Ch.08 Performance engineering_ by Jonas Müller Korndörfer
//   ]
// ]

#bibliography("references.bib")

