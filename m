Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 985B0198BEC
	for <lists+linux-ext4@lfdr.de>; Tue, 31 Mar 2020 07:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgCaFsf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 31 Mar 2020 01:48:35 -0400
Received: from mga04.intel.com ([192.55.52.120]:8114 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbgCaFsf (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 31 Mar 2020 01:48:35 -0400
IronPort-SDR: cC/9oiQrXnlzsAdiCtIOxWNuwMEVr3T4LALmVfDCPRNMAGBM5GKGitaSItNM9KFu0l09oo7VxB
 n1zJ0q+8VChA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2020 22:48:34 -0700
IronPort-SDR: 3ztvLvEJwxLfdOAzKsfpCM3o/vw/NKRAoPgWItPle5ktY0LZD4O+sAvbYmXeUS+8ZmR/ypQYuZ
 DjygEX6f5fFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,327,1580803200"; 
   d="scan'208";a="242260484"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 30 Mar 2020 22:48:33 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jJ9lI-0004RD-ES; Tue, 31 Mar 2020 13:48:32 +0800
Date:   Tue, 31 Mar 2020 13:48:02 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [ext4:dev] BUILD SUCCESS 2ea2fc775321f17d9324653e5548cc499247906e
Message-ID: <5e82d992.ehlF1e2MUSvtIcMf%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git  dev
branch HEAD: 2ea2fc775321f17d9324653e5548cc499247906e  ext4: save all error info in save_error_info() and drop ext4_set_errno()

elapsed time: 483m

configs tested: 180
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
ia64                                defconfig
powerpc                             defconfig
parisc                generic-32bit_defconfig
riscv                               defconfig
sparc64                           allnoconfig
sparc                            allyesconfig
i386                              allnoconfig
i386                             allyesconfig
i386                             alldefconfig
i386                                defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
nds32                               defconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
h8300                       h8s-sim_defconfig
h8300                     edosk2674_defconfig
m68k                       m5475evb_defconfig
m68k                             allmodconfig
h8300                    h8300h-sim_defconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                generic-64bit_defconfig
x86_64               randconfig-a001-20200331
x86_64               randconfig-a002-20200331
x86_64               randconfig-a003-20200331
i386                 randconfig-a001-20200331
i386                 randconfig-a002-20200331
i386                 randconfig-a003-20200331
alpha                randconfig-a001-20200331
m68k                 randconfig-a001-20200331
mips                 randconfig-a001-20200331
nds32                randconfig-a001-20200331
parisc               randconfig-a001-20200331
riscv                randconfig-a001-20200331
microblaze           randconfig-a001-20200330
h8300                randconfig-a001-20200330
nios2                randconfig-a001-20200330
c6x                  randconfig-a001-20200330
sparc64              randconfig-a001-20200330
c6x                  randconfig-a001-20200331
h8300                randconfig-a001-20200331
microblaze           randconfig-a001-20200331
nios2                randconfig-a001-20200331
sparc64              randconfig-a001-20200331
csky                 randconfig-a001-20200330
s390                 randconfig-a001-20200330
xtensa               randconfig-a001-20200330
openrisc             randconfig-a001-20200330
sh                   randconfig-a001-20200330
csky                 randconfig-a001-20200331
openrisc             randconfig-a001-20200331
s390                 randconfig-a001-20200331
sh                   randconfig-a001-20200331
xtensa               randconfig-a001-20200331
x86_64               randconfig-b001-20200330
x86_64               randconfig-b002-20200330
x86_64               randconfig-b003-20200330
i386                 randconfig-b001-20200330
i386                 randconfig-b002-20200330
i386                 randconfig-b003-20200330
x86_64               randconfig-b001-20200331
x86_64               randconfig-b002-20200331
x86_64               randconfig-b003-20200331
i386                 randconfig-b001-20200331
i386                 randconfig-b002-20200331
i386                 randconfig-b003-20200331
x86_64               randconfig-c001-20200331
x86_64               randconfig-c002-20200331
x86_64               randconfig-c003-20200331
i386                 randconfig-c001-20200331
i386                 randconfig-c002-20200331
i386                 randconfig-c003-20200331
x86_64               randconfig-d001-20200331
x86_64               randconfig-d002-20200331
x86_64               randconfig-d003-20200331
i386                 randconfig-d001-20200331
i386                 randconfig-d002-20200331
i386                 randconfig-d003-20200331
x86_64               randconfig-f001-20200331
x86_64               randconfig-f002-20200331
x86_64               randconfig-f003-20200331
i386                 randconfig-f001-20200331
i386                 randconfig-f002-20200331
i386                 randconfig-f003-20200331
x86_64               randconfig-g001-20200331
x86_64               randconfig-g002-20200331
x86_64               randconfig-g003-20200331
i386                 randconfig-g001-20200331
i386                 randconfig-g002-20200331
i386                 randconfig-g003-20200331
x86_64               randconfig-h001-20200331
x86_64               randconfig-h002-20200331
x86_64               randconfig-h003-20200331
i386                 randconfig-h001-20200331
i386                 randconfig-h002-20200331
i386                 randconfig-h003-20200331
arc                  randconfig-a001-20200330
arm                  randconfig-a001-20200330
arm64                randconfig-a001-20200330
ia64                 randconfig-a001-20200330
powerpc              randconfig-a001-20200330
sparc                randconfig-a001-20200330
arc                  randconfig-a001-20200331
arm                  randconfig-a001-20200331
arm64                randconfig-a001-20200331
ia64                 randconfig-a001-20200331
powerpc              randconfig-a001-20200331
sparc                randconfig-a001-20200331
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
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
sparc64                          allyesconfig
sparc64                             defconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                                  defconfig
x86_64                                  kexec
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
