#include "config.h"

#include <cstdlib>
#include <iostream>

int main() {
  std::cout << "Number of logical cores: " << NUMBER_OF_LOGICAL_CORES << std::endl;
  std::cout << "Number of physical cores: " << NUMBER_OF_PHYSICAL_CORES << std::endl;

  std::cout << "Total virtual memory in megabytes: " << TOTAL_VIRTUAL_MEMORY
            << std::endl;
  std::cout << "Available virtual memory in megabytes: " << AVAILABLE_VIRTUAL_MEMORY
            << std::endl;
  std::cout << "Total physical memory in megabytes: " << TOTAL_PHYSICAL_MEMORY
            << std::endl;
  std::cout << "Available physical memory in megabytes: "
            << AVAILABLE_PHYSICAL_MEMORY << std::endl;

  std::cout << "Processor is 64Bit: " << IS_64BIT << std::endl;
  std::cout << "Processor has floating point unit: " << HAS_FPU << std::endl;
  std::cout << "Processor supports MMX instructions: " << HAS_MMX << std::endl;
  std::cout << "Processor supports Ext. MMX instructions: " << HAS_MMX_PLUS
            << std::endl;
  std::cout << "Processor supports SSE instructions: " << HAS_SSE << std::endl;
  std::cout << "Processor supports SSE2 instructions: " << HAS_SSE2 << std::endl;
  std::cout << "Processor supports SSE FP instructions: " << HAS_SSE_FP << std::endl;
  std::cout << "Processor supports SSE MMX instructions: " << HAS_SSE_MMX
            << std::endl;
  std::cout << "Processor supports 3DNow instructions: " << HAS_AMD_3DNOW
            << std::endl;
  std::cout << "Processor supports 3DNow+ instructions: " << HAS_AMD_3DNOW_PLUS
            << std::endl;
  std::cout << "IA64 processor emulating x86 : " << HAS_IA64 << std::endl;

  std::cout << "OS name: " << OS_NAME << std::endl;
  std::cout << "OS sub-type: " << OS_RELEASE << std::endl;
  std::cout << "OS build ID: " << OS_VERSION << std::endl;
  std::cout << "OS platform: " << OS_PLATFORM << std::endl;

  return EXIT_SUCCESS;
}
