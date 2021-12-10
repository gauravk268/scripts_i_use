import argparse
parser = argparse.ArgumentParser()
parser.add_argument("cipher",  help="Enter the ciphered file (ROT47)")

args = parser.parse_args()
data = args.cipher


def rot47(data):
    with open(data, "r") as file:
        decode = []
        for data in file:
            data = data.strip()
            for i in xrange(len(data)):
                encoded = ord(data[i])
                if encoded >= 33 and encoded <= 126:
                    decode.append(chr(33 + ((encoded + 14) % 94)))
                else:
                    decode.append(data[i])
        return ''.join(decode)


print("Decrypted Cipher: {}".format(rot47(data)))
