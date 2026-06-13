# clang-format

## Based on style

Use option defaults from the `LLVM` style.

    BasedOnStyle: LLVM

## Pointer alignment

Align pointers and references to the left.

    PointerAlignment: Left

| Style     | Value | Value |
|:--------- |:----- |:----- |
| LLVM      | Right |       |
| GNU       | Right |       |
| Google    |       | Left  |
| Chromium  |       | Left  |
| Microsoft | Right |       |
| Mozilla   |       | Left  |
| WebKit    |       | Left  |

## Indentation

The following options are used when an indent of 4 columns is preferred.

    IndentWidth: 4
    AccessModifierOffset: -4
    ContinuationIndentWidth: 8
    ConstructorInitializerIndentWidth: 8

| Style     | Indent | Access | Continuation | Constructor |
|:--------- | ------:| ------:| ------------:| -----------:|
| LLVM      |      2 |     -2 |            4 |           4 |
| GNU       |      2 |     -2 |            4 |           4 |
| Google    |      2 |     -1 |            4 |           4 |
| Chromium  |      2 |     -1 |            4 |           4 |
| Microsoft |      4 |     -2 |            4 |           4 |
| Mozilla   |      2 |     -2 |            2 |           2 |
| WebKit    |      4 |     -4 |            4 |           4 |

## Column limit

The following option is used when a wider column limit is preferred.

    ColumnLimit: 120

| Style     | Value | Value | Value | Value |
|:--------- | -----:| -----:| -----:| -----:|
| LLVM      |       |    80 |       |       |
| GNU       |    79 |       |       |       |
| Google    |       |    80 |       |       |
| Chromium  |       |    80 |       |       |
| Microsoft |       |       |   120 |       |
| Mozilla   |       |    80 |       |       |
| WebKit    |       |       |       |     0 |

## Non-default options

The following non-default options, relative to `LLVM`, are used.

    AllowShortEnumsOnASingleLine: false
    AllowShortFunctionsOnASingleLine: Inline
    AlwaysBreakTemplateDeclarations: Yes
    PackConstructorInitializers: NextLine

### Allow short enumerations on a single line

`false` is used by Microsoft.

| Style     | Value | Value |
|:--------- |:----- |:----- |
| LLVM      | true  |       |
| GNU       | true  |       |
| Google    | true  |       |
| Chromium  | true  |       |
| Microsoft |       | false |
| Mozilla   | true  |       |
| WebKit    | true  |       |

### Allow short functions on a single line

`Inline` is used by Chromium and Mozilla.

| Style     | Value | Value  | Value |
|:--------- |:----- |:------ |:----- |
| LLVM      | All   |        |       |
| GNU       | All   |        |       |
| Google    | All   |        |       |
| Chromium  |       | Inline |       |
| Microsoft |       |        | None  |
| Mozilla   |       | Inline |       |
| WebKit    | All   |        |       |

### Always break template declarations

`Yes` is used by Google, Chromium, and Mozilla.

| Style     | Value     | Value |
|:--------- |:--------- |:----- |
| LLVM      | MultiLine |       |
| GNU       | MultiLine |       |
| Google    |           | Yes   |
| Chromium  |           | Yes   |
| Microsoft | MultiLine |       |
| Mozilla   |           | Yes   |
| WebKit    | MultiLine |       |

### Pack constructor initializers

`NextLine` is used by Google and Chromium.

| Style     | Value   | Value    |
|:--------- |:------- |:-------- |
| LLVM      | BinPack |          |
| GNU       | BinPack |          |
| Google    |         | NextLine |
| Chromium  |         | NextLine |
| Microsoft | BinPack |          |
| Mozilla   | BinPack |          |
| WebKit    | BinPack |          |

## Considered but rejected options

The following option values were considered but are not used.

    AllowShortFunctionsOnASingleLine: InlineOnly
    PackConstructorInitializers: Never

The following option was considered but is not used.

    BreakBeforeBraces: Stroustrup

### Break before braces

`Stroustrup` is not used by any style.

| Style     | Value  | Value   | Value  |
|:--------- |:------ |:------- |:------ |
| LLVM      | Attach |         |        |
| GNU       |        | GNU     |        |
| Google    | Attach |         |        |
| Chromium  | Attach |         |        |
| Microsoft |        |         | Custom |
| Mozilla   |        | Mozilla |        |
| WebKit    |        | WebKit  |        |
