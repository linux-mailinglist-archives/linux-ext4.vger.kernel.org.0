Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61894485F96
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Jan 2022 05:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbiAFEOK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Jan 2022 23:14:10 -0500
Received: from mga11.intel.com ([192.55.52.93]:49818 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232517AbiAFEOG (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 5 Jan 2022 23:14:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641442446; x=1672978446;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=JoMytLg+/UUalgDPOh/0ZLpZ3U4ZBvqrYA8qAztzpLc=;
  b=W2o9/4ejCY5ah7w3k0forlgz/O2+prge2k9SmjcyCaqS3/cLaaR+YaS1
   dZTVSg6atheFrSHC0MavXEzS8Trd9k9G+awRGFL36cVhjsnojsk6DGI1d
   a7NZa7n6IJ1R63KObsXa+WqxQaox7TlvNm9UVodn3lEU/8+AoP7dfNsFl
   XmK52CtXLOTNxaUgI7pjLWJK+iHUrSrthlqmUSOO2Vfk+oG6BoXYJJXAZ
   gOuh04eXf/VnzW7XtHPomhGcBGqo28y7Oh8OmOeQk+hctw6g4OMGedB+o
   hVdGDEQUCmLv3steMn1TrPl3TiNY5PT+9DNPDDvfcYKrOTfA+cHPdkZ5C
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="240133269"
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="240133269"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 20:14:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="488815583"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 05 Jan 2022 20:14:05 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5KA8-000HK1-Iz; Thu, 06 Jan 2022 04:14:04 +0000
Date:   Thu, 06 Jan 2022 12:13:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 db19c4cdc28a8ec1241d50656991ab1bd96f5c02
Message-ID: <61d66c5c.r6U+9ssjzlmPpDVU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: db19c4cdc28a8ec1241d50656991ab1bd96f5c02  ext4: allow to change s_last_trim_minblks via sysfs

elapsed time: 732m

configs tested: 143
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220105
powerpc              randconfig-c003-20220105
arm                         axm55xx_defconfig
sh                   sh7724_generic_defconfig
mips                      fuloong2e_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                    klondike_defconfig
parisc                generic-32bit_defconfig
sh                   sh7770_generic_defconfig
powerpc                        warp_defconfig
ia64                         bigsur_defconfig
s390                       zfcpdump_defconfig
sh                      rts7751r2d1_defconfig
arm                          pxa3xx_defconfig
arm                          pxa910_defconfig
sh                          r7785rp_defconfig
sh                            titan_defconfig
riscv                    nommu_k210_defconfig
sh                         ap325rxa_defconfig
powerpc                      tqm8xx_defconfig
h8300                     edosk2674_defconfig
m68k                          amiga_defconfig
arm                          iop32x_defconfig
powerpc                      makalu_defconfig
arc                        nsim_700_defconfig
mips                         mpc30x_defconfig
mips                         cobalt_defconfig
arm                      jornada720_defconfig
mips                           gcw0_defconfig
openrisc                         alldefconfig
sh                           se7750_defconfig
m68k                        mvme16x_defconfig
parisc                           allyesconfig
sh                     magicpanelr2_defconfig
m68k                          hp300_defconfig
powerpc                       eiger_defconfig
arc                        nsimosci_defconfig
powerpc                       maple_defconfig
arm                       omap2plus_defconfig
arm64                            alldefconfig
arm                        mini2440_defconfig
sh                        dreamcast_defconfig
sh                          lboxre2_defconfig
powerpc                    sam440ep_defconfig
arm                         assabet_defconfig
s390                          debug_defconfig
sparc64                             defconfig
powerpc                     sequoia_defconfig
sh                         ecovec24_defconfig
arm                           sunxi_defconfig
arm                  randconfig-c002-20220105
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20220105
x86_64               randconfig-a001-20220105
x86_64               randconfig-a004-20220105
x86_64               randconfig-a006-20220105
x86_64               randconfig-a003-20220105
x86_64               randconfig-a002-20220105
i386                 randconfig-a003-20220105
i386                 randconfig-a005-20220105
i386                 randconfig-a004-20220105
i386                 randconfig-a006-20220105
i386                 randconfig-a002-20220105
i386                 randconfig-a001-20220105
s390                 randconfig-r044-20220106
arc                  randconfig-r043-20220106
riscv                randconfig-r042-20220106
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
powerpc                     akebono_defconfig
riscv                    nommu_virt_defconfig
mips                          ath79_defconfig
powerpc                       ebony_defconfig
arm                           sama7_defconfig
riscv                          rv32_defconfig
powerpc                    ge_imp3a_defconfig
arm                              alldefconfig
riscv                             allnoconfig
powerpc                  mpc885_ads_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                      ppc64e_defconfig
arm                       spear13xx_defconfig
x86_64               randconfig-a012-20220105
x86_64               randconfig-a015-20220105
x86_64               randconfig-a014-20220105
x86_64               randconfig-a013-20220105
x86_64               randconfig-a011-20220105
x86_64               randconfig-a016-20220105
i386                 randconfig-a012-20220105
i386                 randconfig-a016-20220105
i386                 randconfig-a015-20220105
i386                 randconfig-a014-20220105
i386                 randconfig-a011-20220105
i386                 randconfig-a013-20220105
hexagon              randconfig-r041-20220105
hexagon              randconfig-r045-20220105
riscv                randconfig-r042-20220105

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
