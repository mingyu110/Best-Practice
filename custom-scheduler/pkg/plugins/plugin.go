package plugins

import (
	"context"
	v1 "k8s.io/api/core/v1"
	"k8s.io/kubernetes/pkg/scheduler/framework"
	"k8s.io/kubernetes/pkg/scheduler/framework/runtime"
)

type PodNodeAffinityPlugin struct {
	handle framework.Handle
}

func (pl *PodNodeAffinityPlugin) Name() string {
	return "PodNodeAffinityPlugin"
}

func (pl *PodNodeAffinityPlugin) Filter(ctx context.Context, state *framework.CycleState, pod *v1.Pod, nodeInfo *framework.NodeInfo) *framework.Status {
	node := nodeInfo.Node()
	podLabels := pod.Labels
	nodeLabels := node.Labels

	for key, value := range podLabels {
		if nodeValue, exists := nodeLabels[key]; exists && nodeValue == value {
			continue
		} else {
			return framework.NewStatus(framework.Unschedulable, "Node does not match pod's affinity labels")
		}
	}

	return framework.NewStatus(framework.Success)
}

func New(_ runtime.Object, h framework.Handle) (framework.Plugin, error) {
	return &PodNodeAffinityPlugin{handle: h}, nil
}
