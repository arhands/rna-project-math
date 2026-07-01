# LaTeX Math Research Template

## Project Overview

LaTeX template for ML/GNN conference papers (NeurIPS, ICML, ICLR level). Topics span GNNs, generative graph models, and representation theory.

## Five Non-Negotiable Invariants

### 1. Citations (top priority)
Never add `\cite{key}` without independently verifying: title, authors, year, venue, and that the specific claim at the cite site actually appears in that paper. When uncertain, mark with `% TODO: verify cite — <reason>` and add to `sources.md` Pending section. Never guess or invent a citation.

### 2. Math Correctness
Verify every step explicitly. Before finalizing any derivation, check:
- All summation/product indices are in valid range; operations well-defined when sets are empty
- Matrix dimensions are compatible at each operation
- No circular reasoning (no step assumes the conclusion)
- Edge cases: empty graph ($|V|=0$), single node, disconnected, degenerate eigenvalues
- Any limit/expectation/sum interchange is justified (name the applicable theorem)

Flag uncertain steps: `% TODO: verify — <what is uncertain>`.

### 3. TikZ Figures
Never hardcode absolute coordinates. `arrows.meta` and `calc` are already in `style.sty`; add `positioning` to the document preamble for any multi-node figure:
```
\usetikzlibrary{positioning}
```
- **Files**: each figure is a separate `.tikz` file in `tikz-figs/` containing only the `tikzpicture`; include with `\input{tikz-figs/<name>.tikz}` inside a `figure` environment
- Use `node distance=Xem` for spacing
- Use `($(nodeA)+(dx,dy)$)` for offsets from named nodes
- Use `\foreach` for any element appearing more than twice
- Name nodes semantically (`input-layer`, not `n1`)
- Self-check: grep for raw `(X.X, Y.Y)` pairs — if any exist outside an origin anchor, refactor

### 4. Prune Dead Ends
When an approach is tried and abandoned, remove it from the document. Scratch may use `% DRAFT:` prefix but must be deleted before a clean draft. Never comment out failed derivations and leave them.

### 5. Concision
When asked to refine or edit, actually cut. Target ≥20% word reduction. Rephrasing without reducing is not editing. Higher signal density is the goal.

---

## Available Skills

| Skill | Invocation | Purpose |
|-------|-----------|---------|
| Lead Author | `/lead-author <task>` | Orchestrates research; manages subagents |
| Math Expert | `/math-expert <claim>` | Verifies proofs and derivations step-by-step |
| Reviewer | `/reviewer` | Reviews paper against ML conference standards |
| Figure Designer | `/figure-designer <description>` | Designs TikZ figures with no hardcoded coords |
| Literature Reviewer | `/literature-reviewer` | Verifies citations; updates `sources.md` |
| Editor | `/editor <section>` | Trims writing and prunes abandoned content |

---

## File Organization

### TikZ Figures (`tikz-figs/`)
All TikZ figures live as individual `.tikz` files in `tikz-figs/`. Each file contains only the `tikzpicture` environment — no `\begin{figure}`, no caption. Include in the document with:

```latex
\begin{figure}[t]
  \centering
  \input{tikz-figs/figure-name.tikz}
  \caption{Caption.}
  \label{fig:figure-name}
\end{figure}
```

Use `/figure-designer` to generate these files — it creates `tikz-figs/<name>.tikz` directly and outputs the `\input{}` reference.

### Proofs and Appendices (`appendices/`)
Every theorem gets two proof versions:
- **Main body**: short intuitive `proofSketch` (3–8 lines), ending with `Full proof in \cref{app:proof-label}.`
- **Appendix**: full rigorous proof in `appendices/proofs.tex`, passing the full verification checklist

Wire up in `main.tex`:
```latex
\appendix
\input{appendices/proofs}
```

Use `/math-expert` to generate both versions simultaneously.

---

## Macro Quick Reference (`style.sty`)

