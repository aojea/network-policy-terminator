# network-policy-terminator

The network-policy-terminator controller ensure that the Network Policies, when the namespace is being deleted,
are not deleted before the Pods they are targeting.

## How it works

The network-policy-terminator adds a finalizer to every NetworkPolicy object created and,
when the NetworkPolicy is being deleted by the namespace controller, it waits for the Pods
associated to the NetworkPolicy to be deleted before removing the finalizer.

## Install

kubectl apply -f ./install.yaml
