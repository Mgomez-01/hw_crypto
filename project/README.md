# Project submission for ECE 6960 HW Cryptography

The tex files are all included to show how we put together the project and we will be working on finishing up the last parts of the project mentioned as TODO. The conference is CHES journal and takes up  20 page papers, it has a due date July.

We would appreciate any help you could provide in terms of things we should keep, remove, clarify, update, etc. in order to consider this a good submission for that deadline. More info at the link below:
https://ches.iacr.org/2024/cfp-ches2024.pdf


## Files included

	- Files include tsvs used to calculate some characteristics in making the choice of which polynomial to use
	- python, singular, and sage scripts used in various calculations and verifications
	- text files that contain some results of scripts
	
## Python files
	- shinker.py - sample implementation of the kind of cipher that was released in 1993 referenced in section VII: Analysis E: Weaknesses
	- verify_totient.py - a script to take in a degree and base to then calculate the number of primitive polynomials using the totient function
		`python3 verify_totient.py 4 37` example run of the base 37 and degree 4
	- how_many_rounds.py - a script to check the number of runs needed to get a polynomial. basically a binomial rounds calculator given probability of success and the desired probability of success. 
		`python3 how_many_rounds.py -p .0627 -d .99` example run of 6.27% and wanted win rate of 99%
	- gen_prim_37.py - a script to calculate all primitive plynomials with a particular degree
		`python3 gen_prim_37.py deg` takes in degree as an int
	- hello.py - The example shown in the paper where we show it can be used for setting up the taps and the initial state of the design
		`python3 hello.py`
	- bermas.py - example of berkleymasse in python
		`python3 bermas.py`


## Singular
	- p37_4_3.sing - prints the polynomials. generated with python to easily setup all of the prints to calculate the coefficients for the parts of section V Key Exchange and Auth D: Implementation
		`singular p37_4_3.sing`
	- F37.sing - calculates degrees from the minpoly and indicates if primitive or not
		`singular F37.sing`
## Sage
	- bermas.sage - example of berkleymasse in sage instead 
		`sage bermas.sage`
	- bin_LFSR.sage - example of an implementation of an LFSR in binary and F_37 in sage
		`sage bin_LFSR.sage`
	- F37.sage - NOTE!!!! will never finish!! only prints the first few degrees before entering the forever loop that will take too long to get a result
	- try2F37.sage - the random search algorithm created with an exit condition after 100 attempts
		`sage try2F37.sage`
	- verifyPrimitive.sage - a script to enumerate all primitives by using the polynomial found and then prints whether or not a set created with that matches the length of the generated list. if yes, then the alpha generates all elements with that poly.
		`sage verifyPrimitive.sage`



## mathematica notebooks
 - interesting things done in mathematica
   - cayleytable.nb - makes a cayleytable and was used in figure generation
   - TotientFunction.nb - used to learn more and verify my totient calculations
   
   
## tsv files
- used in doing some characterizing of the poly results. 

## txt files 
- used in the tsv and in searching for polys
