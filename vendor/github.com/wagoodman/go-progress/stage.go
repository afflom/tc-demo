package progress

type Stager interface {
	Stage() string
}

type Stage struct {
	Current string
}

func (s Stage) Stage() string {
	return s.Current
}

type StagedProgressable interface {
	Stager
	Progressable
}

type StagedProgressor interface {
	Stager
	Progressor
}
