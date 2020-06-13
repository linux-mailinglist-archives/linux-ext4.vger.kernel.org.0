Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 485AC1F839D
	for <lists+linux-ext4@lfdr.de>; Sat, 13 Jun 2020 16:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgFMOHI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 13 Jun 2020 10:07:08 -0400
Received: from mga17.intel.com ([192.55.52.151]:49346 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726132AbgFMOHH (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 13 Jun 2020 10:07:07 -0400
IronPort-SDR: A31ChBUxgN4jFuQToBtbODBcarc2c+5r7K1icWKgvWcvJ5qX4WQQpjddKJpOn7HM5U3XQzBGGn
 8pKRo0gIyjaQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2020 07:07:07 -0700
IronPort-SDR: 2zlfKujPrHNCT2Qv+d4hvr9aaPEaw38N4A9pw0jkjIVyP0AQItkcrJ86JIMu77TAPX8vxhJLvo
 YpMri7hrWXyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,507,1583222400"; 
   d="scan'208";a="307874644"
Received: from lkp-server02.sh.intel.com (HELO de5642daf266) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 13 Jun 2020 07:07:06 -0700
Received: from kbuild by de5642daf266 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jk6oL-0000LD-DZ; Sat, 13 Jun 2020 14:07:05 +0000
Date:   Sat, 13 Jun 2020 22:06:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [ext4:dev] BUILD SUCCESS 7b97d868b7ab2448859668de9222b8af43f76e78
Message-ID: <5ee4dd75.2YWn6EmB0AH0iEjn%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git  dev
branch HEAD: 7b97d868b7ab2448859668de9222b8af43f76e78  ext4, jbd2: ensure panic by fix a race between jbd2 abort and ext4 error handlers

Warning in current branch:

fs/ext4/mballoc.c:2209:9: sparse: sparse: context imbalance in 'ext4_mb_good_group_nolock' - different lock contexts for basic block

Warning ids grouped by kconfigs:

recent_errors
`-- i386-randconfig-s001-20200612
    `-- fs-ext4-mballoc.c:sparse:sparse:context-imbalance-in-ext4_mb_good_group_nolock-different-lock-contexts-for-basic-block

elapsed time: 629m

configs tested: 149
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm                            zeus_defconfig
arm                         socfpga_defconfig
parisc                generic-64bit_defconfig
mips                        qi_lb60_defconfig
arm                             ezx_defconfig
arm                          pxa168_defconfig
arc                      axs103_smp_defconfig
arm                            pleb_defconfig
arm                        mini2440_defconfig
arm                          ep93xx_defconfig
arc                     nsimosci_hs_defconfig
xtensa                         virt_defconfig
arm                          moxart_defconfig
arm                              zx_defconfig
sh                   sh7770_generic_defconfig
arm                          imote2_defconfig
powerpc                     mpc512x_defconfig
ia64                             allyesconfig
arm                        clps711x_defconfig
sh                 kfr2r09-romimage_defconfig
arc                 nsimosci_hs_smp_defconfig
xtensa                          iss_defconfig
riscv                          rv32_defconfig
c6x                        evmc6474_defconfig
arc                        vdk_hs38_defconfig
arm                  colibri_pxa270_defconfig
arm                          collie_defconfig
sh                          lboxre2_defconfig
csky                             allyesconfig
arc                         haps_hs_defconfig
mips                     loongson1c_defconfig
arm                         vf610m4_defconfig
arm                          tango4_defconfig
m68k                           sun3_defconfig
arc                        nsim_700_defconfig
sh                        dreamcast_defconfig
h8300                            alldefconfig
mips                          ath79_defconfig
arc                          axs103_defconfig
um                           x86_64_defconfig
arm                         s3c6400_defconfig
sh                ecovec24-romimage_defconfig
c6x                         dsk6455_defconfig
mips                         rt305x_defconfig
sh                          rsk7269_defconfig
arm                           sama5_defconfig
arm                         s5pv210_defconfig
xtensa                    xip_kc705_defconfig
x86_64                              defconfig
arm                      jornada720_defconfig
arm                              alldefconfig
sparc                            allyesconfig
mips                      bmips_stb_defconfig
arm                          pxa910_defconfig
mips                         cobalt_defconfig
microblaze                    nommu_defconfig
sh                          urquell_defconfig
m68k                          amiga_defconfig
ia64                      gensparse_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                        shmobile_defconfig
ia64                              allnoconfig
sh                         ecovec24_defconfig
arm                          pcm027_defconfig
mips                          ath25_defconfig
sh                        sh7785lcr_defconfig
nds32                             allnoconfig
arm                         palmz72_defconfig
um                            kunit_defconfig
powerpc                           allnoconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                             defconfig
i386                 randconfig-a015-20200612
i386                 randconfig-a011-20200612
i386                 randconfig-a014-20200612
i386                 randconfig-a016-20200612
i386                 randconfig-a013-20200612
i386                 randconfig-a012-20200612
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                                allnoconfig
um                                  defconfig
um                               allmodconfig
um                               allyesconfig
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
