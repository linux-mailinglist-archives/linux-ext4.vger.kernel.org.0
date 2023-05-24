Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CC870ED21
	for <lists+linux-ext4@lfdr.de>; Wed, 24 May 2023 07:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236486AbjEXFc6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 24 May 2023 01:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238870AbjEXFcx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 24 May 2023 01:32:53 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640D21B0
        for <linux-ext4@vger.kernel.org>; Tue, 23 May 2023 22:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684906369; x=1716442369;
  h=date:from:to:cc:subject:message-id;
  bh=7EO6yvbXKCJRE3w5JQoA59hcvPLR2TwCgLC9pdVfGwg=;
  b=Mc2XBfzcRQgQdvi1O5BP3DrrTHs/2X9FItPtS2+1TDZz4ELyhMjXbMxM
   H9Ycxlxw1tW3/IwVqf3XnArt+X0PLehoTgF0exHcB7Tg8DJRxWg7Z43Qk
   osIkIOm27nuQADJkJt9wdI4cJtdiFtcRmH8WP7Vc6ElSNM5DJB523+p0e
   nUrXeMw55/Nf+cyi/X8Yv54zi2P+e0dDpGNVicKELGgPKAfkIgWjUfcsn
   DRnCmCxoO2EdlycE701PUzGzLHeXleNZ9ENIfVcvqiFoAVYCePbm+CdwC
   FY3KWpcx2LqoY/pQm967iZhN5CifDKWCvN70J75pvYA4dk2Titc0Ve76p
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="439813770"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="439813770"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 22:32:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="950855126"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="950855126"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 23 May 2023 22:32:48 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q1h79-000ERH-1Y;
        Wed, 24 May 2023 05:32:47 +0000
Date:   Wed, 24 May 2023 13:32:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:test] BUILD SUCCESS
 6a5695213ee67fc52e60fd1a6078266b026828d9
Message-ID: <20230524053223.5UgSV%lkp@intel.com>
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

tree/branch: INFO setup_repo_specs: /db/releases/20230524121217/lkp-src/repo/*/tytso-ext4
https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git test
branch HEAD: 6a5695213ee67fc52e60fd1a6078266b026828d9  ext4: disallow ea_inodes with extended attributes

elapsed time: 720m

configs tested: 156
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r036-20230522   gcc  
arc                              allyesconfig   gcc  
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                            hsdk_defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                  randconfig-r012-20230522   gcc  
arc                  randconfig-r043-20230521   gcc  
arc                  randconfig-r043-20230522   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                       imx_v6_v7_defconfig   gcc  
arm                  randconfig-r014-20230522   gcc  
arm                  randconfig-r034-20230521   gcc  
arm                  randconfig-r046-20230521   clang
arm                  randconfig-r046-20230522   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r021-20230521   gcc  
arm64                randconfig-r024-20230522   clang
arm64                randconfig-r033-20230521   clang
csky                                defconfig   gcc  
csky                 randconfig-r036-20230521   gcc  
hexagon              randconfig-r024-20230521   clang
hexagon              randconfig-r031-20230522   clang
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
i386                 randconfig-r016-20230522   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r026-20230522   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r003-20230522   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r004-20230522   gcc  
loongarch            randconfig-r012-20230521   gcc  
loongarch            randconfig-r014-20230521   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r002-20230521   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r021-20230522   gcc  
m68k                 randconfig-r022-20230521   gcc  
m68k                 randconfig-r032-20230522   gcc  
microblaze           randconfig-r006-20230521   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r002-20230522   clang
mips         buildonly-randconfig-r004-20230521   gcc  
mips         buildonly-randconfig-r006-20230521   gcc  
mips                 randconfig-r004-20230521   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r023-20230522   gcc  
openrisc             randconfig-r002-20230522   gcc  
openrisc             randconfig-r015-20230522   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r001-20230522   gcc  
parisc               randconfig-r033-20230522   gcc  
parisc               randconfig-r034-20230522   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r004-20230522   clang
powerpc                      chrp32_defconfig   gcc  
powerpc              randconfig-r026-20230521   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r001-20230522   clang
riscv        buildonly-randconfig-r005-20230522   clang
riscv                               defconfig   gcc  
riscv                randconfig-r025-20230522   clang
riscv                randconfig-r042-20230521   gcc  
riscv                randconfig-r042-20230522   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r001-20230521   clang
s390                 randconfig-r002-20230521   clang
s390                 randconfig-r011-20230521   gcc  
s390                 randconfig-r013-20230521   gcc  
s390                 randconfig-r044-20230521   gcc  
s390                 randconfig-r044-20230522   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r001-20230521   gcc  
sh                   randconfig-r015-20230521   gcc  
sh                           se7705_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r005-20230522   gcc  
sparc                randconfig-r035-20230522   gcc  
sparc64      buildonly-randconfig-r006-20230522   gcc  
sparc64              randconfig-r003-20230521   gcc  
sparc64              randconfig-r006-20230522   gcc  
sparc64              randconfig-r013-20230522   gcc  
sparc64              randconfig-r032-20230521   gcc  
um                                  defconfig   gcc  
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
x86_64               randconfig-r011-20230522   clang
x86_64               randconfig-r022-20230522   clang
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
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
