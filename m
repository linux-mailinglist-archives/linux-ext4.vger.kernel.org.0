Return-Path: <linux-ext4+bounces-12119-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DE3C99F1E
	for <lists+linux-ext4@lfdr.de>; Tue, 02 Dec 2025 04:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5ACE34E214E
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Dec 2025 03:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BB725CC40;
	Tue,  2 Dec 2025 03:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e4QYmCyK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BD1125A0
	for <linux-ext4@vger.kernel.org>; Tue,  2 Dec 2025 03:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764645057; cv=none; b=cuAhkU2h4V3duAcF8iAowg4L2KEL7ul9SF0aBCOkWsPQflHpeUOLFgJJ1SBDnDIId4W9yLUxlMZDF9gZgTb28y2NOc0IfKML3UvYM03iAyiGwc0iK1v3S7gjdKFa7+hrCe4AcpOB5Arbb9NhIx8GC2pLLOAaQVvGg1O3TjETBvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764645057; c=relaxed/simple;
	bh=vaOBYte4fNsScWoJ0PbyPNn0QPj3euL+S8Xo+kN6qzQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SDVqX+3Zr6jYTPixnBa3Vju09riub3vucsexih8M35JHq/ETmNe1x0DNENbKiXQV2j3zUJ0cqokXNiXkQUjap05tlTGGMut0GrrGJ7GVyeqQQvq6z9zkH18XVRHMYb20hr42UL0y9CTBf1adNXVQ4d52OlNuvZ7vrbMx3FFeeJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e4QYmCyK; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764645056; x=1796181056;
  h=date:from:to:cc:subject:message-id;
  bh=vaOBYte4fNsScWoJ0PbyPNn0QPj3euL+S8Xo+kN6qzQ=;
  b=e4QYmCyK4CeN6cQKDdL8x50+xI7VYoJNbO91jxqYJ5t6JjF3cKYjGAe5
   N4bNW4BsWdHu2kQbj0OxUuABV/jLbsm95SfjDtH2WFNEi2FgvBma/L/rN
   IWDgP+hDk8MTmDR/3MQ+dfDjz6Js4lefc5E2I4sDLRQnHUI137ZbaiLMo
   S3v+U0tKdnFeRSPWVF3wy6xVycqdNxDD3U0No8EVLtCbzXTg3wmelkZPg
   wEdpM0rinPmj/hdx4Hlh1cZmYVfQ4G+9o8XTZ0GqY4nxJV0pmUqRu4RTI
   VJSRFjuwJxbCaxIkVkq4c+Inq9FLxk5x/SxHegeOr6x52mcz8k+1iVOOQ
   w==;
X-CSE-ConnectionGUID: jJGivaW9QfiBoenfKmV9WQ==
X-CSE-MsgGUID: h/qauCylTaidaoesmIwmfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="69192807"
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; 
   d="scan'208";a="69192807"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 19:10:55 -0800
X-CSE-ConnectionGUID: pvIgyVcSSTyKBhpwjcQoUw==
X-CSE-MsgGUID: Q5EQmJJlTOO5+NIOUjEJMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; 
   d="scan'208";a="194345835"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 01 Dec 2025 19:10:53 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vQGmw-000000009Mj-2tTq;
	Tue, 02 Dec 2025 03:10:50 +0000
Date: Tue, 02 Dec 2025 11:09:53 +0800
From: kernel test robot <lkp@intel.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 6fb67ac896900e60f46ee4efba97b372a80370e0
Message-ID: <202512021147.OSSg4EoG-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: 6fb67ac896900e60f46ee4efba97b372a80370e0  ext4: drop the TODO comment in ext4_es_insert_extent()

elapsed time: 1453m

