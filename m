Return-Path: <linux-ext4+bounces-12963-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAD5D399F0
	for <lists+linux-ext4@lfdr.de>; Sun, 18 Jan 2026 22:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 21EA130078BD
	for <lists+linux-ext4@lfdr.de>; Sun, 18 Jan 2026 21:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6D21D88D7;
	Sun, 18 Jan 2026 21:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZoAL5/Ey"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066E5190664
	for <linux-ext4@vger.kernel.org>; Sun, 18 Jan 2026 21:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768770926; cv=none; b=Stm1lfthnBXDg3Mz26bv1iCTir8He7/ziRyBsRLLIoOcVzy8brV4LPnyjbHCvcgyC4ef0HBeR7Wnsu4oukHC409dkh3utZkLY/WJd1uIJmbSKu0Dxv5S0LbYqKP/L6dkgbWUCF6YLusypuZes/JWV+eo1ZCcBi3qAAzZgxrbkXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768770926; c=relaxed/simple;
	bh=nzTze7Oy2Ww98/C574URFvYNK38eHRGnE5Q2j/sicpo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XZcOEw+MaCnUCVwnbtR1JAjlbRCZISsB5zGGnvzDiLKf4j84TkNx1lqrPApj31z1n7fWqqF0oIbkm1s43iHfuA0mGRGASNS8VpK3uc5189NpLyEG6329peKVHK/V0teiUxi7cBOQTVgcMoaLOmMm9dLfiCy0jZE1Bns60V2PUOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZoAL5/Ey; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768770925; x=1800306925;
  h=date:from:to:cc:subject:message-id;
  bh=nzTze7Oy2Ww98/C574URFvYNK38eHRGnE5Q2j/sicpo=;
  b=ZoAL5/EyeUn9qFGU1vZpBcglDQS7IJPbS3MDWC/sQv5BsVQYoIjVYrVb
   oF65iia/KJjq+3d72Bbb9vHm3vz1rfQ9emAC3a4VqQddRHyF6dLzZfp4Z
   U+GXPxprwoEfkkuoJwTSY4il6ofdu1SYjN31SDi5LFg6wJ3nVUiIyiUxQ
   Z0XouqAd5FJezLtYBgYNT0D7PFXQAs2lPquGUzXMUTpPlz+FJsci+cbHB
   DvCA02LEEHMNfOwNB/f5Fb8ncW5Ract4EKOL9b2HBBpZxHmOw+T690Vf0
   E5JhXQ5RfSIX47OmUiqKJ506TElz33mp9894sNB1MkS5rUaUuM4Xtoy8E
   A==;
X-CSE-ConnectionGUID: 2JxDzo8zT/eps0uqMK3dpA==
X-CSE-MsgGUID: Ggy9kWXgQfefr49tNxEnGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="69892510"
X-IronPort-AV: E=Sophos;i="6.21,236,1763452800"; 
   d="scan'208";a="69892510"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 13:15:25 -0800
X-CSE-ConnectionGUID: oIifd4uMQNCD9SB1CgDAuQ==
X-CSE-MsgGUID: I3kADDy5RTKG/W+UqNO4oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,236,1763452800"; 
   d="scan'208";a="206132202"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 18 Jan 2026 13:15:22 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vha7E-00000000NEH-0wqK;
	Sun, 18 Jan 2026 21:15:20 +0000
Date: Mon, 19 Jan 2026 05:14:48 +0800
From: kernel test robot <lkp@intel.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
 Jan Kara <jack@suse.cz>
Subject: [tytso-ext4:dev 25/37] fs/ext4/extents-test.c:300:5:
 warning: format specifies type 'long' but the argument has type '__ptrdiff_t'
 (aka 'int')
Message-ID: <202601190552.ZJeAkmLt-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
head:   11f1ff3cc21a8e9ca9f509a664de5975469ec561
commit: 16bbdb54f49e58d51dbf2217bab9ed424172ea9a [25/37] ext4: kunit tests for extent splitting and conversion
config: powerpc-randconfig-002-20260119 (https://download.01.org/0day-ci/archive/20260119/202601190552.ZJeAkmLt-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260119/202601190552.ZJeAkmLt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601190552.ZJeAkmLt-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from fs/ext4/extents.c:6200:
>> fs/ext4/extents-test.c:300:5: warning: format specifies type 'long' but the argument has type '__ptrdiff_t' (aka 'int') [-Wformat]
     299 |                   "# %s: wrong char found at offset %ld (expected:%d got:%d)", __func__,
         |                                                     ~~~
         |                                                     %td
     300 |                   ((char *)ret - buf), c, *((char *)ret));
         |                   ^~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:661:21: note: expanded from macro 'kunit_log'
     661 |                 printk(lvl fmt, ##__VA_ARGS__);                         \
         |                            ~~~    ^~~~~~~~~~~
   include/linux/printk.h:512:60: note: expanded from macro 'printk'
     512 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                                                     ~~~    ^~~~~~~~~~~
   include/linux/printk.h:484:19: note: expanded from macro 'printk_index_wrap'
     484 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ~~~~    ^~~~~~~~~~~
   In file included from fs/ext4/extents.c:6200:
>> fs/ext4/extents-test.c:300:5: warning: format specifies type 'long' but the argument has type '__ptrdiff_t' (aka 'int') [-Wformat]
     299 |                   "# %s: wrong char found at offset %ld (expected:%d got:%d)", __func__,
         |                                                     ~~~
         |                                                     %td
     300 |                   ((char *)ret - buf), c, *((char *)ret));
         |                   ^~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:663:8: note: expanded from macro 'kunit_log'
     662 |                 kunit_log_append((test_or_suite)->log,  fmt,            \
         |                                                         ~~~
     663 |                                  ##__VA_ARGS__);                        \
         |                                    ^~~~~~~~~~~
   2 warnings generated.


vim +300 fs/ext4/extents-test.c

   286	
   287	/*
   288	 * Return 1 if all bytes in the buf equal to c, else return the offset of first mismatch
   289	 */
   290	static int check_buffer(char *buf, int c, int size)
   291	{
   292		void *ret = NULL;
   293	
   294		ret = memchr_inv(buf, c, size);
   295		if (ret  == NULL)
   296			return 0;
   297	
   298		kunit_log(KERN_ALERT, kunit_get_current_test(),
   299			  "# %s: wrong char found at offset %ld (expected:%d got:%d)", __func__,
 > 300			  ((char *)ret - buf), c, *((char *)ret));
   301		return 1;
   302	}
   303	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

