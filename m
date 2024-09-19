Return-Path: <linux-ext4+bounces-4216-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B038597C344
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Sep 2024 06:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D54951C21671
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Sep 2024 04:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414021400A;
	Thu, 19 Sep 2024 04:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="By+VLi2m"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CFC11711
	for <linux-ext4@vger.kernel.org>; Thu, 19 Sep 2024 04:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726719153; cv=none; b=Nz4P+y8NoQdjE/e47OYPpMKEJMS9Ctg2imufEA/NlMXaJx3EwnwnG5QHzPYTYAkvWBPdAOEWe1TBFHwDM0UW5pQYKJpaGY8B1fEjsNGcO0asbxmvmXrtgwlmehQQ+qcpiUdUwXPvaYWcqQrByY2P0gIdRA4gR9QPdbEJdxf5Dig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726719153; c=relaxed/simple;
	bh=bIxPMtaCjRppiyTU90T2VuR7DAIQIVIuG7wCb77Q5a0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Xtq4REJ3/pxVYly1Ikq//hShrbsD7V+ZREIjaggBS95zNAgsiEBid5xdGNXtAVzEOIaYmWnzPM8XZaGhNkiFnYzlhbQOiYbsg6GOOpS8tE3eER0/TOH+jd65jz/feq9v1SBOuZZa1+OyGfLEnIrUuALr67hdI5+AeHqO0JtQ/ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=By+VLi2m; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726719152; x=1758255152;
  h=date:from:to:cc:subject:message-id;
  bh=bIxPMtaCjRppiyTU90T2VuR7DAIQIVIuG7wCb77Q5a0=;
  b=By+VLi2mmTulKFl1Y7sh5k3GX+epsmNS5i0b8VpFU7la1P8JBEI1NIcP
   IbCrpApRXI6RbulKrvdrvIznIc7j01InILrNIR4GlO5rlAQ2bf2QbpjQM
   K/k6om1QkAI3Gixmg25g6q4gHxowrybNszvFDKILLIA02p0/pG3d10U0w
   0OpYYIgWdqY0zs41nA2QBMsHatEF0zQpB7Zk7pgPOQ1Q49Xev50hxl0A6
   pGv25yBFggwGtZROjBCEMrPa9C+cyRbQ70r4JoD5PEy2pmLui/P6jXBPn
   ldex5w46gqo8NJc7dQd3TTgVYoGdXHhJYZKQKJdsNyqOiGkAD+iQMItGV
   A==;
X-CSE-ConnectionGUID: sxLenSErQX2XjwEvpuByyw==
X-CSE-MsgGUID: ZqDrV2TQR2+B70p3AMkjmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="29558583"
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; 
   d="scan'208";a="29558583"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 21:12:10 -0700
X-CSE-ConnectionGUID: hcTUyAXHRLqQvhrtAfgq9Q==
X-CSE-MsgGUID: 3TLdjqM8TTCK5G5atnxsUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; 
   d="scan'208";a="93072218"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 18 Sep 2024 21:12:09 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sr8WV-000Csq-14;
	Thu, 19 Sep 2024 04:12:07 +0000
Date: Thu, 19 Sep 2024 12:11:18 +0800
From: kernel test robot <lkp@intel.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Subject: [tytso-ext4:test] BUILD SUCCESS
 16e483f44be05ec9303dfe0fe7664f393142e9ba
Message-ID: <202409191212.HYwJ5aeI-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git test
branch HEAD: 16e483f44be05ec9303dfe0fe7664f393142e9ba  Merge branch 'dev' into test

elapsed time: 977m

configs tested: 136
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                      axs103_smp_defconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.1.0
arc                 nsimosci_hs_smp_defconfig    gcc-13.2.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                      footbridge_defconfig    gcc-13.2.0
arm                           sama5_defconfig    gcc-13.2.0
arm                       versatile_defconfig    gcc-13.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20240919    clang-18
i386        buildonly-randconfig-002-20240919    clang-18
i386        buildonly-randconfig-003-20240919    clang-18
i386        buildonly-randconfig-004-20240919    clang-18
i386        buildonly-randconfig-005-20240919    clang-18
i386        buildonly-randconfig-006-20240919    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20240919    clang-18
i386                  randconfig-002-20240919    clang-18
i386                  randconfig-003-20240919    clang-18
i386                  randconfig-004-20240919    clang-18
i386                  randconfig-005-20240919    clang-18
i386                  randconfig-006-20240919    clang-18
i386                  randconfig-011-20240919    clang-18
i386                  randconfig-012-20240919    clang-18
i386                  randconfig-013-20240919    clang-18
i386                  randconfig-014-20240919    clang-18
i386                  randconfig-015-20240919    clang-18
i386                  randconfig-016-20240919    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                          multi_defconfig    gcc-13.2.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                          ath25_defconfig    gcc-13.2.0
mips                  decstation_64_defconfig    gcc-13.2.0
mips                           ip32_defconfig    gcc-13.2.0
mips                malta_qemu_32r6_defconfig    gcc-13.2.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           alldefconfig    gcc-13.2.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                     asp8347_defconfig    gcc-13.2.0
powerpc                       eiger_defconfig    gcc-13.2.0
powerpc                          g5_defconfig    gcc-13.2.0
powerpc                     tqm8541_defconfig    gcc-13.2.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20240919    clang-18
x86_64      buildonly-randconfig-002-20240919    clang-18
x86_64      buildonly-randconfig-003-20240919    clang-18
x86_64      buildonly-randconfig-004-20240919    clang-18
x86_64      buildonly-randconfig-005-20240919    clang-18
x86_64      buildonly-randconfig-006-20240919    clang-18
x86_64                              defconfig    clang-18
x86_64                randconfig-001-20240919    clang-18
x86_64                randconfig-002-20240919    clang-18
x86_64                randconfig-003-20240919    clang-18
x86_64                randconfig-004-20240919    clang-18
x86_64                randconfig-005-20240919    clang-18
x86_64                randconfig-006-20240919    clang-18
x86_64                randconfig-011-20240919    clang-18
x86_64                randconfig-012-20240919    clang-18
x86_64                randconfig-013-20240919    clang-18
x86_64                randconfig-014-20240919    clang-18
x86_64                randconfig-015-20240919    clang-18
x86_64                randconfig-016-20240919    clang-18
x86_64                randconfig-071-20240919    clang-18
x86_64                randconfig-072-20240919    clang-18
x86_64                randconfig-073-20240919    clang-18
x86_64                randconfig-074-20240919    clang-18
x86_64                randconfig-075-20240919    clang-18
x86_64                randconfig-076-20240919    clang-18
x86_64                           rhel-8.3-bpf    gcc-12
x86_64                         rhel-8.3-kunit    gcc-12
x86_64                           rhel-8.3-ltp    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                  cadence_csp_defconfig    gcc-13.2.0
xtensa                         virt_defconfig    gcc-13.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

