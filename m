Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD39A27D5F6
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Sep 2020 20:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgI2SnB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 29 Sep 2020 14:43:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:37513 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727740AbgI2SnA (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 29 Sep 2020 14:43:00 -0400
IronPort-SDR: iE3fLCFd0550y86DjkAYi+cuZ1YIXZEJHJf0LkZnjPD6YP+4JpmFlZQnLHQpv78liR8SVKKBQZ
 ARUSYabMaOTA==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="226412778"
X-IronPort-AV: E=Sophos;i="5.77,319,1596524400"; 
   d="scan'208";a="226412778"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 11:42:59 -0700
IronPort-SDR: vxt6XlMcraqPlg7a+j4kx6xE2iElsNiixkHdBLcHFXub65oErMIptvQzRJ2MojehVCTib5GPVo
 RaQ2iKYOP7Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,319,1596524400"; 
   d="scan'208";a="513988836"
Received: from lkp-server02.sh.intel.com (HELO 10ae44db8633) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 29 Sep 2020 11:42:58 -0700
Received: from kbuild by 10ae44db8633 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kNKaX-0000Eg-BI; Tue, 29 Sep 2020 18:42:57 +0000
Date:   Wed, 30 Sep 2020 02:42:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [ext4:dev] BUILD SUCCESS bfd54e29c6101fcfccd16ec2069404d393a7fc23
Message-ID: <5f738003.IcwKoBmVBDukZ2Xe%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git  dev
branch HEAD: bfd54e29c6101fcfccd16ec2069404d393a7fc23  ext4: fix leaking sysfs kobject after failed mount

elapsed time: 724m

configs tested: 122
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                            allyesconfig
arm64                               defconfig
arm                    vt8500_v6_v7_defconfig
m68k                        m5407c3_defconfig
mips                         db1xxx_defconfig
powerpc                      cm5200_defconfig
arm                        keystone_defconfig
arm                        multi_v5_defconfig
powerpc                 mpc8540_ads_defconfig
arm                        mvebu_v7_defconfig
arm                        spear3xx_defconfig
ia64                        generic_defconfig
mips                       rbtx49xx_defconfig
powerpc                      pmac32_defconfig
powerpc64                        alldefconfig
sh                        sh7785lcr_defconfig
powerpc                     mpc5200_defconfig
arm                          badge4_defconfig
sh                         ecovec24_defconfig
microblaze                    nommu_defconfig
xtensa                           allyesconfig
mips                          rm200_defconfig
m68k                       m5249evb_defconfig
arc                    vdk_hs38_smp_defconfig
mips                        maltaup_defconfig
arm                       versatile_defconfig
powerpc                     tqm8541_defconfig
m68k                        mvme16x_defconfig
powerpc                 mpc8560_ads_defconfig
mips                      pistachio_defconfig
s390                                defconfig
powerpc                 mpc837x_rdb_defconfig
sh                          polaris_defconfig
sh                          urquell_defconfig
arm                           sama5_defconfig
arc                             nps_defconfig
arm                          exynos_defconfig
um                            kunit_defconfig
sh                           se7206_defconfig
powerpc                      katmai_defconfig
powerpc                     tqm8560_defconfig
arc                        vdk_hs38_defconfig
mips                             allmodconfig
m68k                                defconfig
arm                         at91_dt_defconfig
sh                          sdk7780_defconfig
powerpc                     tqm8555_defconfig
mips                         mpc30x_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                       aspeed_g5_defconfig
sparc                            alldefconfig
riscv                          rv32_defconfig
mips                        bcm63xx_defconfig
um                           x86_64_defconfig
arm                        multi_v7_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
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
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
parisc                           allyesconfig
parisc                              defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20200929
i386                 randconfig-a002-20200929
i386                 randconfig-a003-20200929
i386                 randconfig-a004-20200929
i386                 randconfig-a005-20200929
i386                 randconfig-a001-20200929
x86_64               randconfig-a011-20200929
x86_64               randconfig-a013-20200929
x86_64               randconfig-a015-20200929
x86_64               randconfig-a014-20200929
x86_64               randconfig-a016-20200929
x86_64               randconfig-a012-20200929
i386                 randconfig-a012-20200929
i386                 randconfig-a016-20200929
i386                 randconfig-a014-20200929
i386                 randconfig-a013-20200929
i386                 randconfig-a015-20200929
i386                 randconfig-a011-20200929
riscv                    nommu_virt_defconfig
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a005-20200929
x86_64               randconfig-a003-20200929
x86_64               randconfig-a004-20200929
x86_64               randconfig-a002-20200929
x86_64               randconfig-a006-20200929
x86_64               randconfig-a001-20200929

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
