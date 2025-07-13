Return-Path: <linux-ext4+bounces-8965-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E454BB02F0A
	for <lists+linux-ext4@lfdr.de>; Sun, 13 Jul 2025 09:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECF3E189BAED
	for <lists+linux-ext4@lfdr.de>; Sun, 13 Jul 2025 07:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8232F1CAA82;
	Sun, 13 Jul 2025 07:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ceUFCEFP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676346FC3
	for <linux-ext4@vger.kernel.org>; Sun, 13 Jul 2025 07:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752390675; cv=none; b=PuyQESZw3SBsafWjLIv+JNpvF9po689TgNSQp4CFRLjIasLaU5c7dQe1liRi9QQwsM/sIt9O/E0mJym4jOtOQFmAaC0lfAiowBxLk9pByxm9quMr/M6u09Xyx5nYtMaEyw+rxVRUW6HKJszPqC8qIzvIdor5SSmpE7TsHAps5bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752390675; c=relaxed/simple;
	bh=mTpBMI6eIQjSFevdmGk2vDx568QdKWZ2kk15V8sRk9g=;
	h=Date:From:To:Cc:Subject:Message-ID; b=uU6pT+kr455Nf7O6hlB5dnZFRRZPYi6yC9iUnXjSG/t4YM/oxySxt625pBjZ2JlHKoTActT57JUAiBFQFx0Uf+mh1SDn+QMlcldmMdThnFsAtDIMMke9tY5cAztMYRgymfuTq915JWCj7FRHmrUztKrzLNayqwBiWzZ5yUEVsgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ceUFCEFP; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752390673; x=1783926673;
  h=date:from:to:cc:subject:message-id;
  bh=mTpBMI6eIQjSFevdmGk2vDx568QdKWZ2kk15V8sRk9g=;
  b=ceUFCEFPjd0pWXVJwA611FcBmFV3+01SEzL/ZM1NIkO1smEZC0leAMyz
   sBQmltLCfjzrKrIkbWp3BjWovzx5QShp+hqLylKu/Xgxl9KOOYZARwJ3k
   q2S9AMDpNgHeGgjSs2jX7neaLmu/FTwBzlv4Ad4FTfW8Mn20aBvPUVjTw
   zqSWcBBsGs6jF7u7ErpghgICMGfFlFnmyepw4YW71bWo8w4gKUm2r++d/
   swimJWnCN0JhnYQEMRzvu1z3wflFXvK9N6OlzauBqQUek8NdVzzYSXsZq
   rIZao/7j6cYpfNEe5NV89RQPTiDS/issQ677zuk5fR/nbZoaEHduNSvzQ
   Q==;
X-CSE-ConnectionGUID: cpYnbGBxRVK0XZYXIoXDsg==
X-CSE-MsgGUID: LPUNtdoxTzy6+dczmrqteg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54475690"
X-IronPort-AV: E=Sophos;i="6.16,308,1744095600"; 
   d="scan'208";a="54475690"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 00:11:13 -0700
X-CSE-ConnectionGUID: Ve8RbGcfQHOjyiPI0Hcpfw==
X-CSE-MsgGUID: 2LIgYBt7S7Wo09qRavilkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,308,1744095600"; 
   d="scan'208";a="193882761"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 13 Jul 2025 00:11:12 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uaqrd-0007xT-21;
	Sun, 13 Jul 2025 07:11:09 +0000
Date: Sun, 13 Jul 2025 15:10:38 +0800
From: kernel test robot <lkp@intel.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 c5da1f66940d8015cbf95c2501345c83eb6ba0ab
Message-ID: <202507131526.qbKf6YUB-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: c5da1f66940d8015cbf95c2501345c83eb6ba0ab  ext4: remove unnecessary duplicate check in ext4_map_blocks()

elapsed time: 726m

configs tested: 122
configs skipped: 5

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
arc                   randconfig-002-20250713    gcc-10.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250713    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250713    gcc-15.1.0
csky                  randconfig-002-20250713    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250713    clang-21
hexagon               randconfig-002-20250713    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250713    clang-20
i386        buildonly-randconfig-002-20250713    clang-20
i386        buildonly-randconfig-003-20250713    gcc-12
i386        buildonly-randconfig-004-20250713    gcc-12
i386        buildonly-randconfig-005-20250713    clang-20
i386        buildonly-randconfig-006-20250713    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch             randconfig-001-20250713    clang-21
loongarch             randconfig-002-20250713    clang-21
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                       bvme6000_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250713    gcc-11.5.0
nios2                 randconfig-002-20250713    gcc-10.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
openrisc                    or1ksim_defconfig    gcc-15.1.0
openrisc                       virt_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250713    gcc-8.5.0
parisc                randconfig-002-20250713    gcc-10.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                 mpc836x_rdk_defconfig    clang-21
powerpc               randconfig-001-20250713    clang-21
powerpc               randconfig-002-20250713    clang-19
powerpc               randconfig-003-20250713    gcc-8.5.0
powerpc64             randconfig-002-20250713    clang-21
powerpc64             randconfig-003-20250713    gcc-13.4.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250713    clang-20
riscv                 randconfig-002-20250713    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250713    clang-21
s390                  randconfig-002-20250713    clang-21
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                        apsh4ad0a_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250713    gcc-15.1.0
sh                    randconfig-002-20250713    gcc-11.5.0
sh                   secureedge5410_defconfig    gcc-15.1.0
sh                            titan_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250713    gcc-8.5.0
sparc                 randconfig-002-20250713    gcc-10.3.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250713    gcc-8.5.0
sparc64               randconfig-002-20250713    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250713    clang-21
um                    randconfig-002-20250713    gcc-12
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250713    clang-20
x86_64      buildonly-randconfig-002-20250713    clang-20
x86_64      buildonly-randconfig-003-20250713    clang-20
x86_64      buildonly-randconfig-004-20250713    clang-20
x86_64      buildonly-randconfig-005-20250713    clang-20
x86_64      buildonly-randconfig-006-20250713    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250713    gcc-11.5.0
xtensa                randconfig-002-20250713    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

