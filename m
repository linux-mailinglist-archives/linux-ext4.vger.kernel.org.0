Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C125B194D4A
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Mar 2020 00:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgCZXbn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 26 Mar 2020 19:31:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:59657 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726954AbgCZXbn (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 26 Mar 2020 19:31:43 -0400
IronPort-SDR: HfOQKsk6yFnOBYYIJ0+4KaqguFSyymx+shf9MmwCYnGXSrDsS5PkUvwSOqdSth8dBh2cpDIpu1
 lbEAiHpmMu+A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2020 16:31:42 -0700
IronPort-SDR: nMj3jhSfOQhyph+OorwI6HGTy9HuMVuensWmSnctQZNePGw+k7zzGheU2ofjvW1BqYco3nVo7C
 1GLVbSdzrF2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,310,1580803200"; 
   d="scan'208";a="241131269"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 26 Mar 2020 16:31:40 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jHbyO-000BXz-7G; Fri, 27 Mar 2020 07:31:40 +0800
Date:   Fri, 27 Mar 2020 07:31:32 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [ext4:dev] BUILD SUCCESS c8980e1980ccdc2229aa2218d532ddc62e0aabe5
Message-ID: <5e7d3b54.lDJwBahdOwE38zS3%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git  dev
branch HEAD: c8980e1980ccdc2229aa2218d532ddc62e0aabe5  ext4: disable dioread_nolock whenever delayed allocation is disabled

elapsed time: 484m

configs tested: 145
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm                           efm32_defconfig
arm                         at91_dt_defconfig
arm                        shmobile_defconfig
arm64                               defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm                        multi_v7_defconfig
sparc                            allyesconfig
mips                             allmodconfig
powerpc                       ppc64_defconfig
um                           x86_64_defconfig
xtensa                          iss_defconfig
i386                             alldefconfig
riscv                    nommu_virt_defconfig
nds32                               defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
parisc                            allnoconfig
parisc                generic-64bit_defconfig
parisc                generic-32bit_defconfig
parisc                           allyesconfig
x86_64               randconfig-a001-20200326
x86_64               randconfig-a002-20200326
x86_64               randconfig-a003-20200326
i386                 randconfig-a001-20200326
i386                 randconfig-a002-20200326
i386                 randconfig-a003-20200326
alpha                randconfig-a001-20200326
m68k                 randconfig-a001-20200326
mips                 randconfig-a001-20200326
nds32                randconfig-a001-20200326
parisc               randconfig-a001-20200326
riscv                randconfig-a001-20200326
c6x                  randconfig-a001-20200326
h8300                randconfig-a001-20200326
microblaze           randconfig-a001-20200326
nios2                randconfig-a001-20200326
sparc64              randconfig-a001-20200326
csky                 randconfig-a001-20200326
openrisc             randconfig-a001-20200326
s390                 randconfig-a001-20200326
xtensa               randconfig-a001-20200326
x86_64               randconfig-c001-20200326
x86_64               randconfig-c002-20200326
x86_64               randconfig-c003-20200326
i386                 randconfig-c001-20200326
i386                 randconfig-c002-20200326
i386                 randconfig-c003-20200326
x86_64               randconfig-e001-20200326
x86_64               randconfig-e002-20200326
x86_64               randconfig-e003-20200326
i386                 randconfig-e001-20200326
i386                 randconfig-e002-20200326
i386                 randconfig-e003-20200326
x86_64               randconfig-f001-20200326
x86_64               randconfig-f002-20200326
x86_64               randconfig-f003-20200326
i386                 randconfig-f001-20200326
i386                 randconfig-f002-20200326
i386                 randconfig-f003-20200326
x86_64               randconfig-g001-20200326
x86_64               randconfig-g002-20200326
x86_64               randconfig-g003-20200326
i386                 randconfig-g001-20200326
i386                 randconfig-g002-20200326
i386                 randconfig-g003-20200326
arc                  randconfig-a001-20200326
arm                  randconfig-a001-20200326
arm64                randconfig-a001-20200326
ia64                 randconfig-a001-20200326
powerpc              randconfig-a001-20200326
sparc                randconfig-a001-20200326
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                          rv32_defconfig
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
sh                          rsk7269_defconfig
sh                               allmodconfig
sh                            titan_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
um                             i386_defconfig
um                                  defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
