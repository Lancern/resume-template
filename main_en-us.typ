#import "resume.typ": *

#show: resume.with(
  "Knuth Hacker",
  "123456789",
  "hacker@hacker.com",
  webpage: "https://hacker.me",
  github-id: "Hacker",
)

= Education
#edu-item(
  "Number One University",
  "Bachelor",
  "2016.08",
  end-date: "2020.07",
  major: "Software Engineering",
  body: [
    GPA: top 5%
  ]
)
#edu-item(
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
#award-item(
  "ACM-ICPC 2018 EC-Final",
  "2018.11",
  "Gold Medal"
)
#award-item(
  "ACM-ICPC 2018 World Final",
  "2019.04",
  "Gold Medal"
)

= Research Experiences
#resume-item(
  "P != NP",
  badge: "2020.12 - 2023.03",
  subtitle: "Under peer review",
  body: lorem(20),
)

= Work Experiences
#work-item(
  "Google Corp.",
  "Software Development Intern",
  "2021.02",
  end-date: "2022.03",
  body: lorem(40),
)
#work-item(
  "Microsoft Corp.",
  "Software Development Intern",
  "2022.03",
  body: lorem(40),
)

= Hobby Projects
#develop-item(
  "HackerA/ProjectA",
  "Rust, C",
  "Open-Source Contributor",
  body: lorem(40),
)
#develop-item(
  "HackerB/ProjectB",
  "C++",
  "Open-Source Contributor",
  body: lorem(40),
)
#develop-item(
  "Hacker/ProjectC",
  "Agda",
  "Owner",
  body: lorem(40),
)
