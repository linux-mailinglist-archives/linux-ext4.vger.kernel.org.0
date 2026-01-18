Return-Path: <linux-ext4+bounces-12964-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EB7D39A66
	for <lists+linux-ext4@lfdr.de>; Sun, 18 Jan 2026 23:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74FDD3009100
	for <lists+linux-ext4@lfdr.de>; Sun, 18 Jan 2026 22:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823AC30C603;
	Sun, 18 Jan 2026 22:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ntRH91mc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C2730BF6D
	for <linux-ext4@vger.kernel.org>; Sun, 18 Jan 2026 22:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768774230; cv=none; b=lkZzcqRjhjwQXA5h5Iqx0jpxXjzHVGn5nY2TUibWJ+MCfpSbHwez+V0GnJocXVfvm5OpuS9nCXMliBHI5XwAWNw8+GSjCpv8pLkKNqgtTXtr9ztocjSOwj+QZr5wiiPvoLBZg2KhoBusc9KnQVuSYz+dcpPWUyXKzcIw6Wp/d7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768774230; c=relaxed/simple;
	bh=X4a3Irmj+vX1hCyAXSnVDpj/jz8naUG5TnZN3hNxXTk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RMl9jo6JkXjXk1nWtpLR2gdC+1L+ZQ6uLUDSR+nzKD9+MBplTI8wU1cwp9QbCTXPTxpYT/EAuLrswRs9VDHzKPGgecWn6seZ2kl9IpgEAamn4KH/ldJC0MyaZ6kv0E9d4jNWHz7YVyljo2l60eX/wnhEoA8Fa/bXC3LSNpGjL1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ntRH91mc; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768774226; x=1800310226;
  h=date:from:to:cc:subject:message-id;
  bh=X4a3Irmj+vX1hCyAXSnVDpj/jz8naUG5TnZN3hNxXTk=;
  b=ntRH91mcP5bgUXzbFutKXXDVo3DKUNRVl8Z/epp4H3ZMZH5OAGafM5v8
   4MmxCOmHNFfB+XDnZIDaiOyIxhz0nCnTrFJz1kxDufB3RTxPCBiEq1qKe
   +z9ZaCXMmjCkYWeNdwhPozw6+7QVAQhMAj+DhzybN12N0vFVN/H+lC9AT
   hv68OJFBrXcexbS2xO31CJVHCY0QsALIgsFEmkLlORxo/JT1DEHz0rDu3
   w+tbExQLqoG3TBcWmPTxQH7Uvois314eKHHssDDxMU3vdWZqoEleq90DC
   mKPpxR+9SBFgi3araTBGPVS3ZDGZQgOPZoSe/2nDOCv/Sm2Z9dx3/z4Ve
   g==;
X-CSE-ConnectionGUID: lqtUctcKRRqJWrUp4f1TYA==
X-CSE-MsgGUID: EsJKD676TQyhkVv7Sm008g==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="69904177"
X-IronPort-AV: E=Sophos;i="6.21,236,1763452800"; 
   d="scan'208";a="69904177"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 14:10:25 -0800
X-CSE-ConnectionGUID: JtwhbvIEQ9qZI5MivBRe5w==
X-CSE-MsgGUID: qZhVGQm/RRSvQEeCvTNTHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,236,1763452800"; 
   d="scan'208";a="210568373"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 18 Jan 2026 14:10:24 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vhayU-00000000NFz-270E;
	Sun, 18 Jan 2026 22:10:22 +0000
Date: Mon, 19 Jan 2026 06:09:58 +0800
From: kernel test robot <lkp@intel.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-ext4@vger.kernel.org,
 "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Subject: [tytso-ext4:dev 25/37] fs/ext4/extents-test.c:299:19:
 warning: format '%ld' expects argument of type 'long int', but argument 4 has
 type 'int'
Message-ID: <202601190600.xYVh1uKf-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
head:   11f1ff3cc21a8e9ca9f509a664de5975469ec561
commit: 16bbdb54f49e58d51dbf2217bab9ed424172ea9a [25/37] ext4: kunit tests for extent splitting and conversion
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20260119/202601190600.xYVh1uKf-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260119/202601190600.xYVh1uKf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601190600.xYVh1uKf-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:31,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/random.h:6,
                    from include/linux/nodemask.h:94,
                    from include/linux/list_lru.h:12,
                    from include/linux/fs/super_types.h:7,
                    from include/linux/fs/super.h:5,
                    from include/linux/fs.h:5,
                    from fs/ext4/extents.c:20:
   fs/ext4/extents-test.c: In function 'check_buffer':
   include/linux/kern_levels.h:5:25: warning: format '%ld' expects argument of type 'long int', but argument 3 has type 'int' [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:484:25: note: in definition of macro 'printk_index_wrap'
     484 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/kunit/test.h:661:17: note: in expansion of macro 'printk'
     661 |                 printk(lvl fmt, ##__VA_ARGS__);                         \
         |                 ^~~~~~
   fs/ext4/extents-test.c:298:9: note: in expansion of macro 'kunit_log'
     298 |         kunit_log(KERN_ALERT, kunit_get_current_test(),
         |         ^~~~~~~~~
   include/linux/kern_levels.h:9:25: note: in expansion of macro 'KERN_SOH'
       9 | #define KERN_ALERT      KERN_SOH "1"    /* action must be taken immediately */
         |                         ^~~~~~~~
   fs/ext4/extents-test.c:298:19: note: in expansion of macro 'KERN_ALERT'
     298 |         kunit_log(KERN_ALERT, kunit_get_current_test(),
         |                   ^~~~~~~~~~
   In file included from include/kunit/static_stub.h:18,
                    from fs/ext4/extents.c:35:
>> fs/ext4/extents-test.c:299:19: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'int' [-Wformat=]
     299 |                   "# %s: wrong char found at offset %ld (expected:%d got:%d)", __func__,
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     300 |                   ((char *)ret - buf), c, *((char *)ret));
         |                   ~~~~~~~~~~~~~~~~~~~
         |                                |
         |                                int
   include/kunit/test.h:662:57: note: in definition of macro 'kunit_log'
     662 |                 kunit_log_append((test_or_suite)->log,  fmt,            \
         |                                                         ^~~
   In file included from fs/ext4/extents.c:6200:
   fs/ext4/extents-test.c:299:55: note: format string is defined here
     299 |                   "# %s: wrong char found at offset %ld (expected:%d got:%d)", __func__,
         |                                                     ~~^
         |                                                       |
         |                                                       long int
         |                                                     %d


vim +299 fs/ext4/extents-test.c

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
 > 299			  "# %s: wrong char found at offset %ld (expected:%d got:%d)", __func__,
   300			  ((char *)ret - buf), c, *((char *)ret));
   301		return 1;
   302	}
   303	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

