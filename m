Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7D5319C453
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Apr 2020 16:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733032AbgDBOe7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Apr 2020 10:34:59 -0400
Received: from mga18.intel.com ([134.134.136.126]:46230 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732263AbgDBOe7 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 2 Apr 2020 10:34:59 -0400
IronPort-SDR: 1F/rqr31Y6pJ8QDwzGy/7JG+hldr9Ig6NodniSyqH2s01HYJT+1r9Rmrt8n2A4Qij17q9vXDvB
 ZXU+RT9W8YrA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 07:34:58 -0700
IronPort-SDR: aAUd4514uaj3YrN/jE4jNk2jJmH1d27UhFuYLmrSaF7op2xV7e1PQYMxgWlQR1xtxA0nTt6SDT
 RueBR7OX3OuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,335,1580803200"; 
   d="scan'208";a="295669016"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Apr 2020 07:34:56 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jK0vn-000Gn6-Ua; Thu, 02 Apr 2020 22:34:55 +0800
Date:   Thu, 02 Apr 2020 22:34:16 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [ext4:dev] BUILD SUCCESS 54d3adbc29f0c7c53890da1683e629cd220d7201
Message-ID: <5e85f7e8.sbMdMyLl3xygNmue%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git  dev
branch HEAD: 54d3adbc29f0c7c53890da1683e629cd220d7201  ext4: save all error info in save_error_info() and drop ext4_set_errno()

elapsed time: 968m

configs tested: 191
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
riscv                    nommu_virt_defconfig
s390                              allnoconfig
sh                                allnoconfig
ia64                                defconfig
powerpc                             defconfig
sparc64                             defconfig
riscv                             allnoconfig
i386                              allnoconfig
i386                             alldefconfig
i386                             allyesconfig
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
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
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
parisc                generic-64bit_defconfig
parisc                generic-32bit_defconfig
parisc                           allyesconfig
x86_64               randconfig-a001-20200402
x86_64               randconfig-a002-20200402
x86_64               randconfig-a003-20200402
i386                 randconfig-a001-20200402
i386                 randconfig-a002-20200402
i386                 randconfig-a003-20200402
mips                 randconfig-a001-20200402
nds32                randconfig-a001-20200402
m68k                 randconfig-a001-20200402
alpha                randconfig-a001-20200402
parisc               randconfig-a001-20200402
riscv                randconfig-a001-20200402
c6x                  randconfig-a001-20200402
h8300                randconfig-a001-20200402
microblaze           randconfig-a001-20200402
nios2                randconfig-a001-20200402
sparc64              randconfig-a001-20200402
c6x                  randconfig-a001-20200401
h8300                randconfig-a001-20200401
microblaze           randconfig-a001-20200401
nios2                randconfig-a001-20200401
sparc64              randconfig-a001-20200401
csky                 randconfig-a001-20200402
openrisc             randconfig-a001-20200402
s390                 randconfig-a001-20200402
sh                   randconfig-a001-20200402
xtensa               randconfig-a001-20200402
x86_64               randconfig-b001-20200402
x86_64               randconfig-b002-20200402
x86_64               randconfig-b003-20200402
i386                 randconfig-b001-20200402
i386                 randconfig-b002-20200402
i386                 randconfig-b003-20200402
x86_64               randconfig-c001-20200402
x86_64               randconfig-c002-20200402
x86_64               randconfig-c003-20200402
i386                 randconfig-c001-20200402
i386                 randconfig-c002-20200402
i386                 randconfig-c003-20200402
x86_64               randconfig-c001-20200401
x86_64               randconfig-c002-20200401
x86_64               randconfig-c003-20200401
i386                 randconfig-c001-20200401
i386                 randconfig-c002-20200401
i386                 randconfig-c003-20200401
x86_64               randconfig-d001-20200402
x86_64               randconfig-d002-20200402
x86_64               randconfig-d003-20200402
i386                 randconfig-d001-20200402
i386                 randconfig-d002-20200402
i386                 randconfig-d003-20200402
x86_64               randconfig-d001-20200401
x86_64               randconfig-d002-20200401
x86_64               randconfig-d003-20200401
i386                 randconfig-d001-20200401
i386                 randconfig-d002-20200401
i386                 randconfig-d003-20200401
x86_64               randconfig-e001-20200402
x86_64               randconfig-e002-20200402
x86_64               randconfig-e003-20200402
i386                 randconfig-e001-20200402
i386                 randconfig-e002-20200402
i386                 randconfig-e003-20200402
x86_64               randconfig-e001-20200401
x86_64               randconfig-e002-20200401
x86_64               randconfig-e003-20200401
i386                 randconfig-e001-20200401
i386                 randconfig-e002-20200401
i386                 randconfig-e003-20200401
x86_64               randconfig-f001-20200402
x86_64               randconfig-f002-20200402
x86_64               randconfig-f003-20200402
i386                 randconfig-f001-20200402
i386                 randconfig-f002-20200402
i386                 randconfig-f003-20200402
x86_64               randconfig-g001-20200402
x86_64               randconfig-g002-20200402
x86_64               randconfig-g003-20200402
i386                 randconfig-g001-20200402
i386                 randconfig-g002-20200402
i386                 randconfig-g003-20200402
x86_64               randconfig-h001-20200402
x86_64               randconfig-h002-20200402
x86_64               randconfig-h003-20200402
i386                 randconfig-h001-20200402
i386                 randconfig-h002-20200402
i386                 randconfig-h003-20200402
arc                  randconfig-a001-20200402
arm                  randconfig-a001-20200402
arm64                randconfig-a001-20200402
ia64                 randconfig-a001-20200402
powerpc              randconfig-a001-20200402
sparc                randconfig-a001-20200402
arm64                randconfig-a001-20200401
sparc                randconfig-a001-20200401
ia64                 randconfig-a001-20200401
arc                  randconfig-a001-20200401
riscv                            allmodconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                          rv32_defconfig
s390                             alldefconfig
s390                             allmodconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
sh                               allmodconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                                  defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
