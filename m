Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6625FB763
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Oct 2022 17:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiJKPeK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 11 Oct 2022 11:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbiJKPdd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 11 Oct 2022 11:33:33 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667ADBEAEA;
        Tue, 11 Oct 2022 08:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665501766; x=1697037766;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=7wSP4TYlAxkaflihOJTFEcb8ISzoiRnXg100vqVWAvo=;
  b=PNvSpCBJkyXze3AmBGCSmbh2wZ9iH8BgEFCuPzGbbJQqzlzxgsAPXCEh
   U+yEooz+LB94otNjTSVtYvlMAwtHE9SK/SlHCjZHzRguMJh/wCzDwwFwW
   +gmtW4OoqqKHUEiLCbAN3ZqauJuaGosF2nWOanPWcYh2saa0gUjQKjaAU
   3YzPjWgm+Uq/ThUJShNcMBsois0yC75nX/IYq9FShrtfD+uihZq1FrNyH
   94m2e8WMApjI3Dn0fBpuUZSuhqbQD8QPtBbhTdB4C1fGZEQtmU7zp9Fn2
   BiFcDcxWJTCshNVzhKRFq53fiTcxlcxTraa6R0Fnh6pJFCPfUNFUNVqmt
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="284912449"
X-IronPort-AV: E=Sophos;i="5.95,176,1661842800"; 
   d="scan'208";a="284912449"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 08:18:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="695098463"
X-IronPort-AV: E=Sophos;i="5.95,176,1661842800"; 
   d="scan'208";a="695098463"
Received: from lkp-server01.sh.intel.com (HELO 2af0a69ca4e0) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 11 Oct 2022 08:18:21 -0700
Received: from kbuild by 2af0a69ca4e0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oiH1R-0002wR-00;
        Tue, 11 Oct 2022 15:18:21 +0000
Date:   Tue, 11 Oct 2022 23:17:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     ntfs3@lists.linux.dev, loongarch@lists.linux.dev,
        linux-perf-users@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-mm@kvack.org, linux-iio@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        apparmor@lists.ubuntu.com, amd-gfx@lists.freedesktop.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [linux-next:master] BUILD REGRESSION
 b9f85101cad3397ef1e509909602a90e257ab9d8
Message-ID: <6345891e.N8YlqGQ6WJeXXn2f%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: b9f85101cad3397ef1e509909602a90e257ab9d8  Add linux-next specific files for 20221011

Error/Warning reports:

https://lore.kernel.org/linux-doc/202209201326.sY9kHOLm-lkp@intel.com
https://lore.kernel.org/linux-doc/202210070057.NpbaMyxB-lkp@intel.com
https://lore.kernel.org/linux-mm/202210090954.pTR6m6rj-lkp@intel.com
https://lore.kernel.org/linux-mm/202210110857.9s0tXVNn-lkp@intel.com
https://lore.kernel.org/linux-mm/202210111318.mbUfyhps-lkp@intel.com
https://lore.kernel.org/llvm/202210111438.WT5u8Im6-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

