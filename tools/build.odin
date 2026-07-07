package main

import "core:fmt"
import "core:os"
import "core:strings"

Segment :: struct {
	docs: string,
	code: string,
}

main :: proc() {
	examples := read_examples()
	fmt.println("Building", len(examples), "examples...")

	footer  := read_template("templates/footer.html")
	index_t := read_template("templates/index.html")
	ex_tmpl := read_template("templates/example.html")
	css     := read_template("templates/site.css")
	js      := read_template("templates/site.js")
	clipboard := read_template("templates/clipboard.svg")

	os.make_directory("public")

	links := make([dynamic]string)
	defer delete(links)

	for ex, i in examples {
		title, segments, ok := parse_example(ex)
		if !ok {
			continue
		}

		dir := strings.concatenate({"public/", ex})
		os.make_directory(dir)

		segments_html := render_segments(segments[:])
		prev_next := render_prev_next(examples[:], i)

		page := ex_tmpl
		page, _ = strings.replace_all(page, "{{Title}}", title)
		page, _ = strings.replace_all(page, "{{ID}}", ex)
		page, _ = strings.replace_all(page, "{{Segments}}", segments_html)
		page, _ = strings.replace_all(page, "{{PrevNext}}", prev_next)
		page, _ = strings.replace_all(page, "{{Footer}}", footer)

		out_path := strings.concatenate({"public/", ex, "/index.html"})
		if werr := os.write_entire_file(out_path, transmute([]byte)page); werr != nil {
			fmt.eprintln("ERROR: could not write", out_path)
		}

		link := fmt.tprintf("<li><a href=\"/%s\">%s</a></li>", ex, title)
		append(&links, strings.clone(link))

		fmt.println("  built:", ex)
	}

	// Index page
	idx := index_t
	idx, _ = strings.replace_all(idx, "{{Examples}}", strings.join(links[:], "\n"))
	idx, _ = strings.replace_all(idx, "{{Footer}}", footer)
	if werr := os.write_entire_file("public/index.html", transmute([]byte)idx); werr != nil {
		fmt.eprintln("ERROR: could not write public/index.html")
	}

	// Copy CSS
	if werr := os.write_entire_file("public/site.css", transmute([]byte)css); werr != nil {
		fmt.eprintln("ERROR: could not write public/site.css")
	}

	// Copy JS
	if werr := os.write_entire_file("public/site.js", transmute([]byte)js); werr != nil {
		fmt.eprintln("ERROR: could not write public/site.js")
	}

	// Copy clipboard icon
	if werr := os.write_entire_file("public/clipboard.svg", transmute([]byte)clipboard); werr != nil {
		fmt.eprintln("ERROR: could not write public/clipboard.svg")
	}

	fmt.println("Done!")
}

read_examples :: proc() -> []string {
	data, err := os.read_entire_file_from_path("examples.txt", context.allocator)
	if err != nil {
		fmt.eprintln("ERROR: could not read examples.txt")
		os.exit(1)
	}

	text := string(data)
	lines := strings.split(text, "\n")

	examples := make([dynamic]string)
	for line in lines {
		trimmed := strings.trim_space(line)
		if trimmed == "" {
			continue
		}
		append(&examples, strings.clone(trimmed))
	}

	return examples[:]
}

read_template :: proc(path: string) -> string {
	data, err := os.read_entire_file_from_path(path, context.allocator)
	if err != nil {
		fmt.eprintln("ERROR: could not read:", path)
		os.exit(1)
	}
	return strings.clone(string(data))
}

parse_example :: proc(dir: string) -> (title: string, segments: []Segment, ok: bool) {
	path := strings.concatenate({"examples/", dir, "/", dir, ".odin"})
	defer delete(path)

	data, err := os.read_entire_file_from_path(path, context.allocator)
	if err != nil {
		fmt.eprintln("ERROR: could not read:", path)
		return "", nil, false
	}

	text := string(data)
	lines := strings.split(text, "\n")

	docs_lines := make([dynamic]string)
	code_lines := make([dynamic]string)
	in_code := false

	for line in lines {
		if !in_code {
			if strings.has_prefix(line, "package ") {
				in_code = true
				append(&code_lines, line)
				continue
			}
			if strings.has_prefix(line, "//") {
				doc_line := strings.trim_prefix(line, "//")
				doc_line = strings.trim_space(doc_line)
				append(&docs_lines, doc_line)
				continue
			}
		} else {
			append(&code_lines, line)
		}
	}

	// Build segments
	segs := make([dynamic]Segment)

	docs_text := render_docs(docs_lines[:])
	code_text := highlight_code(strings.join(code_lines[:], "\n"))

	if len(code_text) > 0 || len(docs_text) > 0 {
		append(&segs, Segment{
			docs = strings.clone(docs_text),
			code = strings.clone(code_text),
		})
	}

	title = format_title(dir)
	return title, segs[:], true
}

