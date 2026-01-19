Return-Path: <linux-ext4+bounces-12970-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB19ED39D81
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Jan 2026 05:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37D3F300760D
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Jan 2026 04:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE18B2690D5;
	Mon, 19 Jan 2026 04:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WZv4qVzm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E281DF73A
	for <linux-ext4@vger.kernel.org>; Mon, 19 Jan 2026 04:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768797377; cv=none; b=g2ZdrIxEc0Taa3+6L1rDqD0ZvcV+KwuqMifZJfVkWX8K79jw0ay5OQlvGg5YqEMs6dWd1dSydSDa4QUpDd9k21p0x+xzX6neNdU1HRlUUE2C3Cs3rMaCMx8a73hE3VMbrMuptCeFs3X9Le6WK3LG9GAFoJxrT8ekaKLtUnuUToA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768797377; c=relaxed/simple;
	bh=OG2UFaxvK5CzxQHxMsVYXZpHHMONXXBnL6vO4w2jNuQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=c24HlCZjYPVk6857oqkwi3AUdczc9MITpm2rHpPYDfkrt85W73CoDkpfE4CgSNuxdLq7tMqUvSnG5BAh4zMdmP/Xk5X2QbqYUFih6MawzIdMEGMst0X1VzHwEtx+6CoXZMzX6+Iy6FSAWznLmL3Et3WANDe2n/NztPZHeaCmmVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WZv4qVzm; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768797375; x=1800333375;
  h=date:from:to:cc:subject:message-id;
  bh=OG2UFaxvK5CzxQHxMsVYXZpHHMONXXBnL6vO4w2jNuQ=;
  b=WZv4qVzmTnE0LyTk6lKc9JCbRsjtUP0xcBS0a701ZoatUyMe5PTlHMAR
   sHOumlgttmmaNOXwJF4Lt7sISpWFUIltUueQakuktvqo71bdpsx0eTUzb
   gIxkTAOx25jn2I6IC52C8sEId3kr1K2K0awwsnI/TnAXDSlzIRLwe7PFB
   nRP2w3RhLW/QFW+QPOwG09oE+CUmY5meej6GKP55MI682SxgtNOAB5EHk
   UcAg6kTcy+7HgZnmnqDX+nTyRRCWpH8RnH+aLScyoRagLAyzRXd7WSYxU
   EpWvJ7KKNSijfG86kob3qhcAVETrMAFlFrcJU+2glAlycNMcgVaeTxjC8
   Q==;
X-CSE-ConnectionGUID: y3yuKKm8TpqBUViryFDJwg==
X-CSE-MsgGUID: I9QPqjD2TkCwqVzJwTczyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="81118671"
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="81118671"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 20:36:15 -0800
X-CSE-ConnectionGUID: XJqtxix4Qyu5TRmk4BZ3gw==
X-CSE-MsgGUID: 7AHHFHOnT6q9O54cuJp/Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="210249728"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 18 Jan 2026 20:36:09 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vhgzm-00000000NSj-43tS;
	Mon, 19 Jan 2026 04:36:06 +0000
Date: Mon, 19 Jan 2026 12:35:54 +0800
From: kernel test robot <lkp@intel.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD REGRESSION
 11f1ff3cc21a8e9ca9f509a664de5975469ec561
Message-ID: <202601191230.CXFSqYnl-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: 11f1ff3cc21a8e9ca9f509a664de5975469ec561  ext4: mark group extend fast-commit ineligible

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202601190438.9w3maqnc-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202601190552.ZJeAkmLt-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202601190600.xYVh1uKf-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202601191038.JQbdLRwC-lkp@intel.com

    fs/ext4/extents-test.c:299:19: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'int' [-Wformat=]
    fs/ext4/extents-test.c:300:5: warning: format specifies type 'long' but the argument has type '__ptrdiff_t' (aka 'int') [-Wformat]
    fs/ext4/extents-test.c:300:5: warning: format specifies type 'long' but the argument has type 'int' [-Wformat]
    fs/ext4/extents-test.c:323:19: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'int' [-Wformat=]
    fs/ext4/extents-test.c:323:5: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'int' [-Wformat=]
    fs/ext4/extents-test.c:48:9: warning: 'EX_DATA_LEN' redefined
    fs/ext4/move_extent.c:324:26: error: 'sb' undeclared (first use in this function); did you mean 's8'?
    fs/ext4/move_extent.c:324:26: error: use of undeclared identifier 'sb'
    fs/ext4/move_extent.c:324:33: error: 'sb' undeclared (first use in this function); did you mean 's8'?
    fs/ext4/move_extent.c:324:33: error: 'sb' undeclared (first use in this function); did you mean 'tsb'?

