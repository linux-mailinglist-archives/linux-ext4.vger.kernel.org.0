Return-Path: <linux-ext4+bounces-7956-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A394ABB2CF
	for <lists+linux-ext4@lfdr.de>; Mon, 19 May 2025 03:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71906172800
	for <lists+linux-ext4@lfdr.de>; Mon, 19 May 2025 01:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF42839F4;
	Mon, 19 May 2025 01:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M3wnoLqj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D75487BF
	for <linux-ext4@vger.kernel.org>; Mon, 19 May 2025 01:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747617750; cv=none; b=YpO1FRqr4iTesS7NXhTdZqEHbH6Ug5QXsCCRfwoXOwqfJRSZsW1GdDJ+7UkNn/XFWdVO8kp4ssGODyVRjaatXVCr/w7FP8c+AjQ6o97q0oZ5X80tfCMeQABGvcV30v8611W5Cgp+jjv4tObLPmhoqlnmopo9oL1x3wZyS6qRarY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747617750; c=relaxed/simple;
	bh=/SQQgySisQU/utk2o2agcv7AzQAauhPcxqPfTTbWRYs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=aj21NVkF/h2lyUwurgRHo2BJqpz3S3ScCb5pMVpXnqSngY8pldsk1TvT7VTtUCSZRvvznvQzRN7SePOvpBXsn1AesQeNkbDGMdwCSYKNAaLwO4DSId57E1eO8S/WGH9V0JNPGn0B2Bcuae4hiAUFnZ3dBIVe3IBD4dyTNhyTFgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M3wnoLqj; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747617749; x=1779153749;
  h=date:from:to:cc:subject:message-id;
  bh=/SQQgySisQU/utk2o2agcv7AzQAauhPcxqPfTTbWRYs=;
  b=M3wnoLqj/5B+V+iEWZsXicB9AMjxrGFujBjxBc8VIzHG/CDqli+3Re3d
   Urp6Jm6olZJLl11j7c1y1LUVgk89XdQwcWCysScKM0ldVIB7ETUPwMKcJ
   CP7psEvZu1tC/pDTLmr40is3W6vBjnMbeMfGqLJPgjOujh8co56BZ4UX7
   lCiM4RWOr28NqJOIfhX0XMGWBYDlJP2/7yATq3Ddwgbg14DVZCmtZmh3c
   Y4s5yZrxuYtVJ9POeEY/c3JaFUk7/GvJ+FxYm6AXEpiaYLbIsYK6/zSET
   IIgwLwmz+pVoB8BAF9lXv+n+sIoHgkxybmFO+WNRbnMQTSbuBxsZDb61c
   w==;
X-CSE-ConnectionGUID: vGWJtWyZTsyp2mCUVlcEYA==
X-CSE-MsgGUID: D+QjDlCISEKM7r+BE+Jh1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="49643757"
X-IronPort-AV: E=Sophos;i="6.15,299,1739865600"; 
   d="scan'208";a="49643757"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2025 18:22:28 -0700
X-CSE-ConnectionGUID: ip/QmSAeTY2rHssOoP28dg==
X-CSE-MsgGUID: 3ZUUBytGSRKRNkMh9Cs7Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,299,1739865600"; 
   d="scan'208";a="139128092"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 18 May 2025 18:22:27 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uGpCy-000L4l-2C;
	Mon, 19 May 2025 01:22:24 +0000
Date: Mon, 19 May 2025 09:22:01 +0800
From: kernel test robot <lkp@intel.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 e4e129b9e3d37b21d78a5a6617c6987dafa9600d
Message-ID: <202505190952.jzBXOONW-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: e4e129b9e3d37b21d78a5a6617c6987dafa9600d  ext4: only dirty folios when data journaling regular files

elapsed time: 721m

configs tested: 135
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250518    gcc-14.2.0
arc                   randconfig-002-20250518    gcc-11.5.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                       aspeed_g5_defconfig    gcc-14.2.0
arm                        multi_v5_defconfig    gcc-14.2.0
arm                         nhk8815_defconfig    clang-21
arm                   randconfig-001-20250518    gcc-10.5.0
arm                   randconfig-002-20250518    clang-21
arm                   randconfig-003-20250518    gcc-7.5.0
arm                   randconfig-004-20250518    clang-16
arm                        shmobile_defconfig    gcc-14.2.0
arm                           sunxi_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250518    gcc-7.5.0
arm64                 randconfig-002-20250518    clang-21
arm64                 randconfig-003-20250518    clang-21
arm64                 randconfig-004-20250518    clang-21
csky                             alldefconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250518    gcc-14.2.0
csky                  randconfig-002-20250518    gcc-9.3.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250518    clang-21
hexagon               randconfig-002-20250518    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250518    gcc-12
i386        buildonly-randconfig-002-20250518    clang-20
i386        buildonly-randconfig-003-20250518    gcc-12
i386        buildonly-randconfig-004-20250518    gcc-12
i386        buildonly-randconfig-005-20250518    gcc-12
i386        buildonly-randconfig-006-20250518    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250518    gcc-13.3.0
loongarch             randconfig-002-20250518    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        omega2p_defconfig    clang-21
mips                           xway_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250518    gcc-5.5.0
nios2                 randconfig-002-20250518    gcc-13.3.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250518    gcc-8.5.0
parisc                randconfig-002-20250518    gcc-8.5.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                      bamboo_defconfig    clang-21
powerpc                  mpc885_ads_defconfig    clang-21
powerpc                      pmac32_defconfig    clang-21
powerpc               randconfig-001-20250518    gcc-7.5.0
powerpc               randconfig-002-20250518    gcc-5.5.0
powerpc               randconfig-003-20250518    clang-21
powerpc                    sam440ep_defconfig    gcc-14.2.0
powerpc64                        alldefconfig    clang-21
powerpc64             randconfig-001-20250518    gcc-10.5.0
powerpc64             randconfig-002-20250518    gcc-7.5.0
powerpc64             randconfig-003-20250518    gcc-7.5.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250518    clang-21
riscv                 randconfig-002-20250518    clang-20
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250518    gcc-7.5.0
s390                  randconfig-002-20250518    gcc-7.5.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                         ecovec24_defconfig    gcc-14.2.0
sh                          lboxre2_defconfig    gcc-14.2.0
sh                    randconfig-001-20250518    gcc-13.3.0
sh                    randconfig-002-20250518    gcc-7.5.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250518    gcc-12.4.0
sparc                 randconfig-002-20250518    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250518    gcc-6.5.0
sparc64               randconfig-002-20250518    gcc-6.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250518    clang-19
um                    randconfig-002-20250518    clang-21
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250518    gcc-12
x86_64      buildonly-randconfig-002-20250518    clang-20
x86_64      buildonly-randconfig-003-20250518    gcc-12
x86_64      buildonly-randconfig-004-20250518    gcc-12
x86_64      buildonly-randconfig-005-20250518    gcc-12
x86_64      buildonly-randconfig-006-20250518    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250518    gcc-12.4.0
xtensa                randconfig-002-20250518    gcc-12.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

