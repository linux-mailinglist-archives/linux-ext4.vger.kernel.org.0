Return-Path: <linux-ext4+bounces-3033-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD5591CEDA
	for <lists+linux-ext4@lfdr.de>; Sat, 29 Jun 2024 21:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43D401F21C23
	for <lists+linux-ext4@lfdr.de>; Sat, 29 Jun 2024 19:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22703132112;
	Sat, 29 Jun 2024 19:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ysf1xD7m"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D36280046
	for <linux-ext4@vger.kernel.org>; Sat, 29 Jun 2024 19:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719689856; cv=none; b=hY3Dn9DHAduFEe7nDDmEbkT6v8hsvZysRAfwFUeSsGkduYrKlkc44VFB81qRAsfVuQFm/pYSllJoFNE/laDFltX6z+J1OkyuVJvfEnYoDXh+JpOQNp73q5TuMSUEMOQdc/C4RFLLjQfxpO1dqPrBfgn/5px7KPK7tWKPV60b+mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719689856; c=relaxed/simple;
	bh=LM7tlgKDO7kW+D/bcqrGzbqvleT0t6LoifWS21imoro=;
	h=Date:From:To:Cc:Subject:Message-ID; b=cPGkFc0rsQGkxpGI97rOf6NtpEXmyHwkGITFJat9VOajmbS/DiZXupTJp+njHO8tmP6nI5eH45M1xGuH8rt2IOFOyb9W+Dt2rLjURcWeaz6uG/w+spZqXIEMcZnHY6aujrYSgQbDVEMASGBkPAesvtlsduCu8HhEz/Xawi77vAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ysf1xD7m; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719689855; x=1751225855;
  h=date:from:to:cc:subject:message-id;
  bh=LM7tlgKDO7kW+D/bcqrGzbqvleT0t6LoifWS21imoro=;
  b=Ysf1xD7m8TbAIGDkjzGzl1bvKpP0vODxmi+bU6ZNrmQu7GsUZkQXrHMw
   x5J7U3nlHXe27i9gDIov6cZpWxJXQkLhAYIsZmouGKmrgeSV0frM340ar
   0lSC1CXN4SUEw4sFpAkHOzOTdQ82ieDisNjeB7Ymhl/rIyg/DtHI3sV67
   HYSFi4KpIVYrbOOqpbPUARFEvjoLnb8SHUXp1v4HTQ+W52/X/mjmgG/gu
   MVMwGZnpRdjMSGndnTLy++r3Bs/jl3E1X5YIgbJgvxm8UBenPiedDUNOg
   z+YA9Qc4owRKT2Y9zQZyvLV8k9pxPuKq9I0qsRmNiMbOBlc/bUGXl3s3o
   w==;
X-CSE-ConnectionGUID: qtycFp0YTgWTsLBiJr4Q4A==
X-CSE-MsgGUID: qnvtBJITSaiFHBGIGALSzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11118"; a="28242490"
X-IronPort-AV: E=Sophos;i="6.09,172,1716274800"; 
   d="scan'208";a="28242490"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2024 12:37:34 -0700
X-CSE-ConnectionGUID: D0UZmc3NTweNnAVJf9zujA==
X-CSE-MsgGUID: VewD6O0cRISvVgx36FIwxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,172,1716274800"; 
   d="scan'208";a="49963400"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 29 Jun 2024 12:37:32 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sNdt4-000KDg-26;
	Sat, 29 Jun 2024 19:37:30 +0000
Date: Sun, 30 Jun 2024 03:36:58 +0800
From: kernel test robot <lkp@intel.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 8262fe9a902c8a7b68c8521ebe18360a9145bada
Message-ID: <202406300356.19ONwXE1-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: 8262fe9a902c8a7b68c8521ebe18360a9145bada  ext4: make ext4_da_map_blocks() buffer_head unaware

elapsed time: 1548m