### Notation Collision Warning
| Use | Not | Reason |
|-----|-----|--------|
| `\AAA` | `\AA` | `\AA` is reserved by LaTeX (Å) |
| `\SSS` | `\SS` | `\SS` is reserved by LaTeX (ß) |

### Bold Vectors (all 26 letters)
`\abf \Abf`, `\bbf \Bbf`, `\cbf \Cbf`, `\dbf \Dbf`, `\ebf \Ebf`, `\fbf \Fbf`, `\gbf \Gbf`, `\hbf \Hbf`, `\ibf \Ibf`, `\jbf \Jbf`, `\kbf \Kbf`, `\lbf \Lbf`, `\mbf \Mbf`, `\nbf \Nbf`, `\obf \Obf`, `\pbf \Pbf`, `\qbf \Qbf`, `\rbf \Rbf`, `\sbf \Sbf`, `\tbf \Tbf`, `\ubf \Ubf`, `\vbf \Vbf`, `\wbf \Wbf`, `\xbf \Xbf`, `\ybf \Ybf`, `\zbf \Zbf`

### Blackboard Bold
`\AAA \BB \CC \DD \EE \FF \GG \HH \II \JJ \KK \LL \MM \NN \OO \PP \QQ \RR \SSS \TT \UU \VV \WW \XX \YY \ZZ`
Also: `\sym` = `\mbb{S}` (symmetric group)

### Calligraphic
`\Ac \Bc \Cc \Dc \Ec \Fc \Gc \Hc \Ic \Jc \Kc \Lc \Mc \Nc \Oc \Pc \Qc \Rc \Sc \Tc \Uc \Vc \Wc \Xc \Yc \Zc`
Aliases: `\ecal` (`\mcal{E}`), `\hcal`, `\vcal`, `\zcal`

### Operators
| Command | Output | Notes |
|---------|--------|-------|
| `\argmax`, `\argmin` | arg max, arg min | |
| `\diag` | diag | |
| `\tr` | Tr | trace |
| `\inner{a}{b}` | ⟨a, b⟩ | inner product |
| `\norm{x}` | ‖x‖ | |
| `\abs{x}` | \|x\| | |
| `\transpose{M}` | M^T | |
| `\prob[X]{E}` | Pr_X[E] | |
| `\expect[X]{f}` | 𝔼_X[f] | |
| `\agg` | □ | GNN aggregation |
| `\concat` | ‖ | concatenation |
| `\defeq` | := | definition |
| `\eqdef` | =: | |
| `\ind[S]` | 𝟏_S | indicator function |
| `\identity{n}` | Id_n | |
| `\multiset{x}` | {{x}} | multiset notation |
| `\Oh` | 𝒪 | big-O |
| `\floor{x}`, `\ceil{x}` | ⌊x⌋, ⌈x⌉ | |
| `\cupdot` | ⊔ | disjoint union |
| `\dom`, `\Span`, `\im` | dom, span, im | |
| `\aut`, `\diam`, `\fix`, `\stab` | aut, diam, fix, stab | graph theory |

### Theorem Environments (defined in `main.tex`)
- `\begin{thm}...\end{thm}` — Theorem
- `\begin{prop}...\end{prop}` — Proposition
- `\begin{rmk}...\end{rmk}` — Remark (unnumbered)
- `\begin{pf}...\end{pf}` — Proof with QED box (from `style.sty`)
- `\begin{pf}[Name]...\end{pf}` — Named proof
- `\begin{proofSketch}...\end{proofSketch}` — Proof sketch

### Algorithm Macros
`\CONTINUE`, `\RETURN`, `\BREAK`, `\TRUE`, `\FALSE`
`\alglabel{name}` / `\algref{name}` — label and reference algorithm line numbers

---

## Subagent Communication Protocol

When using `/lead-author`, each spawned subagent must respond in this format:

```
STATUS: success | failure
OUTPUT: <LaTeX content to integrate, or empty if failure>
REASON: <why it failed, if failure; empty if success>
```

The orchestrator integrates `success` outputs and discards `failure` outputs. Failed approaches are never written into the document.
