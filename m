Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AA56F9FAE
	for <lists+linux-ext4@lfdr.de>; Mon,  8 May 2023 08:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbjEHGUH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 May 2023 02:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjEHGUH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 8 May 2023 02:20:07 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D421FEA
        for <linux-ext4@vger.kernel.org>; Sun,  7 May 2023 23:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683526806; x=1715062806;
  h=date:from:to:cc:subject:message-id;
  bh=IVnAROJH12x7qFdPWBOzv+oA2SUdHxuW0bQyrSBFWtY=;
  b=LI3jZ/xToPbvaQbrAo4mBE/dFhJdUV0dUxA6hyx2PxjtTmGOCt0lCti3
   lGjheTJM0T+qr0dd6nZN4yfZMDjMvPINdtP9E8XeUR1RqMnSc5OEjjULJ
   7JzO3b0tYRNZfkl2pv2jgbPFgrd3scx/vXLcpmegEeszupcBktme5WNIJ
   empIWbcBVBnyKnPXaovLRp2C/6jNKihkaJKpQWCuc8/1HmvPwKbQFChDp
   Ar69rKzIpMac+cFoyIrtjh4KZLc9C2G3iUMB2bVzf5eZqX8dS2Ie8tlyc
   G+GdQ0iYp/IynjCOXRRXzR7hw1KygFMYsWQ+NeXlg9WXmPiaVT2P6nAyF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="377658734"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="377658734"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2023 23:20:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="842580994"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="842580994"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 07 May 2023 23:20:04 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pvuE8-00014r-19;
        Mon, 08 May 2023 06:20:04 +0000
Date:   Mon, 08 May 2023 14:19:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:next] BUILD SUCCESS
 fc8af73230c676380de897bd05b0d2da04ba9e35
Message-ID: <20230508061911.ARdBb%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git next
branch HEAD: fc8af73230c676380de897bd05b0d2da04ba9e35  ext4: fix deadlock when converting an inline directory in nojournal mode

elapsed time: 720m

configs tested: 126
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r003-20230507   gcc  
alpha        buildonly-randconfig-r005-20230508   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r032-20230507   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r004-20230508   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r022-20230508   gcc  
arc                  randconfig-r043-20230507   gcc  
arc                  randconfig-r043-20230508   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r004-20230508   gcc  
arm                  randconfig-r014-20230508   clang
arm                  randconfig-r026-20230508   clang
arm                  randconfig-r046-20230507   gcc  
arm                  randconfig-r046-20230508   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r021-20230507   clang
arm64                randconfig-r031-20230507   gcc  
csky         buildonly-randconfig-r004-20230507   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r005-20230508   clang
hexagon              randconfig-r026-20230507   clang
hexagon              randconfig-r034-20230507   clang
hexagon              randconfig-r041-20230507   clang
hexagon              randconfig-r041-20230508   clang
hexagon              randconfig-r045-20230507   clang
hexagon              randconfig-r045-20230508   clang
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
i386                 randconfig-r013-20230508   gcc  
i386                 randconfig-r021-20230508   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r002-20230507   gcc  
ia64                 randconfig-r024-20230508   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r003-20230508   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r003-20230507   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
microblaze   buildonly-randconfig-r001-20230508   gcc  
microblaze           randconfig-r001-20230507   gcc  
microblaze           randconfig-r011-20230508   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r006-20230507   clang
mips                 randconfig-r012-20230508   clang
mips                 randconfig-r022-20230507   gcc  
nios2        buildonly-randconfig-r005-20230507   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r033-20230507   gcc  
nios2                randconfig-r036-20230507   gcc  
openrisc             randconfig-r015-20230508   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r013-20230507   gcc  
parisc               randconfig-r024-20230507   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r002-20230508   clang
powerpc              randconfig-r011-20230507   clang
powerpc              randconfig-r016-20230507   clang
powerpc              randconfig-r023-20230508   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230507   clang
riscv                randconfig-r042-20230508   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r001-20230508   clang
s390                 randconfig-r006-20230508   clang
s390                 randconfig-r025-20230508   gcc  
s390                 randconfig-r044-20230507   clang
s390                 randconfig-r044-20230508   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r004-20230507   gcc  
sparc        buildonly-randconfig-r002-20230507   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r035-20230507   gcc  
sparc64      buildonly-randconfig-r006-20230508   gcc  
sparc64              randconfig-r015-20230507   gcc  
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
x86_64               randconfig-a011-20230508   gcc  
x86_64               randconfig-a012-20230508   gcc  
x86_64               randconfig-a013-20230508   gcc  
x86_64               randconfig-a014-20230508   gcc  
x86_64               randconfig-a015-20230508   gcc  
x86_64               randconfig-a016-20230508   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r002-20230508   gcc  
xtensa               randconfig-r005-20230507   gcc  
xtensa               randconfig-r006-20230507   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
