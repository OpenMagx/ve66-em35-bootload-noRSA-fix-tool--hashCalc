// Writed by Ant-ON, 2010
// Metod by yakk
//
// This program generete hash for CG (Code Group)
//

#include <gcrypt.h>
#include <stdio.h>
#include <stdlib.h>

#define BLOCK_LEN 0x800

int main(int argc, char **argv)
{
	FILE * cg = fopen(argv[1], "rb");
	FILE * hashTable = fopen(argv[2], "wb");
	
	if ( !cg || !hashTable )
	{
		fprintf(stderr, "ERROR-- check file\n");
		return 0;
	}
	
	char * buf = (char*)malloc( BLOCK_LEN );
	
	char * hash = (char*)malloc( gcry_md_get_algo_dlen( GCRY_MD_SHA1 ) );
	
	int i=0;
	while ( true )
	{
		if ( fread(buf, BLOCK_LEN, sizeof(char), cg) != 1 )
			break;
		
		gcry_md_hash_buffer( GCRY_MD_SHA1, hash, buf, BLOCK_LEN );
		
		fwrite(hash, gcry_md_get_algo_dlen( GCRY_MD_SHA1 ), 1, hashTable);
	}
	
	free( buf );
	free( hash );
	fclose( cg );
	fclose( hashTable) ;
	
	return 0;
}
