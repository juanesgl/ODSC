.section .data
    .balign 4
cases:              .word 0
x1:                 .word 0
y1:                 .word 0
z1:                 .word 0
result_x1:          .word 0
x2:                 .word 0
y2:                 .word 0
z2:                 .word 0
result_x2:          .word 0
x3:                 .word 0
y3:                 .word 0
z3:                 .word 0
result_x3:          .word 0
solution_x:         .word 0
solution_y:         .word 0
solution_z:         .word 0
scanf_pattern:      .asciz "%d"
print_pattern:      .asciz "%d\n"
print_coprime:      .asciz "coprime solutions\n"
print_no_coprime:   .asciz "no coprime solutions\n"

    .section .text
    .global main
    .global scanf
    .global printf

    .func main
main:
    PUSH {LR}

    LDR R0,=scanf_pattern
    LDR R1,=cases
    BL scanf

    LDR R4,=cases
    LDR R4,[R4]
    MOV R5,#0

for_cases:
    CMP R5,R4
    BGE end_main

    PUSH {R4,R5}
    
    LDR R0,=scanf_pattern
    LDR R1,=x1
    BL scanf
    LDR R0,=scanf_pattern
    LDR R1,=y1
    BL scanf
    LDR R0,=scanf_pattern
    LDR R1,=z1
    BL scanf
    LDR R0,=scanf_pattern
    LDR R1,=result_x1
    BL scanf
    LDR R0,=scanf_pattern
    LDR R1,=x2
    BL scanf
    LDR R0,=scanf_pattern
    LDR R1,=y2
    BL scanf
    LDR R0,=scanf_pattern
    LDR R1,=z2
    BL scanf
    LDR R0,=scanf_pattern
    LDR R1,=result_x2
    BL scanf
    LDR R0,=scanf_pattern
    LDR R1,=x3
    BL scanf
    LDR R0,=scanf_pattern
    LDR R1,=y3
    BL scanf
    LDR R0,=scanf_pattern
    LDR R1,=z3
    BL scanf
    LDR R0,=scanf_pattern
    LDR R1,=result_x3
    BL scanf

    BL solve_system
    BL print_results

    POP {R4,R5}
    ADD R5,R5,#1
    B for_cases

