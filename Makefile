all: certs

certs: clean
	./scripts/certs-gen.sh

certs-clean:
	rm -f ./saltstack/salt/certs/*.crt
	rm -f ./saltstack/salt/certs/*.key
	rm -f ./saltstack/salt/certs/*.req
	rm -f ./saltstack/salt/certs/*.csr
	rm -f ./saltstack/salt/certs/*.srl

clean: certs-clean