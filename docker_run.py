#!/usr/bin/env python
from __future__ import print_function

import argparse
import os
import getpass

if __name__=="__main__":
	user_name = getpass.getuser()
	default_image_name = user_name + '-filament'
	parser = argparse.ArgumentParser()
	parser.add_argument("-i", "--image", type=str,
		help="(required) name of the image that this container is derived from", default=default_image_name)

	parser.add_argument("-c", "--container", type=str, default="filament", help="(optional) name of the container")\

	parser.add_argument("-d", "--dry_run", action='store_true', help="(optional) perform a dry_run, print the command that would have been executed but don't execute it.")

	parser.add_argument("-e", "--entrypoint", type=str, default="", help="(optional) thing to run in container")

	parser.add_argument("-p", "--passthrough", type=str, default="", help="(optional) extra string that will be tacked onto the docker run command, allows you to pass extra options. Make sure to put this in quotes and leave a space before the first character")

	parser.add_argument("-nodudp", "--no_udp", action='store_true', help="(optional) don't expose the udp ports")

	args = parser.parse_args()
	print("running docker container derived from image %s" %args.image)
	source_dir=os.getcwd()

	image_name = args.image

	cmd = "xhost +local:root \n"
	cmd += "nvidia-docker run "
	if args.container:
		cmd += " --name %(container_name)s " % {'container_name': args.container}

	cmd += " -e DISPLAY -e QT_X11_NO_MITSHM=1 -v /tmp/.X11-unix:/tmp/.X11-unix:rw "     # enable graphics

	cmd += " " + args.passthrough + " "

	cmd += " --rm " # remove the image when you exit

	if args.entrypoint and args.entrypoint != "":
		cmd += "--entrypoint=\"%(entrypoint)s\" " % {"entrypoint": args.entrypoint}
	else:
		cmd += "-it "
	cmd += image_name
	cmd_endxhost = "xhost -local:root"

	print("command = \n \n", cmd, "\n", cmd_endxhost)
	print("")

	# build the docker image
	if not args.dry_run:
		print("executing shell command")
		code = os.system(cmd)
		print("Executed with code ", code)
		os.system(cmd_endxhost)
		exit(code != 0)
	else:
		print("dry run, not executing command")
		exit(0)
