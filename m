Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397C16FB208
	for <lists+linux-ext4@lfdr.de>; Mon,  8 May 2023 15:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbjEHNwg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 May 2023 09:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbjEHNwf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 8 May 2023 09:52:35 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73CE36558
        for <linux-ext4@vger.kernel.org>; Mon,  8 May 2023 06:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683553954; x=1715089954;
  h=date:from:to:cc:subject:message-id;
  bh=DyC1qzWQDSmiIKe4COsc+ZM+ojGDMZARrOGkyRLww3M=;
  b=abxgfFRrwUclvYME6yUBL8cCv4b4a8IOPnXGloakqnjzHwO4t0mny93Z
   W3fGZkay5CrhcT4Z+rG95CAntnVOfMn7SauCtHOAaj9nwBzPQS/7rvKZd
   ycC/GlJoRhEtDVFANCqwwR7K2ADLWO4yVKH6YPdSa3hgDXcAACssuHfsn
   G4lkt5NnQV1zY8sLXNFmEVU3ih53F7s6KMUYPBy3cNFtfk16B9rjUO4L+
   tE66M/m1D+8EjgcYFY8SOaqRztYXuMfmhjzYnt7f/YtIUTcq4W84oG9hx
   u9XSP3CXJkLuUgBJ3gSCEwUau4J26EYksxT8ZK/XSozRlZTD+4lmNVxx3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="349681274"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="349681274"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 06:52:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="1028414433"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="1028414433"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 08 May 2023 06:52:33 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pw1I1-0001FY-0Y;
        Mon, 08 May 2023 13:52:33 +0000
Date:   Mon, 08 May 2023 21:52:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 b5f9cca1feade4c1910e79731536e022da38c9d9
Message-ID: <20230508135218.N4zX7%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: b5f9cca1feade4c1910e79731536e022da38c9d9  ext4: fix deadlock when converting an inline directory in nojournal mode

elapsed time: 720m

configs tested: 124
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r002-20230507   gcc  
arc          buildonly-randconfig-r003-20230508   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r002-20230507   gcc  
arc                  randconfig-r004-20230508   gcc  
arc                  randconfig-r043-20230507   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r011-20230508   clang
arm                  randconfig-r036-20230507   clang
arm                  randconfig-r046-20230507   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r001-20230507   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r004-20230507   gcc  
arm64                randconfig-r005-20230507   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r001-20230507   gcc  
csky                 randconfig-r024-20230508   gcc  
hexagon      buildonly-randconfig-r002-20230508   clang
hexagon      buildonly-randconfig-r006-20230508   clang
hexagon              randconfig-r012-20230508   clang
hexagon              randconfig-r041-20230507   clang
hexagon              randconfig-r045-20230507   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230508   clang
i386                 randconfig-a002-20230508   clang
i386                 randconfig-a003-20230508   clang
i386                 randconfig-a004-20230508   clang
i386                 randconfig-a005-20230508   clang
i386                 randconfig-a006-20230508   clang
i386                 randconfig-a011-20230508   gcc  
i386                 randconfig-a012-20230508   gcc  
i386                 randconfig-a013-20230508   gcc  
i386                 randconfig-a014-20230508   gcc  
i386                 randconfig-a015-20230508   gcc  
i386                 randconfig-a016-20230508   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r034-20230507   gcc  
ia64                 randconfig-r036-20230508   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r003-20230507   gcc  
loongarch            randconfig-r026-20230508   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r005-20230508   gcc  
microblaze           randconfig-r014-20230508   gcc  
microblaze           randconfig-r022-20230508   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r034-20230508   gcc  
mips                 randconfig-r035-20230507   clang
nios2                               defconfig   gcc  
nios2                randconfig-r003-20230508   gcc  
nios2                randconfig-r022-20230507   gcc  
nios2                randconfig-r025-20230507   gcc  
openrisc     buildonly-randconfig-r006-20230507   gcc  
openrisc             randconfig-r032-20230507   gcc  
parisc       buildonly-randconfig-r004-20230507   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r006-20230507   gcc  
parisc               randconfig-r015-20230508   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r025-20230508   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r005-20230507   clang
riscv                               defconfig   gcc  
riscv                randconfig-r023-20230507   clang
riscv                randconfig-r042-20230507   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r021-20230507   clang
s390                 randconfig-r044-20230507   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r003-20230507   gcc  
sh           buildonly-randconfig-r005-20230508   gcc  
sh                   randconfig-r006-20230508   gcc  
sh                   randconfig-r023-20230508   gcc  
sparc        buildonly-randconfig-r001-20230508   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r016-20230508   gcc  
sparc                randconfig-r035-20230508   gcc  
sparc64      buildonly-randconfig-r004-20230508   gcc  
sparc64              randconfig-r001-20230508   gcc  
sparc64              randconfig-r002-20230508   gcc  
sparc64              randconfig-r013-20230508   gcc  
sparc64              randconfig-r033-20230507   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230508   clang
x86_64               randconfig-a002-20230508   clang
x86_64               randconfig-a003-20230508   clang
x86_64               randconfig-a004-20230508   clang
x86_64               randconfig-a005-20230508   clang
x86_64               randconfig-a006-20230508   clang
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64               randconfig-r033-20230508   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r021-20230508   gcc  
xtensa               randconfig-r024-20230507   gcc  
xtensa               randconfig-r026-20230507   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
