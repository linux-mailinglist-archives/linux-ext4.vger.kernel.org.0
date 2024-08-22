Return-Path: <linux-ext4+bounces-3837-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2298A95AADB
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 04:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B0C51F23A5F
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 02:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6222314277;
	Thu, 22 Aug 2024 02:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HTBOS/t7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8097479C8
	for <linux-ext4@vger.kernel.org>; Thu, 22 Aug 2024 02:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724292736; cv=none; b=XdJhi8u975Ibg8A/f+Rt1vVNCmCQrrlyj9qyxvmNhFuRsFmod5EoW2tDErXZTw2mkFnc7LCO9oo7O9zV5ZHkuU5EIdtbTftf1Dn1iHTfTjLNMu4GKfKrm+4sdU0w/10hMsfeqoKigoP6xt88j1jsruFOaKZV+Ul9lSBZ9+jZV/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724292736; c=relaxed/simple;
	bh=nr5ZtGeeSjDho/pwwoKpDLaUDHN5eWyYZwR3ledFvdQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mmAnMKldR0PpAJOksM+OD0qpeQi8/G0YW33AH4D+r1GmagWXxSdebb7/fOYd3T1F8rMEnsJt84mnLc5dtu4ofQQ6mTnClfarGwXzGcNdSfFQQp0yNpzM//HXVsBlJUtTrM2pmrjVFyluiUAtUHY/icx9/kTVP+l1CsYkfnnbneM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HTBOS/t7; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724292734; x=1755828734;
  h=date:from:to:cc:subject:message-id;
  bh=nr5ZtGeeSjDho/pwwoKpDLaUDHN5eWyYZwR3ledFvdQ=;
  b=HTBOS/t7cjsz3awNEMyWtbb98bLYtlrquEC+PtP/h7TtBRyy9tscAD73
   EdLUQfIjmFuYiWCGcwc0B1bdvJNwKRIiPxdSWIjsfYvzMuRORhI5XMTCJ
   /gUooHNjzLJBeffno5dl9+D9FkF6HveFNVCLoYJew47R+ny8Up6aENCSC
   S2Or1PpOfUK0JExzXWbNlokNUef8BA8mLDRHvgk/n1w5EpiqmBswTL3lj
   fcOyTicaDyaBpYLk8p77Zmy2MZpXF4QTpvAA33g/Alcck/soohG7wDsQW
   8CwEr2j9gpE6pVk4cMU4zFTYqEVpAYt0W+TDSIxR1O/0EtfPiFAzkscMN
   w==;
X-CSE-ConnectionGUID: 7TmNb+9zTwCooNSvE1a6Ow==
X-CSE-MsgGUID: fEkCN6wHQB2cA0zmZteC6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22295116"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="22295116"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 19:12:14 -0700
X-CSE-ConnectionGUID: qjAdEfRaTRGXr+1v+o7mrw==
X-CSE-MsgGUID: XknBycGCS1OrONuXv6ECyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="66231653"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 21 Aug 2024 19:12:13 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sgxJ4-000CAY-2I;
	Thu, 22 Aug 2024 02:12:10 +0000
Date: Thu, 22 Aug 2024 10:12:07 +0800
From: kernel test robot <lkp@intel.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 dd7895c6e4a71257be661bc76dfd8211ee27b9ba
Message-ID: <202408221005.LZMQsbND-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: dd7895c6e4a71257be661bc76dfd8211ee27b9ba  ext4: no need to continue when the number of entries is 1

elapsed time: 1311m

