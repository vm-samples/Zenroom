#!/bin/sh

if ! [ -d $PWD/src ]; then
	echo "usage: ./build/codegen_ecdh_factory.sh CURVE_NAME"
	return 1
fi

CN="$1"

cat <<EOF > src/zen_ecdh_factory.c
// Generated by build/codegen_ecdh_factory.sh
// `date`
#include <string.h>
#include <jutils.h>
#include <lauxlib.h>
#include <zen_ecdh.h>
#include <zen_error.h>
#include <ecdh_${CN}.h>

void ecdh_init(ecdh *ECDH) {
	ECDH->seclen = EGS_${CN}; // public key size
	ECDH->fieldsize = EFS_${CN};
	ECDH->rng = NULL;
	ECDH->hash = HASH_TYPE_${CN};
	ECDH->ECP__KEY_PAIR_GENERATE = ECP_${CN}_KEY_PAIR_GENERATE;
	ECDH->ECP__PUBLIC_KEY_VALIDATE	= ECP_${CN}_PUBLIC_KEY_VALIDATE;
	ECDH->ECP__SVDP_DH = ECP_${CN}_SVDP_DH;
	ECDH->ECP__ECIES_ENCRYPT = ECP_${CN}_ECIES_ENCRYPT;
	ECDH->ECP__ECIES_DECRYPT = ECP_${CN}_ECIES_DECRYPT;
	ECDH->ECP__SP_DSA = ECP_${CN}_SP_DSA;
	ECDH->ECP__VP_DSA = ECP_${CN}_VP_DSA;
	act(NULL,"ECDH curve is ${CN}");
}
EOF
