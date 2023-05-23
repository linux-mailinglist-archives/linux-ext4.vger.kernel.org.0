Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D76470E0F1
	for <lists+linux-ext4@lfdr.de>; Tue, 23 May 2023 17:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235630AbjEWPuY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 23 May 2023 11:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjEWPuX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 23 May 2023 11:50:23 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307B1DD
        for <linux-ext4@vger.kernel.org>; Tue, 23 May 2023 08:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684857022; x=1716393022;
  h=date:from:to:cc:subject:message-id;
  bh=J3G5Svl4mbLYEuLhOBmIomsZXhczH8rQ8M4NYXw+gL0=;
  b=dkWRxhto40IT8HA0PIl43oVgTE9AftScucFkbwdm8CQ1OAqr705S1ssZ
   DmLAZ2oOoOsOikWZxiqYSODRKMCm0BuJXA/gVJ1UoPvnfsO2OKy0aHLwe
   NlAhbkwuPEw8fcGgeeh8AIR4LAPN9ACyFCXUXQ3TQnOXR9A1zngFxmQIb
   B84qdciGBxrwFbWHnG5zyHn8+PLHbOyjo5n2LMBbrTNT5Z4wwkvmVIkdH
   XaBW+Ca8EbUZJwBTKZWa4Dc74pvjTc5aGcH4GntREwRLguMX54lLgcKqC
   usI+U2Q/nYSOfQtIRAjCFfdFR2CMOwaQ2M7nruej/L6Zb8zTvi45JdP/j
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="356508956"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; 
   d="scan'208";a="356508956"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 08:50:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="950595241"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; 
   d="scan'208";a="950595241"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 23 May 2023 08:50:20 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q1UHD-000DtF-1p;
        Tue, 23 May 2023 15:50:19 +0000
Date:   Tue, 23 May 2023 23:49:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:test] BUILD SUCCESS
 5f0839acb99f87e162cee1bfb8a9e964f2bfd7e6
