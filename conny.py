#!/usr/bin/env python3

import argparse
import binascii

def unhex(value):
	if len(value)%2!=0:
		value = '0' + value
	return binascii.unhexlify(value).decode('latin-1')

def hex(value):
	return binascii.hexlify(value.encode()).decode()

def unascii(value):
	ret = ''
	val = 0
	for i in value:
		if int(str(val)+i) > 256 :
			ret += chr(val)
			val = int(i)
		else:
			val = int(str(val) + i)

	ret += chr(val)
	return ret

def ascii(value):

	ret = ''
	for i in value:
		ret += str(ord(i))

	return ret

def main():

	my_parser = argparse.ArgumentParser(prog='conny',
		description="Convert to/from hex and ascii encodings",
		usage="conny [flags] [string to encode/decode]",
		allow_abbrev=False)

	my_parser.add_argument('string',
							type=str,
							help="The string to encode/decode from"
							)

	# add file reading and decoding 

	my_group = my_parser.add_mutually_exclusive_group(required=True)

	my_group.add_argument('-ux','--unhex', action='store_true', help="Hex code to readable format")
	my_group.add_argument('-x','--hex', action='store_true', help="Normal string to hex code")
	my_group.add_argument('-ua','--unascii', action='store_true', help="Ascii codes to readable string")
	my_group.add_argument('-a','--ascii', action='store_true', help="Normal string to ascii codes")

	args = my_parser.parse_args()

	the_string = args.string
	the_string = the_string.split(' ')

	# print(the_string)
	if args.unhex:
		for value in the_string :
			print(unhex(value), end=' ')
	elif args.hex:
		for value in the_string :
			print(hex(value), end=' ')
	elif args.unascii:
		for value in the_string :
			print(unascii(value), end=' ')
	elif args.ascii:
		for value in the_string :
			print(ascii(value), end=' ')

	print()


if __name__ == '__main__':
	main()