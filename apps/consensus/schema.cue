@experiment(explicitopen)

@experiment(aliasv2)

package consensus

import (
	"strings"
)

// Base schema for consensus client
#ConsensusClient: {
	let _base = self

	// Client name
	client: string

	// Network (passed from Node config)
	network: string

	image:   string
	version: string
	// Full command including subcommands (if needed)
	command?: [...string]

	// Base options common for all presets
	// Can use network variable for conditional logic
	options: [string]: string | int | bool | null

	// Final container configuration
	container: {
		name:    "consensus"
		image:   _base.image
		version: _base.version
		if _base.command != _|_ {
			command: _base.command
		}
		options: _base.options
		// Convert to ContainerPort format
		ports: [
			for portName, portDef in _base.ports {
				name:          portName
				containerPort: portDef.port
				protocol:      portDef.protocol
			},
		]
	}

	// Ports (same for all presets)
	ports: [string]~(NAME,_): {
		_name:     strings.MaxRunes(15)
		_name:     NAME
		port:      int
		protocol:  "TCP" | "UDP"
		#internal: *false | bool // include in internal ClusterIP service

		#external: *false | bool // include in external LoadBalancer/NodePort
	}
}
