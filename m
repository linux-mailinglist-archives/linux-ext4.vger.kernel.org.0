Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68EA86F92F2
	for <lists+linux-ext4@lfdr.de>; Sat,  6 May 2023 18:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbjEFQAX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 6 May 2023 12:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbjEFQAW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 6 May 2023 12:00:22 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A98E1730
        for <linux-ext4@vger.kernel.org>; Sat,  6 May 2023 09:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683388821; x=1714924821;
  h=date:from:to:cc:subject:message-id;
  bh=4ukHf0uUq2IWicIldNAouV9KCC0lmR8+n0g6GNHiGr4=;
  b=OIG0EWY7YX3TZMx5AvvR7DeGTTGQphoXEwQX+Dbq/VEQMVuQ50ZzDJ4a
   mrU3Bg9rToQ0tjwMLrDM5neDMXR2ORe7nyK0xy2f6L7TVfHEkXwO/wxg0
   dYcoIgQh7EO1I1jniT3hIWewtEti/20sNSB3C/vR3H04DjoHCj0NNyAqp
   IHJr6sPPib3Id6nrnk7QWi35oplzqElLaHLiP59vWCuz2gPX48t23zGtC
   /YXFv+xYifWxAc7f4f3qSXApEHJ1Px/mEyPx5e76CQ/0qtG1FssPWouX+
   XffjKvetq5cOJrJEcvfu5SI4mdHtxJnsskYgMxaooQ8B3lHwxDBMffA/Y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10702"; a="349426910"
X-IronPort-AV: E=Sophos;i="5.99,255,1677571200"; 
   d="scan'208";a="349426910"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2023 09:00:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10702"; a="822122740"
X-IronPort-AV: E=Sophos;i="5.99,255,1677571200"; 
   d="scan'208";a="822122740"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 06 May 2023 09:00:19 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pvKKZ-0000Ne-0X;
        Sat, 06 May 2023 16:00:19 +0000
Date:   Sat, 06 May 2023 23:59:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:tt/next] BUILD SUCCESS
 0a81bb2f4a4000b1196253477cf9f37ac21d3a58
Message-ID: <20230506155942.ZjT2J%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tt/next
branch HEAD: 0a81bb2f4a4000b1196253477cf9f37ac21d3a58  ext4: improve error recovery code paths in __ext4_remount()

elapsed time: 722m

configs tested: 146
configs skipped: 16

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230502   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r014-20230503   gcc  
alpha                randconfig-r015-20230505   gcc  
alpha                randconfig-r032-20230501   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r006-20230502   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r004-20230501   gcc  
arc                  randconfig-r024-20230506   gcc  
arc                  randconfig-r043-20230430   gcc  
arc                  randconfig-r043-20230501   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230430   gcc  
arm                  randconfig-r046-20230501   gcc  
arm                         s3c6400_defconfig   gcc  
arm                           stm32_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r005-20230430   gcc  
arm64                randconfig-r011-20230505   clang
csky         buildonly-randconfig-r001-20230505   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r001-20230505   gcc  
csky                 randconfig-r003-20230501   gcc  
csky                 randconfig-r006-20230502   gcc  
csky                 randconfig-r016-20230505   gcc  
csky                 randconfig-r025-20230506   gcc  
csky                 randconfig-r026-20230506   gcc  
hexagon              randconfig-r035-20230430   clang
hexagon              randconfig-r041-20230430   clang
hexagon              randconfig-r041-20230501   clang
hexagon              randconfig-r045-20230430   clang
hexagon              randconfig-r045-20230501   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230501   gcc  
i386                 randconfig-a002-20230501   gcc  
i386                 randconfig-a003-20230501   gcc  
i386                 randconfig-a004-20230501   gcc  
i386                 randconfig-a005-20230501   gcc  
i386                 randconfig-a006-20230501   gcc  
i386                 randconfig-a011-20230501   clang
i386                 randconfig-a012-20230501   clang
i386                 randconfig-a013-20230501   clang
i386                 randconfig-a014-20230501   clang
i386                 randconfig-a015-20230501   clang
i386                 randconfig-a016-20230501   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r012-20230505   gcc  
ia64                 randconfig-r023-20230506   gcc  
ia64                 randconfig-r034-20230430   gcc  
ia64                 randconfig-r035-20230501   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r021-20230506   gcc  
loongarch            randconfig-r036-20230430   gcc  
m68k                             allmodconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                 randconfig-r001-20230501   gcc  
m68k                 randconfig-r001-20230502   gcc  
m68k                 randconfig-r032-20230430   gcc  
microblaze   buildonly-randconfig-r003-20230505   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath25_defconfig   clang
mips                     loongson1c_defconfig   clang
mips                 randconfig-r006-20230501   clang
mips                 randconfig-r013-20230505   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230505   gcc  
nios2                randconfig-r022-20230506   gcc  
openrisc             randconfig-r004-20230502   gcc  
openrisc             randconfig-r012-20230503   gcc  
parisc                           alldefconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r003-20230430   gcc  
parisc               randconfig-r003-20230502   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                   bluestone_defconfig   clang
powerpc                 mpc836x_rdk_defconfig   clang
powerpc              randconfig-r006-20230505   gcc  
powerpc              randconfig-r036-20230501   gcc  
powerpc                      tqm8xx_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r005-20230505   clang
riscv                               defconfig   gcc  
riscv                randconfig-r002-20230430   gcc  
riscv                randconfig-r002-20230502   clang
riscv                randconfig-r003-20230505   gcc  
riscv                randconfig-r004-20230430   gcc  
riscv                randconfig-r014-20230505   clang
riscv                randconfig-r031-20230430   gcc  
riscv                randconfig-r042-20230430   clang
riscv                randconfig-r042-20230501   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r005-20230502   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r016-20230503   clang
s390                 randconfig-r044-20230430   clang
s390                 randconfig-r044-20230501   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r005-20230502   gcc  
sh                        sh7757lcr_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r015-20230503   gcc  
sparc                randconfig-r034-20230501   gcc  
sparc64              randconfig-r001-20230430   gcc  
sparc64              randconfig-r002-20230501   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230501   gcc  
x86_64               randconfig-a002-20230501   gcc  
x86_64               randconfig-a003-20230501   gcc  
x86_64               randconfig-a004-20230501   gcc  
x86_64               randconfig-a005-20230501   gcc  
x86_64               randconfig-a006-20230501   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64               randconfig-r005-20230501   gcc  
x86_64                               rhel-8.3   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa               randconfig-r004-20230505   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
