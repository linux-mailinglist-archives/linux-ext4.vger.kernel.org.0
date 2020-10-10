Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA71E289EE9
	for <lists+linux-ext4@lfdr.de>; Sat, 10 Oct 2020 09:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbgJJHUq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 10 Oct 2020 03:20:46 -0400
Received: from mga02.intel.com ([134.134.136.20]:40616 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729060AbgJJHQj (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 10 Oct 2020 03:16:39 -0400
IronPort-SDR: cLCDWYALFbOcXuIht2mOMMs6y4mSwJiXogQC6/BQyp0gxfJRQ3EuSu/63FCIkd+cOFP85MNXeh
 jjgZ1LO4EPxQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9769"; a="152488647"
X-IronPort-AV: E=Sophos;i="5.77,358,1596524400"; 
   d="scan'208";a="152488647"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2020 00:16:38 -0700
IronPort-SDR: 70GSd/MMYCeXJlbR6l0ZRLQnrZIHpU7BwxfLWeb1Dfp6t93dKJP0hrmwIEKP2Qu/7rSTe7O9+C
 NntsGoApYpVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,358,1596524400"; 
   d="scan'208";a="345276006"
Received: from lkp-server02.sh.intel.com (HELO d5d245f0dec0) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 10 Oct 2020 00:16:37 -0700
Received: from kbuild by d5d245f0dec0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kR97M-00002a-UL; Sat, 10 Oct 2020 07:16:36 +0000
Date:   Sat, 10 Oct 2020 15:15:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [ext4:dev] BUILD SUCCESS 9cb3701fb5997a03841073faa52e9d4bd0893076
Message-ID: <5f815f9e.DXZLDcJOXgV7Sxb+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git  dev
branch HEAD: 9cb3701fb5997a03841073faa52e9d4bd0893076  ext4: Fix bs < ps issue reported with dioread_nolock mount opt

elapsed time: 724m

configs tested: 133
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                     pq2fads_defconfig
arm                        spear6xx_defconfig
arm                          ep93xx_defconfig
ia64                             alldefconfig
arm                         hackkit_defconfig
sh                             sh03_defconfig
mips                            gpr_defconfig
powerpc                 mpc834x_mds_defconfig
arm                         nhk8815_defconfig
parisc                           allyesconfig
powerpc                      tqm8xx_defconfig
mips                      fuloong2e_defconfig
sh                          sdk7780_defconfig
m68k                          atari_defconfig
mips                     loongson1c_defconfig
powerpc                     mpc83xx_defconfig
arm                             pxa_defconfig
powerpc                      cm5200_defconfig
powerpc                      bamboo_defconfig
powerpc                         wii_defconfig
sh                            shmin_defconfig
powerpc                     kmeter1_defconfig
powerpc                 mpc836x_rdk_defconfig
m68k                        m5307c3_defconfig
arc                      axs103_smp_defconfig
arm                           sama5_defconfig
powerpc                    gamecube_defconfig
powerpc                     stx_gp3_defconfig
mips                           ci20_defconfig
arm                       mainstone_defconfig
powerpc                     tqm5200_defconfig
um                             i386_defconfig
sparc64                             defconfig
openrisc                 simple_smp_defconfig
sh                        edosk7705_defconfig
sh                 kfr2r09-romimage_defconfig
mips                      pic32mzda_defconfig
arc                            hsdk_defconfig
arm                          lpd270_defconfig
arm                     davinci_all_defconfig
m68k                        m5272c3_defconfig
arm                            u300_defconfig
arm                           viper_defconfig
mips                       lemote2f_defconfig
powerpc                    sam440ep_defconfig
powerpc                      ppc64e_defconfig
mips                       capcella_defconfig
sh                           se7705_defconfig
m68k                         amcore_defconfig
arm                             ezx_defconfig
riscv                    nommu_k210_defconfig
arm                         lpc18xx_defconfig
powerpc                      pasemi_defconfig
riscv                            alldefconfig
powerpc                     tqm8548_defconfig
mips                      loongson3_defconfig
arm                          imote2_defconfig
powerpc                  mpc866_ads_defconfig
i386                             alldefconfig
xtensa                  audio_kc705_defconfig
arm                       spear13xx_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20201009
i386                 randconfig-a005-20201009
i386                 randconfig-a001-20201009
i386                 randconfig-a004-20201009
i386                 randconfig-a002-20201009
i386                 randconfig-a003-20201009
x86_64               randconfig-a012-20201009
x86_64               randconfig-a015-20201009
x86_64               randconfig-a013-20201009
x86_64               randconfig-a014-20201009
x86_64               randconfig-a011-20201009
x86_64               randconfig-a016-20201009
i386                 randconfig-a015-20201009
i386                 randconfig-a013-20201009
i386                 randconfig-a014-20201009
i386                 randconfig-a016-20201009
i386                 randconfig-a011-20201009
i386                 randconfig-a012-20201009
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201009
x86_64               randconfig-a003-20201009
x86_64               randconfig-a005-20201009
x86_64               randconfig-a001-20201009
x86_64               randconfig-a002-20201009
x86_64               randconfig-a006-20201009

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
