import NNG.Metadata
import NNG.MyNat.Multiplication
import Std.Tactic.RCases
import Mathlib.Tactic.LeftRight

Game "NNG"
World "AdvMultiplication"
Level 1
Title "mul_pos"

open MyNat

Introduction
"
Welcome to Advanced Multiplication World! Before attempting this
world you should have completed seven other worlds, including
Multiplication World and Advanced Addition World. There are four
levels in this world.

Recall that if `b : mynat` is a hypothesis and you do `cases b with n`,
your one goal will split into two goals, 
namely the cases `b = 0` and `b = succ(n)`. So `cases` here is like
a weaker version of induction (you don't get the inductive hypothesis).

## Tricks

1) if your goal is `⊢ X ≠ Y` then `intro h` will give you `h : X = Y` and
a goal of `⊢ false`. This is because `X ≠ Y` *means* `(X = Y) → false`.
Conversely if your goal is `false` and you have `h : X ≠ Y` as a hypothesis
then `apply h` will turn the goal into `X = Y`.

2) if `hab : succ (3 * x + 2 * y + 1) = 0` is a hypothesis and your goal is `⊢ false`,
then `exact succ_ne_zero _ hab` will solve the goal, because Lean will figure
out that `_` is supposed to be `3 * x + 2 * y + 1`.

"

Statement
"The product of two non-zero natural numbers is non-zero."
    (a b : ℕ) : a ≠ 0 → b ≠ 0 → a * b ≠ 0 := by
  intro ha hb
  intro hab
  induction b with b
  apply hb
  rfl
  rw [mul_succ] at hab
  apply ha
  induction a with a
  rfl
  rw [add_succ] at hab
  exfalso
  exact succ_ne_zero _ hab

Conclusion
"

"
