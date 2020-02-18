Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE3D416228F
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Feb 2020 09:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgBRIoQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 Feb 2020 03:44:16 -0500
Received: from mga17.intel.com ([192.55.52.151]:12279 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgBRIoP (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 18 Feb 2020 03:44:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 00:44:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,455,1574150400"; 
   d="scan'208";a="235469591"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 18 Feb 2020 00:44:13 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j3yUH-000IUg-1R; Tue, 18 Feb 2020 16:44:13 +0800
Date:   Tue, 18 Feb 2020 16:43:26 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [ext4:dev] BUILD SUCCESS c96dceeabf765d0b1b1f29c3bf50a5c01315b820
Message-ID: <5e4ba3ae.W9nEbARHN/GuM1UM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git  dev
branch HEAD: c96dceeabf765d0b1b1f29c3bf50a5c01315b820  jbd2: do not clear the BH_Mapped flag when forgetting a metadata buffer

elapsed time: 5104m

configs tested: 133
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm64                               defconfig
sparc                            allyesconfig
c6x                              allyesconfig
riscv                             allnoconfig
powerpc                       ppc64_defconfig
sh                                allnoconfig
i386                             allyesconfig
microblaze                      mmu_defconfig
m68k                             allmodconfig
parisc                generic-32bit_defconfig
riscv                    nommu_virt_defconfig
mips                             allmodconfig
openrisc                    or1ksim_defconfig
csky                                defconfig
s390                                defconfig
nds32                               defconfig
nios2                         10m50_defconfig
s390                       zfcpdump_defconfig
ia64                             alldefconfig
m68k                       m5475evb_defconfig
powerpc                           allnoconfig
riscv                               defconfig
arc                                 defconfig
c6x                        evmc6678_defconfig
m68k                           sun3_defconfig
sparc64                             defconfig
s390                             allmodconfig
s390                              allnoconfig
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
nios2                         3c120_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
alpha                               defconfig
nds32                             allnoconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                          multi_defconfig
arc                              allyesconfig
powerpc                             defconfig
powerpc                          rhel-kconfig
microblaze                    nommu_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                generic-64bit_defconfig
c6x                  randconfig-a001-20200214
h8300                randconfig-a001-20200214
microblaze           randconfig-a001-20200214
nios2                randconfig-a001-20200214
sparc64              randconfig-a001-20200214
csky                 randconfig-a001-20200214
openrisc             randconfig-a001-20200214
s390                 randconfig-a001-20200214
xtensa               randconfig-a001-20200214
x86_64               randconfig-b001-20200214
x86_64               randconfig-b002-20200214
x86_64               randconfig-b003-20200214
i386                 randconfig-b001-20200214
i386                 randconfig-b002-20200214
i386                 randconfig-b003-20200214
x86_64               randconfig-d001-20200214
x86_64               randconfig-d002-20200214
x86_64               randconfig-d003-20200214
i386                 randconfig-d001-20200214
i386                 randconfig-d002-20200214
i386                 randconfig-d003-20200214
x86_64               randconfig-f001-20200214
x86_64               randconfig-f002-20200214
x86_64               randconfig-f003-20200214
i386                 randconfig-f001-20200214
i386                 randconfig-f002-20200214
i386                 randconfig-f003-20200214
i386                 randconfig-g001-20200215
i386                 randconfig-g002-20200215
x86_64               randconfig-g003-20200215
x86_64               randconfig-g001-20200215
i386                 randconfig-g003-20200215
x86_64               randconfig-g002-20200215
x86_64               randconfig-h001-20200214
x86_64               randconfig-h002-20200214
x86_64               randconfig-h003-20200214
i386                 randconfig-h001-20200214
i386                 randconfig-h002-20200214
i386                 randconfig-h003-20200214
riscv                            allmodconfig
riscv                            allyesconfig
riscv                          rv32_defconfig
s390                             alldefconfig
s390                             allyesconfig
s390                          debug_defconfig
sh                               allmodconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
um                                  defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
