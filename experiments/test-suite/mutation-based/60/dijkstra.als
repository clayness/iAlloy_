open util/ordering [State] as so
open util/ordering [Mutex] as mo
pred test66 {
some disj Process0, Process1: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process1->Mutex0 + State0->Process1->Mutex1 + State0->Process1->Mutex2 + State1->Process0->Mutex2 + State1->Process1->Mutex0 + State1->Process1->Mutex1 + State2->Process0->Mutex2 + State2->Process1->Mutex0
waits = State0->Process1->Mutex0 + State0->Process1->Mutex1 + State0->Process1->Mutex2 + State1->Process0->Mutex0 + State2->Process0->Mutex0
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
ReleaseMutex[State1,Process1,Mutex1,State2]
}}}
}
run test66 for 3 expect 1
pred test101 {
some disj Process0: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State2->Process0->Mutex0
no waits
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
GrabOrRelease[]
}}}
}
run test101 for 3 expect 1
pred test4 {
some disj Process0: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process0->Mutex0 + State0->Process0->Mutex1 + State0->Process0->Mutex2 + State1->Process0->Mutex0 + State1->Process0->Mutex1 + State1->Process0->Mutex2 + State2->Process0->Mutex0 + State2->Process0->Mutex1 + State2->Process0->Mutex2
waits = State0->Process0->Mutex0 + State0->Process0->Mutex1 + State0->Process0->Mutex2 + State1->Process0->Mutex0 + State1->Process0->Mutex1 + State1->Process0->Mutex2 + State2->Process0->Mutex0 + State2->Process0->Mutex1
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
}}}
}
run test4 for 3 expect 1
pred test48 {
some disj Process0, Process1: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process0->Mutex1 + State0->Process0->Mutex2 + State0->Process1->Mutex0 + State1->Process0->Mutex1 + State1->Process0->Mutex2 + State1->Process1->Mutex0 + State2->Process1->Mutex0 + State2->Process1->Mutex1 + State2->Process1->Mutex2
waits = State0->Process0->Mutex0 + State1->Process1->Mutex1 + State2->Process1->Mutex0 + State2->Process1->Mutex1
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
GrabMutex[State0,Process1,Mutex1,State1]
}}}
}
run test48 for 3 expect 0
pred test90 {
some disj Process0, Process1: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process1->Mutex1 + State0->Process1->Mutex2 + State1->Process0->Mutex2 + State1->Process1->Mutex0 + State1->Process1->Mutex1 + State1->Process1->Mutex2 + State2->Process1->Mutex0 + State2->Process1->Mutex1 + State2->Process1->Mutex2
waits = State0->Process0->Mutex1 + State0->Process0->Mutex2 + State1->Process0->Mutex1 + State2->Process1->Mutex0 + State2->Process1->Mutex1
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
ReleaseMutex[State1,Process1,Mutex0,State0]
}}}
}
run test90 for 3 expect 0
pred test59 {
some disj Process0, Process1, Process2: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1 + Process2
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process1->Mutex1 + State0->Process2->Mutex0 + State0->Process2->Mutex1 + State0->Process2->Mutex2 + State1->Process0->Mutex0 + State1->Process2->Mutex1 + State1->Process2->Mutex2 + State2->Process0->Mutex0 + State2->Process1->Mutex0 + State2->Process2->Mutex1 + State2->Process2->Mutex2
waits = State0->Process2->Mutex0 + State0->Process2->Mutex1 + State0->Process2->Mutex2 + State1->Process1->Mutex0 + State2->Process0->Mutex0 + State2->Process1->Mutex0
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
ReleaseMutex[State2,Process2,Mutex0,State1]
}}}
}
run test59 for 3 expect 0
pred test22 {
some disj Process0: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process0->Mutex0 + State0->Process0->Mutex1 + State0->Process0->Mutex2 + State1->Process0->Mutex0 + State1->Process0->Mutex1 + State1->Process0->Mutex2
waits = State0->Process0->Mutex0 + State0->Process0->Mutex1 + State0->Process0->Mutex2 + State1->Process0->Mutex0 + State1->Process0->Mutex1 + State1->Process0->Mutex2
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
GrabMutex[State2,Process0,Mutex0,State0]
}}}
}
run test22 for 3 expect 0
pred test96 {
some disj Process0, Process1: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process1->Mutex0 + State0->Process1->Mutex1 + State0->Process1->Mutex2 + State1->Process0->Mutex1 + State1->Process1->Mutex0 + State1->Process1->Mutex2 + State2->Process0->Mutex1 + State2->Process1->Mutex0
waits = State0->Process1->Mutex0 + State0->Process1->Mutex1 + State0->Process1->Mutex2 + State1->Process0->Mutex0
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
ReleaseMutex[State1,Process1,Mutex2,State2]
}}}
}
run test96 for 3 expect 0
pred test13 {
some disj Process0: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process0->Mutex0 + State0->Process0->Mutex1 + State0->Process0->Mutex2 + State1->Process0->Mutex0 + State1->Process0->Mutex1 + State1->Process0->Mutex2 + State2->Process0->Mutex0 + State2->Process0->Mutex1 + State2->Process0->Mutex2
waits = State0->Process0->Mutex0 + State0->Process0->Mutex1 + State0->Process0->Mutex2 + State1->Process0->Mutex0 + State1->Process0->Mutex1 + State1->Process0->Mutex2 + State2->Process0->Mutex0 + State2->Process0->Mutex1
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
IsFree[State2,Mutex2]
}}}
}
run test13 for 3 expect 0
pred test95 {
some disj Process0, Process1, Process2: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1 + Process2
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process2->Mutex0 + State0->Process2->Mutex1 + State0->Process2->Mutex2 + State1->Process1->Mutex0 + State1->Process2->Mutex1 + State1->Process2->Mutex2 + State2->Process0->Mutex1 + State2->Process1->Mutex0 + State2->Process2->Mutex1
waits = State0->Process2->Mutex0 + State0->Process2->Mutex1 + State0->Process2->Mutex2 + State1->Process1->Mutex0 + State2->Process1->Mutex0
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
ReleaseMutex[State1,Process2,Mutex2,State2]
}}}
}
run test95 for 3 expect 0
pred test20 {
some disj Process0: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process0->Mutex0 + State0->Process0->Mutex1 + State0->Process0->Mutex2 + State1->Process0->Mutex0 + State1->Process0->Mutex1 + State1->Process0->Mutex2 + State2->Process0->Mutex0 + State2->Process0->Mutex1
waits = State1->Process0->Mutex0 + State1->Process0->Mutex1 + State1->Process0->Mutex2 + State2->Process0->Mutex0
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
GrabMutex[State2,Process0,Mutex2,State0]
}}}
}
run test20 for 3 expect 0
pred test64 {
some disj Process0, Process1: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State1->Process1->Mutex0 + State1->Process1->Mutex1 + State1->Process1->Mutex2 + State2->Process1->Mutex1
waits = State0->Process0->Mutex0 + State1->Process1->Mutex0 + State1->Process1->Mutex1 + State1->Process1->Mutex2 + State2->Process0->Mutex0
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
ReleaseMutex[State2,Process1,Mutex1,State0]
}}}
}
run test64 for 3 expect 1
pred test49 {
some disj Process0, Process1: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process0->Mutex2 + State0->Process1->Mutex0 + State0->Process1->Mutex1 + State1->Process0->Mutex1 + State1->Process0->Mutex2 + State1->Process1->Mutex0 + State2->Process0->Mutex1 + State2->Process0->Mutex2 + State2->Process1->Mutex0
waits = State0->Process0->Mutex0 + State1->Process0->Mutex2 + State2->Process1->Mutex1
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
GrabMutex[State1,Process1,Mutex1,State2]
}}}
}
run test49 for 3 expect 0
pred test85 {
some disj Process0, Process1, Process2: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1 + Process2
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process1->Mutex2 + State0->Process2->Mutex1 + State1->Process0->Mutex0 + State1->Process2->Mutex1 + State2->Process2->Mutex0 + State2->Process2->Mutex1
waits = State2->Process0->Mutex0 + State2->Process1->Mutex0
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
ReleaseMutex[State2,Process2,Mutex0,State1]
}}}
}
run test85 for 3 expect 0
pred test63 {
some disj Process0, Process1: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process0->Mutex2 + State0->Process1->Mutex0 + State1->Process1->Mutex0 + State1->Process1->Mutex1 + State1->Process1->Mutex2 + State2->Process0->Mutex2 + State2->Process1->Mutex0 + State2->Process1->Mutex2
waits = State1->Process1->Mutex0 + State1->Process1->Mutex1 + State1->Process1->Mutex2 + State2->Process0->Mutex2
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
ReleaseMutex[State2,Process1,Mutex2,State0]
}}}
}
run test63 for 3 expect 1
pred test104 {
some disj Process0: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
no holds
no waits
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
GrabOrRelease[]
}}}
}
run test104 for 3 expect 1
pred test109 {
some disj Process0, Process1, Process2: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1 + Process2
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State1->Process1->Mutex1 + State1->Process2->Mutex1 + State2->Process1->Mutex2 + State2->Process2->Mutex1
waits = State1->Process2->Mutex0 + State1->Process2->Mutex1 + State2->Process2->Mutex0 + State2->Process2->Mutex1
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
GrabOrRelease[]
}}}
}
run test109 for 3 expect 0
pred test72 {
some disj Process0, Process1: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process0->Mutex0 + State1->Process1->Mutex0 + State1->Process1->Mutex1 + State1->Process1->Mutex2 + State2->Process0->Mutex0 + State2->Process1->Mutex0
waits = State0->Process0->Mutex1 + State0->Process0->Mutex2 + State1->Process1->Mutex0 + State1->Process1->Mutex1 + State1->Process1->Mutex2 + State2->Process0->Mutex0 + State2->Process0->Mutex1 + State2->Process0->Mutex2
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
ReleaseMutex[State2,Process1,Mutex0,State0]
}}}
}
run test72 for 3 expect 1
pred test120 {
some disj Process0, Process1, Process2: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1 + Process2
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State1->Process2->Mutex2 + State2->Process2->Mutex2
waits = State2->Process1->Mutex2
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
ShowDijkstra[]
}}}
}
run test120 for 3 expect 0
pred test50 {
some disj Process0, Process1: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process0->Mutex0 + State0->Process0->Mutex2 + State0->Process1->Mutex0 + State0->Process1->Mutex1 + State1->Process0->Mutex0 + State1->Process0->Mutex1 + State1->Process1->Mutex2 + State2->Process0->Mutex1
waits = State0->Process0->Mutex0 + State0->Process0->Mutex1 + State0->Process1->Mutex2 + State1->Process0->Mutex0 + State2->Process0->Mutex0
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
GrabMutex[State2,Process1,Mutex2,State1]
}}}
}
run test50 for 3 expect 0
pred test84 {
some disj Process0, Process1: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process1->Mutex0 + State1->Process1->Mutex0 + State1->Process1->Mutex1 + State1->Process1->Mutex2 + State2->Process0->Mutex0
waits = State0->Process0->Mutex0 + State1->Process1->Mutex0 + State1->Process1->Mutex1 + State1->Process1->Mutex2 + State2->Process0->Mutex0
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
ReleaseMutex[State0,Process1,Mutex0,State2]
}}}
}
run test84 for 3 expect 0
pred test93 {
some disj Process0, Process1, Process2: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1 + Process2
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process0->Mutex2 + State0->Process1->Mutex2 + State0->Process2->Mutex0 + State1->Process1->Mutex2 + State1->Process2->Mutex0 + State1->Process2->Mutex1 + State2->Process2->Mutex0 + State2->Process2->Mutex1 + State2->Process2->Mutex2
waits = State0->Process1->Mutex0 + State1->Process1->Mutex0 + State2->Process2->Mutex0 + State2->Process2->Mutex1
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
ReleaseMutex[State1,Process2,Mutex1,State0]
}}}
}
run test93 for 3 expect 0
pred test55 {
some disj Process0, Process1: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process0->Mutex1 + State0->Process0->Mutex2 + State0->Process1->Mutex0 + State1->Process0->Mutex0 + State1->Process0->Mutex1 + State1->Process0->Mutex2 + State2->Process0->Mutex1 + State2->Process0->Mutex2 + State2->Process1->Mutex0
waits = State0->Process0->Mutex0 + State2->Process0->Mutex0 + State2->Process0->Mutex1 + State2->Process1->Mutex1
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
GrabMutex[State0,Process1,Mutex1,State2]
}}}
}
run test55 for 3 expect 0
pred test89 {
some disj Process0, Process1: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process1->Mutex1 + State1->Process1->Mutex0 + State1->Process1->Mutex1 + State2->Process1->Mutex0 + State2->Process1->Mutex1 + State2->Process1->Mutex2
waits = State0->Process0->Mutex1 + State0->Process0->Mutex2 + State1->Process0->Mutex1 + State1->Process0->Mutex2 + State2->Process1->Mutex0 + State2->Process1->Mutex1
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
ReleaseMutex[State1,Process1,Mutex0,State0]
}}}
}
run test89 for 3 expect 1
pred test114 {
some disj Process0, Process1: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process1->Mutex0 + State0->Process1->Mutex1 + State0->Process1->Mutex2 + State1->Process1->Mutex0 + State1->Process1->Mutex1 + State1->Process1->Mutex2 + State2->Process1->Mutex0 + State2->Process1->Mutex1 + State2->Process1->Mutex2
waits = State0->Process0->Mutex1 + State0->Process1->Mutex0 + State0->Process1->Mutex2 + State1->Process0->Mutex0 + State1->Process1->Mutex1 + State1->Process1->Mutex2 + State2->Process0->Mutex2 + State2->Process1->Mutex0 + State2->Process1->Mutex1
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
Deadlock[]
}}}
}
run test114 for 3 expect 1
pred test5 {
some disj Process0: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process0->Mutex0 + State0->Process0->Mutex1 + State0->Process0->Mutex2 + State1->Process0->Mutex0 + State1->Process0->Mutex1 + State1->Process0->Mutex2 + State2->Process0->Mutex0 + State2->Process0->Mutex1 + State2->Process0->Mutex2
waits = State0->Process0->Mutex0 + State0->Process0->Mutex1 + State0->Process0->Mutex2 + State1->Process0->Mutex0 + State1->Process0->Mutex1 + State1->Process0->Mutex2 + State2->Process0->Mutex0 + State2->Process0->Mutex1
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
Initial[State0]
}}}
}
run test5 for 3 expect 0
pred test79 {
some disj Process0, Process1, Process2: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1 + Process2
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process2->Mutex0 + State0->Process2->Mutex1 + State0->Process2->Mutex2 + State1->Process1->Mutex2 + State1->Process2->Mutex0 + State2->Process0->Mutex0 + State2->Process1->Mutex2
waits = State0->Process2->Mutex0 + State0->Process2->Mutex1 + State0->Process2->Mutex2 + State1->Process0->Mutex0 + State1->Process1->Mutex0 + State2->Process1->Mutex0
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
ReleaseMutex[State1,Process2,Mutex0,State2]
}}}
}
run test79 for 3 expect 1
pred test106 {
some disj Process0: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State2->Process0->Mutex0 + State2->Process0->Mutex1 + State2->Process0->Mutex2
no waits
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
GrabOrRelease[]
}}}
}
run test106 for 3 expect 0
pred test52 {
some disj Process0, Process1: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process0->Mutex0 + State0->Process0->Mutex2 + State0->Process1->Mutex0 + State0->Process1->Mutex1 + State1->Process0->Mutex2 + State1->Process1->Mutex0 + State1->Process1->Mutex1 + State2->Process0->Mutex0 + State2->Process0->Mutex2 + State2->Process1->Mutex1
waits = State0->Process0->Mutex0 + State0->Process1->Mutex2 + State1->Process0->Mutex0 + State2->Process0->Mutex0 + State2->Process1->Mutex2
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
GrabMutex[State1,Process1,Mutex2,State0]
}}}
}
run test52 for 3 expect 0
pred test111 {
some disj Process0, Process1: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process1->Mutex0 + State0->Process1->Mutex1 + State0->Process1->Mutex2 + State1->Process1->Mutex0 + State1->Process1->Mutex1 + State1->Process1->Mutex2 + State2->Process1->Mutex0 + State2->Process1->Mutex1 + State2->Process1->Mutex2
waits = State0->Process0->Mutex0 + State0->Process0->Mutex1 + State0->Process0->Mutex2 + State1->Process0->Mutex0 + State1->Process0->Mutex1 + State1->Process0->Mutex2 + State2->Process0->Mutex0 + State2->Process0->Mutex1
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
Deadlock[]
}}}
}
run test111 for 3 expect 0
pred test11 {
some disj Process0: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process0->Mutex0 + State0->Process0->Mutex1 + State0->Process0->Mutex2 + State1->Process0->Mutex0 + State1->Process0->Mutex1 + State1->Process0->Mutex2 + State2->Process0->Mutex0 + State2->Process0->Mutex1 + State2->Process0->Mutex2
waits = State0->Process0->Mutex0 + State0->Process0->Mutex1 + State0->Process0->Mutex2 + State1->Process0->Mutex0 + State1->Process0->Mutex1 + State1->Process0->Mutex2 + State2->Process0->Mutex0 + State2->Process0->Mutex1
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
IsFree[State0,Mutex0]
}}}
}
run test11 for 3 expect 0
pred test71 {
some disj Process0, Process1: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process0->Mutex0 + State0->Process0->Mutex1 + State1->Process1->Mutex0 + State1->Process1->Mutex1 + State1->Process1->Mutex2 + State2->Process0->Mutex0 + State2->Process0->Mutex1 + State2->Process1->Mutex1
waits = State0->Process0->Mutex0 + State0->Process0->Mutex2 + State1->Process1->Mutex0 + State1->Process1->Mutex1 + State1->Process1->Mutex2 + State2->Process0->Mutex0 + State2->Process0->Mutex1 + State2->Process0->Mutex2
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
ReleaseMutex[State2,Process1,Mutex1,State0]
}}}
}
run test71 for 3 expect 1
pred test88 {
some disj Process0, Process1: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process1->Mutex0 + State0->Process1->Mutex1 + State0->Process1->Mutex2 + State2->Process1->Mutex2
waits = State0->Process1->Mutex0 + State0->Process1->Mutex1 + State0->Process1->Mutex2 + State1->Process0->Mutex0 + State2->Process0->Mutex0
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
ReleaseMutex[State2,Process1,Mutex2,State1]
}}}
}
run test88 for 3 expect 1
pred test75 {
some disj Process0, Process1, Process2: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1 + Process2
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State1->Process2->Mutex0 + State2->Process1->Mutex1 + State2->Process2->Mutex0 + State2->Process2->Mutex1 + State2->Process2->Mutex2
waits = State0->Process0->Mutex0 + State2->Process2->Mutex0 + State2->Process2->Mutex1
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
ReleaseMutex[State1,Process2,Mutex0,State0]
}}}
}
run test75 for 3 expect 0
pred test37 {
some disj Process0, Process1: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process0->Mutex2 + State0->Process1->Mutex0 + State0->Process1->Mutex1 + State1->Process1->Mutex0 + State1->Process1->Mutex1 + State1->Process1->Mutex2 + State2->Process1->Mutex0 + State2->Process1->Mutex1 + State2->Process1->Mutex2
waits = State1->Process1->Mutex0 + State1->Process1->Mutex1 + State1->Process1->Mutex2 + State2->Process1->Mutex0 + State2->Process1->Mutex1
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
GrabMutex[State0,Process1,Mutex2,State0]
}}}
}
run test37 for 3 expect 0
pred test83 {
some disj Process0, Process1, Process2: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1 + Process2
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process0->Mutex0 + State0->Process1->Mutex0 + State0->Process1->Mutex2 + State0->Process2->Mutex0 + State0->Process2->Mutex1 + State0->Process2->Mutex2 + State1->Process0->Mutex0 + State2->Process2->Mutex0
waits = State0->Process2->Mutex0 + State0->Process2->Mutex1 + State0->Process2->Mutex2 + State2->Process0->Mutex0 + State2->Process1->Mutex0
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
ReleaseMutex[State2,Process2,Mutex0,State1]
}}}
}
run test83 for 3 expect 0
pred test46 {
some disj Process0: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process0->Mutex2 + State1->Process0->Mutex0 + State1->Process0->Mutex1 + State1->Process0->Mutex2
waits = State1->Process0->Mutex0 + State1->Process0->Mutex1 + State1->Process0->Mutex2
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
GrabMutex[State2,Process0,Mutex2,State0]
}}}
}
run test46 for 3 expect 1
pred test30 {
some disj Process0, Process1: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process0->Mutex1 + State0->Process1->Mutex0 + State0->Process1->Mutex2 + State1->Process1->Mutex0 + State1->Process1->Mutex1 + State1->Process1->Mutex2 + State2->Process0->Mutex1 + State2->Process1->Mutex0 + State2->Process1->Mutex2
waits = State0->Process0->Mutex0 + State0->Process1->Mutex1 + State1->Process1->Mutex0 + State1->Process1->Mutex1 + State1->Process1->Mutex2 + State2->Process0->Mutex0
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
GrabMutex[State2,Process1,Mutex1,State0]
}}}
}
run test30 for 3 expect 0
pred test41 {
some disj Process0, Process1, Process2: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1 + Process2
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process0->Mutex2 + State0->Process1->Mutex2 + State0->Process2->Mutex0 + State0->Process2->Mutex1 + State1->Process2->Mutex0 + State1->Process2->Mutex1 + State1->Process2->Mutex2 + State2->Process2->Mutex0 + State2->Process2->Mutex1 + State2->Process2->Mutex2
waits = State1->Process2->Mutex0 + State1->Process2->Mutex1 + State1->Process2->Mutex2 + State2->Process2->Mutex0 + State2->Process2->Mutex1
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
GrabMutex[State0,Process2,Mutex2,State0]
}}}
}
run test41 for 3 expect 0
pred test19 {
some disj Process0: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process0->Mutex0 + State0->Process0->Mutex1 + State0->Process0->Mutex2 + State1->Process0->Mutex0 + State1->Process0->Mutex1 + State1->Process0->Mutex2 + State2->Process0->Mutex0 + State2->Process0->Mutex1 + State2->Process0->Mutex2
waits = State0->Process0->Mutex0 + State0->Process0->Mutex1 + State0->Process0->Mutex2 + State1->Process0->Mutex0 + State1->Process0->Mutex1 + State1->Process0->Mutex2 + State2->Process0->Mutex0 + State2->Process0->Mutex1 + State2->Process0->Mutex2
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
GrabMutex[State2,Process0,Mutex2,State2]
}}}
}
run test19 for 3 expect 0
pred test9 {
some disj Process0, Process1: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process1->Mutex0 + State0->Process1->Mutex1 + State0->Process1->Mutex2 + State1->Process1->Mutex0 + State1->Process1->Mutex1 + State1->Process1->Mutex2 + State2->Process0->Mutex0 + State2->Process0->Mutex1 + State2->Process1->Mutex2
waits = State0->Process1->Mutex0 + State0->Process1->Mutex1 + State0->Process1->Mutex2 + State1->Process1->Mutex0 + State1->Process1->Mutex1 + State1->Process1->Mutex2 + State2->Process1->Mutex0 + State2->Process1->Mutex1
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
Initial[State2]
}}}
}
run test9 for 3 expect 0
pred test78 {
some disj Process0, Process1: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process1->Mutex0 + State0->Process1->Mutex1 + State1->Process1->Mutex0 + State1->Process1->Mutex1 + State1->Process1->Mutex2 + State2->Process1->Mutex0
waits = State1->Process1->Mutex0 + State1->Process1->Mutex1 + State1->Process1->Mutex2 + State2->Process0->Mutex1
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
ReleaseMutex[State0,Process1,Mutex1,State2]
}}}
}
run test78 for 3 expect 0
pred test82 {
some disj Process0, Process1: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process0->Mutex1 + State0->Process1->Mutex0 + State1->Process1->Mutex0 + State1->Process1->Mutex1 + State1->Process1->Mutex2 + State2->Process1->Mutex0 + State2->Process1->Mutex1
waits = State0->Process0->Mutex1 + State1->Process1->Mutex0 + State1->Process1->Mutex1 + State1->Process1->Mutex2 + State2->Process0->Mutex1
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
ReleaseMutex[State2,Process1,Mutex1,State0]
}}}
}
run test82 for 3 expect 0
pred test68 {
some disj Process0, Process1: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process1->Mutex0 + State0->Process1->Mutex1 + State0->Process1->Mutex2 + State1->Process0->Mutex0 + State1->Process0->Mutex1 + State1->Process1->Mutex1 + State1->Process1->Mutex2 + State2->Process0->Mutex0 + State2->Process0->Mutex1 + State2->Process1->Mutex2
waits = State0->Process1->Mutex0 + State0->Process1->Mutex1 + State0->Process1->Mutex2 + State1->Process0->Mutex1
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
ReleaseMutex[State1,Process1,Mutex1,State2]
}}}
}
run test68 for 3 expect 1
pred test92 {
some disj Process0, Process1: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process1->Mutex0 + State0->Process1->Mutex1 + State0->Process1->Mutex2 + State1->Process0->Mutex0 + State1->Process0->Mutex2 + State1->Process1->Mutex1 + State2->Process0->Mutex0 + State2->Process0->Mutex2
waits = State0->Process1->Mutex0 + State0->Process1->Mutex1 + State0->Process1->Mutex2 + State1->Process0->Mutex0 + State2->Process0->Mutex0
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
ReleaseMutex[State1,Process1,Mutex1,State2]
}}}
}
run test92 for 3 expect 1
pred test86 {
some disj Process0, Process1: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process1->Mutex0 + State0->Process1->Mutex1 + State0->Process1->Mutex2 + State1->Process1->Mutex1 + State1->Process1->Mutex2 + State2->Process0->Mutex2 + State2->Process1->Mutex1
waits = State0->Process1->Mutex0 + State0->Process1->Mutex1 + State0->Process1->Mutex2 + State1->Process0->Mutex0 + State1->Process0->Mutex2 + State2->Process0->Mutex0
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
ReleaseMutex[State1,Process1,Mutex2,State2]
}}}
}
run test86 for 3 expect 1
pred test110 {
some disj Process0, Process1, Process2: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1 + Process2
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State1->Process0->Mutex0 + State1->Process0->Mutex1 + State1->Process1->Mutex0 + State1->Process1->Mutex1 + State1->Process2->Mutex0 + State1->Process2->Mutex1 + State1->Process2->Mutex2 + State2->Process0->Mutex1 + State2->Process1->Mutex1 + State2->Process2->Mutex0 + State2->Process2->Mutex1 + State2->Process2->Mutex2
waits = State1->Process1->Mutex1 + State1->Process2->Mutex0 + State2->Process1->Mutex1
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
GrabOrRelease[]
}}}
}
run test110 for 3 expect 0
pred test18 {
some disj Process0: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process0->Mutex0 + State0->Process0->Mutex1 + State0->Process0->Mutex2 + State1->Process0->Mutex0 + State1->Process0->Mutex1 + State1->Process0->Mutex2 + State2->Process0->Mutex0 + State2->Process0->Mutex1 + State2->Process0->Mutex2
waits = State0->Process0->Mutex0 + State0->Process0->Mutex1 + State0->Process0->Mutex2 + State1->Process0->Mutex0 + State1->Process0->Mutex1 + State1->Process0->Mutex2 + State2->Process0->Mutex0 + State2->Process0->Mutex1 + State2->Process0->Mutex2
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
GrabMutex[State2,Process0,Mutex0,State2]
}}}
}
run test18 for 3 expect 0
pred test1 {
some disj Process0, Process1: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process0->Mutex1 + State0->Process0->Mutex2 + State0->Process1->Mutex0 + State1->Process0->Mutex0 + State1->Process0->Mutex1 + State1->Process0->Mutex2 + State2->Process0->Mutex0 + State2->Process0->Mutex1 + State2->Process0->Mutex2
waits = State0->Process0->Mutex0 + State0->Process0->Mutex1 + State0->Process0->Mutex2 + State1->Process0->Mutex0 + State1->Process0->Mutex1 + State1->Process0->Mutex2 + State2->Process0->Mutex0 + State2->Process0->Mutex1
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
}}}
}
run test1 for 3 expect 1
pred test42 {
some disj Process0, Process1, Process2: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1 + Process2
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process0->Mutex0 + State0->Process1->Mutex0 + State1->Process2->Mutex0 + State1->Process2->Mutex1 + State1->Process2->Mutex2 + State2->Process0->Mutex0 + State2->Process1->Mutex0
waits = State0->Process2->Mutex0 + State1->Process2->Mutex0 + State1->Process2->Mutex1 + State1->Process2->Mutex2
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
GrabMutex[State2,Process2,Mutex0,State0]
}}}
}
run test42 for 3 expect 1
pred test2 {
some disj Process0, Process1: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process1->Mutex0 + State0->Process1->Mutex1 + State0->Process1->Mutex2 + State1->Process1->Mutex0 + State1->Process1->Mutex1 + State1->Process1->Mutex2 + State2->Process1->Mutex0 + State2->Process1->Mutex1 + State2->Process1->Mutex2
waits = State0->Process1->Mutex0 + State0->Process1->Mutex1 + State0->Process1->Mutex2 + State1->Process1->Mutex0 + State1->Process1->Mutex1 + State1->Process1->Mutex2 + State2->Process1->Mutex0 + State2->Process1->Mutex1
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
}}}
}
run test2 for 3 expect 1
pred test17 {
some disj Process0: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process0->Mutex0 + State0->Process0->Mutex1 + State0->Process0->Mutex2 + State1->Process0->Mutex0 + State1->Process0->Mutex1 + State1->Process0->Mutex2 + State2->Process0->Mutex0 + State2->Process0->Mutex1 + State2->Process0->Mutex2
waits = State0->Process0->Mutex0 + State0->Process0->Mutex1 + State0->Process0->Mutex2 + State1->Process0->Mutex0 + State1->Process0->Mutex1 + State1->Process0->Mutex2 + State2->Process0->Mutex0 + State2->Process0->Mutex1
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
IsStalled[State2,Process0]
}}}
}
run test17 for 3 expect 1
pred test10 {
some disj Process0: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process0->Mutex0 + State0->Process0->Mutex1 + State0->Process0->Mutex2 + State1->Process0->Mutex0 + State1->Process0->Mutex1 + State1->Process0->Mutex2 + State2->Process0->Mutex0 + State2->Process0->Mutex1 + State2->Process0->Mutex2
waits = State0->Process0->Mutex0 + State0->Process0->Mutex1 + State0->Process0->Mutex2 + State1->Process0->Mutex0 + State1->Process0->Mutex1 + State1->Process0->Mutex2 + State2->Process0->Mutex0 + State2->Process0->Mutex1 + State2->Process0->Mutex2
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
Initial[State2]
}}}
}
run test10 for 3 expect 0
pred test32 {
some disj Process0, Process1: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process0->Mutex1 + State0->Process0->Mutex2 + State1->Process1->Mutex0 + State1->Process1->Mutex1 + State1->Process1->Mutex2 + State2->Process1->Mutex0 + State2->Process1->Mutex1 + State2->Process1->Mutex2
waits = State1->Process1->Mutex0 + State1->Process1->Mutex1 + State1->Process1->Mutex2 + State2->Process1->Mutex0 + State2->Process1->Mutex1
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
GrabMutex[State0,Process1,Mutex0,State0]
}}}
}
run test32 for 3 expect 0
pred test56 {
some disj Process0, Process1: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process0->Mutex1 + State0->Process0->Mutex2 + State0->Process1->Mutex0 + State1->Process0->Mutex1 + State1->Process0->Mutex2 + State1->Process1->Mutex0 + State2->Process0->Mutex1 + State2->Process0->Mutex2 + State2->Process1->Mutex0
waits = State0->Process0->Mutex0 + State0->Process1->Mutex1 + State1->Process0->Mutex0 + State2->Process1->Mutex1
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
GrabMutex[State1,Process1,Mutex1,State2]
}}}
}
run test56 for 3 expect 0
pred test57 {
some disj Process0: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process0->Mutex0 + State0->Process0->Mutex1 + State0->Process0->Mutex2 + State1->Process0->Mutex0 + State1->Process0->Mutex1 + State1->Process0->Mutex2 + State2->Process0->Mutex0 + State2->Process0->Mutex1 + State2->Process0->Mutex2
waits = State0->Process0->Mutex0 + State0->Process0->Mutex1 + State0->Process0->Mutex2 + State1->Process0->Mutex0 + State1->Process0->Mutex1 + State1->Process0->Mutex2 + State2->Process0->Mutex0 + State2->Process0->Mutex1 + State2->Process0->Mutex2
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
ReleaseMutex[State2,Process0,Mutex2,State2]
}}}
}
run test57 for 3 expect 0
pred test100 {
some disj Process0: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State1->Process0->Mutex0 + State1->Process0->Mutex1 + State1->Process0->Mutex2 + State2->Process0->Mutex0 + State2->Process0->Mutex1 + State2->Process0->Mutex2
waits = State1->Process0->Mutex0 + State1->Process0->Mutex1 + State1->Process0->Mutex2 + State2->Process0->Mutex0 + State2->Process0->Mutex1
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
GrabOrRelease[]
}}}
}
run test100 for 3 expect 0
pred test40 {
some disj Process0, Process1, Process2: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1 + Process2
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process2->Mutex0 + State0->Process2->Mutex1 + State0->Process2->Mutex2 + State1->Process2->Mutex0 + State1->Process2->Mutex1 + State1->Process2->Mutex2 + State2->Process0->Mutex1 + State2->Process1->Mutex1 + State2->Process2->Mutex0
waits = State0->Process2->Mutex0 + State0->Process2->Mutex1 + State0->Process2->Mutex2 + State1->Process2->Mutex0 + State1->Process2->Mutex1 + State1->Process2->Mutex2
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
GrabMutex[State2,Process2,Mutex1,State2]
}}}
}
run test40 for 3 expect 0
pred test45 {
some disj Process0: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State1->Process0->Mutex2 + State2->Process0->Mutex0 + State2->Process0->Mutex1 + State2->Process0->Mutex2
waits = State2->Process0->Mutex0 + State2->Process0->Mutex1
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
GrabMutex[State0,Process0,Mutex2,State1]
}}}
}
run test45 for 3 expect 1
pred test38 {
some disj Process0, Process1: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process0->Mutex2 + State0->Process1->Mutex1 + State1->Process1->Mutex0 + State1->Process1->Mutex1 + State1->Process1->Mutex2 + State2->Process0->Mutex2 + State2->Process1->Mutex1
waits = State0->Process1->Mutex2 + State1->Process1->Mutex0 + State1->Process1->Mutex1 + State1->Process1->Mutex2
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
GrabMutex[State2,Process1,Mutex2,State0]
}}}
}
run test38 for 3 expect 1
pred test102 {
some disj Process0: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State1->Process0->Mutex0 + State1->Process0->Mutex1 + State1->Process0->Mutex2 + State2->Process0->Mutex0 + State2->Process0->Mutex1 + State2->Process0->Mutex2
waits = State1->Process0->Mutex0 + State1->Process0->Mutex1 + State1->Process0->Mutex2 + State2->Process0->Mutex0 + State2->Process0->Mutex1 + State2->Process0->Mutex2
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
GrabOrRelease[]
}}}
}
run test102 for 3 expect 0
pred test47 {
some disj Process0, Process1: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process1->Mutex0 + State0->Process1->Mutex1 + State0->Process1->Mutex2 + State1->Process0->Mutex0 + State1->Process1->Mutex2 + State2->Process0->Mutex0
waits = State0->Process1->Mutex0 + State0->Process1->Mutex1 + State0->Process1->Mutex2
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
GrabMutex[State2,Process1,Mutex2,State1]
}}}
}
run test47 for 3 expect 1
pred test81 {
some disj Process0, Process1: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process1->Mutex0 + State1->Process1->Mutex0 + State1->Process1->Mutex1 + State1->Process1->Mutex2 + State2->Process1->Mutex0 + State2->Process1->Mutex1
waits = State1->Process1->Mutex0 + State1->Process1->Mutex1 + State1->Process1->Mutex2 + State2->Process0->Mutex1
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
ReleaseMutex[State2,Process1,Mutex1,State0]
}}}
}
run test81 for 3 expect 0
pred test119 {
some disj Process0: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process0->Mutex0 + State0->Process0->Mutex1 + State0->Process0->Mutex2 + State1->Process0->Mutex0 + State1->Process0->Mutex1 + State1->Process0->Mutex2 + State2->Process0->Mutex0 + State2->Process0->Mutex1 + State2->Process0->Mutex2
waits = State0->Process0->Mutex0 + State0->Process0->Mutex1 + State0->Process0->Mutex2 + State1->Process0->Mutex0 + State1->Process0->Mutex1 + State1->Process0->Mutex2 + State2->Process0->Mutex0 + State2->Process0->Mutex1
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
ShowDijkstra[]
}}}
}
run test119 for 3 expect 0
pred test77 {
some disj Process0: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State1->Process0->Mutex0 + State1->Process0->Mutex1 + State1->Process0->Mutex2 + State2->Process0->Mutex2
waits = State1->Process0->Mutex0 + State1->Process0->Mutex1 + State1->Process0->Mutex2
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
ReleaseMutex[State2,Process0,Mutex2,State0]
}}}
}
run test77 for 3 expect 1
pred test113 {
some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
no Process
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
no holds
no waits
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
Deadlock[]
}}
}
run test113 for 3 expect 0
pred test24 {
some disj Process0, Process1: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process0->Mutex1 + State0->Process1->Mutex2 + State1->Process1->Mutex0 + State1->Process1->Mutex1 + State1->Process1->Mutex2 + State2->Process0->Mutex1
waits = State0->Process0->Mutex1 + State1->Process1->Mutex0 + State1->Process1->Mutex1 + State1->Process1->Mutex2 + State2->Process0->Mutex1
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
GrabMutex[State2,Process1,Mutex2,State0]
}}}
}
run test24 for 3 expect 1
pred test36 {
some disj Process0, Process1: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process0->Mutex0 + State0->Process0->Mutex1 + State0->Process0->Mutex2 + State0->Process1->Mutex0 + State0->Process1->Mutex1 + State1->Process1->Mutex0 + State1->Process1->Mutex1 + State1->Process1->Mutex2 + State2->Process0->Mutex0 + State2->Process0->Mutex1 + State2->Process0->Mutex2 + State2->Process1->Mutex2
waits = State1->Process1->Mutex0 + State1->Process1->Mutex1 + State1->Process1->Mutex2 + State2->Process1->Mutex2
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
GrabMutex[State0,Process1,Mutex2,State2]
}}}
}
run test36 for 3 expect 0
pred test14 {
some disj Process0: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process0->Mutex0 + State0->Process0->Mutex1 + State0->Process0->Mutex2 + State1->Process0->Mutex0 + State1->Process0->Mutex1 + State1->Process0->Mutex2 + State2->Process0->Mutex0 + State2->Process0->Mutex1 + State2->Process0->Mutex2
waits = State0->Process0->Mutex0 + State0->Process0->Mutex1 + State0->Process0->Mutex2 + State1->Process0->Mutex0 + State1->Process0->Mutex1 + State1->Process0->Mutex2
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
IsStalled[State2,Process0]
}}}
}
run test14 for 3 expect 0
pred test34 {
some disj Process0, Process1: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process1->Mutex0 + State0->Process1->Mutex1 + State1->Process1->Mutex0 + State1->Process1->Mutex1 + State1->Process1->Mutex2 + State2->Process1->Mutex0 + State2->Process1->Mutex1 + State2->Process1->Mutex2
waits = State1->Process1->Mutex1 + State2->Process1->Mutex0 + State2->Process1->Mutex1
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
GrabMutex[State0,Process1,Mutex2,State1]
}}}
}
run test34 for 3 expect 0
pred test3 {
some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
no Process
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
no holds
no waits
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
}}
}
run test3 for 3 expect 1
pred test69 {
some disj Process0, Process1: Process {some disj Mutex0, Mutex1, Mutex2: Mutex {some disj State0, State1, State2: State {
Process = Process0 + Process1
Mutex = Mutex0 + Mutex1 + Mutex2
State = State0 + State1 + State2
holds = State0->Process0->Mutex1 + State0->Process0->Mutex2 + State1->Process1->Mutex0 + State1->Process1->Mutex1 + State1->Process1->Mutex2 + State2->Process0->Mutex1 + State2->Process0->Mutex2 + State2->Process1->Mutex1
waits = State0->Process0->Mutex0 + State0->Process0->Mutex2 + State1->Process1->Mutex0 + State1->Process1->Mutex1 + State1->Process1->Mutex2 + State2->Process0->Mutex0 + State2->Process0->Mutex1 + State2->Process0->Mutex2
so/first = State0
so/next = State0->State1 + State1->State2
mo/first = Mutex0
mo/next = Mutex0->Mutex1 + Mutex1->Mutex2
ReleaseMutex[State2,Process1,Mutex1,State0]
}}}
}
run test69 for 3 expect 1
