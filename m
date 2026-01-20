Return-Path: <linux-ext4+bounces-13136-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJqIA1fJb2mgMQAAu9opvQ
	(envelope-from <linux-ext4+bounces-13136-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Jan 2026 19:28:39 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 724C64973C
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Jan 2026 19:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F4B9A0AA94
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Jan 2026 16:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC03314A8D;
	Tue, 20 Jan 2026 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pb7q/4bo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A764142DFFA
	for <linux-ext4@vger.kernel.org>; Tue, 20 Jan 2026 16:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768926572; cv=none; b=ZA+LXB9WXZ1EPsB4lIfxQJYZXqUE76lirn0n/S2A8HvQmdw1L6cFrvqT/a56mObH+fl5u4I5292GKW1/olAZXExfcLVCMPZ9oXQCfBF9kZlClIJtiH4zds2o9f4rEQea8L3Za40ghcchTjiB4wPBZm4kO2vGnoapUaPN7rvXOSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768926572; c=relaxed/simple;
	bh=Msd8kYtdHGpTD1vDseZPxiayCT7bH0CItP81+U7fmtQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Mlh1ufQG8JT8YZ84lL4kK0jQohYs3XAgTTkj5gFn1s+VPFZy7dn6nBfkws2a/nQX95D/WKY2N93TpXWz9VAmz0gwYoo6CJM87sQ0HL5KgN8GzkYIOKeD/ej4+GvEOJCMqRuPIumPbHSCVhKO6HBOpIf4bs0Y9WZVkdzUdoDr10Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pb7q/4bo; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768926569; x=1800462569;
  h=date:from:to:cc:subject:message-id;
  bh=Msd8kYtdHGpTD1vDseZPxiayCT7bH0CItP81+U7fmtQ=;
  b=Pb7q/4boGD/oFzvxjl5dVWHDF1rdE2dHcDJcw79vTMDhN96bmedMEDKc
   RcaiDmh1koOPrMcP0OAN3Rhsv685S0yYFDSSNGgCwVvV2MFmVVAlOJ1ks
   eubSD2jdo5gPYqDnaSHikx2rkDzlQPCymitg0B9LqY6Zxnt6MCWwVJIdK
   p1tNboP+L7TlIkrXer/XJxusYYDcOqJ0k52d1VozZuqDLsDO+tBhepD+z
   lX+sEZ0l5+ZKxwFHaV1Zgw4QUjofs3TsHIepYUp0h47OiWalVK8Bzdozc
   4BgbemcTMiKYfBSWDzLSb8V+jAZWeUzhhrcjpcUtRK4W2KSK+vUD3Q9Ob
   Q==;
X-CSE-ConnectionGUID: FGANe+tHQyaBTeTT44Aoww==
X-CSE-MsgGUID: +ugLgqboS5+K8t6QJ/x+Fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="81249709"
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="81249709"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 08:29:28 -0800
X-CSE-ConnectionGUID: Rj3A4AMPQ4KjrELzi7ySfA==
X-CSE-MsgGUID: HEDKKfdVRiyUqLT0edZVMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="211017697"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 20 Jan 2026 08:29:27 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1viEbc-00000000PEb-1sQ4;
	Tue, 20 Jan 2026 16:29:24 +0000
Date: Wed, 21 Jan 2026 00:29:17 +0800
From: kernel test robot <lkp@intel.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS WITH WARNING
 1375189be5a60de4c0966f9e1dc5b34f056ec04d
Message-ID: <202601210011.UEP6VwCi-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13136-lists,linux-ext4=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-ext4@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 724C64973C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: 1375189be5a60de4c0966f9e1dc5b34f056ec04d  ext4: allow zeroout when doing written to unwritten split

Warning (recently discovered and may have been fixed):

    fs/ext4/extents-test.c:48:9: warning: 'EX_DATA_LEN' redefined

Warning ids grouped by kconfigs:

recent_errors
`-- s390-allyesconfig
    `-- fs-ext4-extents-test.c:warning:EX_DATA_LEN-redefined

elapsed time: 724m

configs tested: 193
configs skipped: 3

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260120    clang-22
arc                   randconfig-002-20260120    clang-22
arc                           tb10x_defconfig    gcc-15.2.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                     am200epdkit_defconfig    clang-18
arm                                 defconfig    gcc-15.2.0
arm                          exynos_defconfig    clang-18
arm                          exynos_defconfig    gcc-15.2.0
arm                   randconfig-001-20260120    clang-22
arm                   randconfig-002-20260120    clang-22
arm                   randconfig-003-20260120    clang-22
arm                   randconfig-004-20260120    clang-22
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260120    gcc-15.2.0
arm64                 randconfig-002-20260120    gcc-15.2.0
arm64                 randconfig-003-20260120    gcc-15.2.0
arm64                 randconfig-004-20260120    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260120    gcc-15.2.0
csky                  randconfig-002-20260120    gcc-15.2.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260120    gcc-12.5.0
hexagon               randconfig-002-20260120    gcc-12.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260120    gcc-14
i386        buildonly-randconfig-002-20260120    gcc-14
i386        buildonly-randconfig-003-20260120    gcc-14
i386        buildonly-randconfig-004-20260120    gcc-14
i386        buildonly-randconfig-005-20260120    gcc-14
i386        buildonly-randconfig-006-20260120    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260120    clang-20
i386                  randconfig-001-20260120    gcc-14
i386                  randconfig-002-20260120    clang-20
i386                  randconfig-002-20260120    gcc-12
i386                  randconfig-003-20260120    clang-20
i386                  randconfig-004-20260120    clang-20
i386                  randconfig-005-20260120    clang-20
i386                  randconfig-006-20260120    clang-20
i386                  randconfig-007-20260120    clang-20
i386                  randconfig-007-20260120    gcc-14
i386                  randconfig-011-20260120    clang-20
i386                  randconfig-012-20260120    clang-20
i386                  randconfig-013-20260120    clang-20
i386                  randconfig-014-20260120    clang-20
i386                  randconfig-015-20260120    clang-20
i386                  randconfig-016-20260120    clang-20
i386                  randconfig-017-20260120    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260120    gcc-12.5.0
loongarch             randconfig-002-20260120    gcc-12.5.0
m68k                             alldefconfig    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                            gpr_defconfig    clang-18
mips                      maltasmvp_defconfig    gcc-15.2.0
mips                        vocore2_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260120    gcc-12.5.0
nios2                 randconfig-002-20260120    gcc-12.5.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-15.2.0
openrisc                       virt_defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260120    gcc-8.5.0
parisc                randconfig-002-20260120    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                    gamecube_defconfig    gcc-15.2.0
powerpc                      katmai_defconfig    clang-18
powerpc                      pmac32_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260120    gcc-8.5.0
powerpc               randconfig-002-20260120    gcc-8.5.0
powerpc                         wii_defconfig    clang-18
powerpc64             randconfig-001-20260120    gcc-8.5.0
powerpc64             randconfig-002-20260120    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260120    gcc-13.4.0
riscv                 randconfig-002-20260120    gcc-13.4.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260120    gcc-13.4.0
s390                  randconfig-002-20260120    gcc-13.4.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260120    gcc-13.4.0
sh                    randconfig-002-20260120    gcc-13.4.0
sparc                             allnoconfig    clang-22
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260120    gcc-8.5.0
sparc                 randconfig-002-20260120    gcc-8.5.0
sparc                       sparc32_defconfig    clang-18
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260120    gcc-8.5.0
sparc64               randconfig-002-20260120    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260120    gcc-8.5.0
um                    randconfig-002-20260120    gcc-8.5.0
um                           x86_64_defconfig    clang-18
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260120    gcc-14
x86_64      buildonly-randconfig-002-20260120    gcc-14
x86_64      buildonly-randconfig-003-20260120    gcc-14
x86_64      buildonly-randconfig-004-20260120    gcc-14
x86_64      buildonly-randconfig-005-20260120    gcc-14
x86_64      buildonly-randconfig-006-20260120    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260120    gcc-14
x86_64                randconfig-002-20260120    gcc-14
x86_64                randconfig-003-20260120    gcc-14
x86_64                randconfig-004-20260120    gcc-14
x86_64                randconfig-005-20260120    gcc-14
x86_64                randconfig-006-20260120    gcc-14
x86_64                randconfig-011-20260120    gcc-14
x86_64                randconfig-012-20260120    gcc-14
x86_64                randconfig-013-20260120    gcc-14
x86_64                randconfig-014-20260120    gcc-14
x86_64                randconfig-015-20260120    gcc-14
x86_64                randconfig-016-20260120    gcc-14
x86_64                randconfig-071-20260120    gcc-14
x86_64                randconfig-072-20260120    gcc-14
x86_64                randconfig-073-20260120    gcc-14
x86_64                randconfig-074-20260120    gcc-14
x86_64                randconfig-075-20260120    gcc-14
x86_64                randconfig-076-20260120    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20260120    gcc-8.5.0
xtensa                randconfig-002-20260120    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

