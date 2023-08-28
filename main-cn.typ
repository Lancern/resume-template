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
  body: [
    云对雨，雪对风，晚照对晴空。来鸿对去燕，宿鸟对鸣虫。三尺剑，六钧弓，岭北对江东。人间清暑殿，天上广寒宫。两岸晓烟杨柳绿，一园春雨杏花红。两鬓风霜，途次早行之客；一蓑烟雨，溪边晚钓之翁。
  ],
)

= 工作经历
#work-item(
  "Google Corp.",
  "软件开发实习生",
  "2021.02",
  end-date: "2022.03",
  body: [
    沿对革，异对同，白叟对黄童。江风对海雾，牧子对渔翁。颜巷陋，阮途穷，冀北对辽东。池中濯足水，门外打头风。梁帝讲经同泰寺，汉皇置酒未央宫。尘虑萦心，懒抚七弦绿绮；霜华满鬓，羞看百炼青铜。
  ],
)
#work-item(
  "Microsoft Corp.",
  "软件开发实习生",
  "2022.03",
  body: [
    贫对富，塞对通，野叟对溪童。鬓皤对眉绿，齿皓对唇红。天浩浩，日融融，佩剑对弯弓。半溪流水绿，千树落花红。野渡燕穿杨柳雨，芳池鱼戏芰荷风。女子眉纤，额下现一弯新月；男儿气壮，胸中吐万丈长虹。
  ],
)

= 开发项目
#develop-item(
  "HackerA/ProjectA",
  "Rust, C",
  "开源贡献者",
  body: [
    春对夏，秋对冬，暮鼓对晨钟。观山对玩水，绿竹对苍松。冯妇虎，叶公龙，舞蝶对鸣蛩。衔泥双紫燕，课蜜几黄蜂。春日园中莺恰恰，秋天塞外雁雍雍。秦岭云横，迢递八千远路；巫山雨洗，嵯峨十二危峰。
  ],
)
#develop-item(
  "HackerB/ProjectB",
  "C++",
  "开源贡献者",
  body: [
    明对暗，淡对浓，上智对中庸。镜奁对衣笥，野杵对村舂。花灼烁，草蒙茸，九夏对三冬。台高名戏马，斋小号蟠龙。手擘蟹螯从毕卓，身披鹤氅自王恭。五老峰高，秀插云霄如玉笔；三姑石大，响传风雨若金镛。
  ],
)
#develop-item(
  "Hacker/ProjectC",
  "Agda",
  "拥有者",
  body: [
    仁对义，让对恭，禹舜对羲农。雪花对云叶，芍药对芙蓉。陈后主，汉中宗，绣虎对雕龙。柳塘风淡淡，花圃月浓浓。春日正宜朝看蝶，秋风那更夜闻蛩。战士邀功，必借干戈成勇武；逸民适志，须凭诗酒养疏慵。
  ],
)
#develop-item(
  "HackerD/ProjectD",
  "Zig",
  "开源贡献者",
  body: [
    楼对阁，户对窗，巨海对长江。蓉裳对蕙帐，玉斝对银釭。青布幔，碧油幢，宝剑对金缸。忠心安社稷，利口覆家邦。世祖中兴延马武，桀王失道杀龙逄。秋雨潇潇，漫烂黄花都满径；春风袅袅，扶疏绿竹正盈窗。
  ],
)
