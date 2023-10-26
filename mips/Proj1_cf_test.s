.data
.text
.globl main


main: 
	beq	$0,$0,beqbranch1
beqbranch2:
	beq	$0,$0,beqbranch3
beqbranch4:
	beq	$0,$0,beqbranch5
beqbranch6:
	beq	$0,$0,beqbranch7
beqbranch8:
	beq	$0,$0,beqbranch9
beqbranch10:
	beq	$0,$0,pass1
beqbranch9:
	beq	$0,$0,beqbranch10
beqbranch7:
	beq	$0,$0,beqbranch8
beqbranch5:
	beq	$0,$0,beqbranch6
beqbranch3:
	beq	$0,$0,beqbranch4
beqbranch1:
	beq	$0,$0,beqbranch2

pass1:

	li $1, 1
	bne	$1,$0,bnebranch1
bnebranch2:
	bne	$1,$0,bnebranch3
bnebranch4:
	bne	$1,$0,bnebranch5
bnebranch6:
	bne	$1,$0,bnebranch7
bnebranch8:
	bne	$1,$0,bnebranch9
bnebranch10:
	bne	$1,$0,pass2
bnebranch9:
	bne	$1,$0,bnebranch10
bnebranch7:
	bne	$1,$0,bnebranch8
bnebranch5:
	bne	$1,$0,bnebranch6
bnebranch3:
	bne	$1,$0,bnebranch4
bnebranch1:
	bne	$1,$0,bnebranch2

pass2:


	li $t1, 1
	li $t2, 2
	blt	$t1,$t2,bltbranch1
bltbranch2:
	blt	$t1,$t2,bltbranch3
bltbranch4:
	blt	$t1,$t2,bltbranch5
bltbranch6:
	blt	$t1,$t2,bltbranch7
bltbranch8:
	blt	$t1,$t2,bltbranch9
bltbranch10:
	blt	$t1,$t2,pass3
bltbranch9:
	blt	$t1,$t2,bltbranch10
bltbranch7:
	blt	$t1,$t2,bltbranch8
bltbranch5:
	blt	$t1,$t2,bltbranch6
bltbranch3:
	blt	$t1,$t2,bltbranch4
bltbranch1:
	blt	$t1,$t2,bltbranch2

pass3:



	li $t1, 2
	li $t2, 1
	bgt	$t1,$t2,bgtbranch1
bgtbranch2:
	bgt	$t1,$t2,bgtbranch3
bgtbranch4:
	bgt	$t1,$t2,bgtbranch5
bgtbranch6:
	bgt	$t1,$t2,bgtbranch7
bgtbranch8:
	bgt	$t1,$t2,bgtbranch9
bgtbranch10:
	bgt	$t1,$t2,pass4
bgtbranch9:
	bgt	$t1,$t2,bgtbranch10
bgtbranch7:
	bgt	$t1,$t2,bgtbranch8
bgtbranch5:
	bgt	$t1,$t2,bgtbranch6
bgtbranch3:
	bgt	$t1,$t2,bgtbranch4
bgtbranch1:
	bgt	$t1,$t2,bgtbranch2

pass4:


	li $t1, -1
	blez	$t1,blezbranch1
blezbranch2:
	blez	$t1,blezbranch3
blezbranch4:
	blez	$t1,blezbranch5
blezbranch6:
	blez	$t1,blezbranch7
blezbranch8:
	blez	$t1,blezbranch9
blezbranch10:
	blez	$t1,pass5
blezbranch9:
	blez	$t1,blezbranch10
blezbranch7:
	blez	$t1,blezbranch8
blezbranch5:
	blez	$t1,blezbranch6
blezbranch3:
	blez	$t1,blezbranch4
blezbranch1:
	blez	$t1,blezbranch2

pass5:


	li $t1, -1
	bltz	$t1,bltzbranch1
bltzbranch2:
	bltz	$t1,bltzbranch3
bltzbranch4:
	bltz	$t1,bltzbranch5
bltzbranch6:
	bltz	$t1,bltzbranch7
bltzbranch8:
	bltz	$t1,bltzbranch9
bltzbranch10:
	bltz	$t1,pass6
bltzbranch9:
	bltz	$t1,bltzbranch10
bltzbranch7:
	bltz	$t1,bltzbranch8
bltzbranch5:
	bltz	$t1,bltzbranch6
bltzbranch3:
	bltz	$t1,bltzbranch4
bltzbranch1:
	bltz	$t1,bltzbranch2

pass6:


	li $t1, 1
	bgtz	$t1,bgtzbranch1
bgtzbranch2:
	bgtz	$t1,bgtzbranch3
bgtzbranch4:
	bgtz	$t1,bgtzbranch5
bgtzbranch6:
	bgtz	$t1,bgtzbranch7
bgtzbranch8:
	bgtz	$t1,bgtzbranch9
bgtzbranch10:
	bgtz	$t1,pass7
bgtzbranch9:
	bgtz	$t1,bgtzbranch10
bgtzbranch7:
	bgtz	$t1,bgtzbranch8
bgtzbranch5:
	bgtz	$t1,bgtzbranch6
bgtzbranch3:
	bgtz	$t1,bgtzbranch4
bgtzbranch1:
	bgtz	$t1,bgtzbranch2

pass7:


	li $t1, 1
	bgez	$t1,bgezbranch1
bgezbranch2:
	bgez	$t1,bgezbranch3
bgezbranch4:
	bgez	$t1,bgezbranch5
bgezbranch6:
	bgez	$t1,bgezbranch7
bgezbranch8:
	bgez	$t1,bgezbranch9
bgezbranch10:
	bgez	$t1,A
bgezbranch9:
	bgez	$t1,bgezbranch10
bgezbranch7:
	bgez	$t1,bgezbranch8
bgezbranch5:
	bgez	$t1,bgezbranch6
bgezbranch3:
	bgez	$t1,bgezbranch4
bgezbranch1:
	bgez	$t1,bgezbranch2

A:
    jal B
B: 
    addi $t1, $t1, 1
    jal C
C:
    addi $t1, $t1, 1
    jal D
D: 
    addi $t1, $t1, 1
    jal J_target_test
   

J_target_test:
jal target

j end       #can proram jump through multiple different nested jal jr statents


target:
jal target2

addi $sp, $ra, -8  #jumpst to correct sopt
jr $sp


target2:

jr $ra #returns to previous are inside the inside of the initial jal statement


 
 end:

    # Exit the program
    li $v0, 10
    syscall