ERROR: modpost: "dcn20_acquire_dsc" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "dcn20_build_mapped_resource" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "devm_ioremap_resource" [drivers/dma/fsl-edma.ko] undefined!
ERROR: modpost: "devm_ioremap_resource" [drivers/dma/idma64.ko] undefined!
ERROR: modpost: "devm_ioremap_resource" [drivers/dma/qcom/hdma.ko] undefined!
ERROR: modpost: "devm_memremap" [drivers/misc/open-dice.ko] undefined!
ERROR: modpost: "devm_memunmap" [drivers/misc/open-dice.ko] undefined!
ERROR: modpost: "devm_platform_ioremap_resource" [drivers/char/xillybus/xillybus_of.ko] undefined!
ERROR: modpost: "ioremap" [drivers/net/ethernet/8390/pcnet_cs.ko] undefined!
ERROR: modpost: "ioremap" [drivers/tty/ipwireless/ipwireless.ko] undefined!
ERROR: modpost: "iounmap" [drivers/net/ethernet/8390/pcnet_cs.ko] undefined!
ERROR: modpost: "iounmap" [drivers/tty/ipwireless/ipwireless.ko] undefined!
Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/clock/microchip,mpfs.yaml
Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
arch/arm64/kernel/alternative.c:199:6: warning: no previous prototype for 'apply_alternatives_vdso' [-Wmissing-prototypes]
arch/arm64/kernel/alternative.c:295:14: warning: no previous prototype for 'alt_cb_patch_nops' [-Wmissing-prototypes]
arch/loongarch/mm/init.c:166:24: warning: variable 'new' set but not used [-Wunused-but-set-variable]
dc_resource.c:(.text.dc_resource_acquire_secondary_pipe_for_mpc_odm+0x21c): undefined reference to `dcn20_acquire_dsc'
drivers/iio/adc/mcp3911.c:252 mcp3911_write_raw() error: buffer overflow 'mcp3911_osr_table' 8 <= 31
drivers/iio/adc/mcp3911.c:499 mcp3911_probe() warn: passing zero to 'PTR_ERR'
drivers/nvme/target/loop.c:578 nvme_loop_create_ctrl() warn: 'opts->queue_size - 1' 18446744073709551615 can't fit into 65535 'ctrl->ctrl.sqsize'
drivers/nvme/target/loop.c:578 nvme_loop_create_ctrl() warn: 'opts->queue_size - 1' 4294967295 can't fit into 65535 'ctrl->ctrl.sqsize'
fs/ext4/super.c:1744:19: warning: 'deprecated_msg' defined but not used [-Wunused-const-variable=]
fs/ntfs3/namei.c:487 ntfs_d_compare() error: uninitialized symbol 'uni1'.
include/linux/compiler_types.h:357:45: error: call to '__compiletime_assert_422' declared with attribute error: FIELD_GET: mask is not constant
mips-linux-ld: dc_resource.c:(.text.dc_resource_acquire_secondary_pipe_for_mpc_odm+0x304): undefined reference to `dcn20_build_mapped_resource'
mm/mmap.c:802 __vma_adjust() error: uninitialized symbol 'next_next'.
security/apparmor/policy_unpack.c:1089 unpack_profile() warn: passing zero to 'ERR_PTR'
security/apparmor/policy_unpack.c:548 unpack_trans_table() error: uninitialized symbol 'table'.

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm64-allyesconfig
|   |-- arch-arm64-kernel-alternative.c:warning:no-previous-prototype-for-alt_cb_patch_nops
|   `-- arch-arm64-kernel-alternative.c:warning:no-previous-prototype-for-apply_alternatives_vdso
|-- csky-randconfig-m041-20221010
|   `-- mm-mmap.c-__vma_adjust()-error:uninitialized-symbol-next_next-.
|-- i386-allyesconfig
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- i386-defconfig
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- i386-randconfig-a003
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- i386-randconfig-a005
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- i386-randconfig-a011-20221010
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- i386-randconfig-a012-20221010
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- i386-randconfig-a014-20221010
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- i386-randconfig-a016-20221010
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- i386-randconfig-c001-20221010
|   `-- include-linux-compiler_types.h:error:call-to-__compiletime_assert_NNN-declared-with-attribute-error:FIELD_GET:mask-is-not-constant
|-- i386-randconfig-c021-20221010
|   `-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|-- i386-randconfig-m021-20221010
|   |-- arch-x86-kernel-apic-apic.c-generic_processor_info()-warn:always-true-condition-(num_processors-()-)-(-u32max-)
|   |-- drivers-iio-adc-mcp3911.c-mcp3911_probe()-warn:passing-zero-to-PTR_ERR
|   |-- drivers-iio-adc-mcp3911.c-mcp3911_write_raw()-error:buffer-overflow-mcp3911_osr_table
|   |-- drivers-nvme-target-loop.c-nvme_loop_create_ctrl()-warn:opts-queue_size-can-t-fit-into-ctrl-ctrl.sqsize
|   |-- fs-ext4-super.c:warning:deprecated_msg-defined-but-not-used
|   `-- mm-mmap.c-__vma_adjust()-error:uninitialized-symbol-next_next-.
|-- i386-randconfig-s052-20221010
|   |-- fs-ntfs3-index.c:sparse:sparse:restricted-__le32-degrades-to-integer
|   |-- fs-ntfs3-namei.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-restricted-__le16-const-usertype-s1-got-unsigned-short
|   `-- fs-ntfs3-namei.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-restricted-__le16-const-usertype-s2-got-unsigned-short
|-- loongarch-randconfig-r012-20221010
|   `-- arch-loongarch-mm-init.c:warning:variable-new-set-but-not-used
|-- loongarch-randconfig-s032-20221010
|   |-- arch-loongarch-kernel-perf_event.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-void-ptr-got-int-noderef-__percpu
|   `-- arch-loongarch-kernel-perf_event.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-void-ptr-got-unsigned-int-noderef-__percpu
|-- mips-allyesconfig
|   |-- dc_resource.c:(.text.dc_resource_acquire_secondary_pipe_for_mpc_odm):undefined-reference-to-dcn20_acquire_dsc
|   `-- mips-linux-ld:dc_resource.c:(.text.dc_resource_acquire_secondary_pipe_for_mpc_odm):undefined-reference-to-dcn20_build_mapped_resource
|-- powerpc-allmodconfig
|   |-- ERROR:dcn20_acquire_dsc-drivers-gpu-drm-amd-amdgpu-amdgpu.ko-undefined
|   `-- ERROR:dcn20_build_mapped_resource-drivers-gpu-drm-amd-amdgpu-amdgpu.ko-undefined
|-- s390-allmodconfig
|   |-- ERROR:devm_ioremap_resource-drivers-dma-fsl-edma.ko-undefined
|   |-- ERROR:devm_ioremap_resource-drivers-dma-idma64.ko-undefined
clang_recent_errors
|-- arm-ep93xx_defconfig
|   `-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|-- arm-imx_v4_v5_defconfig
|   `-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|-- arm-ixp4xx_defconfig
|   `-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|-- arm-randconfig-r026-20221010
|   |-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|   `-- fs-ntfs3-namei.c:warning:variable-uni1-is-used-uninitialized-whenever-if-condition-is-true
|-- hexagon-randconfig-r041-20221010
|   |-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|   |-- fs-ntfs3-namei.c:warning:variable-uni1-is-used-uninitialized-whenever-if-condition-is-true
|   |-- ld.lld:error:vmlinux.a(arch-hexagon-kernel-head.o):(.init.text):relocation-R_HEX_B22_PCREL-out-of-range:is-not-in-references-__vmnewmap
|   |-- ld.lld:error:vmlinux.a(arch-hexagon-kernel-head.o):(.init.text):relocation-R_HEX_B22_PCREL-out-of-range:is-not-in-references-__vmsetvec
|   `-- ld.lld:error:vmlinux.a(arch-hexagon-kernel-head.o):(.init.text):relocation-R_HEX_B22_PCREL-out-of-range:is-not-in-references-memset
|-- i386-buildonly-randconfig-r006-20221010
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dml-dcn32-dcn32_fpu.c:warning:no-previous-prototype-for-function-dcn32_split_stream_for_mpc_or_odm
|-- i386-randconfig-a002
|   |-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|   `-- fs-ntfs3-namei.c:warning:variable-uni1-is-used-uninitialized-whenever-if-condition-is-true
|-- i386-randconfig-a004
|   |-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|   `-- fs-ntfs3-namei.c:warning:variable-uni1-is-used-uninitialized-whenever-if-condition-is-true
|-- mips-cu1000-neo_defconfig
|   `-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|-- powerpc-fsp2_defconfig
|   `-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|-- riscv-randconfig-r042-20221011
|   `-- ld.lld:error:undefined-symbol:riscv_cbom_block_size
|-- riscv-rv32_defconfig
|   `-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|-- x86_64-randconfig-a001-20221010
|   |-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|   `-- fs-ntfs3-namei.c:warning:variable-uni1-is-used-uninitialized-whenever-if-condition-is-true
|-- x86_64-randconfig-a003-20221010
|   |-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
|   `-- fs-ntfs3-namei.c:warning:variable-uni1-is-used-uninitialized-whenever-if-condition-is-true
|-- x86_64-randconfig-a004-20221010
|   `-- fs-ext4-super.c:warning:unused-variable-deprecated_msg
`-- x86_64-rhel-8.3-rust
    `-- fs-ext4-super.c:warning:unused-variable-deprecated_msg