render_docs :: proc(lines: []string) -> string {
	if len(lines) == 0 {
		return ""
	}

	paragraphs := make([dynamic]string)
	current := make([dynamic]string)

	for line in lines {
		if line == "" {
			if len(current) > 0 {
				append(&paragraphs, strings.join(current[:], " "))
				clear(&current)
			}
		} else {
			append(&current, line)
		}
	}
	if len(current) > 0 {
		append(&paragraphs, strings.join(current[:], " "))
	}

	result := make([dynamic]string)
	for p in paragraphs {
		append(&result, fmt.tprintf("<p>%s</p>", p))
	}

	return strings.join(result[:], "\n")
}

highlight_code :: proc(code: string) -> string {
	lines := strings.split(code, "\n")
	out := make([dynamic]string)

	for line in lines {
		trimmed := strings.trim_space(line)

		if strings.has_prefix(trimmed, "//") {
			append(&out, fmt.tprintf("<span class=\"c1\">%s</span>", escape_html(line)))
		} else {
			append(&out, highlight_line(line))
		}
	}

	return strings.join(out[:], "\n")
}

highlight_line :: proc(line: string) -> string {
	result := escape_html(line)

	keywords := [?]string{
		"package", "import", "proc", "for", "if", "else", "switch",
		"case", "defer", "when", "return", "fallthrough", "break",
		"continue", "or_else", "or_return", "using", "foreign",
		"where", "in", "not_in", "do", "map", "struct", "enum",
		"union", "bit_set", "distinct", "transmute", "cast",
	}

	types := [?]string{
		"int", "uint", "i8", "i16", "i32", "i64", "i128",
		"u8", "u16", "u32", "u64", "u128", "uintptr",
		"f16", "f32", "f64",
		"bool", "b8", "b16", "b32", "b64",
		"string", "cstring", "rune", "rawptr",
		"typeid", "any",
		"complex32", "complex64", "complex128",
		"quaternion64", "quaternion128", "quaternion256",
	}

	constants := [?]string{"nil", "true", "false"}

	builtins := [?]string{
		"len", "cap", "size_of", "align_of", "offset_of",
		"type_of", "typeid_of", "type_info_of",
		"swizzle", "soa_zip", "soa_unzip",
		"min", "max", "abs", "clamp",
	}

	result = highlight_strings(result)
	result = highlight_numbers(result)
	result = replace_tokens(result, keywords[:], "k")
	result = replace_tokens(result, types[:], "kt")
	result = replace_tokens(result, constants[:], "kc")
	result = replace_tokens(result, builtins[:], "nb")

	return result
}

replace_tokens :: proc(text: string, words: []string, class: string) -> string {
	result := text
	wrapper := fmt.tprintf("<span class=\"%s\">", class)
	end_tag := "</span>"

	for word in words {
		if !strings.contains(result, word) {
			continue
		}

		new_result := make([dynamic]byte)
		defer delete(new_result)

		i := 0
		for i < len(result) {
			if i + len(word) > len(result) {
				append(&new_result, result[i])
				i += 1
				continue
			}
			if result[i:i+len(word)] == word {
				is_start := i == 0 || is_word_boundary(rune(result[i-1]))
				after := i + len(word)
				is_end := after == len(result) || is_word_boundary(rune(result[after]))

				if is_start && is_end {
					append(&new_result, ..transmute([]byte)wrapper)
					append(&new_result, ..transmute([]byte)word)
					append(&new_result, ..transmute([]byte)end_tag)
					i += len(word)
					continue
				}
			}

			append(&new_result, result[i])
			i += 1
		}

		result = strings.clone(string(new_result[:]))
	}

	return result
}

is_word_boundary :: proc(r: rune) -> bool {
	switch r {
	case ' ', '\t', '\n', '(', ')', '{', '}', '[', ']', ',', ':', ';', '.', '=', '+', '-', '*', '/', '%', '<', '>', '!', '&', '|', '~', '^':
		return true
	case:
		return false
	}
}

escape_html :: proc(s: string) -> string {
	result := s
	result, _ = strings.replace_all(result, "&", "&amp;")
	result, _ = strings.replace_all(result, "<", "&lt;")
	result, _ = strings.replace_all(result, ">", "&gt;")
	return result
}

render_segments :: proc(segments: []Segment) -> string {
	rows := make([dynamic]string)

	for seg in segments {
		row := fmt.tprintf("<table><tr><td class=\"docs\">%s</td><td class=\"code\"><pre>%s</pre></td></tr></table>", seg.docs, seg.code)
		append(&rows, row)
	}

	return strings.join(rows[:], "\n")
}

