Find all imported packages in a directory tree of go source code. This is useful to find what dependencies a go project has.

    find . -name "*.go" -exec grep -Pzo "(?s)import \(.*?\)" {} \; | sort -u

1. recursively find all files with extension *.go
2. exec `grep -Pzo "(?s)import \(.*?\)" {} \;` on these files
  * http://stackoverflow.com/questions/3717772/regex-grep-for-multi-line-search-needed
3. sort result with unique option

Explanation:
* `-P` activate perl-regexp for grep (a powerful extension of regular extensions)
* `-z` suppress newline at the end of line, subtituting it for null character. That is, grep knows where end of line is, but sees the input as one big line.
* `-o` print only matching. Because we're using -z, the whole file is like a single big line, so if there is a match, the entire file would be printed; this way it won't do that.

In regexp:
* `(?s)` activate PCRE_DOTALL, which means that . finds any character or newline
* `.*?` find . in nongreedy mode, that is, stops as soon as possible.