Error/Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allyesconfig
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- alpha-randconfig-r064-20260119
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- arc-allmodconfig
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- arc-allyesconfig
|   |-- fs-ext4-extents-test.c:warning:format-ld-expects-argument-of-type-long-int-but-argument-has-type-int
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- arc-axs103_defconfig
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- arc-hsdk_defconfig
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- arc-randconfig-r122-20260119
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- arm-allyesconfig
|   |-- fs-ext4-extents-test.c:warning:format-ld-expects-argument-of-type-long-int-but-argument-has-type-int
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- arm-bcm2835_defconfig
|   `-- fs-ext4-move_extent.c:error:use-of-undeclared-identifier-sb
|-- arm-dove_defconfig
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- arm-multi_v5_defconfig
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- arm-mxs_defconfig
|   `-- fs-ext4-move_extent.c:error:use-of-undeclared-identifier-sb
|-- arm-omap2plus_defconfig
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- arm-pxa_defconfig
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- arm-qcom_defconfig
|   `-- fs-ext4-move_extent.c:error:use-of-undeclared-identifier-sb
|-- arm-randconfig-002-20260119
|   `-- fs-ext4-move_extent.c:error:use-of-undeclared-identifier-sb
|-- arm-randconfig-003-20260119
|   `-- fs-ext4-move_extent.c:error:use-of-undeclared-identifier-sb
|-- arm-randconfig-r063-20260119
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- arm-sp7021_defconfig
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- arm-spitz_defconfig
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- arm-u8500_defconfig
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- arm64-defconfig
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- arm64-randconfig-004-20260119
|   `-- fs-ext4-move_extent.c:error:use-of-undeclared-identifier-sb
|-- csky-allmodconfig
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- csky-defconfig
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- csky-randconfig-001-20260119
|   |-- fs-ext4-extents-test.c:warning:format-ld-expects-argument-of-type-long-int-but-argument-has-type-int
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- csky-randconfig-002-20260119
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- csky-randconfig-r054-20260119
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- hexagon-allmodconfig
|   `-- fs-ext4-move_extent.c:error:use-of-undeclared-identifier-sb
|-- i386-allmodconfig
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- i386-allyesconfig
|   |-- fs-ext4-extents-test.c:warning:format-ld-expects-argument-of-type-long-int-but-argument-has-type-int
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- i386-buildonly-randconfig-001-20260119
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- i386-buildonly-randconfig-002-20260119
|   |-- fs-ext4-extents-test.c:warning:format-specifies-type-long-but-the-argument-has-type-int
|   `-- fs-ext4-move_extent.c:error:use-of-undeclared-identifier-sb
|-- i386-buildonly-randconfig-003-20260119
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- i386-buildonly-randconfig-006-20260119
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- i386-randconfig-003-20260119
|   `-- fs-ext4-move_extent.c:error:use-of-undeclared-identifier-sb
|-- i386-randconfig-006-20260119
|   `-- fs-ext4-move_extent.c:error:use-of-undeclared-identifier-sb
|-- i386-randconfig-007-20260119
|   `-- fs-ext4-move_extent.c:error:use-of-undeclared-identifier-sb
|-- i386-randconfig-012-20260119
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- i386-randconfig-013-20260119
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- i386-randconfig-015-20260119
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- i386-randconfig-016-20260119
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- i386-randconfig-051-20260119
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- i386-randconfig-052-20260119
|   `-- fs-ext4-move_extent.c:error:use-of-undeclared-identifier-sb
|-- i386-randconfig-061-20260119
|   `-- fs-ext4-move_extent.c:error:use-of-undeclared-identifier-sb
|-- i386-randconfig-062-20260119
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- i386-randconfig-063-20260119
|   `-- fs-ext4-move_extent.c:error:use-of-undeclared-identifier-sb
|-- loongarch-defconfig
|   `-- fs-ext4-move_extent.c:error:use-of-undeclared-identifier-sb
|-- loongarch-randconfig-001-20260119
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- loongarch-randconfig-002-20260119
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- loongarch-randconfig-r064-20260119
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- m68k-allmodconfig
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- m68k-allyesconfig
|   |-- fs-ext4-extents-test.c:warning:format-ld-expects-argument-of-type-long-int-but-argument-has-type-int
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- m68k-defconfig
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- m68k-randconfig-r064-20260119
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- microblaze-allyesconfig
|   |-- fs-ext4-extents-test.c:warning:format-ld-expects-argument-of-type-long-int-but-argument-has-type-int
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- microblaze-defconfig
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- microblaze-randconfig-r123-20260119
|   |-- fs-ext4-extents-test.c:warning:format-ld-expects-argument-of-type-long-int-but-argument-has-type-int
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- mips-allmodconfig
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- mips-allyesconfig
|   |-- fs-ext4-extents-test.c:warning:format-ld-expects-argument-of-type-long-int-but-argument-has-type-int
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- mips-bigsur_defconfig
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- mips-bmips_stb_defconfig
|   `-- fs-ext4-move_extent.c:error:use-of-undeclared-identifier-sb
|-- mips-cu1830-neo_defconfig
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- mips-eyeq6_defconfig
|   `-- fs-ext4-move_extent.c:error:use-of-undeclared-identifier-sb
|-- mips-malta_defconfig
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- nios2-allmodconfig
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- openrisc-allmodconfig
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- parisc-allmodconfig
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- parisc-allyesconfig
|   |-- fs-ext4-extents-test.c:warning:format-ld-expects-argument-of-type-long-int-but-argument-has-type-int
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- parisc-defconfig
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- parisc-randconfig-001-20260119
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- parisc-randconfig-002-20260119
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- parisc64-defconfig
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- powerpc-allmodconfig
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- powerpc-iss476-smp_defconfig
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- powerpc-microwatt_defconfig
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- powerpc-powernv_defconfig
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- powerpc-ppc44x_defconfig
|   `-- fs-ext4-move_extent.c:error:use-of-undeclared-identifier-sb
|-- powerpc-ppc64e_defconfig
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- powerpc-randconfig-002-20260119
|   |-- fs-ext4-extents-test.c:warning:format-specifies-type-long-but-the-argument-has-type-__ptrdiff_t-(aka-int-)
|   `-- fs-ext4-move_extent.c:error:use-of-undeclared-identifier-sb
|-- powerpc-randconfig-r073-20260119
|   |-- fs-ext4-extents-test.c:warning:format-ld-expects-argument-of-type-long-int-but-argument-has-type-int
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- powerpc-tqm8560_defconfig
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- powerpc64-randconfig-r061-20260119
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- riscv-allyesconfig
|   `-- fs-ext4-move_extent.c:error:use-of-undeclared-identifier-sb
|-- riscv-defconfig
|   `-- fs-ext4-move_extent.c:error:use-of-undeclared-identifier-sb
|-- riscv-randconfig-001-20260119
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- riscv-randconfig-002-20260119
|   `-- fs-ext4-move_extent.c:error:use-of-undeclared-identifier-sb
|-- riscv-randconfig-r071-20260119
|   |-- fs-ext4-extents-test.c:warning:format-ld-expects-argument-of-type-long-int-but-argument-has-type-int
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- s390-allmodconfig
|   `-- fs-ext4-move_extent.c:error:use-of-undeclared-identifier-sb
|-- s390-allyesconfig
|   |-- fs-ext4-extents-test.c:warning:EX_DATA_LEN-redefined
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- s390-randconfig-001-20260119
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- s390-randconfig-002-20260119
|   `-- fs-ext4-move_extent.c:error:use-of-undeclared-identifier-sb
|-- sh-allmodconfig
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- sh-allyesconfig
|   |-- fs-ext4-extents-test.c:warning:format-ld-expects-argument-of-type-long-int-but-argument-has-type-int
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- sh-defconfig
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- sh-randconfig-002-20260119
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- sh-shx3_defconfig
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- sparc-randconfig-002-20260119
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- sparc-randconfig-r071-20260119
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- sparc64-allmodconfig
|   `-- fs-ext4-move_extent.c:error:use-of-undeclared-identifier-sb
|-- sparc64-defconfig
|   `-- fs-ext4-move_extent.c:error:use-of-undeclared-identifier-sb
|-- sparc64-randconfig-001-20260119
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- sparc64-randconfig-002-20260119
|   `-- fs-ext4-move_extent.c:error:use-of-undeclared-identifier-sb
|-- um-allmodconfig
|   `-- fs-ext4-move_extent.c:error:use-of-undeclared-identifier-sb
|-- um-allyesconfig
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- um-i386_defconfig
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- x86_64-buildonly-randconfig-006-20260119
|   `-- fs-ext4-move_extent.c:error:use-of-undeclared-identifier-sb
|-- x86_64-defconfig
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- x86_64-randconfig-001-20260119
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- x86_64-randconfig-003-20260119
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- x86_64-randconfig-004-20260119
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- x86_64-randconfig-005-20260119
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- x86_64-randconfig-012-20260119
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- x86_64-randconfig-015-20260119
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- x86_64-randconfig-016-20260119
|   `-- fs-ext4-move_extent.c:error:use-of-undeclared-identifier-sb
|-- x86_64-randconfig-075-20260119
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- x86_64-rhel-9.4
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- x86_64-rhel-9.4-bpf
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- x86_64-rhel-9.4-func
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- x86_64-rhel-9.4-kselftests
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- x86_64-rhel-9.4-kunit
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- x86_64-rhel-9.4-ltp
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- xtensa-allyesconfig
|   |-- fs-ext4-extents-test.c:warning:format-ld-expects-argument-of-type-long-int-but-argument-has-type-int
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
|-- xtensa-nommu_kc705_defconfig
|   `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)
`-- xtensa-randconfig-002-20260119
    `-- fs-ext4-move_extent.c:error:sb-undeclared-(first-use-in-this-function)

elapsed time: 722m

configs tested: 236
configs skipped: 2

tested configs:
alpha                            alldefconfig    gcc-15.2.0
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              alldefconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                            hsdk_defconfig    gcc-15.2.0
arc                   randconfig-001-20260119    gcc-14.3.0
arc                   randconfig-002-20260119    gcc-14.3.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                         bcm2835_defconfig    gcc-15.2.0
arm                        clps711x_defconfig    gcc-15.2.0
arm                          collie_defconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                            dove_defconfig    gcc-15.2.0
arm                          ep93xx_defconfig    gcc-15.2.0
arm                       imx_v4_v5_defconfig    gcc-15.2.0
arm                      jornada720_defconfig    clang-22
arm                         lpc32xx_defconfig    gcc-15.2.0
arm                            mps2_defconfig    gcc-15.2.0
arm                        multi_v5_defconfig    clang-22
arm                       omap2plus_defconfig    clang-18
arm                             pxa_defconfig    clang-18
arm                   randconfig-001-20260119    gcc-14.3.0
arm                   randconfig-002-20260119    gcc-14.3.0
arm                   randconfig-003-20260119    gcc-14.3.0
arm                   randconfig-004-20260119    gcc-14.3.0
arm                         s3c6400_defconfig    gcc-15.2.0
arm                          sp7021_defconfig    gcc-15.2.0
arm                           spitz_defconfig    gcc-15.2.0
arm                           u8500_defconfig    gcc-15.2.0
arm                    vt8500_v6_v7_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260119    clang-19
arm64                 randconfig-002-20260119    clang-19
arm64                 randconfig-003-20260119    clang-19
arm64                 randconfig-004-20260119    clang-19
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260119    clang-19
csky                  randconfig-002-20260119    clang-19
hexagon                          alldefconfig    clang-22
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260119    clang-18
hexagon               randconfig-002-20260119    clang-18
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260119    clang-20
i386        buildonly-randconfig-002-20260119    clang-20
i386        buildonly-randconfig-003-20260119    clang-20
i386        buildonly-randconfig-004-20260119    clang-20
i386        buildonly-randconfig-005-20260119    clang-20
i386        buildonly-randconfig-006-20260119    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260119    gcc-13
i386                  randconfig-002-20260119    gcc-13
i386                  randconfig-003-20260119    gcc-13
i386                  randconfig-004-20260119    gcc-13
i386                  randconfig-005-20260119    gcc-13
i386                  randconfig-006-20260119    gcc-13
i386                  randconfig-007-20260119    gcc-13
i386                  randconfig-011-20260119    gcc-14
i386                  randconfig-012-20260119    gcc-14
i386                  randconfig-013-20260119    gcc-14
i386                  randconfig-014-20260119    gcc-14
i386                  randconfig-015-20260119    gcc-14
i386                  randconfig-016-20260119    gcc-14
i386                  randconfig-017-20260119    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260119    clang-18
loongarch             randconfig-002-20260119    clang-18
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                         apollo_defconfig    gcc-15.2.0
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                         bigsur_defconfig    gcc-15.2.0
mips                      bmips_stb_defconfig    gcc-15.2.0
mips                     cu1830-neo_defconfig    gcc-15.2.0
mips                          eyeq6_defconfig    clang-18
mips                           gcw0_defconfig    gcc-15.2.0
mips                            gpr_defconfig    clang-18
mips                           ip28_defconfig    gcc-15.2.0
mips                          rb532_defconfig    clang-22
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260119    clang-18
nios2                 randconfig-002-20260119    clang-18
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-15.2.0
openrisc                    or1ksim_defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                generic-64bit_defconfig    gcc-15.2.0
parisc                randconfig-001-20260119    clang-22
parisc                randconfig-002-20260119    clang-22
parisc64                            defconfig    clang-19
powerpc                    adder875_defconfig    clang-18
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                      ep88xc_defconfig    gcc-15.2.0
powerpc                  iss476-smp_defconfig    clang-22
powerpc                   microwatt_defconfig    gcc-15.2.0
powerpc                  mpc885_ads_defconfig    gcc-15.2.0
powerpc                     powernv_defconfig    gcc-15.2.0
powerpc                      ppc44x_defconfig    clang-18
powerpc                      ppc64e_defconfig    gcc-15.2.0
powerpc                     rainier_defconfig    clang-22
powerpc               randconfig-001-20260119    clang-22
powerpc               randconfig-002-20260119    clang-22
powerpc                     redwood_defconfig    gcc-15.2.0
powerpc                     tqm8541_defconfig    gcc-15.2.0
powerpc                     tqm8548_defconfig    gcc-15.2.0
powerpc                     tqm8560_defconfig    clang-18
powerpc64                        alldefconfig    gcc-15.2.0
powerpc64             randconfig-001-20260119    clang-22
powerpc64             randconfig-002-20260119    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260119    gcc-15.2.0
riscv                 randconfig-001-20260119    gcc-8.5.0
riscv                 randconfig-002-20260119    clang-22
riscv                 randconfig-002-20260119    gcc-15.2.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260119    gcc-15.2.0
s390                  randconfig-001-20260119    gcc-9.5.0
s390                  randconfig-002-20260119    clang-22
s390                  randconfig-002-20260119    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                        edosk7705_defconfig    gcc-15.2.0
sh                          polaris_defconfig    gcc-15.2.0
sh                    randconfig-001-20260119    gcc-15.2.0
sh                    randconfig-002-20260119    gcc-12.5.0
sh                    randconfig-002-20260119    gcc-15.2.0
sh                        sh7763rdp_defconfig    gcc-15.2.0
sh                   sh7770_generic_defconfig    clang-22
sh                  sh7785lcr_32bit_defconfig    gcc-15.2.0
sh                            shmin_defconfig    gcc-15.2.0
sh                             shx3_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260119    gcc-14.3.0
sparc                 randconfig-002-20260119    gcc-14.3.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260119    gcc-14.3.0
sparc64               randconfig-002-20260119    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260119    gcc-14.3.0
um                    randconfig-002-20260119    gcc-14.3.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260119    gcc-14
x86_64      buildonly-randconfig-002-20260119    gcc-14
x86_64      buildonly-randconfig-003-20260119    gcc-14
x86_64      buildonly-randconfig-004-20260119    gcc-14
x86_64      buildonly-randconfig-005-20260119    gcc-14
x86_64      buildonly-randconfig-006-20260119    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260119    gcc-14
x86_64                randconfig-002-20260119    gcc-14
x86_64                randconfig-003-20260119    gcc-14
x86_64                randconfig-004-20260119    gcc-14
x86_64                randconfig-005-20260119    gcc-14
x86_64                randconfig-006-20260119    gcc-14
x86_64                randconfig-011-20260119    clang-20
x86_64                randconfig-012-20260119    clang-20
x86_64                randconfig-013-20260119    clang-20
x86_64                randconfig-014-20260119    clang-20
x86_64                randconfig-015-20260119    clang-20
x86_64                randconfig-016-20260119    clang-20
x86_64                randconfig-071-20260119    clang-20
x86_64                randconfig-072-20260119    clang-20
x86_64                randconfig-073-20260119    clang-20
x86_64                randconfig-074-20260119    clang-20
x86_64                randconfig-075-20260119    clang-20
x86_64                randconfig-076-20260119    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                           allyesconfig    clang-22
xtensa                          iss_defconfig    gcc-15.2.0
xtensa                  nommu_kc705_defconfig    clang-18
xtensa                randconfig-001-20260119    gcc-14.3.0
xtensa                randconfig-002-20260119    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

