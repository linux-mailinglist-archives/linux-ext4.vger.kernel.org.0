Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078075505AE
	for <lists+linux-ext4@lfdr.de>; Sat, 18 Jun 2022 17:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbiFRPUY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 18 Jun 2022 11:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiFRPUX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 18 Jun 2022 11:20:23 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E229D12AD0
        for <linux-ext4@vger.kernel.org>; Sat, 18 Jun 2022 08:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655565622; x=1687101622;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=9pGOKjqD1rR14o77LzGT3inw5BsnFQlLiDCBcOssMzg=;
  b=BOsUrMmVSpp32UoMvfwUU/71wyaj45eTp8lqMtWELbPkCMZ+sm5YZlkk
   efBC8hCvkY0OOFF65Nu+at/1BYJJjSQpJ0ZNJLu2aaw9jg8ejFEYRMgxd
   xQkVTurd1j4OSFer2/Du2fyfAXaZVcc1mpNe+eggowmaiANfaSZnrbYZE
   CRr8qTeNKncB8bM2CVpfM7xqkOLZeH714C1AOIHYBjX/jHODFe8UAaHpu
   KN/+VXoRTqJd0MDOyxa0KDKxEfNZTwzF9ZNRJedZnYxgg/VsRcc1TxuRH
   WCh9yGfxSxdiwn52gLFArs1AJA2e0x2cNiiUC/xukhMkDDFSuvP/zY+IN
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="305093187"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="305093187"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2022 08:20:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="832451818"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 18 Jun 2022 08:20:20 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2aFH-000QOR-By;
        Sat, 18 Jun 2022 15:20:19 +0000
Date:   Sat, 18 Jun 2022 23:20:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 729e657ab8d41efc2eadbb686193e888660b6253
Message-ID: <62aded23.WL5VuvhxlSyqUY9o%lkp@intel.com>
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
branch HEAD: 729e657ab8d41efc2eadbb686193e888660b6253  ext4: fix a doubled word "need" in a comment

elapsed time: 724m

configs tested: 125
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
powerpc                    adder875_defconfig
sh                           se7724_defconfig
arc                           tb10x_defconfig
arm                        cerfcube_defconfig
powerpc                        cell_defconfig
sh                          sdk7780_defconfig
mips                    maltaup_xpa_defconfig
sh                            titan_defconfig
mips                           ip32_defconfig
xtensa                              defconfig
um                             i386_defconfig
xtensa                         virt_defconfig
powerpc                     pq2fads_defconfig
m68k                            mac_defconfig
xtensa                  audio_kc705_defconfig
arm                            zeus_defconfig
arc                    vdk_hs38_smp_defconfig
sparc64                          alldefconfig
powerpc                       holly_defconfig
m68k                         amcore_defconfig
riscv                               defconfig
mips                      maltasmvp_defconfig
arc                        nsimosci_defconfig
sh                             shx3_defconfig
csky                             alldefconfig
mips                         tb0226_defconfig
m68k                       m5208evb_defconfig
sh                            shmin_defconfig
m68k                          atari_defconfig
nios2                            allyesconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220617
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
riscv                             allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
parisc64                            defconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                        randconfig-a004
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220617
arc                  randconfig-r043-20220617
s390                 randconfig-r044-20220617
riscv                            allyesconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                          rv32_defconfig
riscv                    nommu_virt_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                       spear13xx_defconfig
arm                          moxart_defconfig
powerpc                   lite5200b_defconfig
mips                      maltaaprp_defconfig
powerpc                       ebony_defconfig
arm                             mxs_defconfig
arm                         s3c2410_defconfig
arm                            mmp2_defconfig
powerpc                     mpc512x_defconfig
mips                      bmips_stb_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                          allmodconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220617
hexagon              randconfig-r045-20220617

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
