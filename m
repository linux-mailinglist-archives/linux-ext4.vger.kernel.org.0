Return-Path: <linux-ext4+bounces-2399-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 699AD8C0876
	for <lists+linux-ext4@lfdr.de>; Thu,  9 May 2024 02:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FC0C2813FF
	for <lists+linux-ext4@lfdr.de>; Thu,  9 May 2024 00:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0590C4A1E;
	Thu,  9 May 2024 00:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kwt/scO2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE3A1113
	for <linux-ext4@vger.kernel.org>; Thu,  9 May 2024 00:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715214591; cv=none; b=Vg2dXFjQBKnC3pfJt1j/ZRIoNzFPOxQYMvSOV3UtLfasrpCLLchaxkozPlYLN0pZIF+oenh13IDMUUJaGFFRRG1X+bV1sBJbrBIKocHPbbAt4VBuHMZ/h2lcPd8PzSC0SxPqkgY07RuPzS6cDg2oZvzZn4ImHR0giJk2jaBZNA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715214591; c=relaxed/simple;
	bh=X5hUiRIm05CZca5NkE8rT/NvAnjOa27dNxwEIhgzDLg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Wkv1tInLgRgroPYlftg/L8oLgn+Yl3WY+4NCYRq8xhEzmS6QOFM2xwL9mGGnw3HMYFBUQrH5okaq+SdkGm84rrQFpWJwgu18XA31DKG7sGvCpXXmQVTuJxOCtTdbZkUrmP91YrGE+uuQXTbdO8ipY9Euk/e6DYstV7y3Jpl25i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kwt/scO2; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715214590; x=1746750590;
  h=date:from:to:cc:subject:message-id;
  bh=X5hUiRIm05CZca5NkE8rT/NvAnjOa27dNxwEIhgzDLg=;
  b=Kwt/scO2gx/P9DurV6MTLPk2bevhbFmqIbLxw6jWjQspzGVw78zKBNXS
   6dCO5HRukShEmILAev9kA2QIyhi+jme51mo7qvOcnsIGxyLbCfS9JvrJc
   VonrqXuNFP91RosAle79PCHblAMQz/YE1M8eaEWPqFPz/+U1GBDEWoiwl
   tXX+z4s6EmvdO3NH6WDyiFgjYc3LWIqKvk1uDLwF7NyGLWKANdy51YSFA
   fXneQ/xsM3nY1JOli60aHATcgvkFWFmyiaV/Aez3m9bUpxN2I+Ri315Nx
   +/J7mZtPrkpw5YysfqgT9y9pBVWDeYtiH2PLrjkRi7SKBwQksAGBQvNfj
   w==;
X-CSE-ConnectionGUID: ejLm/59FSv6yL4DsYycKJQ==
X-CSE-MsgGUID: IGPved5VRiSkRAZ/kPULeQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="11321553"
X-IronPort-AV: E=Sophos;i="6.08,146,1712646000"; 
   d="scan'208";a="11321553"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 17:29:49 -0700
X-CSE-ConnectionGUID: IZ4DOjDjQEq1dFL5kZB1aQ==
X-CSE-MsgGUID: 0dtWOBQ8SDmtirGHozgtDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,146,1712646000"; 
   d="scan'208";a="29003882"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 08 May 2024 17:29:49 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s4rfO-0004GL-16;
	Thu, 09 May 2024 00:29:46 +0000
Date: Thu, 09 May 2024 08:29:21 +0800
From: kernel test robot <lkp@intel.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 dc1c4663bc493f323d6b2f9dd55c044ea920dacf
Message-ID: <202405090819.bei6uBvd-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: dc1c4663bc493f323d6b2f9dd55c044ea920dacf  ext4: propagate errors from ext4_sb_bread() in ext4_xattr_block_cache_find()

elapsed time: 1469m

configs tested: 143
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240508   gcc  
arc                   randconfig-002-20240508   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                         at91_dt_defconfig   clang
arm                                 defconfig   clang
arm                   milbeaut_m10v_defconfig   clang
arm                          pxa168_defconfig   clang
arm                   randconfig-001-20240508   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240508   gcc  
arm64                 randconfig-003-20240508   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240508   gcc  
csky                  randconfig-002-20240508   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240508   clang
i386         buildonly-randconfig-002-20240508   clang
i386         buildonly-randconfig-005-20240508   clang
i386                                defconfig   clang
i386                  randconfig-002-20240508   clang
i386                  randconfig-003-20240508   clang
i386                  randconfig-005-20240508   clang
i386                  randconfig-013-20240508   clang
i386                  randconfig-014-20240508   clang
i386                  randconfig-015-20240508   clang
i386                  randconfig-016-20240508   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240508   gcc  
loongarch             randconfig-002-20240508   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           mtx1_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240508   gcc  
nios2                 randconfig-002-20240508   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240508   gcc  
parisc                randconfig-002-20240508   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                   lite5200b_defconfig   clang
powerpc                       ppc64_defconfig   clang
powerpc               randconfig-002-20240508   gcc  
powerpc64             randconfig-001-20240508   gcc  
powerpc64             randconfig-002-20240508   gcc  
powerpc64             randconfig-003-20240508   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240508   gcc  
riscv                 randconfig-002-20240508   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-002-20240508   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240508   gcc  
sh                    randconfig-002-20240508   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240508   gcc  
sparc64               randconfig-002-20240508   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240508   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240508   clang
x86_64       buildonly-randconfig-002-20240508   clang
x86_64       buildonly-randconfig-003-20240508   clang
x86_64       buildonly-randconfig-004-20240508   clang
x86_64       buildonly-randconfig-006-20240508   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-002-20240508   clang
x86_64                randconfig-003-20240508   clang
x86_64                randconfig-011-20240508   clang
x86_64                randconfig-012-20240508   clang
x86_64                randconfig-015-20240508   clang
x86_64                randconfig-073-20240508   clang
x86_64                randconfig-076-20240508   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240508   gcc  
xtensa                randconfig-002-20240508   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

