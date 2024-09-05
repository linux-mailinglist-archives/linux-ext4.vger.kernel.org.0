Return-Path: <linux-ext4+bounces-4058-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A7C96D62E
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Sep 2024 12:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F85D1C21D95
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Sep 2024 10:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEBF198A31;
	Thu,  5 Sep 2024 10:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SAjDecM2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EB71898F4
	for <linux-ext4@vger.kernel.org>; Thu,  5 Sep 2024 10:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725532437; cv=none; b=rJZSLrliRiO5XgJgdHaP973Cx1jFoXAV79Risa+ewAff6bvIAcboMkFsGt/LMwUsHUJw7TNLQTSpzVBAPtN423JQTAIlthBLU20tqRwjzVO56oVQnSAcII+7FEtfYN/cI1wUT3bSfM3aabo06VhLKlZAsNFEVdhsOpqpXGFBrlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725532437; c=relaxed/simple;
	bh=60ZhP3oe9e6llR99Wupi81P0/r8j+P8ikFc6s9+9wc0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ksnQwPOs3akHOeIEaD0HPmu7TxiRXZ+pTL5V2qm5wug8SPjqoEo1QqADKkSccqHJVLiYzB2XY1O8qpSUrhFz6+rCqPbsbV6Q9ks5ZZI1sX83DgU8R8GBoaxu6YtRChqTDUfX6Fu5TughaL/I17PUQVKfAHQG+GDOZ0lerp4cPWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SAjDecM2; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725532435; x=1757068435;
  h=date:from:to:cc:subject:message-id;
  bh=60ZhP3oe9e6llR99Wupi81P0/r8j+P8ikFc6s9+9wc0=;
  b=SAjDecM2NPGwRDCRK14S8Xl1c6bfqBC/X3mZ4wG6/BU+zmyNVEvXFHRr
   ZPe7cv5ipFy6oQPTgQzJDu0kDk3zPpr91rvc37aXULx7IwJS5zIxLyGKx
   p9TVds7XWJi7iJm6EY4ZXXKCKIYb7DnO5Dw3wG/pF74jWRryTM/D+Qoji
   c8JI/Dgv5396BfxniECx6cbRmBgnOueZVv78EBeejS6dfMsEZ+yub1IxZ
   soszQ76fv3b2+dOv0p2SMhCvsdT9G3cSEhJFLZo73k4WbJXnTtcI+4xLI
   n/7r/76Skfc98Ks617i6g3GcL/7TOMkdoW/hwc9HCqXqHL1PXXXsLvjWv
   w==;
X-CSE-ConnectionGUID: 1JUfpP0oSqujygGEt2jwjg==
X-CSE-MsgGUID: nLhSEggkQduHIpklOIEE9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="24385811"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="24385811"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 03:33:55 -0700
X-CSE-ConnectionGUID: 4vhf9AfNTc+FhSsSniiBIA==
X-CSE-MsgGUID: 35odVj7pQhycl7VoznLzKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="88827799"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 05 Sep 2024 03:33:53 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sm9oF-0009fe-2T;
	Thu, 05 Sep 2024 10:33:51 +0000
Date: Thu, 05 Sep 2024 18:33:23 +0800
From: kernel test robot <lkp@intel.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 ff2beee206d23f49d022650122f81285849033e4
Message-ID: <202409051821.nFOiSXI3-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: ff2beee206d23f49d022650122f81285849033e4  ext4: convert EXT4_B2C(sbi->s_stripe) users to EXT4_NUM_B2C

elapsed time: 1922m