solve_system:
    PUSH {R4-R11,LR}
    
    /* Load original coefficients */
    LDR R0,=x1
    LDR R1,[R0]     /* a1 */
    LDR R0,=y1
    LDR R2,[R0]     /* b1 */
    LDR R0,=z1
    LDR R3,[R0]     /* c1 */
    LDR R0,=result_x1
    LDR R4,[R0]     /* d1 */
    
    LDR R0,=x2
    LDR R5,[R0]     /* a2 */
    LDR R0,=y2
    LDR R6,[R0]     /* b2 */
    LDR R0,=z2
    LDR R7,[R0]     /* c2 */
    LDR R0,=result_x2
    LDR R8,[R0]     /* d2 */
    
    LDR R0,=x3
    LDR R9,[R0]     /* a3 */
    LDR R0,=y3
    LDR R10,[R0]    /* b3 */
    LDR R0,=z3
    LDR R11,[R0]    /* c3 */
    LDR R0,=result_x3
    LDR R12,[R0]    /* d3 */
    
    /* Calculate using Cramer's rule */
    /* det = a1(b2*c3 - b3*c2) - b1(a2*c3 - a3*c2) + c1(a2*b3 - a3*b2) */
    
    PUSH {R1-R12}
    MUL R0,R6,R11   /* b2*c3 */
    MUL R1,R10,R7   /* b3*c2 */
    SUB R0,R0,R1    /* b2*c3 - b3*c2 */
    POP {R1-R12}
    PUSH {R0}       /* Save first term */
    
    PUSH {R1-R12}
    MUL R0,R5,R11   /* a2*c3 */
    MUL R1,R9,R7    /* a3*c2 */
    SUB R0,R0,R1    /* a2*c3 - a3*c2 */
    POP {R1-R12}
    PUSH {R0}       /* Save second term */
    
    PUSH {R1-R12}
    MUL R0,R5,R10   /* a2*b3 */
    MUL R1,R9,R6    /* a3*b2 */
    SUB R0,R0,R1    /* a2*b3 - a3*b2 */
    POP {R1-R12}
    MOV R14,R0      /* third term in R14 */
    
    POP {R0}        /* second term */
    MUL R0,R2,R0    /* b1 * second */
    MOV R2,R0
    
    POP {R0}        /* first term */
    MUL R0,R1,R0    /* a1 * first */
    SUB R0,R0,R2    /* a1*first - b1*second */
    
    MUL R1,R3,R14   /* c1 * third */
    ADD R0,R0,R1    /* complete det */
    
    PUSH {R0}       /* Save determinant */
    
    /* Calculate det_x = d1(b2*c3 - b3*c2) - b1(d2*c3 - d3*c2) + c1(d2*b3 - d3*b2) */
    LDR R0,=x1
    LDR R1,[R0]
    LDR R0,=y1
    LDR R2,[R0]
    LDR R0,=z1
    LDR R3,[R0]
    LDR R0,=result_x1
    LDR R4,[R0]
    LDR R0,=x2
    LDR R5,[R0]
    LDR R0,=y2
    LDR R6,[R0]
    LDR R0,=z2
    LDR R7,[R0]
    LDR R0,=result_x2
    LDR R8,[R0]
    LDR R0,=x3
    LDR R9,[R0]
    LDR R0,=y3
    LDR R10,[R0]
    LDR R0,=z3
    LDR R11,[R0]
    LDR R0,=result_x3
    LDR R12,[R0]
    
    PUSH {R1-R12}
    MUL R0,R6,R11   /* b2*c3 */
    MUL R1,R10,R7   /* b3*c2 */
    SUB R0,R0,R1
    POP {R1-R12}
    PUSH {R0}
    
    PUSH {R1-R12}
    MUL R0,R8,R11   /* d2*c3 */
    MUL R1,R12,R7   /* d3*c2 */
    SUB R0,R0,R1
    POP {R1-R12}
    PUSH {R0}
    
    PUSH {R1-R12}
    MUL R0,R8,R10   /* d2*b3 */
    MUL R1,R12,R6   /* d3*b2 */
    SUB R0,R0,R1
    POP {R1-R12}
    MOV R14,R0
    
    POP {R0}
    MUL R0,R2,R0
    MOV R2,R0
    
    POP {R0}
    MUL R0,R4,R0
    SUB R0,R0,R2
    
    MUL R1,R3,R14
    ADD R0,R0,R1
    
    POP {R1}        /* determinant */
    PUSH {R1}       /* save again */
    PUSH {R0-R12}
    BL __aeabi_idiv
    LDR R1,=solution_x
    STR R0,[R1]
    POP {R0-R12}
    
    /* Calculate det_y = a1(d2*c3 - d3*c2) - d1(a2*c3 - a3*c2) + c1(a2*d3 - a3*d2) */
    LDR R0,=x1
    LDR R1,[R0]
    LDR R0,=y1
    LDR R2,[R0]
    LDR R0,=z1
    LDR R3,[R0]
    LDR R0,=result_x1
    LDR R4,[R0]
    LDR R0,=x2
    LDR R5,[R0]
    LDR R0,=y2
    LDR R6,[R0]
    LDR R0,=z2
    LDR R7,[R0]
    LDR R0,=result_x2
    LDR R8,[R0]
    LDR R0,=x3
    LDR R9,[R0]
    LDR R0,=y3
    LDR R10,[R0]
    LDR R0,=z3
    LDR R11,[R0]
    LDR R0,=result_x3
    LDR R12,[R0]
    
    PUSH {R1-R12}
    MUL R0,R8,R11
    MUL R1,R12,R7
    SUB R0,R0,R1
    POP {R1-R12}
    PUSH {R0}
    
    PUSH {R1-R12}
    MUL R0,R5,R11
    MUL R1,R9,R7
    SUB R0,R0,R1
    POP {R1-R12}
    PUSH {R0}
    
    PUSH {R1-R12}
    MUL R0,R5,R12
    MUL R1,R9,R8
    SUB R0,R0,R1
    POP {R1-R12}
    MOV R14,R0
    
    POP {R0}
    MUL R0,R4,R0
    MOV R2,R0
    
    POP {R0}
    MUL R0,R1,R0
    SUB R0,R0,R2
    
    MUL R1,R3,R14
    ADD R0,R0,R1
    
    POP {R1}
    PUSH {R1}
    PUSH {R0-R12}
    BL __aeabi_idiv
    LDR R1,=solution_y
    STR R0,[R1]
    POP {R0-R12}
    
    /* Calculate det_z = a1(b2*d3 - b3*d2) - b1(a2*d3 - a3*d2) + d1(a2*b3 - a3*b2) */
    LDR R0,=x1
    LDR R1,[R0]
    LDR R0,=y1
    LDR R2,[R0]
    LDR R0,=z1
    LDR R3,[R0]
    LDR R0,=result_x1
    LDR R4,[R0]
    LDR R0,=x2
    LDR R5,[R0]
    LDR R0,=y2
    LDR R6,[R0]
    LDR R0,=z2
    LDR R7,[R0]
    LDR R0,=result_x2
    LDR R8,[R0]
    LDR R0,=x3
    LDR R9,[R0]
    LDR R0,=y3
    LDR R10,[R0]
    LDR R0,=z3
    LDR R11,[R0]
    LDR R0,=result_x3
    LDR R12,[R0]
    
    PUSH {R1-R12}
    MUL R0,R6,R12
    MUL R1,R10,R8
    SUB R0,R0,R1
    POP {R1-R12}
    PUSH {R0}
    
    PUSH {R1-R12}
    MUL R0,R5,R12
    MUL R1,R9,R8
    SUB R0,R0,R1
    POP {R1-R12}
    PUSH {R0}
    
    PUSH {R1-R12}
    MUL R0,R5,R10
    MUL R1,R9,R6
    SUB R0,R0,R1
    POP {R1-R12}
    MOV R14,R0
    
    POP {R0}
    MUL R0,R2,R0
    MOV R2,R0
    
    POP {R0}
    MUL R0,R1,R0
    SUB R0,R0,R2
    
    MUL R1,R4,R14
    ADD R0,R0,R1
    
    POP {R1}
    PUSH {R0-R12}
    BL __aeabi_idiv
    LDR R1,=solution_z
    STR R0,[R1]
    POP {R0-R12}
    
    POP {R4-R11,LR}
    BX LR

