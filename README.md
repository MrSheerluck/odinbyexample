# Odin by Example

Hands-on introduction to the [Odin Programming Language](https://odin-lang.org)
using annotated example programs.

## How It Works

Each example is a standalone `.odin` file. Comments at the top become the
tutorial text, and the code is displayed alongside with syntax highlighting.

Shell commands (lines starting with `$`) in comments are rendered as
interactive terminal blocks with expected output.

## Building

Requires the [Odin compiler](https://odin-lang.org/docs/install/).

```bash
# Build the site generator
odin build tools/build.odin -file -out:tools/build

# Generate the static site
./tools/build
```

Output goes to `public/`. Serve it with any static file server:

```bash
python3 -m http.server 8000 --directory public
```

## Project Structure

```
├── examples/          # .odin source files (comments = docs, code = example)
├── templates/         # HTML templates with {{placeholder}} markers
├── tools/
│   └── build.odin     # static site generator written in Odin
├── public/            # generated static site output
└── examples.txt       # ordered list of example IDs
```

## Contributing

Add new examples by creating a directory under `examples/` matching the id
in `examples.txt`. See existing examples for the annotated source format.

## License

MIT
