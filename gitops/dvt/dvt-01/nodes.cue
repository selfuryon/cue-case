package dvt01

let _prefix = "dvt-01"
nodes: {
	"\(_prefix)-node-01": #config: {
		consensus: {
			client: "prysm"
			options: "p2p-max-peers": 100
		}
	}
}
