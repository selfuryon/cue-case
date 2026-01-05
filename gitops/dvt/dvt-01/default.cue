@experiment(aliasv2)

package dvt01

import (
	"github.com/selfuryon/cue-case/apps"
)

nodes: [string]~(Name,_): apps.#Node & {
	#config: metadata: name: Name
}
