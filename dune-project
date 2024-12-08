(lang dune 3.17)

(name scribe)

(generate_opam_files true)

(source
 (github newen-tec/scribe))

(authors "Juno Takano <juno@newen.me>")

(maintainers "Juno Takano <juno@newen.me>")

(license AGPL-3.0-or-later)

(documentation https://github.com/newen-tec/scribe)

(package
 (name scribe)
 (synopsis "A speech-to-text utility")
 (description "A speech-to-text utility to aid in transcription and translation projects")
 (depends ocaml)
)
