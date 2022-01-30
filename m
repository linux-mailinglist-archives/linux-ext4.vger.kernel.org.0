Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682144A36C1
	for <lists+linux-ext4@lfdr.de>; Sun, 30 Jan 2022 15:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236744AbiA3Ohl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 30 Jan 2022 09:37:41 -0500
Received: from mga03.intel.com ([134.134.136.65]:33655 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237542AbiA3Ohl (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 30 Jan 2022 09:37:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643553461; x=1675089461;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=1RhTymFhgmHwFr3rDMujoLw8pUYDPUYk91A3/dgQrZU=;
  b=O2FqBHgJgNLyifupq3QscU7Il2mtsFAHb7pQmTa8pqja8nHbHXnrVpIb
   0UpcZOmnqlHl5DxqIVI8JstEhZXKstxi514DMbzlZLiT3d8A9zajmuv1l
   x8n5811n/gWZCWKEijLT6DcryX0iz91t65DK5+8F7jcp4Y9g/F2mt618y
   Lsv/08Nqk6JjGqdVINinkKKK2PI8ZxCh83lN0NxUbfl7yF6W+hJiLyo99
   y4DGoKJQ4gaj7AHkwIdHJkRyFMhEv0Ixm1IkvDMcpm+0nfBkSyh0CLopB
   MQRnVNdya+MnNuMzxGw3bJxpzy7F3OkhxJGuzm5AGauAyMFiKkorgly1O
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10242"; a="247302145"
X-IronPort-AV: E=Sophos;i="5.88,328,1635231600"; 
   d="scan'208";a="247302145"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 06:37:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,328,1635231600"; 
   d="scan'208";a="582361303"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 30 Jan 2022 06:37:39 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEBKk-000Qc5-Ku; Sun, 30 Jan 2022 14:37:38 +0000
Date:   Sun, 30 Jan 2022 22:36:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 b36c9466ce982906a6420e6af0fca73d1c0931b5
Message-ID: <61f6a28a.BZMawGH9rHdTTlVb%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: b36c9466ce982906a6420e6af0fca73d1c0931b5  fs/ext4: fix comments mentioning i_mutex

elapsed time: 724m

configs tested: 112
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
powerpc                 mpc8540_ads_defconfig
m68k                          amiga_defconfig
arm                           u8500_defconfig
sparc64                             defconfig
powerpc                        cell_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                           sama5_defconfig
parisc                generic-32bit_defconfig
xtensa                           allyesconfig
powerpc                 mpc834x_itx_defconfig
arm                             rpc_defconfig
arc                        nsim_700_defconfig
sh                        dreamcast_defconfig
arm                      integrator_defconfig
nds32                               defconfig
nds32                             allnoconfig
arc                    vdk_hs38_smp_defconfig
m68k                         amcore_defconfig
powerpc                     tqm8541_defconfig
arm                        spear6xx_defconfig
xtensa                           alldefconfig
m68k                                defconfig
powerpc                    adder875_defconfig
powerpc                       eiger_defconfig
mips                 decstation_r4k_defconfig
powerpc                      pcm030_defconfig
sh                               allmodconfig
sh                          polaris_defconfig
sh                         microdev_defconfig
arm                        cerfcube_defconfig
h8300                    h8300h-sim_defconfig
sh                           se7206_defconfig
powerpc                      ppc6xx_defconfig
powerpc                 mpc834x_mds_defconfig
sh                          rsk7264_defconfig
sh                             espt_defconfig
sh                           se7712_defconfig
i386                                defconfig
m68k                             allmodconfig
arm                  randconfig-c002-20220130
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220130
arc                  randconfig-r043-20220130
s390                 randconfig-r044-20220130
riscv                    nommu_k210_defconfig
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
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20220130
x86_64                        randconfig-c007
arm                  randconfig-c002-20220130
powerpc              randconfig-c003-20220130
mips                 randconfig-c004-20220130
s390                 randconfig-c005-20220130
i386                          randconfig-c001
arm                          moxart_defconfig
mips                   sb1250_swarm_defconfig
hexagon                             defconfig
powerpc                 mpc8315_rdb_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