render_prev_next :: proc(examples: []string, idx: int) -> string {
	if len(examples) == 0 {
		return ""
	}

	parts := make([dynamic]string)

	if idx > 0 {
		prev := examples[idx-1]
		append(&parts, fmt.tprintf("<a href=\"/%s\">&larr; %s</a>", prev, prev))
	}

	if idx < len(examples) - 1 {
		next := examples[idx+1]
		append(&parts, fmt.tprintf("<a href=\"/%s\">%s &rarr;</a>", next, next))
	}

	return fmt.tprintf("<p class=\"next\">%s</p>", strings.join(parts[:], " | "))
}

highlight_strings :: proc(text: string) -> string {
	result := make([dynamic]byte)
	i := 0

	for i < len(text) {
		if text[i] == '"' {
			// Double-quoted string
			append(&result, '<', 's', 'p', 'a', 'n', ' ', 'c', 'l', 'a', 's', 's', '=', '"', 's', '"', '>')
			append(&result, text[i])
			i += 1
			for i < len(text) {
				if text[i] == '\\' && i+1 < len(text) {
					append(&result, text[i], text[i+1])
					i += 2
				} else if text[i] == '"' {
					append(&result, text[i])
					i += 1
					break
				} else {
					append(&result, text[i])
					i += 1
				}
			}
			append(&result, '<', '/', 's', 'p', 'a', 'n', '>')
		} else if text[i] == '`' {
			// Raw string literal
			append(&result, '<', 's', 'p', 'a', 'n', ' ', 'c', 'l', 'a', 's', 's', '=', '"', 's', '"', '>')
			append(&result, text[i])
			i += 1
			for i < len(text) && text[i] != '`' {
				append(&result, text[i])
				i += 1
			}
			if i < len(text) {
				append(&result, text[i])
				i += 1
			}
			append(&result, '<', '/', 's', 'p', 'a', 'n', '>')
		} else if text[i] == '\'' {
			// Character literal
			append(&result, '<', 's', 'p', 'a', 'n', ' ', 'c', 'l', 'a', 's', 's', '=', '"', 's', 'c', '"', '>')
			append(&result, text[i])
			i += 1
			for i < len(text) {
				if text[i] == '\\' && i+1 < len(text) {
					append(&result, text[i], text[i+1])
					i += 2
				} else if text[i] == '\'' {
					append(&result, text[i])
					i += 1
					break
				} else {
					append(&result, text[i])
					i += 1
				}
			}
			append(&result, '<', '/', 's', 'p', 'a', 'n', '>')
		} else {
			append(&result, text[i])
			i += 1
		}
	}

	return string(result[:])
}

highlight_numbers :: proc(text: string) -> string {
	result := make([dynamic]byte)
	i := 0

	for i < len(text) {
		r := rune(text[i])
		if (r >= '0' && r <= '9') {
			// Check previous char isn't already inside a span
			start := i
			if i > 0 && text[i-1] == '>' {
				// Already inside a tag (likely a span), skip
				append(&result, text[i])
				i += 1
				continue
			}
			had_dot := false
			had_x := false
			for i < len(text) {
				c := text[i]
				if c == '.' && !had_dot {
					had_dot = true
					i += 1
					continue
				}
				if (c == 'x' || c == 'X') && i == start + 1 && text[start] == '0' && !had_dot {
					had_x = true
					i += 1
					continue
				}
				if (c >= '0' && c <= '9') || (c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F') {
					i += 1
					continue
				}
				if c == '_' {
					i += 1
					continue
				}
				break
			}
			append(&result, '<', 's', 'p', 'a', 'n', ' ', 'c', 'l', 'a', 's', 's', '=', '"', 'm', '"', '>')
			for j := start; j < i; j += 1 {
				append(&result, text[j])
			}
			append(&result, '<', '/', 's', 'p', 'a', 'n', '>')
		} else {
			append(&result, text[i])
			i += 1
		}
	}

	return string(result[:])
}

format_title :: proc(dir: string) -> string {
	result, _ := strings.replace_all(dir, "-", " ")
	result, _ = strings.replace_all(result, "or_else", "Or Else")
	result, _ = strings.replace_all(result, "or_return", "Or Return")
	result, _ = strings.replace_all(result, "or_break", "Or Break")
	result, _ = strings.replace_all(result, "or_continue", "Or Continue")
	result, _ = strings.replace_all(result, "soa", "SOA")
	result, _ = strings.replace_all(result, "cstring", "CString")
	result, _ = strings.replace_all(result, "typeid", "Type ID")
	result, _ = strings.replace_all(result, "typeinfo", "Type Info")
	result, _ = strings.replace_all(result, "raw_data", "Raw Data")
	if len(result) > 0 && result[0] >= 'a' && result[0] <= 'z' {
		first := rune(result[0])
		first = first - 32  // to uppercase
		rest := result[1:]
		return fmt.tprintf("%c%s", first, rest)
	}
	return result
}
