Return-Path: <linux-ext4+bounces-9381-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89570B27077
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Aug 2025 22:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFBA71CC514B
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Aug 2025 20:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8FB273D8B;
	Thu, 14 Aug 2025 20:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nDVVm7U4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1A7269CE5
	for <linux-ext4@vger.kernel.org>; Thu, 14 Aug 2025 20:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755205102; cv=none; b=a7bsFG7Glu24X+Pntg1u08dlv9/wd/suHaBWqz+LbzmGG30GNXeCgle8/G79yWcIJDfl0M/yaQSce3uPenPugFWi6s80dOmXRO+7d7qF7RLRa0v5TZvCqCgGWSOXpjxamSoeJSN3W2BHn0tGtmI9j2tNxoe4byh7IHXa8Wp7cOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755205102; c=relaxed/simple;
	bh=6L0sN1+KMgz/yYz8/4b/0d5sNXqzxmNwnL1WWeMEbQ8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=dKN+sE7snNMsBt/yihL9eT0LFuzCyEMCky+E8jwUHiPYaVZCCd9qiVP44L5IdLZwyaso9YDapReH+hHycFzXjW2pdLNEqOHF5pKS9i8sWJqEVzX46AKige6Dkmfcnz+OeCqq+wQWfKm2j6Nf4x5ief0qbmc52lDNFOODBx+4mUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nDVVm7U4; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755205100; x=1786741100;
  h=date:from:to:cc:subject:message-id;
  bh=6L0sN1+KMgz/yYz8/4b/0d5sNXqzxmNwnL1WWeMEbQ8=;
  b=nDVVm7U4MwQbfvtMLhCqSlOddhyk8cIj+GMsst5gEOmPdSzADnTjprn6
   R49hyy9/4r0nmItIWWsMo/uwTFmjft1ZKyuN/TX0cP4vFC9UqGu+U6InX
   yoAiKFPIOQAhUdHNxipT1QTQtTPd5gNtcWwFyEJ0SJgOM5Z1BU6kS2iVU
   FsEYGPKJ5p4bcg+AEi8zBiVrUPsw7vnJYeX5ophB+jdjNhWf/qrLf6idd
   2Q2zo+iVtrnVxFx3C1laB3wquQck2HHRln3UTNrHYUM/GZrkdgiwyODgL
   4vZ5nDgn1GXGOuF9ZcVMxAAC4n/8qHKIs3XbkWS9dGADgaKHW3a/wPb3v
   g==;
X-CSE-ConnectionGUID: vBH3BNlOR8a15ONKBDxTjQ==
X-CSE-MsgGUID: UAmtBdCoSKOCb1orqgJfiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="57646490"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="57646490"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 13:58:20 -0700
X-CSE-ConnectionGUID: blvt201CT0STc9Z4KnnauA==
X-CSE-MsgGUID: kG03GalKQe+S4AkSZ6vGUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="172188777"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 14 Aug 2025 13:58:19 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umf1c-000BKI-0G;
	Thu, 14 Aug 2025 20:58:16 +0000
Date: Fri, 15 Aug 2025 04:57:30 +0800
From: kernel test robot <lkp@intel.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 9d98cf4632258720f18265a058e62fde120c0151
Message-ID: <202508150422.UwRe4oqB-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: 9d98cf4632258720f18265a058e62fde120c0151  jbd2: prevent softlockup in jbd2_log_do_checkpoint()

elapsed time: 1448m

configs tested: 114
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250814    gcc-12.5.0
arc                   randconfig-002-20250814    gcc-13.4.0
arm                               allnoconfig    clang-22
arm                     am200epdkit_defconfig    gcc-15.1.0
arm                         at91_dt_defconfig    clang-22
arm                          pxa3xx_defconfig    clang-22
arm                   randconfig-001-20250814    clang-22
arm                   randconfig-002-20250814    clang-22
arm                   randconfig-003-20250814    gcc-10.5.0
arm                   randconfig-004-20250814    gcc-8.5.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250814    clang-17
arm64                 randconfig-002-20250814    gcc-8.5.0
arm64                 randconfig-003-20250814    gcc-10.5.0
arm64                 randconfig-004-20250814    gcc-13.4.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250814    gcc-15.1.0
csky                  randconfig-002-20250814    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250814    clang-20
hexagon               randconfig-002-20250814    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386        buildonly-randconfig-001-20250814    clang-20
i386        buildonly-randconfig-002-20250814    gcc-12
i386        buildonly-randconfig-003-20250814    gcc-12
i386        buildonly-randconfig-004-20250814    clang-20
i386        buildonly-randconfig-005-20250814    gcc-12
i386        buildonly-randconfig-006-20250814    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250814    clang-22
loongarch             randconfig-002-20250814    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                         rt305x_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250814    gcc-10.5.0
nios2                 randconfig-002-20250814    gcc-9.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250814    gcc-10.5.0
parisc                randconfig-002-20250814    gcc-13.4.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20250814    gcc-8.5.0
powerpc               randconfig-002-20250814    gcc-8.5.0
powerpc               randconfig-003-20250814    gcc-10.5.0
powerpc64             randconfig-001-20250814    clang-22
powerpc64             randconfig-002-20250814    clang-22
powerpc64             randconfig-003-20250814    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250814    clang-22
riscv                 randconfig-002-20250814    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250814    clang-22
s390                  randconfig-002-20250814    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250814    gcc-9.5.0
sh                    randconfig-002-20250814    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250814    gcc-14.3.0
sparc                 randconfig-002-20250814    gcc-12.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250814    clang-22
sparc64               randconfig-002-20250814    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                    randconfig-001-20250814    clang-22
um                    randconfig-002-20250814    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250814    clang-20
x86_64      buildonly-randconfig-002-20250814    clang-20
x86_64      buildonly-randconfig-003-20250814    gcc-12
x86_64      buildonly-randconfig-004-20250814    clang-20
x86_64      buildonly-randconfig-005-20250814    gcc-12
x86_64      buildonly-randconfig-006-20250814    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250814    gcc-8.5.0
xtensa                randconfig-002-20250814    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