print_results:
    PUSH {LR}
    
    LDR R4,=solution_x
    LDR R1,[R4]
    LDR R0,=print_pattern
    BL printf
    
    LDR R4,=solution_y
    LDR R1,[R4]
    LDR R0,=print_pattern
    BL printf
    
    LDR R4,=solution_z
    LDR R1,[R4]
    LDR R0,=print_pattern
    BL printf
    
    BL count_primes
    MOV R1,R0
    LDR R0,=print_pattern
    BL printf
    
    BL verify_coprime
    CMP R0,#1
    BEQ print_cop
    
    LDR R0,=print_no_coprime
    BL printf
    B end_print
    
print_cop:
    LDR R0,=print_coprime
    BL printf
    
end_print:
    POP {LR}
    BX LR

count_primes:
    PUSH {LR}
    MOV R5,#0
    
    LDR R0,=solution_x           
    LDR R0,[R0]
    BL is_prime
    ADD R5,R5,R0
    
    LDR R0,=solution_y
    LDR R0,[R0]
    BL is_prime
    ADD R5,R5,R0
    
    LDR R0,=solution_z
    LDR R0,[R0]
    BL is_prime
    ADD R5,R5,R0
    
    MOV R0,R5
    POP {LR}
    BX LR

is_prime:
    PUSH {R4,R5,R6,LR}

    /* If less than 2 not prime, if equal to 2 is prime */
    CMP R0,#2
    BLT not_prime        
    BEQ yes_prime

    /* If even, not prime */
    AND R1, R0, #1
    CMP R1, #0
    BEQ not_prime

    /* Start dividing by 3 */
    MOV R4, R0
    MOV R5, #3

prime_loop:
    /* Divisor^2 > n no more divisors and n is prime */
    MUL R6, R5, R5
    CMP R6, R4
    BGT yes_prime

    /* R3 = n % divisor */
    MOV R0, R4
    MOV R1, R5
    BL __aeabi_idiv
    MUL R2, R0, R5      
    SUB R3, R4, R2

    /* n % divisor is 0 then not prime */
    CMP R3, #0
    BEQ not_prime

    /* Next odd divisor */
    ADD R5, R5, #2
    B prime_loop

yes_prime:
    MOV R0, #1
    POP {R4,R5,R6,LR}
    BX LR

not_prime:
    MOV R0, #0
    POP {R4,R5,R6,LR}
    BX LR

verify_coprime:
    PUSH {LR}
    
    LDR R0,=solution_x
    LDR R0,[R0]
    LDR R1,=solution_y
    LDR R1,[R1]
    BL gcd
    CMP R0,#1
    BNE not_coprime
    
    LDR R0,=solution_x
    LDR R0,[R0]
    LDR R1,=solution_z
    LDR R1,[R1]
    BL gcd
    CMP R0,#1
    BNE not_coprime
    
    LDR R0,=solution_y
    LDR R0,[R0]
    LDR R1,=solution_z
    LDR R1,[R1]
    BL gcd
    CMP R0,#1
    BNE not_coprime
    
    MOV R0,#1
    POP {LR}
    BX LR
    
not_coprime:
    MOV R0,#0
    POP {LR}
    BX LR

gcd:
    PUSH {LR}
    CMP R0,#0
    BLT abs_r0
cont_gcd:
    CMP R1,#0
    BLT abs_r1
loop_gcd:
    CMP R1,#0
    BEQ end_gcd
    
    PUSH {R0,R1}
    BL __aeabi_idiv
    MOV R3,R0
    POP {R0,R1}
    
    MUL R2,R3,R1
    SUB R2,R0,R2
    MOV R0,R1
    MOV R1,R2
    B loop_gcd
    
abs_r0:
    RSB R0,R0,#0
    B cont_gcd
    
abs_r1:
    RSB R1,R1,#0
    B loop_gcd
    
end_gcd:
    POP {LR}
    BX LR

end_main:
    POP {LR}
    MOV R0,#0
    BX LR
.endfunc