elapsed time: 725m

configs tested: 85
configs skipped: 3

gcc tested configs:
x86_64                              defconfig
arc                                 defconfig
alpha                               defconfig
i386                                defconfig
x86_64                               rhel-8.3
i386                 randconfig-a011-20221010
um                             i386_defconfig
arc                  randconfig-r043-20221010
s390                             allmodconfig
x86_64               randconfig-a011-20221010
um                           x86_64_defconfig
arm                                 defconfig
i386                          randconfig-a001
i386                 randconfig-a013-20221010
s390                             allyesconfig
x86_64                          rhel-8.3-func
i386                 randconfig-a015-20221010
x86_64               randconfig-a016-20221010
riscv                randconfig-r042-20221010
s390                                defconfig
i386                          randconfig-a003
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a014-20221010
x86_64               randconfig-a014-20221010
i386                          randconfig-a005
powerpc                           allnoconfig
s390                 randconfig-r044-20221010
i386                 randconfig-a016-20221010
x86_64               randconfig-a015-20221010
powerpc                     redwood_defconfig
i386                 randconfig-a012-20221010
powerpc                          allmodconfig
xtensa                  cadence_csp_defconfig
x86_64               randconfig-a012-20221010
mips                             allyesconfig
i386                             allyesconfig
sh                          sdk7780_defconfig
x86_64               randconfig-a013-20221010
arm                              allyesconfig
arc                               allnoconfig
x86_64                           rhel-8.3-syz
arm64                            allyesconfig
sh                               allmodconfig
alpha                             allnoconfig
um                                  defconfig
x86_64                         rhel-8.3-kunit
xtensa                  audio_kc705_defconfig
m68k                             allmodconfig
riscv                             allnoconfig
x86_64                           rhel-8.3-kvm
csky                              allnoconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                        stmark2_defconfig
arc                 nsimosci_hs_smp_defconfig
ia64                          tiger_defconfig
powerpc                     asp8347_defconfig
m68k                             allyesconfig
ia64                             allmodconfig
arm                            pleb_defconfig
arc                      axs103_smp_defconfig
m68k                             alldefconfig
powerpc                  iss476-smp_defconfig
arm                       omap2plus_defconfig
i386                 randconfig-c001-20221010

clang tested configs:
hexagon              randconfig-r045-20221010
hexagon              randconfig-r041-20221010
riscv                             allnoconfig
i386                          randconfig-a002
x86_64               randconfig-a002-20221010
x86_64               randconfig-a001-20221010
x86_64               randconfig-a003-20221010
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a006-20221010
x86_64               randconfig-a004-20221010
x86_64               randconfig-a005-20221010
arm                          ep93xx_defconfig
mips                          ath25_defconfig
arm                       imx_v4_v5_defconfig
arm                          ixp4xx_defconfig
mips                     cu1000-neo_defconfig
x86_64                          rhel-8.3-rust
powerpc                        fsp2_defconfig
riscv                          rv32_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
