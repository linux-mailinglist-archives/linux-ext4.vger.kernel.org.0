Return-Path: <linux-ext4+bounces-8035-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 496A3ABD5BB
	for <lists+linux-ext4@lfdr.de>; Tue, 20 May 2025 13:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0866D179A7E
	for <lists+linux-ext4@lfdr.de>; Tue, 20 May 2025 11:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA91821D3F1;
	Tue, 20 May 2025 11:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="goKPDBtf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200F7279900
	for <linux-ext4@vger.kernel.org>; Tue, 20 May 2025 11:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747738889; cv=none; b=Vbqa6OS6e4/H2ZtKUIcvAlbKmyYYVb2pKPIOdhevT8iKQwWRZnT0/hXqFaLitxfTT6Asu4BbVZAQS9/XTgtjKTch9HCwANXOjwkMnFNBQU9SuK3DbKzu511AbyUQY3IHxyzlkz/4XsSF3fTfCgzPaWfZtdmHpiHjmPtEinI6b48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747738889; c=relaxed/simple;
	bh=HuVvWvrfucZ8mmFJ622RoLguqUrV5FBi1Bpd1oautbo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Y5evUbhKF3KPRoutwok3J/47A7JWBR7AXggM3zZWmfFsfJV1UBeFJ4AR1Ic7Mv/03+LRUDu7PsCH1od8pI8FAPMBpkjRgV1cYllsIrUBPqEyn/eI/yx8E/v8bxStsvv2aFsid6KDDlEMWS7WFRJvboDSzIJCc6AHRG3VoymfuPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=goKPDBtf; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747738887; x=1779274887;
  h=date:from:to:cc:subject:message-id;
  bh=HuVvWvrfucZ8mmFJ622RoLguqUrV5FBi1Bpd1oautbo=;
  b=goKPDBtfPR4GB2eCgKnnEynULIzIfidqTGhzBdFHzPqtZF2xtPKGOZ0h
   /Pa6Udh8LCmvuffb0tIWwS6h8MwxNzlXl1zFSlf/hvY3yr/8tQiq0L4rT
   rPSSm9boCj47hCChI4JG2p4uhitAxvS1PWDZJOk8RplxinpBDvE6jPoU3
   srfH+1Amg/Uxb5+r8a9CXtJ79t62r/QGb+dlmjMAEkzkJicbsRhMJ8CsP
   en4vvzSfMxssr9Pz0kL7xifmRbMWL9UMrvDw8gY2/DRYZGi/fhxNynwjn
   d4ip911EfA+D/xZNsW0+v9/Ve7DjLbpmoA4RbtnGujwYZkFLKTw6blq8f
   A==;
X-CSE-ConnectionGUID: j1SO0+/aRguLao9p26bMBw==
X-CSE-MsgGUID: bcIHQr//S5uaRmt5WF625Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49569438"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49569438"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 04:01:26 -0700
X-CSE-ConnectionGUID: WS6XMl6BQxa0K33NvWf+sw==
X-CSE-MsgGUID: XYnQlYIxSD2iXrHfCLpEvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="176783367"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 20 May 2025 04:01:25 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uHKip-000MTs-04;
	Tue, 20 May 2025 11:01:23 +0000
Date: Tue, 20 May 2025 19:01:17 +0800
From: kernel test robot <lkp@intel.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 dc86fd2ef895241985bb7a185f055e41fc0dfe83
Message-ID: <202505201908.IGq0T3TC-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: dc86fd2ef895241985bb7a185f055e41fc0dfe83  ext4: only dirty folios when data journaling regular files

elapsed time: 1092m

configs tested: 127
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                          axs101_defconfig    gcc-14.2.0
arc                   randconfig-001-20250520    gcc-11.5.0
arc                   randconfig-002-20250520    gcc-14.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                       multi_v4t_defconfig    clang-16
arm                        mvebu_v5_defconfig    gcc-14.2.0
arm                        neponset_defconfig    gcc-14.2.0
arm                   randconfig-001-20250520    gcc-6.5.0
arm                   randconfig-002-20250520    gcc-10.5.0
arm                   randconfig-003-20250520    clang-19
arm                   randconfig-004-20250520    gcc-7.5.0
arm                         s5pv210_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250520    clang-21
arm64                 randconfig-002-20250520    gcc-9.5.0
arm64                 randconfig-003-20250520    clang-18
arm64                 randconfig-004-20250520    gcc-9.5.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250520    gcc-14.2.0
csky                  randconfig-002-20250520    gcc-9.3.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250520    clang-21
hexagon               randconfig-002-20250520    clang-21
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250520    gcc-12
i386        buildonly-randconfig-002-20250520    gcc-12
i386        buildonly-randconfig-003-20250520    clang-20
i386        buildonly-randconfig-004-20250520    gcc-12
i386        buildonly-randconfig-005-20250520    clang-20
i386        buildonly-randconfig-006-20250520    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250520    gcc-14.2.0
loongarch             randconfig-002-20250520    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250520    gcc-9.3.0
nios2                 randconfig-002-20250520    gcc-13.3.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250520    gcc-10.5.0
parisc                randconfig-002-20250520    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                     ppa8548_defconfig    gcc-14.2.0
powerpc                     rainier_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250520    gcc-5.5.0
powerpc               randconfig-002-20250520    clang-17
powerpc               randconfig-003-20250520    gcc-7.5.0
powerpc64             randconfig-001-20250520    clang-21
powerpc64             randconfig-002-20250520    gcc-7.5.0
powerpc64             randconfig-003-20250520    gcc-5.5.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250520    gcc-9.3.0
riscv                 randconfig-002-20250520    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250520    clang-21
s390                  randconfig-002-20250520    clang-21
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                        dreamcast_defconfig    gcc-14.2.0
sh                         ecovec24_defconfig    gcc-14.2.0
sh                    randconfig-001-20250520    gcc-9.3.0
sh                    randconfig-002-20250520    gcc-9.3.0
sh                          urquell_defconfig    gcc-14.2.0
sparc                            alldefconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250520    gcc-8.5.0
sparc                 randconfig-002-20250520    gcc-12.4.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250520    gcc-8.5.0
sparc64               randconfig-002-20250520    gcc-12.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250520    clang-21
um                    randconfig-002-20250520    clang-21
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250520    gcc-12
x86_64      buildonly-randconfig-002-20250520    gcc-12
x86_64      buildonly-randconfig-003-20250520    gcc-12
x86_64      buildonly-randconfig-004-20250520    gcc-12
x86_64      buildonly-randconfig-005-20250520    gcc-12
x86_64      buildonly-randconfig-006-20250520    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                       common_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250520    gcc-6.5.0
xtensa                randconfig-002-20250520    gcc-12.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

