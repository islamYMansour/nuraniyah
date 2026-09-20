# nuraniyah

IMPORTANT:
Do not guess the project architecture, technologies, commands, features, or file structure.

First inspect the repository in read-only mode and understand the actual current implementation.

Review at minimum:
- project structure
- package/build configuration
- app entry points
- existing screens/routes
- assets
- fonts
- localization setup
- Arabic/RTL handling
- lesson/content data structure
- reusable UI components
- development/build commands
- any existing documentation

Then create a README.md at the repository root.

The README should be useful both for developers and AI coding agents working on this project.

Include these sections where supported by the actual repository:

# Nuraniya

Briefly explain what the project is:
An interactive children's learning application based on Al-Qaida Al-Nuraniya, designed to teach Arabic letters, pronunciation, harakat, and progressive Quran-reading foundations.

## Project Goals

Explain the educational purpose and target audience based on the existing implementation.

## Current Features

Document only features that actually exist in the repository.

## Learning Structure

Describe the implemented lesson/level structure.
Do not invent lessons that are not currently implemented.

## Design System

Document the existing visual direction:
- children's educational experience
- Arabic-first / RTL
- colors
- typography
- cards/components
- character/illustration usage

Only document specifics that can be confirmed from the code/assets.

## Arabic & Quranic Text Rules

This section is important.

Document the project's rules for Arabic educational content, including:

- Arabic text must preserve correct Unicode characters and diacritics.
- A base Arabic letter and its combining marks must be treated as one grapheme.
- Educational "separate letters" must remain visually separated.
- Do not accidentally apply normal word shaping to content intended as isolated letters.
- Normal Arabic/Quranic words must retain correct contextual Arabic shaping.
- Do not remove or normalize away harakat.
- Preserve Fatha, Kasra, Damma, Sukun, Shadda, Tanween, Hamza and other required marks.
- Quranic/educational content must not be silently corrected or modified without verification.

Clearly distinguish between:
1. normal Arabic words
2. isolated educational letters
3. letter + harakat grapheme units

## Assets

Explain where educational images, character assets, Arabic letter assets, audio, and other resources are stored, based on the actual repository.

## Project Structure

Provide a concise tree of the important directories and explain their responsibilities.

Do not dump the entire repository tree.

## Tech Stack

List only technologies and libraries actually found in the project.

## Getting Started

Provide exact installation and local-development steps based on the actual package/build configuration.

Do not invent commands.

## Development Commands

Document the actual available commands for:
- install
- development
- build
- test
- lint/type checking

Include only commands confirmed by the repository.

## Development Guidelines

Document important project-specific rules discovered from the code.

Also include these standing rules:

- Preserve Arabic RTL behavior.
- Do not replace educational Arabic glyph assets with approximate fonts without explicit approval.
- Do not modify Quranic/Arabic educational content casually.
- Preserve character visual identity when replacing or adding character artwork.
- Avoid unrelated UI redesigns when fixing functional issues.
- Prefer minimal, scoped changes.
- Do not introduce new dependencies unless necessary.
- Do not change existing lesson content while fixing rendering problems.

## Content Integrity

State clearly that educational Arabic/Quranic content is correctness-sensitive.

Any modification to:
- Arabic letters
- harakat
- Quranic examples
- pronunciation content
- lesson ordering

must preserve the source material and should be verified before release.

## Status / Known Limitations

Only include limitations that can actually be confirmed from the repository.

## Contributing

Give concise guidance for making safe changes to this project.

---

README QUALITY REQUIREMENTS

- Keep it professional and concise.
- Do not turn it into marketing copy.
- Do not invent completed features.
- Do not invent future roadmap items.
- Do not expose secrets, API keys, tokens, private URLs, or credentials.
- Do not include generated build folders in the structure.
- Use clear Markdown.
- Arabic examples must render correctly.
- Use English for the README unless existing repository conventions clearly indicate otherwise.

After creating README.md, report:
1. what repository information you found,
2. the README sections created,
3. any important project information you could not determine,
4. the exact path of README.md.

Do not make any other code or configuration changes.