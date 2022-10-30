# 💩 Big Size
WBS って デッカイ 💩 みたいじゃけぇ。

# Usage

たぶんこんな感じ。

```
const ass = new Asshole();

const wbs_tree = Asshole.build(data);
```

# Files

## Asshole.js

### 1. build (params) => tree

params はこんな感じ。

```
{
    data: {
        projects:     { ht:{}, list: [] },
        wbs:          { ht:{}, list: [] },
        workpackages: { ht:{}, list: [] },
        edges:        { ht:{}, list: [] },
    },
    start_id: number,
    options: {
        hide: boolean,
        term: { start: null, end: null },
    }
}
```


## Wnqi.js

出てくるものは全部これ。

```
{
    _id:      null,
    _class:   null, // PROJECT | WBS | WORKPACKAGE
    label:    '',
    children: { ht:{}, list: [] },
    schedule: null, // { start: null, end: }
    result:   null, // { start: null, end: }
    order:    null, // sort order
};
```

1. label (core) => string
2. schedule (data) => data.schedule
   何してるんだっけ？
3. result (data) => data.result
   何してるんだっけ？
4. build (data) => new_data
   data の内容を template  整えて 返す

## Pool.js

Pool 管理クラス。(管理ではないか。。。)

Pool とはこれのこと。

```
{ list: list, ht: {} }
```

## Filter.js

階層での Filter クラス。

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
