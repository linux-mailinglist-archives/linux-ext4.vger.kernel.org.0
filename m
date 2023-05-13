Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206CB701536
	for <lists+linux-ext4@lfdr.de>; Sat, 13 May 2023 10:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjEMINK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 13 May 2023 04:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjEMINK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 13 May 2023 04:13:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268F4E2
        for <linux-ext4@vger.kernel.org>; Sat, 13 May 2023 01:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683965589; x=1715501589;
  h=date:from:to:cc:subject:message-id;
  bh=4duJxfSQkq4MBUjWwV0DW/9FgRGfqgD/QoiHhOakaKA=;
  b=lJriy4dC4eb+N/TCKKvXsfNUyy+wdp1U+YEuQIKFR+XxCojwwYbUivkj
   yHdyfCQnyYgT6vF8yJcAc2yadiJx24ehkKD/twZoKrJ7jFs7ybxFnFkFr
   oibMEh4GW4MCfNIrCxgWGsVuXaCIQbtAq0gc8Bualu/mZTVNkNbonvLkt
   I6bWsZ6lWFgZCYvuX9+TlIYYUrefLpCJwCwQm5PgSPl0GL/RGyWlh0J/G
   rBFUaiGjAS60E+W39KYvnvq/A0fpflyOvuUpDG42yIOxPl2CV7mjfwV2x
   PB2JQK0Q9yYBuTbfHaeCu3Mgx7gCkxT5aKD0Up4427NVvUZ+F7oKJnO5h
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="349778538"
X-IronPort-AV: E=Sophos;i="5.99,271,1677571200"; 
   d="scan'208";a="349778538"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2023 01:13:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="874632659"
X-IronPort-AV: E=Sophos;i="5.99,271,1677571200"; 
   d="scan'208";a="874632659"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 13 May 2023 01:13:07 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pxkNH-0005Om-0O;
        Sat, 13 May 2023 08:13:07 +0000
Date:   Sat, 13 May 2023 16:12:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:test] BUILD SUCCESS
 8f98020c317b4bf0d602f914becbc6df1682d117
Message-ID: <20230513081221.3PwDm%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git test
branch HEAD: 8f98020c317b4bf0d602f914becbc6df1682d117  ext4: bail out of ext4_xattr_ibody_get() fails for any reason

elapsed time: 726m

configs tested: 139
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r003-20230511   gcc  
alpha                randconfig-r006-20230511   gcc  
alpha                randconfig-r036-20230511   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r005-20230511   gcc  
arc                  randconfig-r023-20230509   gcc  
arc                  randconfig-r043-20230511   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                         lpc18xx_defconfig   gcc  
arm                  randconfig-r002-20230509   clang
arm                  randconfig-r046-20230511   clang
arm                         s3c6400_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r005-20230511   clang
arm64        buildonly-randconfig-r006-20230511   clang
arm64                               defconfig   gcc  
arm64                randconfig-r003-20230509   gcc  
arm64                randconfig-r004-20230509   gcc  
arm64                randconfig-r032-20230509   gcc  
arm64                randconfig-r036-20230509   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r024-20230509   clang
hexagon              randconfig-r024-20230511   clang
hexagon              randconfig-r041-20230511   clang
hexagon              randconfig-r045-20230511   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64                         bigsur_defconfig   gcc  
ia64         buildonly-randconfig-r005-20230509   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r013-20230511   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r021-20230509   gcc  
loongarch            randconfig-r021-20230511   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r003-20230511   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r016-20230511   gcc  
m68k                 randconfig-r025-20230509   gcc  
microblaze   buildonly-randconfig-r001-20230511   gcc  
microblaze           randconfig-r001-20230509   gcc  
microblaze           randconfig-r033-20230511   gcc  
microblaze           randconfig-r035-20230509   gcc  
microblaze           randconfig-r035-20230511   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                            ar7_defconfig   gcc  
mips                         bigsur_defconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r022-20230511   gcc  
nios2                randconfig-r033-20230509   gcc  
openrisc             randconfig-r002-20230511   gcc  
openrisc             randconfig-r011-20230511   gcc  
parisc       buildonly-randconfig-r002-20230509   gcc  
parisc       buildonly-randconfig-r003-20230509   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r012-20230511   gcc  
parisc               randconfig-r025-20230511   gcc  
parisc               randconfig-r026-20230511   gcc  
parisc               randconfig-r034-20230509   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                     akebono_defconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                     asp8347_defconfig   gcc  
powerpc                   bluestone_defconfig   clang
powerpc                 mpc834x_itx_defconfig   gcc  
powerpc              randconfig-r005-20230509   gcc  
powerpc              randconfig-r032-20230511   clang
powerpc                 xes_mpc85xx_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r026-20230509   clang
riscv                randconfig-r031-20230509   gcc  
riscv                randconfig-r042-20230511   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230511   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r004-20230511   gcc  
sh                   randconfig-r022-20230509   gcc  
sh                   randconfig-r023-20230511   gcc  
sh                           se7722_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sparc        buildonly-randconfig-r004-20230509   gcc  
sparc        buildonly-randconfig-r006-20230509   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r014-20230511   gcc  
sparc64      buildonly-randconfig-r002-20230511   gcc  
sparc64              randconfig-r006-20230509   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r004-20230511   gcc  
xtensa               randconfig-r001-20230511   gcc  
xtensa               randconfig-r015-20230511   gcc  
xtensa               randconfig-r034-20230511   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