configs tested: 149
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   clang-20
alpha                               defconfig   gcc-14.1.0
arc                              allmodconfig   clang-20
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   clang-20
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-14.1.0
arc                   randconfig-001-20240905   gcc-13.2.0
arc                   randconfig-002-20240905   gcc-13.2.0
arm                              allmodconfig   clang-20
arm                               allnoconfig   clang-20
arm                              allyesconfig   clang-20
arm                                 defconfig   gcc-14.1.0
arm                   randconfig-001-20240905   clang-14
arm                   randconfig-002-20240905   clang-20
arm                   randconfig-003-20240905   clang-20
arm                   randconfig-004-20240905   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240905   clang-20
arm64                 randconfig-002-20240905   gcc-14.1.0
arm64                 randconfig-003-20240905   clang-20
arm64                 randconfig-004-20240905   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240905   gcc-14.1.0
csky                  randconfig-002-20240905   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
hexagon               randconfig-001-20240905   clang-20
hexagon               randconfig-002-20240905   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240905   clang-18
i386         buildonly-randconfig-001-20240905   gcc-12
i386         buildonly-randconfig-002-20240905   gcc-12
i386         buildonly-randconfig-003-20240905   gcc-12
i386         buildonly-randconfig-004-20240905   clang-18
i386         buildonly-randconfig-004-20240905   gcc-12
i386         buildonly-randconfig-005-20240905   clang-18
i386         buildonly-randconfig-005-20240905   gcc-12
i386         buildonly-randconfig-006-20240905   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240905   gcc-12
i386                  randconfig-002-20240905   clang-18
i386                  randconfig-002-20240905   gcc-12
i386                  randconfig-003-20240905   gcc-12
i386                  randconfig-004-20240905   gcc-11
i386                  randconfig-004-20240905   gcc-12
i386                  randconfig-005-20240905   gcc-12
i386                  randconfig-006-20240905   gcc-12
i386                  randconfig-011-20240905   clang-18
i386                  randconfig-011-20240905   gcc-12
i386                  randconfig-012-20240905   clang-18
i386                  randconfig-012-20240905   gcc-12
i386                  randconfig-013-20240905   gcc-12
i386                  randconfig-014-20240905   clang-18
i386                  randconfig-014-20240905   gcc-12
i386                  randconfig-015-20240905   clang-18
i386                  randconfig-015-20240905   gcc-12
i386                  randconfig-016-20240905   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240905   gcc-14.1.0
loongarch             randconfig-002-20240905   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
nios2                 randconfig-001-20240905   gcc-14.1.0
nios2                 randconfig-002-20240905   gcc-14.1.0
openrisc                          allnoconfig   clang-20
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
parisc                            allnoconfig   clang-20
parisc                            allnoconfig   gcc-14.1.0
parisc                randconfig-001-20240905   gcc-14.1.0
parisc                randconfig-002-20240905   gcc-14.1.0
parisc64                            defconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                           allnoconfig   gcc-14.1.0
powerpc               randconfig-002-20240905   clang-20
powerpc64             randconfig-001-20240905   gcc-14.1.0
powerpc64             randconfig-002-20240905   gcc-14.1.0
powerpc64             randconfig-003-20240905   clang-20
riscv                             allnoconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                 randconfig-001-20240905   gcc-14.1.0
riscv                 randconfig-002-20240905   clang-20
s390                             allmodconfig   clang-20
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                  randconfig-001-20240905   clang-20
s390                  randconfig-002-20240905   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                    randconfig-001-20240905   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240905   gcc-12
x86_64       buildonly-randconfig-002-20240905   clang-18
x86_64       buildonly-randconfig-003-20240905   gcc-12
x86_64       buildonly-randconfig-004-20240905   clang-18
x86_64       buildonly-randconfig-005-20240905   clang-18
x86_64       buildonly-randconfig-006-20240905   gcc-12
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                                  kexec   gcc-12
x86_64                randconfig-001-20240905   clang-18
x86_64                randconfig-002-20240905   gcc-12
x86_64                randconfig-003-20240905   clang-18
x86_64                randconfig-004-20240905   gcc-12
x86_64                randconfig-005-20240905   clang-18
x86_64                randconfig-006-20240905   clang-18
x86_64                randconfig-011-20240905   gcc-12
x86_64                randconfig-012-20240905   gcc-12
x86_64                randconfig-013-20240905   clang-18
x86_64                randconfig-014-20240905   clang-18
x86_64                randconfig-015-20240905   gcc-12
x86_64                randconfig-016-20240905   gcc-12
x86_64                randconfig-071-20240905   clang-18
x86_64                randconfig-072-20240905   gcc-11
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   gcc-12
xtensa                            allnoconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

