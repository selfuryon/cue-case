@experiment(aliasv2)
@experiment(explicitopen)

package apps

import (
	consensusSchema "github.com/selfuryon/cue-case/apps/consensus"
	prysmPkg "github.com/selfuryon/cue-case/apps/consensus/prysm"
)

_consensusClients: {
	prysm: prysmPkg.#Prysm
}

#NodeConfig: {
	let _config = self
	metadata: labels: [string]: string
	metadata: name: string

	// Network selection
	network: *"mainnet" | "hoodi"

	consensus: consensusSchema.#ConsensusClient & {
		client: "prysm"
		image:  "prysm"

		network: _config.network
	}

}

#Node: {
	#config: #NodeConfig

	// Problem part is here
	// This part is working
	let _clBase = _consensusClients[#config.consensus.client] & #config.consensus & {}

	// But this variant doesn't work
	// let _clBase = _consensusClients[#config.consensus.client] & #config.consensus

	// But if we change that to direct call - both works 
	// let _clBase = prysmPkg.#Prysm & #config.consensus & {}
	// let _clBase = prysmPkg.#Prysm & #config.consensus

	// Get container kubernetes manifests for clients
	let _clContainer = _clBase.container

	// Core manifests - StatefulSet and internal Service
	manifests: container: _clContainer
}
