Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A343BE2A2
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Jul 2021 07:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhGGFjS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Jul 2021 01:39:18 -0400
Received: from mga03.intel.com ([134.134.136.65]:61830 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230312AbhGGFjR (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 7 Jul 2021 01:39:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="209283485"
X-IronPort-AV: E=Sophos;i="5.83,331,1616482800"; 
   d="scan'208";a="209283485"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 22:36:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,331,1616482800"; 
   d="scan'208";a="410444993"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 06 Jul 2021 22:36:35 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m10Ed-000DPm-1B; Wed, 07 Jul 2021 05:36:35 +0000
Date:   Wed, 07 Jul 2021 13:35:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [ext4:dev] BUILD SUCCESS 1a40ce3dd8532141fc19f3693e405c7a009caf82
Message-ID: <60e53d2d.MxdzeS2IpMF48Bw8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: 1a40ce3dd8532141fc19f3693e405c7a009caf82  ext4: inline jbd2_journal_[un]register_shrinker()

elapsed time: 723m

configs tested: 155
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                       maple_defconfig
mips                        omega2p_defconfig
arm                            hisi_defconfig
xtensa                           alldefconfig
sh                           se7721_defconfig
sh                          rsk7203_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                   microwatt_defconfig
arm                           h5000_defconfig
riscv                               defconfig
h8300                            alldefconfig
s390                       zfcpdump_defconfig
powerpc                     tqm5200_defconfig
mips                          ath25_defconfig
sh                           se7619_defconfig
arm                          pxa168_defconfig
arm                         lpc32xx_defconfig
m68k                        mvme147_defconfig
openrisc                    or1ksim_defconfig
powerpc                    ge_imp3a_defconfig
sh                           se7206_defconfig
xtensa                       common_defconfig
arm                      jornada720_defconfig
sh                          kfr2r09_defconfig
sh                   secureedge5410_defconfig
sh                        apsh4ad0a_defconfig
arm                            mps2_defconfig
powerpc                   lite5200b_defconfig
m68k                          sun3x_defconfig
arm                        multi_v5_defconfig
powerpc                     stx_gp3_defconfig
powerpc                    sam440ep_defconfig
powerpc                    klondike_defconfig
sh                          sdk7786_defconfig
arm                          pcm027_defconfig
arm                         s5pv210_defconfig
sh                          polaris_defconfig
mips                      fuloong2e_defconfig
mips                          malta_defconfig
arm                      integrator_defconfig
s390                          debug_defconfig
sh                         ap325rxa_defconfig
nds32                             allnoconfig
arm                          iop32x_defconfig
arc                     nsimosci_hs_defconfig
xtensa                  nommu_kc705_defconfig
sh                           se7722_defconfig
arm                         s3c6400_defconfig
arm                           h3600_defconfig
sh                     magicpanelr2_defconfig
sh                             sh03_defconfig
xtensa                    smp_lx200_defconfig
i386                                defconfig
arm                        vexpress_defconfig
mips                            e55_defconfig
sh                            hp6xx_defconfig
arc                          axs101_defconfig
sh                          landisk_defconfig
sh                           se7724_defconfig
powerpc                     pseries_defconfig
powerpc                 canyonlands_defconfig
powerpc                   motionpro_defconfig
sh                           se7750_defconfig
ia64                      gensparse_defconfig
microblaze                      mmu_defconfig
m68k                        stmark2_defconfig
m68k                        m5407c3_defconfig
arm                      pxa255-idp_defconfig
mips                        nlm_xlp_defconfig
arm                          moxart_defconfig
m68k                          amiga_defconfig
sh                ecovec24-romimage_defconfig
arm                           omap1_defconfig
mips                         mpc30x_defconfig
sh                          rsk7264_defconfig
powerpc                 mpc832x_rdb_defconfig
ia64                          tiger_defconfig
arm                            dove_defconfig
parisc                              defconfig
mips                          rb532_defconfig
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
sh                               allmodconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20210706
i386                 randconfig-a006-20210706
i386                 randconfig-a001-20210706
i386                 randconfig-a003-20210706
i386                 randconfig-a005-20210706
i386                 randconfig-a002-20210706
x86_64               randconfig-a015-20210706
x86_64               randconfig-a014-20210706
x86_64               randconfig-a016-20210706
x86_64               randconfig-a012-20210706
x86_64               randconfig-a011-20210706
x86_64               randconfig-a013-20210706
i386                 randconfig-a015-20210706
i386                 randconfig-a016-20210706
i386                 randconfig-a012-20210706
i386                 randconfig-a011-20210706
i386                 randconfig-a014-20210706
i386                 randconfig-a013-20210706
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210706
x86_64               randconfig-a004-20210706
x86_64               randconfig-a002-20210706
x86_64               randconfig-a005-20210706
x86_64               randconfig-a006-20210706
x86_64               randconfig-a003-20210706
x86_64               randconfig-a001-20210706

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
