/*
 * System for randomly generating a randomized mob appearance/stats using 'gene' datums. Intended as a supplement & cross-work to Xenoarch and Xenobio.
 */

/*
 * Sequences, the building block of a mob. Can be as intensive or bare-bones as needed. Shouldn't be accessed as though all things will be present.
 */


/datum/mob_genetic_sequence
	var/name = "genetic sequence"
	var/desc = "A genetic sequence."

	// The intended mob subtype this gene sequence is for.
	var/intended_type = /mob/living

	var/list/genes = list()


/*
 * Genes!
 */

/datum/mob_gene
	var/name = "gene"
	var/desc = "An animal gene."

	var/recessive = FALSE	// Will this gene always be overridden by a non-recessive gene?

	// The intended mob subtype this gene is for.
	var/intended_type = /mob/living

/*
 * Appearance Genes.
 */

/datum/mob_gene/appearance
	var/list/attachment_x = 	// Where is the attachment 'node' on the sprite's X for each dir
	var/list/attachment_y = 16	// Where is the attachment 'node' on the sprite's Y for each dir