configs tested: 164
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251201    gcc-13.4.0
arc                   randconfig-002-20251201    gcc-13.4.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                        neponset_defconfig    gcc-15.1.0
arm                   randconfig-001-20251201    clang-22
arm                   randconfig-002-20251201    gcc-8.5.0
arm                   randconfig-003-20251201    clang-20
arm                   randconfig-004-20251201    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251201    gcc-8.5.0
arm64                 randconfig-002-20251201    clang-22
arm64                 randconfig-003-20251201    clang-18
arm64                 randconfig-004-20251201    gcc-14.3.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251201    gcc-15.1.0
csky                  randconfig-002-20251201    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251201    clang-22
hexagon               randconfig-002-20251201    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251201    clang-20
i386        buildonly-randconfig-002-20251201    clang-20
i386        buildonly-randconfig-003-20251201    clang-20
i386        buildonly-randconfig-004-20251201    clang-20
i386        buildonly-randconfig-005-20251201    clang-20
i386        buildonly-randconfig-006-20251201    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20251201    gcc-14
i386                  randconfig-002-20251201    clang-20
i386                  randconfig-003-20251201    clang-20
i386                  randconfig-004-20251201    clang-20
i386                  randconfig-005-20251201    gcc-14
i386                  randconfig-006-20251201    gcc-14
i386                  randconfig-007-20251201    clang-20
i386                  randconfig-011-20251201    clang-20
i386                  randconfig-012-20251201    gcc-14
i386                  randconfig-013-20251201    clang-20
i386                  randconfig-014-20251201    gcc-14
i386                  randconfig-015-20251201    gcc-14
i386                  randconfig-016-20251201    gcc-14
i386                  randconfig-017-20251201    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251201    gcc-15.1.0
loongarch             randconfig-002-20251201    clang-18
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                           ip28_defconfig    gcc-15.1.0
mips                      maltaaprp_defconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251201    gcc-8.5.0
nios2                 randconfig-002-20251201    gcc-8.5.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
openrisc                    or1ksim_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251201    gcc-13.4.0
parisc                randconfig-002-20251201    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          g5_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251201    gcc-13.4.0
powerpc               randconfig-002-20251201    gcc-10.5.0
powerpc                      tqm8xx_defconfig    clang-19
powerpc64             randconfig-001-20251201    gcc-14.3.0
powerpc64             randconfig-002-20251201    gcc-13.4.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251201    clang-22
riscv                 randconfig-002-20251201    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251201    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251201    gcc-12.5.0
sh                    randconfig-002-20251201    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251201    gcc-8.5.0
sparc                 randconfig-002-20251201    gcc-14.3.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251201    clang-22
sparc64               randconfig-002-20251201    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251201    gcc-14
um                    randconfig-002-20251201    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251201    clang-20
x86_64      buildonly-randconfig-002-20251201    clang-20
x86_64      buildonly-randconfig-003-20251201    gcc-14
x86_64      buildonly-randconfig-004-20251201    gcc-14
x86_64      buildonly-randconfig-005-20251201    gcc-14
x86_64      buildonly-randconfig-006-20251201    gcc-12
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251201    gcc-14
x86_64                randconfig-002-20251201    clang-20
x86_64                randconfig-003-20251201    clang-20
x86_64                randconfig-004-20251201    clang-20
x86_64                randconfig-005-20251201    clang-20
x86_64                randconfig-006-20251201    clang-20
x86_64                randconfig-011-20251201    clang-20
x86_64                randconfig-012-20251201    gcc-14
x86_64                randconfig-013-20251201    gcc-14
x86_64                randconfig-014-20251201    gcc-14
x86_64                randconfig-015-20251201    clang-20
x86_64                randconfig-016-20251201    clang-20
x86_64                randconfig-071-20251201    gcc-12
x86_64                randconfig-072-20251201    gcc-14
x86_64                randconfig-073-20251201    gcc-14
x86_64                randconfig-074-20251201    gcc-14
x86_64                randconfig-075-20251201    gcc-12
x86_64                randconfig-076-20251201    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251201    gcc-9.5.0
xtensa                randconfig-002-20251201    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