configs tested: 225
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240822   gcc-13.2.0
arc                   randconfig-002-20240822   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                            dove_defconfig   gcc-14.1.0
arm                          moxart_defconfig   gcc-14.1.0
arm                           omap1_defconfig   gcc-14.1.0
arm                   randconfig-001-20240822   gcc-13.2.0
arm                   randconfig-002-20240822   gcc-13.2.0
arm                   randconfig-003-20240822   gcc-13.2.0
arm                   randconfig-004-20240822   gcc-13.2.0
arm64                            allmodconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240822   gcc-13.2.0
arm64                 randconfig-002-20240822   gcc-13.2.0
arm64                 randconfig-003-20240822   gcc-13.2.0
arm64                 randconfig-004-20240822   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240822   gcc-13.2.0
csky                  randconfig-002-20240822   gcc-13.2.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240821   gcc-12
i386         buildonly-randconfig-001-20240822   gcc-12
i386         buildonly-randconfig-002-20240821   clang-18
i386         buildonly-randconfig-002-20240821   gcc-12
i386         buildonly-randconfig-002-20240822   gcc-12
i386         buildonly-randconfig-003-20240821   clang-18
i386         buildonly-randconfig-003-20240821   gcc-12
i386         buildonly-randconfig-003-20240822   gcc-12
i386         buildonly-randconfig-004-20240821   gcc-12
i386         buildonly-randconfig-004-20240822   gcc-12
i386         buildonly-randconfig-005-20240821   gcc-12
i386         buildonly-randconfig-005-20240822   gcc-12
i386         buildonly-randconfig-006-20240821   gcc-12
i386         buildonly-randconfig-006-20240822   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240821   clang-18
i386                  randconfig-001-20240821   gcc-12
i386                  randconfig-001-20240822   gcc-12
i386                  randconfig-002-20240821   gcc-12
i386                  randconfig-002-20240822   gcc-12
i386                  randconfig-003-20240821   clang-18
i386                  randconfig-003-20240821   gcc-12
i386                  randconfig-003-20240822   gcc-12
i386                  randconfig-004-20240821   gcc-12
i386                  randconfig-004-20240822   gcc-12
i386                  randconfig-005-20240821   clang-18
i386                  randconfig-005-20240821   gcc-12
i386                  randconfig-005-20240822   gcc-12
i386                  randconfig-006-20240821   gcc-12
i386                  randconfig-006-20240822   gcc-12
i386                  randconfig-011-20240821   gcc-11
i386                  randconfig-011-20240821   gcc-12
i386                  randconfig-011-20240822   gcc-12
i386                  randconfig-012-20240821   gcc-12
i386                  randconfig-012-20240822   gcc-12
i386                  randconfig-013-20240821   clang-18
i386                  randconfig-013-20240821   gcc-12
i386                  randconfig-013-20240822   gcc-12
i386                  randconfig-014-20240821   clang-18
i386                  randconfig-014-20240821   gcc-12
i386                  randconfig-014-20240822   gcc-12
i386                  randconfig-015-20240821   gcc-12
i386                  randconfig-015-20240822   gcc-12
i386                  randconfig-016-20240821   gcc-12
i386                  randconfig-016-20240822   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240822   gcc-13.2.0
loongarch             randconfig-002-20240822   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                         apollo_defconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                          sun3x_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                          ath25_defconfig   gcc-14.1.0
mips                        bcm47xx_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240822   gcc-13.2.0
nios2                 randconfig-002-20240822   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240822   gcc-13.2.0
parisc                randconfig-002-20240822   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                    gamecube_defconfig   gcc-14.1.0
powerpc                     kmeter1_defconfig   gcc-14.1.0
powerpc                 mpc836x_rdk_defconfig   gcc-14.1.0
powerpc                     mpc83xx_defconfig   gcc-14.1.0
powerpc64             randconfig-001-20240822   gcc-13.2.0
powerpc64             randconfig-002-20240822   gcc-13.2.0
powerpc64             randconfig-003-20240822   gcc-13.2.0
riscv                            allmodconfig   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240822   gcc-13.2.0
riscv                 randconfig-002-20240822   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240822   gcc-13.2.0
s390                  randconfig-002-20240822   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                        dreamcast_defconfig   gcc-14.1.0
sh                          lboxre2_defconfig   gcc-14.1.0
sh                    randconfig-001-20240822   gcc-13.2.0
sh                    randconfig-002-20240822   gcc-13.2.0
sh                          rsk7269_defconfig   gcc-14.1.0
sh                          sdk7780_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240822   gcc-13.2.0
sparc64               randconfig-002-20240822   gcc-13.2.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-12
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240822   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240822   gcc-12
x86_64       buildonly-randconfig-002-20240822   clang-18
x86_64       buildonly-randconfig-002-20240822   gcc-12
x86_64       buildonly-randconfig-003-20240822   gcc-12
x86_64       buildonly-randconfig-004-20240822   gcc-12
x86_64       buildonly-randconfig-005-20240822   gcc-12
x86_64       buildonly-randconfig-006-20240822   clang-18
x86_64       buildonly-randconfig-006-20240822   gcc-12
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240822   clang-18
x86_64                randconfig-001-20240822   gcc-12
x86_64                randconfig-002-20240822   clang-18
x86_64                randconfig-002-20240822   gcc-12
x86_64                randconfig-003-20240822   gcc-12
x86_64                randconfig-004-20240822   clang-18
x86_64                randconfig-004-20240822   gcc-12
x86_64                randconfig-005-20240822   gcc-12
x86_64                randconfig-006-20240822   gcc-12
x86_64                randconfig-011-20240822   gcc-12
x86_64                randconfig-012-20240822   clang-18
x86_64                randconfig-012-20240822   gcc-12
x86_64                randconfig-013-20240822   gcc-12
x86_64                randconfig-014-20240822   clang-18
x86_64                randconfig-014-20240822   gcc-12
x86_64                randconfig-015-20240822   clang-18
x86_64                randconfig-015-20240822   gcc-12
x86_64                randconfig-016-20240822   gcc-12
x86_64                randconfig-071-20240822   clang-18
x86_64                randconfig-071-20240822   gcc-12
x86_64                randconfig-072-20240822   clang-18
x86_64                randconfig-072-20240822   gcc-12
x86_64                randconfig-073-20240822   gcc-12
x86_64                randconfig-074-20240822   gcc-12
x86_64                randconfig-075-20240822   gcc-12
x86_64                randconfig-076-20240822   clang-18
x86_64                randconfig-076-20240822   gcc-12
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240822   gcc-13.2.0
xtensa                randconfig-002-20240822   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

