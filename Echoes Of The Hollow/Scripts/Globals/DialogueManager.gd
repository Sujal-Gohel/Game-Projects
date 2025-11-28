extends Node

enum Type{
	NORMAL,
	QUEST
}

var Dialogues : Dictionary = {
	"Villager":[
		"I Don't Know How But These Monsters That Looks Like a Pile Of Stones Were Spawn Out Of Nowhere",
		"And They Were Furious. Beware Of Them",
		"MUMMY....."
	],
	"Swordsman":{
		0:[
			"Ohh... Looks Like I Have a Guest After So Many Time",
			"I Assume That You Have Fought a Lot Enemies Until Now... WITH YOUR BARE HANDS,WHAT THE HELL!!!",
			"You Are a True Worrior.How About I Will Make U Stronger??",
			"Complete The Trial And Meet Me You Will Become Stronger Then I Have a Great Reward For You"
		],
		1:[
			"Trail Is Waiting For You"
		],
		2:[
			"WOW!! You Are Very Brave To Solo The Trial.No One Has Done This Trial Alone Expect You.",
			"Very Well !! You Are Truly Worthy Of This Sword",
			"Here Take This And Put It To Good Use"
		],
		3:[
			"Take Care Of The Sword"
		]
	},
	"DashMaster":{
		0:[
			"Well Hello!! I Am Dash Master.",
			"Do You Want To Learn Dash??"
		],
		1:[
			"Wait A Minute..."
		],
		2:[
			"OHH,Here Learn This And Make It Quick.."
		],
		3:[
			"Be Quick!!"
		]
	},
}
