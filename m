Return-Path: <linux-ext4+bounces-13293-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uy+hCQlJdWm8DQEAu9opvQ
	(envelope-from <linux-ext4+bounces-13293-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sat, 24 Jan 2026 23:34:49 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5141D7F21F
	for <lists+linux-ext4@lfdr.de>; Sat, 24 Jan 2026 23:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6609300C90D
	for <lists+linux-ext4@lfdr.de>; Sat, 24 Jan 2026 22:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4592367DF;
	Sat, 24 Jan 2026 22:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dmkROvyy"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA391391
	for <linux-ext4@vger.kernel.org>; Sat, 24 Jan 2026 22:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769294084; cv=none; b=VJKo5J0LilJvK07HIA+xVV7AahOececeppgUGMFbdWnLsF2pYV1IWVGMr02YBhbzaeiqRTFpSSV9r4/Hf/wtfOXCjqL38UaeHFcwagDgzBF/zsLfz6i3XEh+GfTsmf5xoH6DE+ImIIAAoMocW1bpZKyhD2HmP8WUXz9o5xD75Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769294084; c=relaxed/simple;
	bh=uG48OUXzMyijHTrKSxejizKVoEzqphYoQ7TkqY8OMeU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Dup+JBG06QK13xomzpdxftcW3B0WK/o6KbZd7FzrMUGBq1DZ5LNXJjpCJ9H7TiXFY79fRMk3/ffS5vWlDi9JzaHqVh9ySJ/Zp3GL9+h9Uu5NiRMzZOxD88+ZWLP2pbaj8loR0aQlELukMK2BEsQunFNSK7DgiypvLonnzy1w16U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dmkROvyy; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769294081; x=1800830081;
  h=date:from:to:cc:subject:message-id;
  bh=uG48OUXzMyijHTrKSxejizKVoEzqphYoQ7TkqY8OMeU=;
  b=dmkROvyyzTlJSbK9xuEp+vo2z9EkiWKaazzTIyfcYL/zhrh8Xnxab6GS
   ZuI6z6FQpg+j5N2FBUpaTasnqoWV8abQRFiLl/EP3E7tk+k0bCl/aKic5
   gySPXlPuoS3iRNDPkhp5sFHsZjFispqjVB1APzo+yZ+si/1yb/z6KOZlH
   X/hXeAAKfUG1l9WyD5dTH/ugEBHLUdVJX2ZkOUQSJHV1JXhhPTqSuLK5w
   7CuY8tF6OHPpXmIstmYqHuUy/oQFyvHiJGq/Xsdm2IhrZw8w6bovloqOT
   NONyR6C8YSiguYb3IMYU0cm2mM4479MQI4BElZ5mY0BlsQ7lR2JNzFwku
   g==;
X-CSE-ConnectionGUID: y/wyCK7FT6yGGzkVhZD7Bw==
X-CSE-MsgGUID: ZkIyrXWXRe6mg1c8UJwriw==
X-IronPort-AV: E=McAfee;i="6800,10657,11681"; a="70481988"
X-IronPort-AV: E=Sophos;i="6.21,251,1763452800"; 
   d="scan'208";a="70481988"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2026 14:34:40 -0800
X-CSE-ConnectionGUID: AtnNd1RFT+y0QCLHRZI+LA==
X-CSE-MsgGUID: 7YBUIrQwT62p2cW6Wh7zXA==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 24 Jan 2026 14:34:37 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vjmDD-00000000Vaa-3Agw;
	Sat, 24 Jan 2026 22:34:35 +0000
Date: Sun, 25 Jan 2026 06:33:55 +0800
From: kernel test robot <lkp@intel.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 4f5e8e6f012349a107531b02eed5b5ace6181449
Message-ID: <202601250650.bOD12bPv-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13293-lists,linux-ext4=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5141D7F21F
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: 4f5e8e6f012349a107531b02eed5b5ace6181449  et4: allow zeroout when doing written to unwritten split

elapsed time: 1231m

configs tested: 217
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260124    gcc-14.3.0
arc                   randconfig-002-20260124    gcc-13.4.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                          pxa910_defconfig    gcc-15.2.0
arm                   randconfig-001-20260124    gcc-8.5.0
arm                   randconfig-002-20260124    clang-22
arm                   randconfig-003-20260124    clang-18
arm                   randconfig-004-20260124    gcc-15.2.0
arm                           tegra_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260124    clang-22
arm64                 randconfig-001-20260124    gcc-15.2.0
arm64                 randconfig-002-20260124    clang-22
arm64                 randconfig-002-20260124    gcc-15.2.0
arm64                 randconfig-003-20260124    clang-22
arm64                 randconfig-003-20260124    gcc-15.2.0
arm64                 randconfig-004-20260124    gcc-15.2.0
arm64                 randconfig-004-20260124    gcc-9.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260124    gcc-13.4.0
csky                  randconfig-001-20260124    gcc-15.2.0
csky                  randconfig-002-20260124    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260124    gcc-14
i386                  randconfig-002-20260124    gcc-14
i386                  randconfig-003-20260124    gcc-14
i386                  randconfig-004-20260124    gcc-12
i386                  randconfig-005-20260124    clang-20
i386                  randconfig-006-20260124    gcc-14
i386                  randconfig-007-20260124    gcc-14
i386                  randconfig-011-20260124    clang-20
i386                  randconfig-012-20260124    clang-20
i386                  randconfig-013-20260124    clang-20
i386                  randconfig-014-20260124    clang-20
i386                  randconfig-014-20260124    gcc-14
i386                  randconfig-015-20260124    clang-20
i386                  randconfig-016-20260124    clang-20
i386                  randconfig-016-20260124    gcc-14
i386                  randconfig-017-20260124    clang-20
i386                  randconfig-017-20260124    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                  cavium_octeon_defconfig    gcc-15.2.0
mips                malta_qemu_32r6_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260124    gcc-8.5.0
parisc                randconfig-002-20260124    gcc-14.3.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                       eiger_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260124    clang-22
powerpc               randconfig-002-20260124    clang-22
powerpc                     skiroot_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260124    gcc-10.5.0
powerpc64             randconfig-002-20260124    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260124    gcc-8.5.0
riscv                 randconfig-002-20260124    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-22
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260124    gcc-8.5.0
s390                  randconfig-002-20260124    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260124    gcc-8.5.0
sh                    randconfig-002-20260124    gcc-8.5.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260124    gcc-13.4.0
sparc                 randconfig-001-20260124    gcc-14.3.0
sparc                 randconfig-002-20260124    gcc-13.4.0
sparc                 randconfig-002-20260124    gcc-14.3.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260124    clang-22
sparc64               randconfig-001-20260124    gcc-13.4.0
sparc64               randconfig-002-20260124    clang-22
sparc64               randconfig-002-20260124    gcc-13.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260124    gcc-13.4.0
um                    randconfig-001-20260124    gcc-14
um                    randconfig-002-20260124    clang-18
um                    randconfig-002-20260124    gcc-13.4.0
um                           x86_64_defconfig    gcc-14
um                           x86_64_defconfig    gcc-15.2.0
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260124    clang-20
x86_64      buildonly-randconfig-002-20260124    gcc-14
x86_64      buildonly-randconfig-003-20260124    clang-20
x86_64      buildonly-randconfig-004-20260124    clang-20
x86_64      buildonly-randconfig-005-20260124    clang-20
x86_64      buildonly-randconfig-006-20260124    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260124    clang-20
x86_64                randconfig-001-20260124    gcc-13
x86_64                randconfig-002-20260124    clang-20
x86_64                randconfig-002-20260124    gcc-13
x86_64                randconfig-003-20260124    clang-20
x86_64                randconfig-003-20260124    gcc-13
x86_64                randconfig-004-20260124    clang-20
x86_64                randconfig-004-20260124    gcc-13
x86_64                randconfig-005-20260124    gcc-13
x86_64                randconfig-006-20260124    clang-20
x86_64                randconfig-006-20260124    gcc-13
x86_64                randconfig-011-20260124    gcc-12
x86_64                randconfig-012-20260124    gcc-12
x86_64                randconfig-013-20260124    gcc-12
x86_64                randconfig-014-20260124    gcc-12
x86_64                randconfig-015-20260124    gcc-12
x86_64                randconfig-016-20260124    gcc-12
x86_64                randconfig-071-20260124    gcc-14
x86_64                randconfig-072-20260124    clang-20
x86_64                randconfig-072-20260124    gcc-14
x86_64                randconfig-073-20260124    clang-20
x86_64                randconfig-073-20260124    gcc-14
x86_64                randconfig-074-20260124    gcc-12
x86_64                randconfig-074-20260124    gcc-14
x86_64                randconfig-075-20260124    clang-20
x86_64                randconfig-075-20260124    gcc-14
x86_64                randconfig-076-20260124    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-22
xtensa                  nommu_kc705_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260124    gcc-13.4.0
xtensa                randconfig-001-20260124    gcc-8.5.0
xtensa                randconfig-002-20260124    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

