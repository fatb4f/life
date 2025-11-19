# dev-starter-dual

A dual-language starter repository with:
- **C++ (GCC & Clang)** in `cpp/` using CMake, Catch2 tests, clangd, clang-format/tidy, and Helix config.
- **Rust** in `rust/` using Cargo, library + binary, unit/integration tests, rustfmt, clippy, and Helix config.

Ready for Linux/macOS/Windows with a single GitHub Actions workflow.

## Layout
```
.
├─ cpp/         # Modern C++20 starter
├─ rust/        # Rust starter (library + binary)
├─ .github/workflows/ci.yml
├─ .editorconfig
└─ LICENSE
```

## Quick start (C++)
```bash
cd cpp
cmake -S . -B build -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
ln -sf build/compile_commands.json compile_commands.json
cmake --build build -j
./build/bin/hello
ctest --test-dir build --output-on-failure
```

Choose compiler:
```bash
CXX=g++ cmake -S . -B build-gcc   -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
CXX=clang++ cmake -S . -B build-clang -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
```

## Quick start (Rust)
```bash
cd rust
cargo build
cargo test
cargo run --bin hello
```

## Helix
- C++: uses `clangd`, format on save via `.clang-format`.
- Rust: uses `rust-analyzer` (usually bundled with Helix on Arch) and `rustfmt` for formatting.
Open either subfolder with `hx .`.

## Arch packages (suggested)
```bash
sudo pacman -S --needed base-devel gcc clang clangd cmake bear helix gdb lldb rustup
rustup default stable
rustup component add rustfmt clippy
```


## GitHub bootstrap
Automate repo creation, push, branch protections, and badges (requires `gh` + `git`):

```bash
# from repo root
make OWNER=$(gh api user --jq .login) create   # create on GitHub (private by default)
make push                                       # push main
make protect                                   # add branch protections
make badges                                    # add CI badge to README

# or do it all at once (private)
make OWNER=$(gh api user --jq .login) all

# public repo variant
PUBLIC=1 make OWNER=$(gh api user --jq .login) all

# or the one-liner script
./scripts/bootstrap_repo.sh          # private by default
PUBLIC=1 ./scripts/bootstrap_repo.sh # public
```
