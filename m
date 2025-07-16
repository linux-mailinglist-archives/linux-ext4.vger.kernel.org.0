Return-Path: <linux-ext4+bounces-9017-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61261B06B59
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Jul 2025 03:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 808D67B2704
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Jul 2025 01:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9689A27144B;
	Wed, 16 Jul 2025 01:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RLw15mJf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E7E2AE8E
	for <linux-ext4@vger.kernel.org>; Wed, 16 Jul 2025 01:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752631087; cv=none; b=MidMYLddtGXqrbsZkNQyRZZagOpjyvhy8tx5Jz9ZSJI9X0qJD4zICU8AbS4ktk/VOm6j824TUjoqPDQtOGPwjig5K4cNK1lr1hfx6RndZaTNczENAUGLqTouxh7JNAbZyCK/AZOnRevcUAEvmsvZ8FZ1VeE6h2nc9ECbpQvLI6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752631087; c=relaxed/simple;
	bh=JYOa74J0jcFoSFn846dxHIjFl3N3wedaJhvVxkG2FmI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KUzm+ULKQqsUayr8C3KuiB+/kRVI24CR7f68/h8TJNzh7a1DJAjA0W2xEVNlKueP0WI7HlxeTjYZE3CEr/OLQ2Znr/R71Seme5yZ2bTupdpf3NifWIQwV+59h5mJ+gz9W2QnsPHy/vu5OHQgNEjJDCMSTjlQ9BWZ+bUK7ruwSJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RLw15mJf; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752631085; x=1784167085;
  h=date:from:to:cc:subject:message-id;
  bh=JYOa74J0jcFoSFn846dxHIjFl3N3wedaJhvVxkG2FmI=;
  b=RLw15mJfLTu89Ulpd5fgCLHmijyiqyV/ys/Qf3obv3UuNmgxjBT+u8/B
   68HkDAZv4mW18e8zuEhLeecHRYzM+RDRFw3Pg6/QyuewG/xsdf4O12n2T
   12Xlyl4esSGg5TD8waypYCgqiAqmlqGWzsEvxcye4g9pmtbhOaAnDokZh
   RJJQEapEhcqDatNkW9Qmib5HLJ/un+4orsY/2qzz7r9ldKLsVZHAVgXcc
   L90lv7hfdYL7snRAGWvW9HWYVpROdJ4K3Y+9o2xYzRM3M1il1mlnWTG4N
   c4C6hXfJiQO/ZCm9iEZSk3P3UI04EtFXllsaKqx5SDxGcnVb8kXzncUWi
   A==;
X-CSE-ConnectionGUID: U6KOIAiQQv21NtvjOXhdnw==
X-CSE-MsgGUID: yhLJPjRaSuSidQ9583+npw==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="72439243"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="72439243"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 18:58:03 -0700
X-CSE-ConnectionGUID: LEr96nSUS0aYc1Oi1a7WnA==
X-CSE-MsgGUID: YktF5VuwSL6kxVbPdcuqsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="161694208"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 15 Jul 2025 18:58:01 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ubrPD-000Blp-1k;
	Wed, 16 Jul 2025 01:57:59 +0000
Date: Wed, 16 Jul 2025 09:57:12 +0800
From: kernel test robot <lkp@intel.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 b12f423d598fd874df9ecfb2436789d582fda8e6
Message-ID: <202507160959.8qjnmlS3-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: b12f423d598fd874df9ecfb2436789d582fda8e6  ext4: limit the maximum folio order

elapsed time: 1267m

