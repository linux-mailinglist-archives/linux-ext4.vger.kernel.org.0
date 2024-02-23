Return-Path: <linux-ext4+bounces-1374-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA95860A79
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Feb 2024 06:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 308E1288A46
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Feb 2024 05:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6910125C2;
	Fri, 23 Feb 2024 05:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d+DKfdQ7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9933811CB2
	for <linux-ext4@vger.kernel.org>; Fri, 23 Feb 2024 05:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708667560; cv=none; b=r/nNzzn8s3voNNMDfiNOo1XF2QGyCYl8S5OnAp/BBX0gqwrQLTh/gIP3HQdjSdfhpdrXXCJk5KFV5LaOYDMP0w+/aORVxs09y9U9cQm+UGBY91cTN/Wp2VUSJyuvRBCe2PKwR4pLe61BCaWqi6ba2iNLO/H0b+m4Pipdj4fPITc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708667560; c=relaxed/simple;
	bh=GbjkgBChKsHJxN0LCPMS3l/4gjfzoLqeiBinATcelwI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pf2QvjC0IhoclI0fDmUYj+hRBpCT7bEHSv633dveTK1jSgn9eRct3sgf2biR2AK3wWumV6FUN+Htj3uDXhwYPSXMeYVwSZo3R3iXtDszZCoiIZ2noGgLprAeXrSAf5mLntFoRRowITVFCMD8tTdLmlGMb2nOYuy+YO4hkOpmsyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d+DKfdQ7; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708667559; x=1740203559;
  h=date:from:to:cc:subject:message-id;
  bh=GbjkgBChKsHJxN0LCPMS3l/4gjfzoLqeiBinATcelwI=;
  b=d+DKfdQ7BVHJoNyoBx27F+Inbew53OYjVdS7+T4wLpFVrkDy2wQw04CY
   srQ2Rmr3dAP5vVyzPhzUYd/Yd1tvskxzEKiBNkp9UwvylwcHJbsf2sfSr
   Ays7e494gdYjO1ZARrM6u/kgtLMTeTPCrV4EXqO5d86tAgY091ZOqBi4f
   wofRN0eFscRMLbOihC/DOn9HNW9awkHvhqILuN+QlreAcodOtTgUkjlUC
   3Gkt14F1oWpBE0U8oi/GLGGzcrq9zYtoympwCDkQc2UZM4RkVSmlZSm4z
   4licPWOwBMGR149grOeyM0aGE5fBFZ+FotGeCUbSKEtQxFydoz2xrQFBl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="6751706"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="6751706"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 21:52:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="10380434"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 22 Feb 2024 21:52:37 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rdOU6-00078i-1w;
	Fri, 23 Feb 2024 05:52:34 +0000
Date: Fri, 23 Feb 2024 13:51:57 +0800
From: kernel test robot <lkp@intel.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 1f85b452e07c370448fb4eb4472cd55fc6bf115c
Message-ID: <202402231354.D4Yt4In8-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: 1f85b452e07c370448fb4eb4472cd55fc6bf115c  ext4: verify s_clusters_per_group even without bigalloc

elapsed time: 1457m

