package dvt

import (
	dvt01 "github.com/selfuryon/cue-case/gitops/dvt/dvt-01:dvt01"
)

// Import nodes and apply hoodi-specific overrides
nodes: dvt01.nodes
nodes: [string]: {
	#config: {
		network: "hoodi"
		// Apply defaults per client
		consensus: _defaults.consensus[#config.consensus.client]
	}
}

// Collect manifests from all groups
Manifests: {for _, n in nodes {n.manifests}}
