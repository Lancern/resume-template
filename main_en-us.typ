#import "resume.typ": *

#show: resume.with(
  "Knuth Hacker",
  "123-45678",
  "hacker@hacker.com",
  webpage: "https://hacker.me",
  github-id: "Hacker",
)

= Education
#edu(
  "Number One University",
  "Bachelor",
  "2016.08",
  end-date: "2020.07",
  major: "Software Engineering",
)[
  GPA: top 5%
]
#edu(
  "Number Two University",
  "Master",
  "2020.08",
  major: "Computer Science",
  supervisor: "Old Hacker",
)

= Professional Skills
- *Programming Languages*: C / C++ / C\# / golang / Python / Rust / TypeScript / Zig
- *OS*: Linux / Windows
- *ISA*: x86_64 / ARMv8 / MIPS / CHERI / RISC-V
- *Others*: LLVM / CMake / git

= Awards
#award(
  "ACM-ICPC 2018 EC-Final",
  "2018.11",
  "Gold Medal"
)
#award(
  "ACM-ICPC 2018 World Final",
  "2019.04",
  "Gold Medal"
)

= Research Experiences
#resume-item(
  "P != NP",
  badge: "2020.12 - 2023.03",
  subtitle: "Under peer review",
  lorem(20),
)

= Work Experiences
#career(
  "Google Corp.",
  "Software Development Intern",
  "2021.02",
  end-date: "2022.03",
  lorem(40),
)
#career(
  "Microsoft Corp.",
  "Software Development Intern",
  "2022.03",
  lorem(40),
)

= Hobby Projects
#project(
  "HackerA/ProjectA",
  "Rust, C",
  "Open-Source Contributor",
  lorem(40),
)
#project(
  "HackerB/ProjectB",
  "C++",
  "Open-Source Contributor",
  lorem(40),
)
#project(
  "Hacker/ProjectC",
  "Agda",
  "Owner",
  lorem(40),
)
