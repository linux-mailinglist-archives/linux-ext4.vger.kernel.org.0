Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD14D6B19BD
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Mar 2023 04:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjCIDAQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Mar 2023 22:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjCIDAK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Mar 2023 22:00:10 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDE825965
        for <linux-ext4@vger.kernel.org>; Wed,  8 Mar 2023 19:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678330808; x=1709866808;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ZPWgoQtUMOd73vNXiPozl2an+dxPEw+Y/0s4AytSI0s=;
  b=BjCOmWOFFEzAqxMOyUEjwViqkLBNdC/BKZCE5ZIJvnzZuwwYOQp/6ZRT
   TRg4OptUDJ03ScfOQ1ptkR2l4/mOxelHQtN+cDxcmZdUngp8h5oXDmMJZ
   3PuVowZqTB4eW0LjUzN4wIPxIDjNlMbBDUMNQmlsYxL3ZH6nfuEn24HbA
   v2z793Y2IMJ06oeUsZ4KxiFLC5UHlJRkQv25mXHjyPAy8BLNXlpKp+T7P
   osp9ooV/EpOAl+/WtGmystaZk+c/3Wq6X2fCu595T/RluaGG7aTcNbpg4
   HnAMtqtK0xMpmJnurGTSAZH0fP2zaNTJ96GYo+8ftnXQpP1/A30/k/aLs
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="336355424"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="336355424"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 19:00:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="741378048"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="741378048"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 08 Mar 2023 19:00:06 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pa6Vi-0002ZF-0p;
        Thu, 09 Mar 2023 03:00:06 +0000
Date:   Thu, 09 Mar 2023 10:59:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:test] BUILD SUCCESS
 3c92792da8506a295afb6d032b4476e46f979725
Message-ID: <64094b84.ulj7zMejKehImKiP%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git test
branch HEAD: 3c92792da8506a295afb6d032b4476e46f979725  ext4: Fix deadlock during directory rename

elapsed time: 1412m

configs tested: 162
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig   gcc  
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r005-20230305   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r034-20230306   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r006-20230305   gcc  
arc                  randconfig-r016-20230306   gcc  
arc                  randconfig-r035-20230305   gcc  
arc                  randconfig-r043-20230305   gcc  
arc                  randconfig-r043-20230306   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230305   clang
arm                  randconfig-r046-20230306   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230306   gcc  
arm64                randconfig-r002-20230305   clang
arm64                randconfig-r002-20230306   gcc  
arm64                randconfig-r021-20230305   gcc  
arm64                randconfig-r026-20230306   clang
csky         buildonly-randconfig-r005-20230306   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r013-20230306   gcc  
csky                 randconfig-r025-20230306   gcc  
hexagon      buildonly-randconfig-r003-20230306   clang
hexagon      buildonly-randconfig-r004-20230305   clang
hexagon      buildonly-randconfig-r006-20230305   clang
hexagon              randconfig-r013-20230305   clang
hexagon              randconfig-r015-20230305   clang
hexagon              randconfig-r023-20230305   clang
hexagon              randconfig-r041-20230305   clang
hexagon              randconfig-r041-20230306   clang
hexagon              randconfig-r045-20230305   clang
hexagon              randconfig-r045-20230306   clang
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386                         debian-10.3-func   gcc  
i386                   debian-10.3-kselftests   gcc  
i386                        debian-10.3-kunit   gcc  
i386                          debian-10.3-kvm   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230306   gcc  
i386                 randconfig-a002-20230306   gcc  
i386                          randconfig-a002   clang
i386                 randconfig-a003-20230306   gcc  
i386                 randconfig-a004-20230306   gcc  
i386                          randconfig-a004   clang
i386                 randconfig-a005-20230306   gcc  
i386                 randconfig-a006-20230306   gcc  
i386                          randconfig-a006   clang
i386                 randconfig-a011-20230306   clang
i386                 randconfig-a012-20230306   clang
i386                          randconfig-a012   gcc  
i386                 randconfig-a013-20230306   clang
i386                 randconfig-a014-20230306   clang
i386                          randconfig-a014   gcc  
i386                 randconfig-a015-20230306   clang
i386                 randconfig-a016-20230306   clang
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r011-20230305   gcc  
ia64                 randconfig-r021-20230306   gcc  
ia64                 randconfig-r022-20230306   gcc  
ia64                 randconfig-r033-20230306   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r003-20230306   gcc  
microblaze           randconfig-r003-20230305   gcc  
microblaze           randconfig-r004-20230306   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r006-20230306   clang
mips                 randconfig-r006-20230306   clang
mips                 randconfig-r022-20230305   clang
nios2        buildonly-randconfig-r001-20230306   gcc  
nios2        buildonly-randconfig-r002-20230305   gcc  
nios2        buildonly-randconfig-r003-20230305   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r031-20230305   gcc  
openrisc             randconfig-r001-20230305   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r016-20230305   gcc  
parisc               randconfig-r032-20230305   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r002-20230306   clang
powerpc                  iss476-smp_defconfig   gcc  
powerpc              randconfig-r005-20230306   gcc  
powerpc              randconfig-r015-20230306   clang
powerpc              randconfig-r035-20230306   gcc  
powerpc                      tqm8xx_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r024-20230305   gcc  
riscv                randconfig-r042-20230305   gcc  
riscv                randconfig-r042-20230306   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r014-20230305   gcc  
s390                 randconfig-r031-20230306   gcc  
s390                 randconfig-r032-20230306   gcc  
s390                 randconfig-r044-20230305   gcc  
s390                 randconfig-r044-20230306   clang
sh                               allmodconfig   gcc  
sh                          sdk7780_defconfig   gcc  
sparc        buildonly-randconfig-r001-20230305   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r004-20230305   gcc  
sparc                randconfig-r023-20230306   gcc  
sparc                randconfig-r034-20230305   gcc  
sparc                randconfig-r036-20230305   gcc  
sparc64              randconfig-r024-20230306   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230306   gcc  
x86_64                        randconfig-a001   clang
x86_64               randconfig-a002-20230306   gcc  
x86_64               randconfig-a003-20230306   gcc  
x86_64                        randconfig-a003   clang
x86_64               randconfig-a004-20230306   gcc  
x86_64               randconfig-a005-20230306   gcc  
x86_64                        randconfig-a005   clang
x86_64               randconfig-a006-20230306   gcc  
x86_64               randconfig-a011-20230306   clang
x86_64               randconfig-a012-20230306   clang
x86_64                        randconfig-a012   clang
x86_64               randconfig-a013-20230306   clang
x86_64               randconfig-a014-20230306   clang
x86_64                        randconfig-a014   clang
x86_64               randconfig-a015-20230306   clang
x86_64               randconfig-a016-20230306   clang
x86_64                        randconfig-a016   clang
x86_64                        randconfig-k001   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-kvm   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                           rhel-8.3-syz   gcc  
x86_64                               rhel-8.3   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa       buildonly-randconfig-r004-20230306   gcc  
xtensa               randconfig-r012-20230305   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
