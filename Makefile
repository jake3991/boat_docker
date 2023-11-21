RELEASES := 	kinetic \
		melodic \
		noetic \
		humble

package-xml-batch-dir:
	mkdir -p package_xml_batch

package-xml-batch: package-xml-batch-dir

boat-%: boat.Dockerfile package-xml-batch
	docker build -t "jake/boat:$*" -f "$<" .

test-boat-%: boat-%
	docker run --rm -it --privileged -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=":0" "jake/boat:$*" 
	
all: $(addprefix boat-,$(RELEASES))
