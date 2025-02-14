Return-Path: <linux-ext4+bounces-6457-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A81A356BC
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Feb 2025 07:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 647293A328F
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Feb 2025 06:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CC11DB92A;
	Fri, 14 Feb 2025 06:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JoKC7JaO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACCA18952C
	for <linux-ext4@vger.kernel.org>; Fri, 14 Feb 2025 06:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739513307; cv=none; b=PKhmi1fJZRxRpiZaHBEkEqYxT/33m+0wEvCHs0dGvsDtcguFwxVqJEYVQfitpui7axiAPsic8rlKz5F/wLCYSaKEwwb93HZxn/xLiio8ZNS7vy2bWW8r75FrNIHRC4D99tFO3wWAjduqdLcmCbwGwM5OVDi5bIi2RLXpZFPLnkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739513307; c=relaxed/simple;
	bh=VG1G45HgWwGdqTuVIzLNZpNxm8elV3kPUEI/LsNAzx0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=nCQ9iZrFNyxShDf9WK4igqAX9EMDwd0b6qpc/wQNVK//z9X6ozQhT/mThS+MAxliwUENywUzX4ZVh7beaAZqcPDKShgpTeTNBiIpD4KlPbARW5zzos/7PGovqWUOsmmJTxiVBGevvoOZ7FkOQqMwqHNOyD/Km3gNNdL90h2rS80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JoKC7JaO; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739513306; x=1771049306;
  h=date:from:to:cc:subject:message-id;
  bh=VG1G45HgWwGdqTuVIzLNZpNxm8elV3kPUEI/LsNAzx0=;
  b=JoKC7JaOLWRC0N6eLhB7FCmXwdUPQmHSyP7MSfJOOTNrXxfs15RsfwQA
   h2rxK68UIBC94QqqA687IfvhaQsFvUu/DbQUf2vKbi6rzRBYikLUu80Pt
   Q4vOKm14jipXmMa5SXlJM1W0o6k/Xt1lPIbfcKCf9qt+rDmN/1u1O0w7v
   YF3IBWN4mh2quOzGu0be0lDtggfZSA8wkohcMY+3UlPAMmWrtj6qiBtk/
   4ZYvxQR/AjcGB3yWLzU4MPCPHplrwuh7xVgTFpFZOZ4EMrlLxR6ny4f2C
   +0sN9/6kWBr7vjMcgc0/rTJ9RwSwhmOT7GWQ1CaqtvmvFXuEqUOdUC5B6
   w==;
X-CSE-ConnectionGUID: zwGfNx3eQ12njvZ3rixebw==
X-CSE-MsgGUID: 0d/X15p2Ta+Www2+pRJxrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="27852777"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="27852777"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 22:08:25 -0800
X-CSE-ConnectionGUID: nvVvbqv4RZea0JP+5XGYYA==
X-CSE-MsgGUID: s2WOGxYnR3u1YLwts52I3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117506189"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 13 Feb 2025 22:08:24 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tiosA-00198Z-0t;
	Fri, 14 Feb 2025 06:08:22 +0000
Date: Fri, 14 Feb 2025 14:08:01 +0800
From: kernel test robot <lkp@intel.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD REGRESSION
 ab00acfcfc62ade16f642841d8807816b27b8944
Message-ID: <202502141454.ENyUojaF-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: ab00acfcfc62ade16f642841d8807816b27b8944  ext4: introduce linear search for dentries

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202502131639.HjJlsWin-lkp@intel.com

    include/linux/fs.h:1268:12: error: 'struct super_block' has no member named 's_encoding_flags'

Error/Warning ids grouped by kconfigs:

recent_errors
|-- powerpc-amigaone_defconfig
|   `-- include-linux-fs.h:error:struct-super_block-has-no-member-named-s_encoding_flags
|-- sh-ap325rxa_defconfig
|   `-- include-linux-fs.h:error:struct-super_block-has-no-member-named-s_encoding_flags
|-- sh-magicpanelr2_defconfig
|   `-- include-linux-fs.h:error:struct-super_block-has-no-member-named-s_encoding_flags
|-- x86_64-buildonly-randconfig-002-20250213
|   `-- include-linux-fs.h:error:struct-super_block-has-no-member-named-s_encoding_flags
`-- x86_64-defconfig
    `-- include-linux-fs.h:error:struct-super_block-has-no-member-named-s_encoding_flags

elapsed time: 1445m

configs tested: 117
configs skipped: 5

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                     haps_hs_smp_defconfig    gcc-13.2.0
arc                   randconfig-001-20250213    gcc-13.2.0
arc                   randconfig-002-20250213    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                         lpc18xx_defconfig    clang-19
arm                       netwinder_defconfig    gcc-14.2.0
arm                         orion5x_defconfig    clang-21
arm                   randconfig-001-20250213    clang-17
arm                   randconfig-002-20250213    clang-15
arm                   randconfig-003-20250213    clang-21
arm                   randconfig-004-20250213    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250213    clang-19
arm64                 randconfig-002-20250213    gcc-14.2.0
arm64                 randconfig-003-20250213    gcc-14.2.0
arm64                 randconfig-004-20250213    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250213    gcc-14.2.0
csky                  randconfig-002-20250213    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250213    clang-21
hexagon               randconfig-002-20250213    clang-18
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250213    gcc-12
i386        buildonly-randconfig-002-20250213    clang-19
i386        buildonly-randconfig-003-20250213    clang-19
i386        buildonly-randconfig-004-20250213    clang-19
i386        buildonly-randconfig-005-20250213    clang-19
i386        buildonly-randconfig-006-20250213    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250213    gcc-14.2.0
loongarch             randconfig-002-20250213    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        bcm47xx_defconfig    clang-21
mips                        maltaup_defconfig    clang-21
mips                         rt305x_defconfig    clang-19
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250213    gcc-14.2.0
nios2                 randconfig-002-20250213    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250213    gcc-14.2.0
parisc                randconfig-002-20250213    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                    amigaone_defconfig    gcc-14.2.0
powerpc                      pcm030_defconfig    clang-17
powerpc                     ppa8548_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250213    clang-17
powerpc               randconfig-002-20250213    gcc-14.2.0
powerpc               randconfig-003-20250213    gcc-14.2.0
powerpc                     tqm8541_defconfig    clang-15
powerpc64             randconfig-001-20250213    clang-19
powerpc64             randconfig-002-20250213    clang-21
powerpc64             randconfig-003-20250213    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250213    clang-19
riscv                 randconfig-002-20250213    clang-17
s390                              allnoconfig    clang-21
s390                  randconfig-001-20250213    gcc-14.2.0
s390                  randconfig-002-20250213    clang-21
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                         ap325rxa_defconfig    gcc-14.2.0
sh                     magicpanelr2_defconfig    gcc-14.2.0
sh                    randconfig-001-20250213    gcc-14.2.0
sh                    randconfig-002-20250213    gcc-14.2.0
sh                           se7751_defconfig    gcc-14.2.0
sh                            shmin_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250213    gcc-14.2.0
sparc                 randconfig-002-20250213    gcc-14.2.0
sparc64               randconfig-001-20250213    gcc-14.2.0
sparc64               randconfig-002-20250213    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250213    clang-19
um                    randconfig-002-20250213    clang-21
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250213    gcc-11
x86_64      buildonly-randconfig-002-20250213    gcc-12
x86_64      buildonly-randconfig-003-20250213    clang-19
x86_64      buildonly-randconfig-004-20250213    gcc-12
x86_64      buildonly-randconfig-005-20250213    gcc-12
x86_64      buildonly-randconfig-006-20250213    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250213    gcc-14.2.0
xtensa                randconfig-002-20250213    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

