#import "resume.typ": *

#show: resume.with(
  "惠计算",
  "139 1234 5678",
  "Huijisuan@hacker.com",
  webpage: "https://huijisuan.me",
  github-id: "Huijisuan",
  photo: image("figures/photo.png"),
  lang: "cn",
)

= 教育经历
#edu-item(
  "北京大学",
  "学士",
  "2016.08",
  end-date: "2020.07",
  major: "计算机科学与技术",
  body: [
    学分绩点位于前5%。
  ]
)
#edu-item(
  "清华大学",
  "硕士",
  "2020.08",
  major: "计算机科学与技术",
  supervisor: "吴建平",
)

= 专业技能
- *编程语言*：C / C++ / C\# / golang / Python / Rust / TypeScript / Zig
- *操作系统*：Linux / Windows
- *指令集架构*：x86_64 / ARMv8 / MIPS / CHERI / RISC-V
- *其他*：LLVM / CMake / git

= 获得奖项
#award-item(
  "ACM-ICPC 2018 EC-Final",
  "2018.11",
  "金牌"
)
#award-item(
  "ACM-ICPC 2018 World Final",
  "2019.04",
  "金牌"
)

= 科研经历
#resume-item(
  "P != NP",
  badge: "2020.12 - 2023.03",
  subtitle: "已投稿",
  body: lorem(20),
)

= 工作经历
#work-item(
  "Google Corp.",
  "软件开发实习生",
  "2021.02",
  end-date: "2022.03",
  body: lorem(40),
)
#work-item(
  "Microsoft Corp.",
  "软件开发实习生",
  "2022.03",
  body: lorem(40),
)

= 开发项目
#develop-item(
  "HackerA/ProjectA",
  "Rust",
  "开源贡献者",
  body: lorem(40),
)
#develop-item(
  "HackerB/ProjectB",
  "C++",
  "开源贡献者",
  body: lorem(40),
)
#develop-item(
  "Hacker/ProjectC",
  "Agda",
  "拥有者",
  body: lorem(40),
)
#develop-item(
  "HackerD/ProjectD",
  "Zig",
  "开源贡献者",
  body: lorem(40),
)
