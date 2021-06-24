Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5353A3B248A
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Jun 2021 03:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhFXBiS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 23 Jun 2021 21:38:18 -0400
Received: from mga07.intel.com ([134.134.136.100]:5803 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229758AbhFXBiR (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 23 Jun 2021 21:38:17 -0400
IronPort-SDR: rX10Aifo1cwxdmrD2qkdqfCNHFknhCrguCmepcl/JkWHCoumlm2BDB5lB0Tam+FFNW7uSHe7hr
 xx69ChOVBNnw==
X-IronPort-AV: E=McAfee;i="6200,9189,10024"; a="271217957"
X-IronPort-AV: E=Sophos;i="5.83,295,1616482800"; 
   d="scan'208";a="271217957"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2021 18:35:59 -0700
IronPort-SDR: nbXA/GrNH7xV0iESQVs7t6RD0xR3gx42hHY516t2oGbXNLVP/MWLx6g6VJooSfELZ1hq0Nhc2n
 aezIfdd44ZKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,295,1616482800"; 
   d="scan'208";a="557159562"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 23 Jun 2021 18:35:57 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lwEHd-0006I6-6M; Thu, 24 Jun 2021 01:35:57 +0000
Date:   Thu, 24 Jun 2021 09:35:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [ext4:dev] BUILD SUCCESS f9505c72b2ee80cb68af95449a5215906130e3be
Message-ID: <60d3e15b.oPOiSFibhJqS6Jfg%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: f9505c72b2ee80cb68af95449a5215906130e3be  ext4: use local variable ei instead of EXT4_I() macro

elapsed time: 720m

configs tested: 184
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                                 defconfig
arm                           h3600_defconfig
powerpc                    klondike_defconfig
arm                       imx_v6_v7_defconfig
powerpc                      arches_defconfig
arm                             rpc_defconfig
openrisc                            defconfig
arm                        mvebu_v5_defconfig
xtensa                          iss_defconfig
mips                        vocore2_defconfig
arm                         axm55xx_defconfig
powerpc                       holly_defconfig
powerpc                      makalu_defconfig
arc                        nsimosci_defconfig
nios2                         10m50_defconfig
riscv                            allyesconfig
powerpc                    sam440ep_defconfig
sh                           se7705_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                          malta_defconfig
xtensa                           alldefconfig
sh                          rsk7203_defconfig
sh                        edosk7760_defconfig
m68k                          atari_defconfig
arm                         lpc32xx_defconfig
arm                          lpd270_defconfig
um                             i386_defconfig
powerpc                  mpc866_ads_defconfig
mips                     cu1830-neo_defconfig
powerpc                      acadia_defconfig
arc                     nsimosci_hs_defconfig
arm                             pxa_defconfig
arm                           corgi_defconfig
arm                      pxa255-idp_defconfig
arm                             ezx_defconfig
mips                          ath25_defconfig
mips                       capcella_defconfig
arm                        mini2440_defconfig
arm                            hisi_defconfig
arm                        neponset_defconfig
mips                        bcm63xx_defconfig
arm                       aspeed_g4_defconfig
nds32                             allnoconfig
powerpc                     tqm8540_defconfig
ia64                      gensparse_defconfig
arm                       spear13xx_defconfig
sparc                            alldefconfig
arm                           omap1_defconfig
powerpc                     tqm8555_defconfig
mips                       rbtx49xx_defconfig
mips                   sb1250_swarm_defconfig
mips                         tb0287_defconfig
xtensa                         virt_defconfig
arc                        nsim_700_defconfig
mips                          rb532_defconfig
powerpc                      ppc44x_defconfig
sh                   sh7770_generic_defconfig
arm                        mvebu_v7_defconfig
arm                            zeus_defconfig
mips                           mtx1_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                     pseries_defconfig
mips                        jmr3927_defconfig
arm                      footbridge_defconfig
powerpc                      ppc40x_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                     davinci_all_defconfig
powerpc                      ppc64e_defconfig
m68k                           sun3_defconfig
powerpc                     ppa8548_defconfig
riscv                    nommu_k210_defconfig
h8300                     edosk2674_defconfig
sh                           se7724_defconfig
sh                           se7343_defconfig
sh                             sh03_defconfig
m68k                          sun3x_defconfig
mips                             allmodconfig
powerpc                 canyonlands_defconfig
um                            kunit_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                  storcenter_defconfig
powerpc                         wii_defconfig
openrisc                    or1ksim_defconfig
m68k                        mvme16x_defconfig
arm                        realview_defconfig
s390                             allmodconfig
riscv                               defconfig
arm                         lubbock_defconfig
mips                           ip22_defconfig
arm                        trizeps4_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                       maple_defconfig
arm                       aspeed_g5_defconfig
arm                          ep93xx_defconfig
arm                       cns3420vb_defconfig
powerpc                     sequoia_defconfig
m68k                        mvme147_defconfig
mips                      maltasmvp_defconfig
arc                              allyesconfig
m68k                       m5249evb_defconfig
mips                        omega2p_defconfig
arm                        magician_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210623
x86_64               randconfig-a001-20210623
x86_64               randconfig-a005-20210623
x86_64               randconfig-a003-20210623
x86_64               randconfig-a004-20210623
x86_64               randconfig-a006-20210623
i386                 randconfig-a001-20210622
i386                 randconfig-a002-20210622
i386                 randconfig-a003-20210622
i386                 randconfig-a006-20210622
i386                 randconfig-a005-20210622
i386                 randconfig-a004-20210622
x86_64               randconfig-a012-20210622
x86_64               randconfig-a016-20210622
x86_64               randconfig-a015-20210622
x86_64               randconfig-a014-20210622
x86_64               randconfig-a013-20210622
x86_64               randconfig-a011-20210622
i386                 randconfig-a011-20210623
i386                 randconfig-a014-20210623
i386                 randconfig-a013-20210623
i386                 randconfig-a015-20210623
i386                 randconfig-a012-20210623
i386                 randconfig-a016-20210623
i386                 randconfig-a011-20210622
i386                 randconfig-a014-20210622
i386                 randconfig-a013-20210622
i386                 randconfig-a015-20210622
i386                 randconfig-a012-20210622
i386                 randconfig-a016-20210622
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210622
x86_64               randconfig-b001-20210623
x86_64               randconfig-a002-20210622
x86_64               randconfig-a001-20210622
x86_64               randconfig-a005-20210622
x86_64               randconfig-a003-20210622
x86_64               randconfig-a004-20210622
x86_64               randconfig-a006-20210622

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