configs tested: 244
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20250715    gcc-8.5.0
arc                   randconfig-001-20250716    clang-21
arc                   randconfig-002-20250715    gcc-11.5.0
arc                   randconfig-002-20250716    clang-21
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                         bcm2835_defconfig    clang-21
arm                                 defconfig    clang-19
arm                   randconfig-001-20250715    clang-21
arm                   randconfig-001-20250716    clang-21
arm                   randconfig-002-20250715    gcc-10.5.0
arm                   randconfig-002-20250716    clang-21
arm                   randconfig-003-20250715    clang-21
arm                   randconfig-003-20250716    clang-21
arm                   randconfig-004-20250715    gcc-12.4.0
arm                   randconfig-004-20250716    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250715    clang-16
arm64                 randconfig-001-20250716    clang-21
arm64                 randconfig-002-20250715    gcc-12.3.0
arm64                 randconfig-002-20250716    clang-21
arm64                 randconfig-003-20250715    gcc-8.5.0
arm64                 randconfig-003-20250716    clang-21
arm64                 randconfig-004-20250715    clang-21
arm64                 randconfig-004-20250716    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250715    gcc-9.3.0
csky                  randconfig-001-20250716    gcc-15.1.0
csky                  randconfig-002-20250715    gcc-12.4.0
csky                  randconfig-002-20250716    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250715    clang-18
hexagon               randconfig-001-20250716    gcc-15.1.0
hexagon               randconfig-002-20250715    clang-21
hexagon               randconfig-002-20250716    gcc-15.1.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250715    gcc-12
i386        buildonly-randconfig-001-20250716    gcc-12
i386        buildonly-randconfig-002-20250715    gcc-12
i386        buildonly-randconfig-002-20250716    gcc-12
i386        buildonly-randconfig-003-20250715    gcc-12
i386        buildonly-randconfig-003-20250716    gcc-12
i386        buildonly-randconfig-004-20250715    clang-20
i386        buildonly-randconfig-004-20250716    gcc-12
i386        buildonly-randconfig-005-20250715    clang-20
i386        buildonly-randconfig-005-20250716    gcc-12
i386        buildonly-randconfig-006-20250715    clang-20
i386        buildonly-randconfig-006-20250716    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250716    clang-20
i386                  randconfig-002-20250716    clang-20
i386                  randconfig-003-20250716    clang-20
i386                  randconfig-004-20250716    clang-20
i386                  randconfig-005-20250716    clang-20
i386                  randconfig-006-20250716    clang-20
i386                  randconfig-007-20250716    clang-20
i386                  randconfig-011-20250716    gcc-12
i386                  randconfig-012-20250716    gcc-12
i386                  randconfig-013-20250716    gcc-12
i386                  randconfig-014-20250716    gcc-12
i386                  randconfig-015-20250716    gcc-12
i386                  randconfig-016-20250716    gcc-12
i386                  randconfig-017-20250716    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250715    clang-21
loongarch             randconfig-001-20250716    gcc-15.1.0
loongarch             randconfig-002-20250715    gcc-15.1.0
loongarch             randconfig-002-20250716    gcc-15.1.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                         amcore_defconfig    clang-21
m68k                                defconfig    clang-19
m68k                        m5407c3_defconfig    clang-21
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        maltaup_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-14.2.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250715    gcc-11.5.0
nios2                 randconfig-001-20250716    gcc-15.1.0
nios2                 randconfig-002-20250715    gcc-8.5.0
nios2                 randconfig-002-20250716    gcc-15.1.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250715    gcc-10.5.0
parisc                randconfig-001-20250716    gcc-15.1.0
parisc                randconfig-002-20250715    gcc-9.3.0
parisc                randconfig-002-20250716    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-15.1.0
powerpc                   bluestone_defconfig    clang-21
powerpc                   currituck_defconfig    clang-21
powerpc               randconfig-001-20250715    clang-21
powerpc               randconfig-001-20250716    gcc-15.1.0
powerpc               randconfig-002-20250715    clang-21
powerpc               randconfig-002-20250716    gcc-15.1.0
powerpc               randconfig-003-20250715    gcc-8.5.0
powerpc               randconfig-003-20250716    gcc-15.1.0
powerpc                     stx_gp3_defconfig    clang-21
powerpc64             randconfig-001-20250715    clang-21
powerpc64             randconfig-001-20250716    gcc-15.1.0
powerpc64             randconfig-003-20250715    clang-17
powerpc64             randconfig-003-20250716    gcc-15.1.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250715    clang-21
riscv                 randconfig-001-20250716    gcc-9.3.0
riscv                 randconfig-002-20250715    clang-21
riscv                 randconfig-002-20250716    gcc-9.3.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250715    gcc-8.5.0
s390                  randconfig-001-20250716    gcc-9.3.0
s390                  randconfig-002-20250715    gcc-12.4.0
s390                  randconfig-002-20250716    gcc-9.3.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                ecovec24-romimage_defconfig    clang-21
sh                    randconfig-001-20250715    gcc-11.5.0
sh                    randconfig-001-20250716    gcc-9.3.0
sh                    randconfig-002-20250715    gcc-15.1.0
sh                    randconfig-002-20250716    gcc-9.3.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250715    gcc-8.5.0
sparc                 randconfig-001-20250716    gcc-9.3.0
sparc                 randconfig-002-20250715    gcc-8.5.0
sparc                 randconfig-002-20250716    gcc-9.3.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250715    clang-20
sparc64               randconfig-001-20250716    gcc-9.3.0
sparc64               randconfig-002-20250715    gcc-8.5.0
sparc64               randconfig-002-20250716    gcc-9.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250715    gcc-12
um                    randconfig-001-20250716    gcc-9.3.0
um                    randconfig-002-20250715    gcc-12
um                    randconfig-002-20250716    gcc-9.3.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250715    clang-20
x86_64      buildonly-randconfig-001-20250716    clang-20
x86_64      buildonly-randconfig-002-20250715    gcc-12
x86_64      buildonly-randconfig-002-20250716    clang-20
x86_64      buildonly-randconfig-003-20250715    gcc-12
x86_64      buildonly-randconfig-003-20250716    clang-20
x86_64      buildonly-randconfig-004-20250715    gcc-11
x86_64      buildonly-randconfig-004-20250716    clang-20
x86_64      buildonly-randconfig-005-20250715    gcc-12
x86_64      buildonly-randconfig-005-20250716    clang-20
x86_64      buildonly-randconfig-006-20250715    gcc-12
x86_64      buildonly-randconfig-006-20250716    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250716    clang-20
x86_64                randconfig-002-20250716    clang-20
x86_64                randconfig-003-20250716    clang-20
x86_64                randconfig-004-20250716    clang-20
x86_64                randconfig-005-20250716    clang-20
x86_64                randconfig-006-20250716    clang-20
x86_64                randconfig-007-20250716    clang-20
x86_64                randconfig-008-20250716    clang-20
x86_64                randconfig-071-20250716    gcc-12
x86_64                randconfig-072-20250716    gcc-12
x86_64                randconfig-073-20250716    gcc-12
x86_64                randconfig-074-20250716    gcc-12
x86_64                randconfig-075-20250716    gcc-12
x86_64                randconfig-076-20250716    gcc-12
x86_64                randconfig-077-20250716    gcc-12
x86_64                randconfig-078-20250716    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250715    gcc-8.5.0
xtensa                randconfig-001-20250716    gcc-9.3.0
xtensa                randconfig-002-20250715    gcc-14.3.0
xtensa                randconfig-002-20250716    gcc-9.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