configs tested: 217
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                   randconfig-001-20240222   gcc  
arc                   randconfig-001-20240223   gcc  
arc                   randconfig-002-20240222   gcc  
arc                   randconfig-002-20240223   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                                 defconfig   clang
arm                        keystone_defconfig   gcc  
arm                          moxart_defconfig   gcc  
arm                        neponset_defconfig   gcc  
arm                       omap2plus_defconfig   gcc  
arm                             pxa_defconfig   gcc  
arm                   randconfig-001-20240222   gcc  
arm                   randconfig-001-20240223   gcc  
arm                   randconfig-002-20240222   gcc  
arm                   randconfig-004-20240223   gcc  
arm                        shmobile_defconfig   gcc  
arm                           stm32_defconfig   gcc  
arm                           tegra_defconfig   gcc  
arm                         wpcm450_defconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-002-20240222   gcc  
arm64                 randconfig-002-20240223   gcc  
arm64                 randconfig-004-20240223   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240222   gcc  
csky                  randconfig-001-20240223   gcc  
csky                  randconfig-002-20240222   gcc  
csky                  randconfig-002-20240223   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-002-20240222   clang
i386         buildonly-randconfig-003-20240222   clang
i386         buildonly-randconfig-005-20240222   clang
i386         buildonly-randconfig-006-20240223   clang
i386                                defconfig   clang
i386                  randconfig-001-20240222   clang
i386                  randconfig-001-20240223   clang
i386                  randconfig-002-20240222   clang
i386                  randconfig-004-20240222   clang
i386                  randconfig-006-20240222   clang
i386                  randconfig-006-20240223   clang
i386                  randconfig-012-20240222   clang
i386                  randconfig-013-20240223   clang
i386                  randconfig-014-20240223   clang
i386                  randconfig-015-20240222   clang
i386                  randconfig-015-20240223   clang
i386                  randconfig-016-20240223   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240222   gcc  
loongarch             randconfig-001-20240223   gcc  
loongarch             randconfig-002-20240222   gcc  
loongarch             randconfig-002-20240223   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath79_defconfig   gcc  
nios2                         10m50_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240222   gcc  
nios2                 randconfig-001-20240223   gcc  
nios2                 randconfig-002-20240222   gcc  
nios2                 randconfig-002-20240223   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           alldefconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240222   gcc  
parisc                randconfig-001-20240223   gcc  
parisc                randconfig-002-20240222   gcc  
parisc                randconfig-002-20240223   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     ep8248e_defconfig   gcc  
powerpc                 mpc8313_rdb_defconfig   gcc  
powerpc                      ppc64e_defconfig   gcc  
powerpc                      ppc6xx_defconfig   gcc  
powerpc                     tqm5200_defconfig   gcc  
powerpc                     tqm8540_defconfig   gcc  
powerpc                         wii_defconfig   gcc  
powerpc                 xes_mpc85xx_defconfig   gcc  
powerpc64             randconfig-001-20240223   gcc  
powerpc64             randconfig-002-20240223   gcc  
powerpc64             randconfig-003-20240222   gcc  
powerpc64             randconfig-003-20240223   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240223   gcc  
riscv                 randconfig-002-20240222   gcc  
riscv                 randconfig-002-20240223   gcc  
s390                             alldefconfig   gcc  
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240222   gcc  
s390                  randconfig-001-20240223   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                    randconfig-001-20240222   gcc  
sh                    randconfig-001-20240223   gcc  
sh                    randconfig-002-20240222   gcc  
sh                    randconfig-002-20240223   gcc  
sh                          sdk7780_defconfig   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           se7619_defconfig   gcc  
sh                           se7705_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240222   gcc  
sparc64               randconfig-001-20240223   gcc  
sparc64               randconfig-002-20240222   gcc  
sparc64               randconfig-002-20240223   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-002-20240223   gcc  
um                           x86_64_defconfig   clang
x86_64                           alldefconfig   gcc  
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-003-20240222   gcc  
x86_64       buildonly-randconfig-003-20240223   clang
x86_64       buildonly-randconfig-004-20240223   clang
x86_64       buildonly-randconfig-005-20240222   gcc  
x86_64       buildonly-randconfig-006-20240222   gcc  
x86_64       buildonly-randconfig-006-20240223   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-002-20240223   clang
x86_64                randconfig-005-20240222   gcc  
x86_64                randconfig-005-20240223   clang
x86_64                randconfig-006-20240222   gcc  
x86_64                randconfig-012-20240222   gcc  
x86_64                randconfig-013-20240223   clang
x86_64                randconfig-014-20240222   gcc  
x86_64                randconfig-015-20240223   clang
x86_64                randconfig-016-20240223   clang
x86_64                randconfig-074-20240222   gcc  
x86_64                randconfig-074-20240223   clang
x86_64                randconfig-075-20240222   gcc  
x86_64                randconfig-076-20240222   gcc  
x86_64                randconfig-076-20240223   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240222   gcc  
xtensa                randconfig-001-20240223   gcc  
xtensa                randconfig-002-20240222   gcc  
xtensa                randconfig-002-20240223   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

