Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988A35303AC
	for <lists+linux-ext4@lfdr.de>; Sun, 22 May 2022 16:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345270AbiEVO52 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 22 May 2022 10:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237579AbiEVO51 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 22 May 2022 10:57:27 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB552CE3C
        for <linux-ext4@vger.kernel.org>; Sun, 22 May 2022 07:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653231445; x=1684767445;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Hdh4JEwUvb1A05GI1zJaxlJ9nb8Cp1BZJ2h7UjQAyTo=;
  b=NZQ7mNDNTkGYsdcV9FMLSyvmmUKHp2Lu6TCpqdr/UTzLB7fzMDdHKbs+
   /5xUDYRNpQ01l7qEiJqvZuCOAMlI5ZENk2yFAHMJloLLAmie+p7+5tysV
   aKt2982NBFbTUEY/vI98TfYQ0vXXEJTETya6Q6KD/fPGUieY3SIK4gyt9
   euTq9/FwPifdGCkgEeRmI73gYTRC4eSeJHQfN3VPCQ1c8jaNCiKwI5MWU
   Tb/kw83ahnR+BI5HZdQbFh7tKIeau98q+MDxXpU8xJhmYT5bONV4GMVVq
   8qyl0YrcfjBMHIjY+i1a6/+xDGx4ST/8p/55GP53qYWg+fq4n6KuGpF8U
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10355"; a="298322634"
X-IronPort-AV: E=Sophos;i="5.91,244,1647327600"; 
   d="scan'208";a="298322634"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2022 07:57:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,244,1647327600"; 
   d="scan'208";a="628956970"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 22 May 2022 07:57:24 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nsn1H-0000QG-Pa;
        Sun, 22 May 2022 14:57:23 +0000
Date:   Sun, 22 May 2022 22:56:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 d177c151d74881536aa6b58f450c70fd5a7b6c1a
Message-ID: <628a4f29.CcIHnpNgPHLSDbp8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: d177c151d74881536aa6b58f450c70fd5a7b6c1a  ext4: only allow test_dummy_encryption when supported

elapsed time: 724m

configs tested: 107
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                       imx_v6_v7_defconfig
arm                           imxrt_defconfig
parisc                           alldefconfig
mips                     loongson1b_defconfig
ia64                          tiger_defconfig
mips                  decstation_64_defconfig
sh                           se7750_defconfig
arm                            zeus_defconfig
s390                       zfcpdump_defconfig
arm                       omap2plus_defconfig
powerpc64                           defconfig
mips                 decstation_r4k_defconfig
arm                           sama5_defconfig
m68k                          amiga_defconfig
sh                         microdev_defconfig
powerpc                      ppc6xx_defconfig
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
csky                                defconfig
arc                                 defconfig
h8300                            allyesconfig
xtensa                           allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
parisc64                            defconfig
nios2                               defconfig
arc                              allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220522
s390                 randconfig-r044-20220522
riscv                randconfig-r042-20220522
riscv                             allnoconfig
riscv                            allyesconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz

clang tested configs:
arm                          ep93xx_defconfig
i386                             allyesconfig
powerpc                          g5_defconfig
powerpc                    socrates_defconfig
powerpc                     mpc5200_defconfig
s390                             alldefconfig
arm                           omap1_defconfig
powerpc                   bluestone_defconfig
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220522
hexagon              randconfig-r041-20220522

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
