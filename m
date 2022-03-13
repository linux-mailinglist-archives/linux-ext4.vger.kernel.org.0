Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9DA4D76FE
	for <lists+linux-ext4@lfdr.de>; Sun, 13 Mar 2022 17:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbiCMQ7M (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 13 Mar 2022 12:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbiCMQ7L (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 13 Mar 2022 12:59:11 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C433C499
        for <linux-ext4@vger.kernel.org>; Sun, 13 Mar 2022 09:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647190683; x=1678726683;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ObJr3hJN02Z+r096v5+cHjEyAP+03w5QIkCf4kWns8k=;
  b=MBlopTH4glNpV+PEihVGZGMPeXatmF3IwW/LPxzpxG0mUjXzqP4zHz+q
   WWWU22USjKsXm/8qSiN/2b/tXAQ0uQYkv5wCU2t9h5wIhvzyJnX47Uocu
   HHBLlRv/REtTrgbIou42fgD9FyimKc+vxhZpErEPW4tygp481650mCATD
   FCsMd5MOpQoEDm77eESz4STNP7nONLVfa+emGJkyH5IBG5BcMlQfxeQmr
   AXtc+kHZKvfYugh5JbCpIpZ7BcbOYaYhKpzobPSKNpJRUp7MxP4hx89FM
   /W1OwI83TAmZi1qRwMpkC/B+i5gt+5k7x3XbqAHFjVP6mcIDAENffKPEx
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="280639414"
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="280639414"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 09:58:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="713454317"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 13 Mar 2022 09:58:01 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTRXc-00098I-Df; Sun, 13 Mar 2022 16:58:00 +0000
Date:   Mon, 14 Mar 2022 00:57:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 f7d6c24543c3b4b936db29f627014e71feb95214
Message-ID: <622e226c.U4+axRn66MRm6Hwc%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: f7d6c24543c3b4b936db29f627014e71feb95214  ext4: fix kernel doc warnings

elapsed time: 720m

configs tested: 120
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                 randconfig-c004-20220313
i386                          randconfig-c001
nios2                               defconfig
sh                          polaris_defconfig
sh                         microdev_defconfig
powerpc                     tqm8555_defconfig
powerpc                         wii_defconfig
arc                        vdk_hs38_defconfig
m68k                          atari_defconfig
arc                            hsdk_defconfig
sh                        sh7785lcr_defconfig
xtensa                  cadence_csp_defconfig
um                             i386_defconfig
mips                       capcella_defconfig
ia64                            zx1_defconfig
arm                            mps2_defconfig
mips                             allyesconfig
powerpc                     taishan_defconfig
arm                       multi_v4t_defconfig
h8300                     edosk2674_defconfig
arm                      footbridge_defconfig
parisc64                            defconfig
openrisc                 simple_smp_defconfig
arm                          lpd270_defconfig
sh                 kfr2r09-romimage_defconfig
um                                  defconfig
m68k                          multi_defconfig
m68k                          hp300_defconfig
nios2                            alldefconfig
sh                          rsk7269_defconfig
arm                            pleb_defconfig
ia64                         bigsur_defconfig
arm                          simpad_defconfig
m68k                        stmark2_defconfig
sh                          r7785rp_defconfig
mips                         tb0226_defconfig
powerpc                        cell_defconfig
arm                  randconfig-c002-20220313
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arc                  randconfig-r043-20220313
riscv                randconfig-r042-20220313
s390                 randconfig-r044-20220313
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220313
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220313
riscv                randconfig-c006-20220313
i386                          randconfig-c001
mips                 randconfig-c004-20220313
mips                       rbtx49xx_defconfig
powerpc                     kmeter1_defconfig
arm                        spear3xx_defconfig
arm                       aspeed_g4_defconfig
riscv                             allnoconfig
powerpc               mpc834x_itxgp_defconfig
arm                          pcm027_defconfig
arm                           spitz_defconfig
powerpc                      pmac32_defconfig
mips                       lemote2f_defconfig
mips                           ip28_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220313
hexagon              randconfig-r041-20220313

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
