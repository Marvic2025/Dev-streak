(define-map streaks principal
  (tuple
    (last-block uint)
    (current-streak uint)
    (longest-streak uint)
    (total-days uint)
  )
)

(define-constant admin "SP2C2D9D2YCQ0PZ0M0R5XK2V0K80XYGNYB5KK5J66") ;; change to your address

;; block-height must be passed as a parameter
;; current-block is used instead of block-height to avoid reserved word conflict
(define-public (log-contribution (current-block uint))
  (let (
        (user tx-sender)
        (now current-block)
        (existing (map-get? streaks user))
      )
    (match existing data
      ;; Existing user
      (let (
            (last (get last-block data))
            (streak (get current-streak data))
            (longest (get longest-streak data))
            (total (get total-days data))
           )
        (if (>= now last)
            (if (is-eq now last)
                (err "Already logged today")
                (let (
                      (new-streak (if (is-eq now (+ last u1)) (+ streak u1) u1))
                      (best-streak (if (> (if (is-eq now (+ last u1)) (+ streak u1) u1) longest)
                                      (if (is-eq now (+ last u1)) (+ streak u1) u1)
                                      longest
                                    ))
                      (updated-total (+ total u1))
                    )
                  (begin
                    (map-set streaks user {
                      last-block: now,
                      current-streak: new-streak,
                      longest-streak: best-streak,
                      total-days: updated-total
                    })
                    (ok new-streak)
                  )
                )
            )
            (err "Invalid block height")
        )
      )
      ;; New user
      (begin
        (map-set streaks user {
          last-block: now,
          current-streak: u1,
          longest-streak: u1,
          total-days: u1
        })
        (ok u1)
      )
    )
  )
)

(define-read-only (get-current-streak (user principal))
  (match (map-get? streaks user)
    data (ok (get current-streak data))
    (err "User not found")
  )
)

(define-read-only (get-longest-streak (user principal))
  (match (map-get? streaks user)
    data (ok (get longest-streak data))
    (err "User not found")
  )
)

(define-read-only (get-total-contributions (user principal))
  (match (map-get? streaks user)
    data (ok (get total-days data))
    (err "User not found")
  )
)

;; NOTE: Admin checks must be handled off-chain or with a supported conversion function.
(define-public (reset-streak (user principal))
  (err "Admin check not supported in this Clarity environment")
)
