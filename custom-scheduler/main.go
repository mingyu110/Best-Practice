package main

import (
	"fmt"
	"k8s.io/kubernetes/cmd/kube-scheduler/app"
	"k8s.io/kubernetes/pkg/scheduler/framework/runtime"
	"github.com/mingyu110/Best-Practice/custom-scheduler/pkg/plugins"
	"os"
)

func main() {
	command := app.NewSchedulerCommand(
		app.WithPlugin("PodNodeAffinityPlugin", New),
	)
	if err := command.Execute(); err != nil {
		os.Exit(1)
	}
}
