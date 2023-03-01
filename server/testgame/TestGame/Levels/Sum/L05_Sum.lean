import TestGame.Metadata

import TestGame.Options.BigOperators
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Tactic.Ring

import TestGame.ToBePorted

Game "TestGame"
World "Sum"
Level 5

set_option tactic.hygienic false

Title "Quadrat der Arithmetischen Summe"

Introduction
"
Und hier noch eine etwas schwierigere Übung.

Das Resultat aus Level 3 kannst du als `arithmetic_sum` wiederverwenden:
$$
2 \\cdot \\sum_{i = 0}^n i = n \\cdot (n + 1)
$$
"

open BigOperators

lemma arithmetic_sum (n : ℕ) : 2 * (∑ i : Fin (n + 1), ↑i) = n * (n + 1) := by
  induction' n with n hn
  simp
  rw [Fin.sum_univ_castSucc]
  rw [mul_add]
  simp
  rw [mul_add, hn]
  simp_rw [Nat.succ_eq_one_add]
  ring

Statement
"Zeige $\\sum_{i = 0}^n i^3 = (\\sum_{i = 0}^n i)^2$."
  (m : ℕ) : (∑ i : Fin (m + 1), (i : ℕ)^3) = (∑ i : Fin (m + 1), (i : ℕ))^2 := by
  induction' m with m hm
  simp
  rw [Fin.sum_univ_castSucc]
  simp
  rw [hm]
  rw [Fin.sum_univ_castSucc (n := m + 1)]
  simp
  rw [add_pow_two]
  rw [arithmetic_sum]
  ring

NewLemmas arithmetic_sum add_pow_two

HiddenHint (m : ℕ) : ∑ i : Fin (Nat.zero + 1), ↑i ^ 3 = (∑ i : Fin (Nat.zero + 1), ↑i) ^ 2 =>
"`simp` kann den Induktionsanfang beweisen."

Hint (m : ℕ) : ∑ i : Fin (Nat.succ m + 1), ↑i ^ 3 = (∑ i : Fin (Nat.succ m + 1), ↑i) ^ 2 =>
"Im Induktionsschritt musst du versuchen, das Goal so umzuformen, dass du
`∑ i : Fin (m + 1), ↑i ^ 3` (Induktionshypothese) oder
`2 * (∑ i : Fin (m + 1), ↑i)` (arithmetische Summe) erhälst.

Als erstes kannst du mal mit dem bekannten `rw [Fin.sum_univ_castSucc]` anfangen.
"

HiddenHint (m : ℕ) : ∑ i : Fin (m + 1), ↑(Fin.castSucc.toEmbedding i) ^ 3 +
    ↑(Fin.last (m + 1)) ^ 3 = (∑ i : Fin (Nat.succ m + 1), ↑i) ^ 2 =>
"Mit `simp` kriegst du das `↑(Fin.castSucc.toEmbedding i)` weg"

Hint (m : ℕ) : ∑ x : Fin (m + 1), (x : ℕ) ^ 3 + (m + 1) ^ 3 =
    (∑ i : Fin (Nat.succ m + 1), ↑i) ^ 2 =>
"Jetzt kannst du die Induktionshypothese mit `rw` einsetzen."

Hint (m : ℕ) : (∑ i : Fin (m + 1), ↑i) ^ 2 + (m + 1) ^ 3 = (∑ i : Fin (Nat.succ m + 1), ↑i) ^ 2 =>
"Die linke Seite ist jetzt erst mal gut. Um auf der rechten Seite `Fin.sum_univ_castSucc`
anzuwenden, haben wir ein Problem: Lean schreibt immer die erste Instanz um, also würde gerne
auf der linken Seite `(∑ i : Fin (m + 1), ↑i) ^ 2` umschreiben.

Wir können Lean hier weiterhelfen, indem wir manche Argemente von `Fin.sum_univ_castSucc`
explizit angeben. Die Funktion hat ein Argument mit dem Namen `n`, welches wir z.B. explizit
angeben können:

```
rw [Fin.sum_univ_castSucc (n := m + 1)]
```
"

HiddenHint (m : ℕ) : (∑ i : Fin (m + 1), ↑i) ^ 2 + (m + 1) ^ 3 =
    (∑ i : Fin (m + 1), ↑(Fin.castSucc.toEmbedding i) + ↑(Fin.last (m + 1))) ^ 2 =>
"wieder `simp`"

Hint (m : ℕ) : (∑ i : Fin (m + 1), ↑i) ^ 2 + (m + 1) ^ 3 = (∑ i : Fin (m + 1), ↑i + (m + 1)) ^ 2 =>
"Die rechte Seite hat die Form $(a + b)^2$ welche mit `add_pow_two` zu $a^2 + 2ab + b^2$
umgeschrieben werden kann."

Hint (m : ℕ) : (∑ i : Fin (m + 1), ↑i) ^ 2 + (m + 1) ^ 3 =
    (∑ i : Fin (m + 1), ↑i) ^ 2 + (2 * ∑ i : Fin (m + 1), ↑i) * (m + 1) + (m + 1) ^ 2 =>
"Jetzt hast du in der Mitte `2 * ∑ i : Fin (m + 1), ↑i)`, welches du mit der
arithmetischen Summe `arithmetic_sum` umschreiben kannst."

Hint (m : ℕ) : (∑ i : Fin (m + 1), ↑i) ^ 2 + (m + 1) ^ 3 =
    (∑ i : Fin (m + 1), ↑i) ^ 2 + m * (m + 1) * (m + 1) + (m + 1) ^ 2 =>
"Den Rest sollte `ring` für dich übernehmen."