configs tested: 169
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                     haps_hs_smp_defconfig   gcc-13.2.0
arc                   randconfig-001-20240629   gcc-13.2.0
arc                   randconfig-002-20240629   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                       aspeed_g4_defconfig   clang-19
arm                                 defconfig   gcc-13.2.0
arm                       imx_v6_v7_defconfig   gcc-13.2.0
arm                             pxa_defconfig   clang-19
arm                   randconfig-001-20240629   gcc-13.2.0
arm                   randconfig-002-20240629   gcc-13.2.0
arm                   randconfig-003-20240629   gcc-13.2.0
arm                   randconfig-004-20240629   gcc-13.2.0
arm                         s3c6400_defconfig   clang-19
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240629   gcc-13.2.0
arm64                 randconfig-002-20240629   gcc-13.2.0
arm64                 randconfig-003-20240629   gcc-13.2.0
arm64                 randconfig-004-20240629   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240629   gcc-13.2.0
csky                  randconfig-002-20240629   gcc-13.2.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240629   gcc-7
i386         buildonly-randconfig-002-20240629   gcc-7
i386         buildonly-randconfig-003-20240629   gcc-7
i386         buildonly-randconfig-004-20240629   gcc-7
i386         buildonly-randconfig-005-20240629   gcc-7
i386         buildonly-randconfig-006-20240629   gcc-7
i386                                defconfig   clang-18
i386                  randconfig-001-20240629   gcc-7
i386                  randconfig-002-20240629   gcc-7
i386                  randconfig-003-20240629   gcc-7
i386                  randconfig-004-20240629   gcc-7
i386                  randconfig-005-20240629   gcc-7
i386                  randconfig-006-20240629   gcc-7
i386                  randconfig-011-20240629   gcc-7
i386                  randconfig-012-20240629   gcc-7
i386                  randconfig-013-20240629   gcc-7
i386                  randconfig-014-20240629   gcc-7
i386                  randconfig-015-20240629   gcc-7
i386                  randconfig-016-20240629   gcc-7
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240629   gcc-13.2.0
loongarch             randconfig-002-20240629   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                         apollo_defconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
m68k                           sun3_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                     decstation_defconfig   clang-19
mips                           ip32_defconfig   clang-19
mips                      maltasmvp_defconfig   gcc-13.2.0
mips                           xway_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240629   gcc-13.2.0
nios2                 randconfig-002-20240629   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                         allyesconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240629   gcc-13.2.0
parisc                randconfig-002-20240629   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                          allyesconfig   gcc-13.2.0
powerpc                 canyonlands_defconfig   gcc-13.2.0
powerpc                        icon_defconfig   clang-19
powerpc                     mpc512x_defconfig   clang-19
powerpc                 mpc836x_rdk_defconfig   clang-19
powerpc                     mpc83xx_defconfig   clang-19
powerpc                      pcm030_defconfig   clang-19
powerpc                      pmac32_defconfig   clang-19
powerpc               randconfig-001-20240629   gcc-13.2.0
powerpc               randconfig-002-20240629   gcc-13.2.0
powerpc               randconfig-003-20240629   gcc-13.2.0
powerpc                         wii_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240629   gcc-13.2.0
powerpc64             randconfig-002-20240629   gcc-13.2.0
powerpc64             randconfig-003-20240629   gcc-13.2.0
riscv                            allmodconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                            allyesconfig   gcc-13.2.0
riscv                               defconfig   gcc-13.2.0
riscv                 randconfig-001-20240629   gcc-13.2.0
riscv                 randconfig-002-20240629   gcc-13.2.0
s390                              allnoconfig   gcc-13.2.0
s390                                defconfig   clang-19
s390                                defconfig   gcc-13.2.0
s390                  randconfig-001-20240629   gcc-13.2.0
s390                  randconfig-002-20240629   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                         ap325rxa_defconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                         ecovec24_defconfig   gcc-13.2.0
sh                    randconfig-001-20240629   gcc-13.2.0
sh                    randconfig-002-20240629   gcc-13.2.0
sh                   rts7751r2dplus_defconfig   gcc-13.2.0
sh                           se7722_defconfig   gcc-13.2.0
sh                           se7724_defconfig   gcc-13.2.0
sh                             shx3_defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240629   gcc-13.2.0
sparc64               randconfig-002-20240629   gcc-13.2.0
um                                allnoconfig   gcc-13.2.0
um                                  defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-13.2.0
um                    randconfig-001-20240629   gcc-13.2.0
um                    randconfig-002-20240629   gcc-13.2.0
um                           x86_64_defconfig   gcc-13.2.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240629   clang-18
x86_64       buildonly-randconfig-002-20240629   clang-18
x86_64       buildonly-randconfig-003-20240629   clang-18
x86_64       buildonly-randconfig-004-20240629   clang-18
x86_64       buildonly-randconfig-005-20240629   clang-18
x86_64       buildonly-randconfig-006-20240629   clang-18
x86_64                              defconfig   clang-18
x86_64                                  kexec   clang-18
x86_64                randconfig-001-20240629   clang-18
x86_64                randconfig-002-20240629   clang-18
x86_64                randconfig-003-20240629   clang-18
x86_64                randconfig-004-20240629   clang-18
x86_64                randconfig-005-20240629   clang-18
x86_64                randconfig-006-20240629   clang-18
x86_64                randconfig-011-20240629   clang-18
x86_64                randconfig-012-20240629   clang-18
x86_64                randconfig-013-20240629   clang-18
x86_64                randconfig-014-20240629   clang-18
x86_64                randconfig-015-20240629   clang-18
x86_64                randconfig-016-20240629   clang-18
x86_64                randconfig-071-20240629   clang-18
x86_64                randconfig-072-20240629   clang-18
x86_64                randconfig-073-20240629   clang-18
x86_64                randconfig-074-20240629   clang-18
x86_64                randconfig-075-20240629   clang-18
x86_64                randconfig-076-20240629   clang-18
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                  cadence_csp_defconfig   gcc-13.2.0
xtensa                randconfig-001-20240629   gcc-13.2.0
xtensa                randconfig-002-20240629   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