Message-ID: <20230523154920.SferQ%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: INFO setup_repo_specs: /db/releases/20230523172912/lkp-src/repo/*/tytso-ext4
https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git test
branch HEAD: 5f0839acb99f87e162cee1bfb8a9e964f2bfd7e6  ext4: set lockdep subclass for the ea_inode in ext4_xattr_inode_cache_find()

elapsed time: 722m

configs tested: 222
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r002-20230522   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r012-20230521   gcc  
alpha                randconfig-r022-20230521   gcc  
alpha                randconfig-r023-20230523   gcc  
alpha                randconfig-r024-20230521   gcc  
alpha                randconfig-r025-20230521   gcc  
alpha                randconfig-r026-20230522   gcc  
alpha                randconfig-r033-20230522   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r004-20230521   gcc  
arc          buildonly-randconfig-r005-20230522   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r013-20230521   gcc  
arc                  randconfig-r015-20230521   gcc  
arc                  randconfig-r016-20230522   gcc  
arc                  randconfig-r023-20230521   gcc  
arc                  randconfig-r023-20230522   gcc  
arc                  randconfig-r024-20230523   gcc  
arc                  randconfig-r034-20230522   gcc  
arc                  randconfig-r035-20230521   gcc  
arc                  randconfig-r036-20230521   gcc  
arc                  randconfig-r043-20230521   gcc  
arc                  randconfig-r043-20230522   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r003-20230522   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r013-20230522   gcc  
arm                  randconfig-r046-20230521   clang
arm                  randconfig-r046-20230522   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r001-20230522   gcc  
arm64        buildonly-randconfig-r002-20230521   clang
arm64                               defconfig   gcc  
arm64                randconfig-r005-20230521   clang
arm64                randconfig-r005-20230522   gcc  
csky         buildonly-randconfig-r003-20230521   gcc  
csky         buildonly-randconfig-r006-20230522   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r011-20230522   gcc  
csky                 randconfig-r014-20230521   gcc  
csky                 randconfig-r015-20230521   gcc  
hexagon              randconfig-r013-20230521   clang
hexagon              randconfig-r021-20230522   clang
hexagon              randconfig-r026-20230522   clang
hexagon              randconfig-r032-20230522   clang
hexagon              randconfig-r035-20230521   clang
hexagon              randconfig-r041-20230521   clang
hexagon              randconfig-r041-20230522   clang
hexagon              randconfig-r045-20230521   clang
hexagon              randconfig-r045-20230522   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230522   gcc  
i386                 randconfig-a002-20230522   gcc  
i386                 randconfig-a003-20230522   gcc  
i386                 randconfig-a004-20230522   gcc  
i386                 randconfig-a005-20230522   gcc  
i386                 randconfig-a006-20230522   gcc  
i386                 randconfig-i051-20230523   clang
i386                 randconfig-i052-20230523   clang
i386                 randconfig-i053-20230523   clang
i386                 randconfig-i054-20230523   clang
i386                 randconfig-i055-20230523   clang
i386                 randconfig-i056-20230523   clang
i386                 randconfig-i061-20230523   clang
i386                 randconfig-i062-20230523   clang
i386                 randconfig-i063-20230523   clang
i386                 randconfig-i064-20230523   clang
i386                 randconfig-i065-20230523   clang
i386                 randconfig-i066-20230523   clang
i386                 randconfig-r001-20230522   gcc  
i386                 randconfig-r004-20230522   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                        generic_defconfig   gcc  
ia64                 randconfig-r003-20230522   gcc  
ia64                 randconfig-r015-20230522   gcc  
ia64                 randconfig-r022-20230523   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r003-20230521   gcc  
loongarch    buildonly-randconfig-r006-20230521   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r016-20230521   gcc  
loongarch            randconfig-r024-20230522   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r003-20230522   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                 randconfig-r013-20230522   gcc  
microblaze           randconfig-r004-20230522   gcc  
microblaze           randconfig-r012-20230522   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r002-20230522   clang
mips         buildonly-randconfig-r006-20230521   gcc  
mips                  decstation_64_defconfig   gcc  
mips                 randconfig-r001-20230521   gcc  
mips                 randconfig-r006-20230521   gcc  
mips                 randconfig-r011-20230522   gcc  
mips                 randconfig-r022-20230522   gcc  
mips                 randconfig-r033-20230522   clang
nios2                               defconfig   gcc  
nios2                randconfig-r004-20230521   gcc  
nios2                randconfig-r005-20230521   gcc  
nios2                randconfig-r031-20230521   gcc  
nios2                randconfig-r031-20230522   gcc  
openrisc     buildonly-randconfig-r001-20230522   gcc  
openrisc     buildonly-randconfig-r004-20230522   gcc  
openrisc     buildonly-randconfig-r005-20230521   gcc  
openrisc                    or1ksim_defconfig   gcc  
openrisc             randconfig-r031-20230522   gcc  
openrisc             randconfig-r034-20230521   gcc  
openrisc             randconfig-r035-20230522   gcc  
openrisc             randconfig-r036-20230521   gcc  
openrisc             randconfig-r036-20230522   gcc  
parisc       buildonly-randconfig-r004-20230521   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r002-20230521   gcc  
parisc               randconfig-r014-20230522   gcc  
parisc               randconfig-r022-20230521   gcc  
parisc               randconfig-r023-20230521   gcc  
parisc               randconfig-r023-20230522   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r001-20230521   gcc  
powerpc              randconfig-r006-20230522   gcc  
powerpc              randconfig-r011-20230521   gcc  
powerpc              randconfig-r021-20230521   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r024-20230521   gcc  
riscv                randconfig-r042-20230521   gcc  
riscv                randconfig-r042-20230522   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r025-20230521   gcc  
s390                 randconfig-r026-20230521   gcc  
s390                 randconfig-r044-20230521   gcc  
s390                 randconfig-r044-20230522   clang
sh                               allmodconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                   randconfig-r002-20230522   gcc  
sh                   randconfig-r006-20230521   gcc  
sh                   randconfig-r015-20230522   gcc  
sh                   randconfig-r034-20230521   gcc  
sh                   secureedge5410_defconfig   gcc  
sparc        buildonly-randconfig-r005-20230522   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r014-20230521   gcc  
sparc                randconfig-r014-20230522   gcc  
sparc                randconfig-r025-20230522   gcc  
sparc64              randconfig-r001-20230522   gcc  
sparc64              randconfig-r011-20230521   gcc  
sparc64              randconfig-r016-20230521   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230522   gcc  
x86_64               randconfig-a002-20230522   gcc  
x86_64               randconfig-a003-20230522   gcc  
x86_64               randconfig-a004-20230522   gcc  
x86_64               randconfig-a005-20230522   gcc  
x86_64               randconfig-a006-20230522   gcc  
x86_64               randconfig-a011-20230522   clang
x86_64               randconfig-a012-20230522   clang
x86_64               randconfig-a013-20230522   clang
x86_64               randconfig-a014-20230522   clang
x86_64               randconfig-a015-20230522   clang
x86_64               randconfig-a016-20230522   clang
x86_64               randconfig-x051-20230522   clang
x86_64               randconfig-x052-20230522   clang
x86_64               randconfig-x053-20230522   clang
x86_64               randconfig-x054-20230522   clang
x86_64               randconfig-x055-20230522   clang
x86_64               randconfig-x056-20230522   clang
x86_64               randconfig-x061-20230522   clang
x86_64               randconfig-x062-20230522   clang
x86_64               randconfig-x063-20230522   clang
x86_64               randconfig-x064-20230522   clang
x86_64               randconfig-x065-20230522   clang
x86_64               randconfig-x066-20230522   clang
x86_64               randconfig-x071-20230522   gcc  
x86_64               randconfig-x072-20230522   gcc  
x86_64               randconfig-x073-20230522   gcc  
x86_64               randconfig-x074-20230522   gcc  
x86_64               randconfig-x075-20230522   gcc  
x86_64               randconfig-x076-20230522   gcc  
x86_64               randconfig-x081-20230522   gcc  
x86_64               randconfig-x082-20230522   gcc  
x86_64               randconfig-x083-20230522   gcc  
x86_64               randconfig-x084-20230522   gcc  
x86_64               randconfig-x085-20230522   gcc  
x86_64               randconfig-x086-20230522   gcc  
x86_64               randconfig-x091-20230523   gcc  
x86_64               randconfig-x092-20230523   gcc  
x86_64               randconfig-x093-20230523   gcc  
x86_64               randconfig-x094-20230523   gcc  
x86_64               randconfig-x095-20230523   gcc  
x86_64               randconfig-x096-20230523   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r001-20230521   gcc  
xtensa               randconfig-r002-20230522   gcc  
xtensa               randconfig-r003-20230522   gcc  
xtensa               randconfig-r021-20230521   gcc  
xtensa               randconfig-r025-20230523   gcc  
xtensa               randconfig-r026-20230521   gcc  
xtensa               randconfig-r026-20230523   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
