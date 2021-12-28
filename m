Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4E34806A1
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Dec 2021 06:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbhL1FyE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Dec 2021 00:54:04 -0500
Received: from mga01.intel.com ([192.55.52.88]:44205 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234867AbhL1FyD (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 28 Dec 2021 00:54:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640670843; x=1672206843;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=tuh6RozLWJKteVSoY6wG9HEp9uKkOiLF89dxnJFPjF8=;
  b=Ex/sTkqPVKMZ7TX9UoWrAsAdFHo6FZRMFZ8o4/0Iy9rdAzi3SOXtKtyd
   6ZAv6F3iPlRVNST6KkRDY+tiNRTUhdmwRqU61X3Icz+86KRCe9D2dBu4D
   Pkq4fb3rxDnYA5xihYuLmz+tfZoOVwxNVkD83iqExAaUTtiC60H/fie0N
   06sW8koXDCOXsg1X2L7oWLm8/A6llAwgjzr+oeuORWqLh4Fej0hZxhl0l
   ufHfCquUleyV2yFdLdfD8cfeWMnAArqeXkeUCYCe2mjbrWAxgx6OY+1WD
   EyqGk1RLtzBYUkW41pAOMooF4GcUDbolVQlgnPiAOkiTOxsqgCRrzbXtx
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10210"; a="265545509"
X-IronPort-AV: E=Sophos;i="5.88,241,1635231600"; 
   d="scan'208";a="265545509"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2021 21:53:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,241,1635231600"; 
   d="scan'208";a="554068869"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 27 Dec 2021 21:53:51 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n25Ql-0007I3-4c; Tue, 28 Dec 2021 05:53:51 +0000
Date:   Tue, 28 Dec 2021 13:53:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS WITH WARNING
 856dd2096e2a01f6eb2c9d60f6e0cd587aa273a8
Message-ID: <61caa63c.Fxb1LRcQCSg2mulh%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: 856dd2096e2a01f6eb2c9d60f6e0cd587aa273a8  ext4: fix an use-after-free issue about data=journal writeback mode

Warning reports:

https://lore.kernel.org/llvm/202112281210.5KoelwNW-lkp@intel.com

Warning in current branch:

fs/ext4/super.c:2173:1: warning: unused function 'ctx_clear_flags'

Warning ids grouped by kconfigs:

clang_recent_errors
`-- mips-buildonly-randconfig-r006-20211228
    `-- fs-ext4-super.c:warning:unused-function-ctx_clear_flags

elapsed time: 1310m

configs tested: 232
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                  cavium_octeon_defconfig
h8300                     edosk2674_defconfig
powerpc                        fsp2_defconfig
riscv                    nommu_virt_defconfig
powerpc                 mpc834x_mds_defconfig
arc                        nsimosci_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                      obs600_defconfig
mips                        jmr3927_defconfig
powerpc                   microwatt_defconfig
sh                            shmin_defconfig
m68k                       m5475evb_defconfig
m68k                       m5275evb_defconfig
mips                            gpr_defconfig
powerpc                          allyesconfig
arm                         shannon_defconfig
arm                          moxart_defconfig
arc                         haps_hs_defconfig
arm                       netwinder_defconfig
sh                           se7751_defconfig
ia64                          tiger_defconfig
arm                             rpc_defconfig
arm                   milbeaut_m10v_defconfig
sh                        apsh4ad0a_defconfig
powerpc                         ps3_defconfig
nios2                         10m50_defconfig
arm                         lpc32xx_defconfig
riscv                            alldefconfig
sh                          rsk7203_defconfig
arm                       mainstone_defconfig
arm                           stm32_defconfig
powerpc                     taishan_defconfig
ia64                         bigsur_defconfig
arm                            zeus_defconfig
csky                                defconfig
mips                          rb532_defconfig
arm                         s3c2410_defconfig
sh                              ul2_defconfig
powerpc                      ppc44x_defconfig
arm                        neponset_defconfig
arm                          imote2_defconfig
riscv                    nommu_k210_defconfig
arm                         lpc18xx_defconfig
um                           x86_64_defconfig
arm                        mvebu_v7_defconfig
ia64                             allmodconfig
sh                         ap325rxa_defconfig
powerpc                    amigaone_defconfig
sparc                               defconfig
arm                           spitz_defconfig
powerpc                   bluestone_defconfig
powerpc                    adder875_defconfig
sparc                       sparc64_defconfig
mips                           ip32_defconfig
arm                        multi_v5_defconfig
mips                      maltaaprp_defconfig
m68k                           sun3_defconfig
arm                             mxs_defconfig
sparc                            alldefconfig
mips                        bcm47xx_defconfig
sh                          rsk7201_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                          kfr2r09_defconfig
powerpc                 mpc837x_mds_defconfig
sh                  sh7785lcr_32bit_defconfig
nds32                            alldefconfig
sh                 kfr2r09-romimage_defconfig
mips                           ip27_defconfig
arm                           viper_defconfig
arm                           sunxi_defconfig
mips                           ip22_defconfig
xtensa                generic_kc705_defconfig
powerpc                   lite5200b_defconfig
powerpc                 canyonlands_defconfig
arm                        spear3xx_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                     redwood_defconfig
m68k                        m5307c3_defconfig
nds32                             allnoconfig
powerpc                  mpc866_ads_defconfig
s390                             alldefconfig
ia64                      gensparse_defconfig
sh                            migor_defconfig
arm                            pleb_defconfig
powerpc                       holly_defconfig
arm                      pxa255-idp_defconfig
mips                       capcella_defconfig
m68k                          hp300_defconfig
nios2                            alldefconfig
arm                           u8500_defconfig
powerpc                  iss476-smp_defconfig
arm64                            alldefconfig
xtensa                         virt_defconfig
powerpc                      chrp32_defconfig
powerpc                      cm5200_defconfig
h8300                               defconfig
powerpc                           allnoconfig
m68k                       m5208evb_defconfig
sh                   secureedge5410_defconfig
arc                        nsim_700_defconfig
arm                            xcep_defconfig
arm                          pxa168_defconfig
arm                       omap2plus_defconfig
arm                           corgi_defconfig
sh                          rsk7264_defconfig
powerpc                         wii_defconfig
arc                              allyesconfig
powerpc                       ppc64_defconfig
xtensa                  audio_kc705_defconfig
sh                     sh7710voipgw_defconfig
i386                             alldefconfig
sh                          rsk7269_defconfig
powerpc                 linkstation_defconfig
powerpc64                           defconfig
powerpc                    gamecube_defconfig
sh                           sh2007_defconfig
powerpc                        icon_defconfig
arm                         nhk8815_defconfig
powerpc                    ge_imp3a_defconfig
parisc                              defconfig
powerpc                     asp8347_defconfig
arm                        mini2440_defconfig
arm                       multi_v4t_defconfig
arm                         s3c6400_defconfig
riscv                             allnoconfig
arm                  colibri_pxa270_defconfig
mips                  decstation_64_defconfig
arm                         orion5x_defconfig
powerpc                 mpc8272_ads_defconfig
sh                         microdev_defconfig
powerpc                  storcenter_defconfig
arm                      integrator_defconfig
sh                               alldefconfig
arm                         vf610m4_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                         mpc30x_defconfig
arm                           h5000_defconfig
sh                        sh7785lcr_defconfig
mips                        bcm63xx_defconfig
xtensa                  cadence_csp_defconfig
arm                  randconfig-c002-20211227
arm                  randconfig-c002-20211228
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
x86_64               randconfig-a005-20211228
x86_64               randconfig-a001-20211228
x86_64               randconfig-a003-20211228
x86_64               randconfig-a006-20211228
x86_64               randconfig-a004-20211228
x86_64               randconfig-a002-20211228
x86_64               randconfig-a013-20211227
x86_64               randconfig-a014-20211227
x86_64               randconfig-a015-20211227
x86_64               randconfig-a011-20211227
x86_64               randconfig-a012-20211227
x86_64               randconfig-a016-20211227
i386                 randconfig-a012-20211227
i386                 randconfig-a011-20211227
i386                 randconfig-a014-20211227
i386                 randconfig-a016-20211227
i386                 randconfig-a015-20211227
i386                 randconfig-a013-20211227
arc                  randconfig-r043-20211227
s390                 randconfig-r044-20211227
riscv                randconfig-r042-20211227
riscv                            allyesconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20211227
x86_64               randconfig-a001-20211227
x86_64               randconfig-a005-20211227
x86_64               randconfig-a006-20211227
x86_64               randconfig-a004-20211227
x86_64               randconfig-a002-20211227
i386                 randconfig-a006-20211227
i386                 randconfig-a004-20211227
i386                 randconfig-a002-20211227
i386                 randconfig-a003-20211227
i386                 randconfig-a005-20211227
i386                 randconfig-a001-20211227
x86_64               randconfig-a015-20211228
x86_64               randconfig-a014-20211228
x86_64               randconfig-a013-20211228
x86_64               randconfig-a012-20211228
x86_64               randconfig-a011-20211228
x86_64               randconfig-a016-20211228
i386                 randconfig-a012-20211228
i386                 randconfig-a011-20211228
i386                 randconfig-a014-20211228
i386                 randconfig-a016-20211228
i386                 randconfig-a013-20211228
i386                 randconfig-a015-20211228
hexagon              randconfig-r041-20211228
riscv                randconfig-r042-20211228
hexagon              randconfig-r045-20211228

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
