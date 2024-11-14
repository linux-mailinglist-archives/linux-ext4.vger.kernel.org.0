Return-Path: <linux-ext4+bounces-5152-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A09E59C8BDB
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Nov 2024 14:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60E7D284B85
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Nov 2024 13:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FFE18622;
	Thu, 14 Nov 2024 13:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZSuvmfzX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB322134AB
	for <linux-ext4@vger.kernel.org>; Thu, 14 Nov 2024 13:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731591059; cv=none; b=a6PAobik4eA/pp/lLB5tn0HXr/3L+K5cX9kMSo+3269K0PEMExymsVjYDiIVKr5wCwQeLlhoEjelOq+es3jsmkh+HZfCaVqTXpMqjmVxaXE088TFgmwq9fWXEIQySxWbFU1OdkgjR/V0oi/uEyZb53fIgqVh0xlwNgHq4S97qzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731591059; c=relaxed/simple;
	bh=0gWl/wfi9qRZWaaZPE/wGyhbX67HcpM/KnXSMLx8SH0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=EKcWmTZwQ7HkXoGTXGJW7L0FuLJLVWbkhMXid59HBQKozJiS0J3IeGnNqVq/B0zDex32wwVCmpcZ0rUovhIBLGDt34tT8CXmlf98kah4hJSnK8QzLdq/RueuZP5aWNBsX4xiQSkBbgWxzLlD8hqZFPwUz7cFWUM/rIDyf0LiNnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZSuvmfzX; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731591057; x=1763127057;
  h=date:from:to:cc:subject:message-id;
  bh=0gWl/wfi9qRZWaaZPE/wGyhbX67HcpM/KnXSMLx8SH0=;
  b=ZSuvmfzXgizrJHSn09EzVK1P9zo5deNh7hVY8p6laW3WNF588QVeoniu
   7p2+kWl79GdYFH+r9DH6PakLzQBeFmUk3jAPBW0a2wqPSjzGUbKFD+SVt
   gI6oKA9XdljwpQoy8RDnZFMX8IKW96uitGi3Xgo7wHM3xj8sl7xkP2uP6
   y1w1YwswzRxsUI711cx55X9ySVgi63x7v8srdhB4r9Tjm8OiuBN+/nT9T
   dVPyqvxoUw/DW62qa/mPl2hVyY+DauCp04WoHu0aBhrJLeK+Jlw17xSM3
   LJ9VIr0G0bDh8TaxrGt8edrkgv7W1qEq2NYydyS1bBf4Od/cM9Pli1Vss
   Q==;
X-CSE-ConnectionGUID: BRxGxG0CRoK8Ra+spnk9YA==
X-CSE-MsgGUID: n4tYYvrVS1SGGG+L1V31rg==
X-IronPort-AV: E=McAfee;i="6700,10204,11256"; a="35327865"
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="35327865"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 05:30:56 -0800
X-CSE-ConnectionGUID: x/EWlsbTRjmVA9+iU5vIMw==
X-CSE-MsgGUID: i5QDIVmtRSa4WamjfQ+1bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="92266371"
Received: from lkp-server01.sh.intel.com (HELO c7bc087bbc55) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 14 Nov 2024 05:30:55 -0800
Received: from kbuild by c7bc087bbc55 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tBZvw-000045-39;
	Thu, 14 Nov 2024 13:30:52 +0000
Date: Thu, 14 Nov 2024 21:30:12 +0800
From: kernel test robot <lkp@intel.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 3e7c69cdb053f9edea95502853f35952ab6cbf06
Message-ID: <202411142105.2h8V9gB7-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: 3e7c69cdb053f9edea95502853f35952ab6cbf06  jbd2: Fix comment describing journal_init_common()

elapsed time: 805m

