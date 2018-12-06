# 💩 Big Size
WBS って デッカイ 💩 みたいじゃけぇ。

# Data Model

```
<構成>
+---------+  class:edge   +-----+  class:edge   +-------------+
| project |---:have-to--->| wbs |---:have-to--->| workpackage |
+---------+               +-----+               +-------------+


<予実>
+-------------+  class:edge   +----------+
| workpackage |---:have-to--->| schedule |
|             |               +----------+
|             |  class:edge   +----------+
|             |---:have-to--->| result   |
+-------------+               +----------+

<未使用>
+-----------+ +---------+ +----------+ +---------------+ +----------+
| Airtifact | | product | | estimate | | project-owner | | resource |
+-----------+ +---------+ +----------+ +---------------+ +----------+
```

# Author

Satoshi Iwasaki (yanqirenshi@gmail.com)

# Copyright

Copyright (c) 2014 Satoshi Iwasaki (yanqirenshi@gmail.com)

# License

Licensed under the LLGPL License.
