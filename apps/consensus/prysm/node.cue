@experiment(aliasv2)

package prysm

import (
	"github.com/selfuryon/cue-case/apps/consensus"
)

#Prysm: consensus.#ConsensusClient & {
	let _self = self

	image:   "prysm"
	version: "v7.0.1"
	options: #Options
	options: (_self.network): null

	// Port options from ports structure
	options: {
		"p2p-tcp-port": _self.ports."cl-p2p-listen".port
	}

	ports: {
		"cl-p2p-listen": {
			port:      1010
			protocol:  "TCP"
			#external: true
		}
	}

}
