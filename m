Return-Path: <linux-ext4+bounces-12308-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F214CB7555
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Dec 2025 00:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 51F7930021CF
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Dec 2025 23:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F009F289374;
	Thu, 11 Dec 2025 23:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aZblhp9V"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B5221CFF6;
	Thu, 11 Dec 2025 23:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765494536; cv=none; b=M098zzJUZ5fivGGlReAkBrAwZn0rxXek17wMbc+PMEbTW+CziMC+PbrMvoQ0nQf+52nbnjQxdzTtbWSjW0P/vkbTFRGhM70tuvGF47/rhp1/p3rcbhjm6tHRrUvPXIyiz7w5qmFcqb2/IZ9X0oAopEcZBPEjUJfAtBiRvX2Y2PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765494536; c=relaxed/simple;
	bh=BGQm+n+FMLhDHGRmbCeAtzrHObckM+jPKyyD6jsQfLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6AICEp9eIJbODqwyVFM+vwpW6UUmihS0QL4zPcwKmpjmRu5HKqMgzgcuYm5I1MLd13/D9KrnU66l/XiteCg2PvbQ1HIOPLA/W0WM2WWkIQ+N55MOc7W6IYIMBsTfTwXnkKTFD9QEyP7RCY3uShCYmQkJvtEMEvT/+qbfSmRRUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aZblhp9V; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765494534; x=1797030534;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BGQm+n+FMLhDHGRmbCeAtzrHObckM+jPKyyD6jsQfLA=;
  b=aZblhp9Vw47ZRClBPTdvdte1nhwU1RHxBiCgdkKpaFOBiir/0OlydWvG
   9OiXXvsal4AS/33IY7DwSpXJDoC3f0HQQ6XlOp9CbPurpymBnb1QbISNR
   +GAQQRFEMKo0ekKOMNyflJfTjlL+g1w9QRrLHgkCIM56lvOsb8AjI5GbB
   vx75QpTrn41AYUg8qk4BewDAFnKmhyuZN5VFMgI9e4x9jMOI1KvoB0Kdy
   XcdK8COCrylPMrMrxmBIUUHuCfePDX1fQPlmy91D1MF85iUVDdiOVQveh
   JM0t+banaxTozfXCzM7pOUdTxyodaAUEhaHfoPEILg9h0wgO/Z71VGAKO
   Q==;
X-CSE-ConnectionGUID: 0H3/n9xSSS6Z9+dq+fSB3A==
X-CSE-MsgGUID: zOp0Vb20SaGw9dOu3el2tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="85094793"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="85094793"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 15:08:54 -0800
X-CSE-ConnectionGUID: xEVyJpDTQaONNOcce/BWYQ==
X-CSE-MsgGUID: XyfKaWeuQ8mZ3F/Qwg2RjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="196008851"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 11 Dec 2025 15:08:53 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vTpmE-000000005B3-1F1e;
	Thu, 11 Dec 2025 23:08:50 +0000
Date: Fri, 12 Dec 2025 07:08:01 +0800
From: kernel test robot <lkp@intel.com>
To: Yu Kuai <yukuai@fnnas.com>, tytso@mit.edu, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	yukuai@fnnas.com
Subject: Re: [PATCH 2/2] ext4: align preallocation size to stripe width
Message-ID: <202512120613.mM5COVWV-lkp@intel.com>
References: <20251208083246.320965-3-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208083246.320965-3-yukuai@fnnas.com>

Hi Yu,

kernel test robot noticed the following build errors:

[auto build test ERROR on tytso-ext4/dev]
[also build test ERROR on linus/master v6.18 next-20251211]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yu-Kuai/ext4-refactor-size-prediction-into-helper-functions/20251208-163553
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
patch link:    https://lore.kernel.org/r/20251208083246.320965-3-yukuai%40fnnas.com
patch subject: [PATCH 2/2] ext4: align preallocation size to stripe width
config: arm-randconfig-r072-20251210 (https://download.01.org/0day-ci/archive/20251212/202512120613.mM5COVWV-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251212/202512120613.mM5COVWV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512120613.mM5COVWV-lkp@intel.com/

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: fs/ext4/mballoc.o: in function `ext4_mb_predict_file_size':
>> mballoc.c:(.text+0x242): undefined reference to `__aeabi_ldivmod'
   arm-linux-gnueabi-ld: (__aeabi_ldivmod): Unknown destination type (ARM/Thumb) in fs/ext4/mballoc.o
>> mballoc.c:(.text+0x242): dangerous relocation: unsupported relocation
>> arm-linux-gnueabi-ld: mballoc.c:(.text+0x268): undefined reference to `__aeabi_ldivmod'
   arm-linux-gnueabi-ld: (__aeabi_ldivmod): Unknown destination type (ARM/Thumb) in fs/ext4/mballoc.o
   mballoc.c:(.text+0x268): dangerous relocation: unsupported relocation
   arm-linux-gnueabi-ld: mballoc.c:(.text+0x29c): undefined reference to `__aeabi_ldivmod'
   arm-linux-gnueabi-ld: (__aeabi_ldivmod): Unknown destination type (ARM/Thumb) in fs/ext4/mballoc.o
   mballoc.c:(.text+0x29c): dangerous relocation: unsupported relocation

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

