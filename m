Return-Path: <linux-ext4+bounces-11905-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A45EC6C34D
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Nov 2025 02:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 44BBE34C296
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Nov 2025 00:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6095721FF55;
	Wed, 19 Nov 2025 00:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cmSn91Ln"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515AC3702E8
	for <linux-ext4@vger.kernel.org>; Wed, 19 Nov 2025 00:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763513980; cv=none; b=Juyqe5Fg/EorooDYjGgfkLo8eYjwgTzi8fot9LFKeM19mHlwTqyREGdIE6gCEUIoCOWUOvYSGvOx208GHZvoMoGmrlSFAcefAxfjccoHp3hCHvZGZfL55++Zkax9PSQH5gTF+KWXRqmgDqF3kxYOkiqqRA2AXHx4FF11li0Whto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763513980; c=relaxed/simple;
	bh=eMpZefpU13eMT2gpHmdq72z8g7EKpzIN7Wor8CfXC0Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=j9/KjdWzmPoHRRibvWEdFXd+Z/GgZPQsMoUsYj/qzgTIiIYTZHocghwTuyZwlNgWVYARFip4zuPSwJnfjl51REo6QYYIAwnFboBk9fqT2aCz8Sc8oLefivQYMmEESf18EKwPckcOKTiEE9xwV93GaysH0nMsdvV22Qk+kynGX4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cmSn91Ln; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763513978; x=1795049978;
  h=date:from:to:cc:subject:message-id;
  bh=eMpZefpU13eMT2gpHmdq72z8g7EKpzIN7Wor8CfXC0Q=;
  b=cmSn91LnvhZnUPG9akhLfkH62LWvKkuFDFFRv1L1yJtgko19jH523gyB
   hLcjoYShP204UCJMcSydeyhcFqzPuFD0DjkVwG8aOlEn1ogWmulnLg2/5
   eictORoqcNnojZ6DSi/uB39u2LrV7iRTfK1cdzuR1zP0ydGaxo7hb0yFO
   3mAZh6n+0QjtuWQ8MPtqo2n5zLdXH27sG2W2CkasBqEHW5MV9MD8C2hTs
   0oItXxnPHeAwx9d86yuE60sZ2fF1/fWYP7BlcZ9o/I50aIsm53aTWk04L
   i9k4meEZscux6Ia/7P2dD1V6HJVGnxtJHGbTIQG5qmgFDspDE3oDiybLG
   g==;
X-CSE-ConnectionGUID: s5ZsfofRT063pVBOZAQHww==
X-CSE-MsgGUID: PI6lgDVSTyyA2SoEy8U+sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="64553226"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="64553226"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 16:59:38 -0800
X-CSE-ConnectionGUID: tm3g/KDrR1a3ryOYf0KXHA==
X-CSE-MsgGUID: uOBlGCKHQyequeuAHEOB4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="190158021"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 18 Nov 2025 16:59:36 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vLWXm-0002Jn-1F;
	Wed, 19 Nov 2025 00:59:34 +0000
Date: Wed, 19 Nov 2025 08:58:42 +0800
From: kernel test robot <lkp@intel.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 103ce01cd045197461d654f62f1a30cabedbcad4
Message-ID: <202511190837.KdWXzHQo-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: 103ce01cd045197461d654f62f1a30cabedbcad4  ext4: add i_data_sem protection in ext4_destroy_inline_data_nolock()

elapsed time: 1770m

configs tested: 101
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20251118    gcc-14.3.0
arc                   randconfig-002-20251118    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                   randconfig-001-20251118    gcc-8.5.0
arm                   randconfig-002-20251118    gcc-10.5.0
arm                   randconfig-003-20251118    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251118    clang-20
arm64                 randconfig-002-20251118    clang-22
arm64                 randconfig-003-20251118    clang-19
arm64                 randconfig-004-20251118    clang-17
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251118    gcc-10.5.0
csky                  randconfig-002-20251118    gcc-15.1.0
hexagon                           allnoconfig    clang-22
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251119    gcc-14
i386        buildonly-randconfig-002-20251119    clang-20
i386        buildonly-randconfig-003-20251119    clang-20
i386        buildonly-randconfig-004-20251119    clang-20
i386        buildonly-randconfig-005-20251119    gcc-14
i386        buildonly-randconfig-006-20251119    gcc-14
i386                  randconfig-001-20251118    clang-20
i386                  randconfig-002-20251118    clang-20
i386                  randconfig-003-20251118    gcc-14
i386                  randconfig-004-20251118    gcc-14
i386                  randconfig-005-20251118    clang-20
i386                  randconfig-006-20251118    gcc-14
i386                  randconfig-007-20251118    gcc-14
i386                  randconfig-011-20251118    gcc-14
i386                  randconfig-012-20251118    gcc-12
i386                  randconfig-013-20251118    clang-20
i386                  randconfig-014-20251118    gcc-14
i386                  randconfig-015-20251118    gcc-14
i386                  randconfig-016-20251118    gcc-14
i386                  randconfig-017-20251118    clang-20
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                        m5272c3_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
microblaze                      mmu_defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                      bmips_stb_defconfig    clang-22
mips                   sb1250_swarm_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251118    gcc-14.3.0
parisc                randconfig-002-20251118    gcc-12.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20251118    clang-22
powerpc               randconfig-002-20251118    clang-22
powerpc                     tqm8560_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251118    gcc-13.4.0
powerpc64             randconfig-002-20251118    gcc-8.5.0
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251118    gcc-10.5.0
riscv                 randconfig-002-20251118    clang-22
s390                              allnoconfig    clang-22
s390                                defconfig    clang-22
s390                  randconfig-002-20251118    gcc-9.5.0
sh                                allnoconfig    gcc-15.1.0
sh                        apsh4ad0a_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                        edosk7760_defconfig    gcc-15.1.0
sh                             espt_defconfig    gcc-15.1.0
sh                    randconfig-001-20251118    gcc-11.5.0
sh                    randconfig-002-20251118    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc64                             defconfig    clang-20
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-071-20251118    gcc-13
x86_64                randconfig-072-20251118    clang-20
x86_64                randconfig-073-20251118    gcc-14
x86_64                randconfig-074-20251118    gcc-13
x86_64                randconfig-075-20251118    gcc-14
x86_64                randconfig-076-20251118    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
xtensa                            allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