configs tested: 80
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                  allyesconfig    gcc-14.2.0
arc                    allmodconfig    gcc-13.2.0
arc                    allyesconfig    gcc-13.2.0
arc         randconfig-001-20241114    gcc-13.2.0
arc         randconfig-002-20241114    gcc-13.2.0
arm                    allmodconfig    gcc-14.2.0
arm                    allyesconfig    gcc-14.2.0
arm         randconfig-001-20241114    gcc-14.2.0
arm         randconfig-002-20241114    gcc-14.2.0
arm         randconfig-003-20241114    gcc-14.2.0
arm         randconfig-004-20241114    clang-14
arm64                  allmodconfig    clang-20
arm64       randconfig-001-20241114    clang-20
arm64       randconfig-002-20241114    gcc-14.2.0
arm64       randconfig-003-20241114    gcc-14.2.0
arm64       randconfig-004-20241114    gcc-14.2.0
csky        randconfig-001-20241114    gcc-14.2.0
csky        randconfig-002-20241114    gcc-14.2.0
hexagon                allmodconfig    clang-20
hexagon                allyesconfig    clang-20
hexagon     randconfig-001-20241114    clang-20
hexagon     randconfig-002-20241114    clang-20
i386                   allmodconfig    gcc-12
i386                    allnoconfig    gcc-12
i386                   allyesconfig    gcc-12
i386                      defconfig    clang-19
loongarch              allmodconfig    gcc-14.2.0
loongarch   randconfig-001-20241114    gcc-14.2.0
loongarch   randconfig-002-20241114    gcc-14.2.0
m68k                   allmodconfig    gcc-14.2.0
m68k                   allyesconfig    gcc-14.2.0
microblaze             allmodconfig    gcc-14.2.0
microblaze             allyesconfig    gcc-14.2.0
nios2       randconfig-001-20241114    gcc-14.2.0
nios2       randconfig-002-20241114    gcc-14.2.0
openrisc                allnoconfig    gcc-14.2.0
openrisc               allyesconfig    gcc-14.2.0
parisc                 allmodconfig    gcc-14.2.0
parisc                  allnoconfig    gcc-14.2.0
parisc                 allyesconfig    gcc-14.2.0
parisc      randconfig-001-20241114    gcc-14.2.0
parisc      randconfig-002-20241114    gcc-14.2.0
powerpc                allmodconfig    gcc-14.2.0
powerpc                 allnoconfig    gcc-14.2.0
powerpc                allyesconfig    clang-20
powerpc     randconfig-001-20241114    gcc-14.2.0
powerpc     randconfig-002-20241114    clang-14
powerpc     randconfig-003-20241114    gcc-14.2.0
powerpc64   randconfig-001-20241114    gcc-14.2.0
powerpc64   randconfig-002-20241114    clang-20
powerpc64   randconfig-003-20241114    gcc-14.2.0
riscv                  allmodconfig    clang-20
riscv                   allnoconfig    gcc-14.2.0
riscv                  allyesconfig    clang-20
riscv       randconfig-001-20241114    gcc-14.2.0
riscv       randconfig-002-20241114    clang-14
s390                   allmodconfig    clang-20
s390                    allnoconfig    clang-20
s390                   allyesconfig    gcc-14.2.0
s390        randconfig-001-20241114    gcc-14.2.0
s390        randconfig-002-20241114    clang-20
sh                     allmodconfig    gcc-14.2.0
sh                     allyesconfig    gcc-14.2.0
sh          randconfig-001-20241114    gcc-14.2.0
sh          randconfig-002-20241114    gcc-14.2.0
sparc                  allmodconfig    gcc-14.2.0
sparc64     randconfig-001-20241114    gcc-14.2.0
sparc64     randconfig-002-20241114    gcc-14.2.0
um                     allmodconfig    clang-20
um                      allnoconfig    clang-17
um                     allyesconfig    gcc-12
um          randconfig-001-20241114    gcc-11
um          randconfig-002-20241114    gcc-12
x86_64                  allnoconfig    clang-19
x86_64                 allyesconfig    clang-19
x86_64                    defconfig    gcc-11
x86_64                        kexec    clang-19
x86_64                     rhel-8.3    gcc-12
xtensa      randconfig-001-20241114    gcc-14.2.0
xtensa      randconfig-002-20241114    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

