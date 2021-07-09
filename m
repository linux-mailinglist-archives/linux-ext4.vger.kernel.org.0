Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4062E3C1CEA
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Jul 2021 03:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhGIBDn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Jul 2021 21:03:43 -0400
Received: from mga05.intel.com ([192.55.52.43]:45787 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229843AbhGIBDn (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 8 Jul 2021 21:03:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10039"; a="295262884"
X-IronPort-AV: E=Sophos;i="5.84,225,1620716400"; 
   d="scan'208";a="295262884"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 18:01:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,225,1620716400"; 
   d="scan'208";a="424177909"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 08 Jul 2021 18:00:59 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m1et0-000EaN-N0; Fri, 09 Jul 2021 01:00:58 +0000
Date:   Fri, 09 Jul 2021 09:00:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [ext4:dev] BUILD SUCCESS 0705e8d1e2207ceeb83dc6e1751b6b82718b353a
Message-ID: <60e79f91.pZDTsFcCGd/3Bp7k%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: 0705e8d1e2207ceeb83dc6e1751b6b82718b353a  ext4: inline jbd2_journal_[un]register_shrinker()

elapsed time: 721m

configs tested: 173
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                      malta_kvm_defconfig
m68k                       bvme6000_defconfig
arm                         palmz72_defconfig
mips                          rb532_defconfig
sh                           se7721_defconfig
sh                 kfr2r09-romimage_defconfig
x86_64                              defconfig
ia64                            zx1_defconfig
m68k                          multi_defconfig
arm                            mps2_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                      chrp32_defconfig
powerpc                   bluestone_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                     ep8248e_defconfig
arm                        oxnas_v6_defconfig
mips                         tb0219_defconfig
powerpc                    amigaone_defconfig
x86_64                           alldefconfig
m68k                       m5275evb_defconfig
arm                             ezx_defconfig
nds32                             allnoconfig
arm                         axm55xx_defconfig
arm                        clps711x_defconfig
sparc                       sparc64_defconfig
mips                        vocore2_defconfig
powerpc                         ps3_defconfig
powerpc                    sam440ep_defconfig
arm                           corgi_defconfig
arm                  colibri_pxa270_defconfig
mips                         cobalt_defconfig
mips                     loongson2k_defconfig
sh                           se7724_defconfig
arc                        nsim_700_defconfig
arm                         vf610m4_defconfig
arm                          imote2_defconfig
s390                             allmodconfig
arm                       aspeed_g4_defconfig
arm                            pleb_defconfig
xtensa                       common_defconfig
sh                           se7619_defconfig
mips                          rm200_defconfig
powerpc                      arches_defconfig
mips                        jmr3927_defconfig
arm                      footbridge_defconfig
powerpc                 canyonlands_defconfig
sh                               alldefconfig
mips                    maltaup_xpa_defconfig
mips                  cavium_octeon_defconfig
arm                     eseries_pxa_defconfig
powerpc                      pasemi_defconfig
arm                             mxs_defconfig
sh                           se7712_defconfig
sh                        edosk7705_defconfig
sparc64                          alldefconfig
sh                        sh7757lcr_defconfig
powerpc                          allyesconfig
sh                   secureedge5410_defconfig
powerpc                     tqm8560_defconfig
arm                       aspeed_g5_defconfig
sh                               allmodconfig
mips                       rbtx49xx_defconfig
powerpc                     tqm8548_defconfig
arm                         cm_x300_defconfig
m68k                         apollo_defconfig
m68k                         amcore_defconfig
sh                        dreamcast_defconfig
sh                            migor_defconfig
arm                           h3600_defconfig
arm                           u8500_defconfig
arm                        mvebu_v7_defconfig
sh                            hp6xx_defconfig
powerpc                     akebono_defconfig
arm                       cns3420vb_defconfig
m68k                           sun3_defconfig
arm                           sunxi_defconfig
arm                         shannon_defconfig
powerpc                    gamecube_defconfig
mips                       bmips_be_defconfig
arm                        multi_v7_defconfig
m68k                             alldefconfig
arm                         at91_dt_defconfig
arm                            lart_defconfig
sh                   sh7770_generic_defconfig
powerpc                  mpc885_ads_defconfig
arm                     davinci_all_defconfig
riscv                    nommu_k210_defconfig
mips                     loongson1c_defconfig
mips                            gpr_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210707
x86_64               randconfig-a002-20210707
x86_64               randconfig-a005-20210707
x86_64               randconfig-a006-20210707
x86_64               randconfig-a003-20210707
x86_64               randconfig-a001-20210707
i386                 randconfig-a004-20210707
i386                 randconfig-a006-20210707
i386                 randconfig-a001-20210707
i386                 randconfig-a003-20210707
i386                 randconfig-a005-20210707
i386                 randconfig-a002-20210707
i386                 randconfig-a006-20210708
i386                 randconfig-a004-20210708
i386                 randconfig-a001-20210708
i386                 randconfig-a003-20210708
i386                 randconfig-a005-20210708
i386                 randconfig-a002-20210708
i386                 randconfig-a015-20210707
i386                 randconfig-a016-20210707
i386                 randconfig-a012-20210707
i386                 randconfig-a011-20210707
i386                 randconfig-a014-20210707
i386                 randconfig-a013-20210707
i386                 randconfig-a015-20210708
i386                 randconfig-a016-20210708
i386                 randconfig-a011-20210708
i386                 randconfig-a012-20210708
i386                 randconfig-a013-20210708
i386                 randconfig-a014-20210708
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210707
x86_64               randconfig-a015-20210707
x86_64               randconfig-a014-20210707
x86_64               randconfig-a012-20210707
x86_64               randconfig-a011-20210707
x86_64               randconfig-a016-20210707
x86_64               randconfig-a013-20210707

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
