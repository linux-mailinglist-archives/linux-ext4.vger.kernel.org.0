Return-Path: <linux-ext4+bounces-12146-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AE0CA1645
	for <lists+linux-ext4@lfdr.de>; Wed, 03 Dec 2025 20:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 335233114969
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Dec 2025 19:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6625233290D;
	Wed,  3 Dec 2025 19:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a996FR+t"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDE631CA68;
	Wed,  3 Dec 2025 19:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764789634; cv=none; b=Ahtv1+++QXmtrhkVO+MDQcmWEhHrCZQNq1p88NqvdUu4hQcrPBvkcbjCpvHjlgVDGRtxD0hv3x/OdOLsb4UUOG+pCxvyu2nwpZ8L3cWqA80lZPzebmHtjVe1VSvB1YEyljIEJ7vt61YEThBiDiSODprDmH1ai5w/MuXFr+hXDG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764789634; c=relaxed/simple;
	bh=FIH5XXRWTTG9cqNGaq/Vs0rr7opFOiMVp1spJbp3Kd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUfpPhy8ss79dEPLqzUX+qv5dlxBoM6YvhKX7ZoOgU3d+EwvS5vzphSb6/B7zM6zKNXCCjsat36WZWtloqVg89bD4rjWV8ozabd9+hnu20868vt2v5X718kM0HKpkzMcpI4bbFlHiVbOttSjK25TH8rmAU8zOg1gfLGO0vCJHZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a996FR+t; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764789632; x=1796325632;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FIH5XXRWTTG9cqNGaq/Vs0rr7opFOiMVp1spJbp3Kd0=;
  b=a996FR+tjiFjYEuP5wWEXlXwf9gK8VyWoIGcINMXJTolrc5PZgK/SPKk
   gFc6LT5Xiq04Es4wSZWd2qsNeANjVRviBRtTxKn70aP+WjkAX54ZYt3pH
   ur+36PG3x8/UwRFORBlZjoKHP70lZZr9frZbbXhD//dZ5vVFBLxdQDYeZ
   vUARe06587evMs3f42misyI8UZ/IHJUz8VhpK+zXogDvInQVLiRdYPXjG
   Y3ddfYPqg/Ngf3RSSqNNA2X5AR1Ty6+84Lh2Y7kCPOX2I+9/G8R8w6AuO
   QvC9AI/hKafXY6NEs1yT5SIvry8WV/l45o8mzM8wUmUpdev0CTT9x4QTo
   A==;
X-CSE-ConnectionGUID: bEgY5zE4TYWqDNWP0jB9Ag==
X-CSE-MsgGUID: Cs/QatQHRqWa/768uPHZHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="70411588"
X-IronPort-AV: E=Sophos;i="6.20,246,1758610800"; 
   d="scan'208";a="70411588"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 11:20:30 -0800
X-CSE-ConnectionGUID: PatpNxDyQCm3o94GeAzJ3w==
X-CSE-MsgGUID: qaS9G2miQhaPBV7jX867xQ==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 03 Dec 2025 11:20:26 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vQsOm-00000000D1N-19NN;
	Wed, 03 Dec 2025 19:20:24 +0000
Date: Thu, 4 Dec 2025 03:19:44 +0800
From: kernel test robot <lkp@intel.com>
To: Vivek BalachandharTN <vivek.balachandhar@gmail.com>, jack@suse.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: Re: [PATCH] ext2: factor out ext2_fill_super() teardown path
Message-ID: <202512040211.zHBD933t-lkp@intel.com>
References: <20251203045048.2463502-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203045048.2463502-1-vivek.balachandhar@gmail.com>

Hi Vivek,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jack-fs/for_next]
[also build test WARNING on linus/master v6.18 next-20251203]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vivek-BalachandharTN/ext2-factor-out-ext2_fill_super-teardown-path/20251203-125544
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_next
patch link:    https://lore.kernel.org/r/20251203045048.2463502-1-vivek.balachandhar%40gmail.com
patch subject: [PATCH] ext2: factor out ext2_fill_super() teardown path
config: hexagon-randconfig-002-20251204 (https://download.01.org/0day-ci/archive/20251204/202512040211.zHBD933t-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 734a912d0f025559fcf76bde9aaaeb0383c1625a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251204/202512040211.zHBD933t-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512040211.zHBD933t-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/ext2/super.c:935:6: warning: variable 'bh' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     935 |         if (!blocksize) {
         |             ^~~~~~~~~~
   fs/ext2/super.c:1268:25: note: uninitialized use occurs here
    1268 |         ext2_free_sbi(sb, sbi, bh);
         |                                ^~
   fs/ext2/super.c:935:2: note: remove the 'if' if its condition is always false
     935 |         if (!blocksize) {
         |         ^~~~~~~~~~~~~~~~~
     936 |                 ext2_msg(sb, KERN_ERR, "error: unable to set blocksize");
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     937 |                 goto failed_sbi;
         |                 ~~~~~~~~~~~~~~~~
     938 |         }
         |         ~
   fs/ext2/super.c:894:25: note: initialize the variable 'bh' to silence this warning
     894 |         struct buffer_head * bh;
         |                                ^
         |                                 = NULL
   fs/ext2/super.c:503:1: warning: unused function 'ctx_test_mount_opt' [-Wunused-function]
     503 | ctx_test_mount_opt(struct ext2_fs_context *ctx, unsigned long flag)
         | ^~~~~~~~~~~~~~~~~~
   2 warnings generated.


vim +935 fs/ext2/super.c

c3cbba427149031 Vivek BalachandharTN 2025-12-03   889  
eab61d3260d76b3 Eric Sandeen         2025-02-23   890  static int ext2_fill_super(struct super_block *sb, struct fs_context *fc)
^1da177e4c3f415 Linus Torvalds       2005-04-16   891  {
eab61d3260d76b3 Eric Sandeen         2025-02-23   892  	struct ext2_fs_context *ctx = fc->fs_private;
eab61d3260d76b3 Eric Sandeen         2025-02-23   893  	int silent = fc->sb_flags & SB_SILENT;
^1da177e4c3f415 Linus Torvalds       2005-04-16   894  	struct buffer_head * bh;
^1da177e4c3f415 Linus Torvalds       2005-04-16   895  	struct ext2_sb_info * sbi;
^1da177e4c3f415 Linus Torvalds       2005-04-16   896  	struct ext2_super_block * es;
^1da177e4c3f415 Linus Torvalds       2005-04-16   897  	struct inode *root;
^1da177e4c3f415 Linus Torvalds       2005-04-16   898  	unsigned long block;
eab61d3260d76b3 Eric Sandeen         2025-02-23   899  	unsigned long sb_block = ctx->s_sb_block;
^1da177e4c3f415 Linus Torvalds       2005-04-16   900  	unsigned long logic_sb_block;
^1da177e4c3f415 Linus Torvalds       2005-04-16   901  	unsigned long offset = 0;
d09099051057bba Chengguang Xu        2018-02-26   902  	long ret = -ENOMEM;
^1da177e4c3f415 Linus Torvalds       2005-04-16   903  	int blocksize = BLOCK_SIZE;
^1da177e4c3f415 Linus Torvalds       2005-04-16   904  	int db_count;
^1da177e4c3f415 Linus Torvalds       2005-04-16   905  	int i, j;
^1da177e4c3f415 Linus Torvalds       2005-04-16   906  	__le32 features;
833f4077bf7c2dc Peter Zijlstra       2007-10-16   907  	int err;
^1da177e4c3f415 Linus Torvalds       2005-04-16   908  
f8314dc60ccba7e Panagiotis Issaris   2006-09-27   909  	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
^1da177e4c3f415 Linus Torvalds       2005-04-16   910  	if (!sbi)
cea845cdef4f509 Christoph Hellwig    2021-11-29   911  		return -ENOMEM;
18a82eb9f980b5e Pekka J Enberg       2009-01-07   912  
18a82eb9f980b5e Pekka J Enberg       2009-01-07   913  	sbi->s_blockgroup_lock =
18a82eb9f980b5e Pekka J Enberg       2009-01-07   914  		kzalloc(sizeof(struct blockgroup_lock), GFP_KERNEL);
18a82eb9f980b5e Pekka J Enberg       2009-01-07   915  	if (!sbi->s_blockgroup_lock) {
18a82eb9f980b5e Pekka J Enberg       2009-01-07   916  		kfree(sbi);
cea845cdef4f509 Christoph Hellwig    2021-11-29   917  		return -ENOMEM;
18a82eb9f980b5e Pekka J Enberg       2009-01-07   918  	}
^1da177e4c3f415 Linus Torvalds       2005-04-16   919  	sb->s_fs_info = sbi;
93d44cb275f3eba Miklos Szeredi       2007-10-16   920  	sbi->s_sb_block = sb_block;
8012b8660855237 Shiyang Ruan         2022-06-03   921  	sbi->s_daxdev = fs_dax_get_by_bdev(sb->s_bdev, &sbi->s_dax_part_off,
8012b8660855237 Shiyang Ruan         2022-06-03   922  					   NULL, NULL);
^1da177e4c3f415 Linus Torvalds       2005-04-16   923  
c15271f4e74cd6d Jan Blunck           2010-04-14   924  	spin_lock_init(&sbi->s_lock);
d09099051057bba Chengguang Xu        2018-02-26   925  	ret = -EINVAL;
c15271f4e74cd6d Jan Blunck           2010-04-14   926  
^1da177e4c3f415 Linus Torvalds       2005-04-16   927  	/*
^1da177e4c3f415 Linus Torvalds       2005-04-16   928  	 * See what the current blocksize for the device is, and
^1da177e4c3f415 Linus Torvalds       2005-04-16   929  	 * use that as the blocksize.  Otherwise (or if the blocksize
^1da177e4c3f415 Linus Torvalds       2005-04-16   930  	 * is smaller than the default) use the default.
^1da177e4c3f415 Linus Torvalds       2005-04-16   931  	 * This is important for devices that have a hardware
^1da177e4c3f415 Linus Torvalds       2005-04-16   932  	 * sectorsize that is larger than the default.
^1da177e4c3f415 Linus Torvalds       2005-04-16   933  	 */
^1da177e4c3f415 Linus Torvalds       2005-04-16   934  	blocksize = sb_min_blocksize(sb, BLOCK_SIZE);
^1da177e4c3f415 Linus Torvalds       2005-04-16  @935  	if (!blocksize) {
2314b07cb47ef7d Oleksij Rempel       2009-11-19   936  		ext2_msg(sb, KERN_ERR, "error: unable to set blocksize");
^1da177e4c3f415 Linus Torvalds       2005-04-16   937  		goto failed_sbi;
^1da177e4c3f415 Linus Torvalds       2005-04-16   938  	}
^1da177e4c3f415 Linus Torvalds       2005-04-16   939  
^1da177e4c3f415 Linus Torvalds       2005-04-16   940  	/*
^1da177e4c3f415 Linus Torvalds       2005-04-16   941  	 * If the superblock doesn't start on a hardware sector boundary,
^1da177e4c3f415 Linus Torvalds       2005-04-16   942  	 * calculate the offset.  
^1da177e4c3f415 Linus Torvalds       2005-04-16   943  	 */
^1da177e4c3f415 Linus Torvalds       2005-04-16   944  	if (blocksize != BLOCK_SIZE) {
^1da177e4c3f415 Linus Torvalds       2005-04-16   945  		logic_sb_block = (sb_block*BLOCK_SIZE) / blocksize;
^1da177e4c3f415 Linus Torvalds       2005-04-16   946  		offset = (sb_block*BLOCK_SIZE) % blocksize;
^1da177e4c3f415 Linus Torvalds       2005-04-16   947  	} else {
^1da177e4c3f415 Linus Torvalds       2005-04-16   948  		logic_sb_block = sb_block;
^1da177e4c3f415 Linus Torvalds       2005-04-16   949  	}
^1da177e4c3f415 Linus Torvalds       2005-04-16   950  
^1da177e4c3f415 Linus Torvalds       2005-04-16   951  	if (!(bh = sb_bread(sb, logic_sb_block))) {
2314b07cb47ef7d Oleksij Rempel       2009-11-19   952  		ext2_msg(sb, KERN_ERR, "error: unable to read superblock");
^1da177e4c3f415 Linus Torvalds       2005-04-16   953  		goto failed_sbi;
^1da177e4c3f415 Linus Torvalds       2005-04-16   954  	}
^1da177e4c3f415 Linus Torvalds       2005-04-16   955  	/*
^1da177e4c3f415 Linus Torvalds       2005-04-16   956  	 * Note: s_es must be initialized as soon as possible because
^1da177e4c3f415 Linus Torvalds       2005-04-16   957  	 *       some ext2 macro-instructions depend on its value
^1da177e4c3f415 Linus Torvalds       2005-04-16   958  	 */
^1da177e4c3f415 Linus Torvalds       2005-04-16   959  	es = (struct ext2_super_block *) (((char *)bh->b_data) + offset);
^1da177e4c3f415 Linus Torvalds       2005-04-16   960  	sbi->s_es = es;
^1da177e4c3f415 Linus Torvalds       2005-04-16   961  	sb->s_magic = le16_to_cpu(es->s_magic);
^1da177e4c3f415 Linus Torvalds       2005-04-16   962  
^1da177e4c3f415 Linus Torvalds       2005-04-16   963  	if (sb->s_magic != EXT2_SUPER_MAGIC)
^1da177e4c3f415 Linus Torvalds       2005-04-16   964  		goto cantfind_ext2;
^1da177e4c3f415 Linus Torvalds       2005-04-16   965  
eab61d3260d76b3 Eric Sandeen         2025-02-23   966  	ext2_set_options(fc, sbi);
088519572ca8bd6 Jan Kara             2017-10-09   967  
1751e8a6cb935e5 Linus Torvalds       2017-11-27   968  	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
38fa0e8e4a3b932 Chengguang Xu        2019-05-20   969  		(test_opt(sb, POSIX_ACL) ? SB_POSIXACL : 0);
46b15caa7cb19b0 Tejun Heo            2015-06-16   970  	sb->s_iflags |= SB_I_CGROUPWB;
^1da177e4c3f415 Linus Torvalds       2005-04-16   971  
^1da177e4c3f415 Linus Torvalds       2005-04-16   972  	if (le32_to_cpu(es->s_rev_level) == EXT2_GOOD_OLD_REV &&
^1da177e4c3f415 Linus Torvalds       2005-04-16   973  	    (EXT2_HAS_COMPAT_FEATURE(sb, ~0U) ||
^1da177e4c3f415 Linus Torvalds       2005-04-16   974  	     EXT2_HAS_RO_COMPAT_FEATURE(sb, ~0U) ||
^1da177e4c3f415 Linus Torvalds       2005-04-16   975  	     EXT2_HAS_INCOMPAT_FEATURE(sb, ~0U)))
2314b07cb47ef7d Oleksij Rempel       2009-11-19   976  		ext2_msg(sb, KERN_WARNING,
2314b07cb47ef7d Oleksij Rempel       2009-11-19   977  			"warning: feature flags set on rev 0 fs, "
2314b07cb47ef7d Oleksij Rempel       2009-11-19   978  			"running e2fsck is recommended");
^1da177e4c3f415 Linus Torvalds       2005-04-16   979  	/*
^1da177e4c3f415 Linus Torvalds       2005-04-16   980  	 * Check feature flags regardless of the revision level, since we
^1da177e4c3f415 Linus Torvalds       2005-04-16   981  	 * previously didn't change the revision level when setting the flags,
^1da177e4c3f415 Linus Torvalds       2005-04-16   982  	 * so there is a chance incompat flags are set on a rev 0 filesystem.
^1da177e4c3f415 Linus Torvalds       2005-04-16   983  	 */
^1da177e4c3f415 Linus Torvalds       2005-04-16   984  	features = EXT2_HAS_INCOMPAT_FEATURE(sb, ~EXT2_FEATURE_INCOMPAT_SUPP);
^1da177e4c3f415 Linus Torvalds       2005-04-16   985  	if (features) {
2314b07cb47ef7d Oleksij Rempel       2009-11-19   986  		ext2_msg(sb, KERN_ERR,	"error: couldn't mount because of "
2314b07cb47ef7d Oleksij Rempel       2009-11-19   987  		       "unsupported optional features (%x)",
2314b07cb47ef7d Oleksij Rempel       2009-11-19   988  			le32_to_cpu(features));
^1da177e4c3f415 Linus Torvalds       2005-04-16   989  		goto failed_mount;
^1da177e4c3f415 Linus Torvalds       2005-04-16   990  	}
bc98a42c1f7d0f8 David Howells        2017-07-17   991  	if (!sb_rdonly(sb) && (features = EXT2_HAS_RO_COMPAT_FEATURE(sb, ~EXT2_FEATURE_RO_COMPAT_SUPP))){
2314b07cb47ef7d Oleksij Rempel       2009-11-19   992  		ext2_msg(sb, KERN_ERR, "error: couldn't mount RDWR because of "
2314b07cb47ef7d Oleksij Rempel       2009-11-19   993  		       "unsupported optional features (%x)",
2314b07cb47ef7d Oleksij Rempel       2009-11-19   994  		       le32_to_cpu(features));
^1da177e4c3f415 Linus Torvalds       2005-04-16   995  		goto failed_mount;
^1da177e4c3f415 Linus Torvalds       2005-04-16   996  	}
^1da177e4c3f415 Linus Torvalds       2005-04-16   997  
62aeb94433fcec8 Jan Kara             2023-03-01   998  	if (le32_to_cpu(es->s_log_block_size) >
62aeb94433fcec8 Jan Kara             2023-03-01   999  	    (EXT2_MAX_BLOCK_LOG_SIZE - BLOCK_SIZE_BITS)) {
62aeb94433fcec8 Jan Kara             2023-03-01  1000  		ext2_msg(sb, KERN_ERR,
62aeb94433fcec8 Jan Kara             2023-03-01  1001  			 "Invalid log block size: %u",
62aeb94433fcec8 Jan Kara             2023-03-01  1002  			 le32_to_cpu(es->s_log_block_size));
62aeb94433fcec8 Jan Kara             2023-03-01  1003  		goto failed_mount;
62aeb94433fcec8 Jan Kara             2023-03-01  1004  	}
^1da177e4c3f415 Linus Torvalds       2005-04-16  1005  	blocksize = BLOCK_SIZE << le32_to_cpu(sbi->s_es->s_log_block_size);
^1da177e4c3f415 Linus Torvalds       2005-04-16  1006  
38fa0e8e4a3b932 Chengguang Xu        2019-05-20  1007  	if (test_opt(sb, DAX)) {
cea845cdef4f509 Christoph Hellwig    2021-11-29  1008  		if (!sbi->s_daxdev) {
b4b5798cea8f40a Dan Williams         2017-12-21  1009  			ext2_msg(sb, KERN_ERR,
b4b5798cea8f40a Dan Williams         2017-12-21  1010  				"DAX unsupported by block device. Turning off DAX.");
38fa0e8e4a3b932 Chengguang Xu        2019-05-20  1011  			clear_opt(sbi->s_mount_opt, DAX);
7b0800d00dae8c8 Christoph Hellwig    2021-11-29  1012  		} else if (blocksize != PAGE_SIZE) {
7b0800d00dae8c8 Christoph Hellwig    2021-11-29  1013  			ext2_msg(sb, KERN_ERR, "unsupported blocksize for DAX\n");
7b0800d00dae8c8 Christoph Hellwig    2021-11-29  1014  			clear_opt(sbi->s_mount_opt, DAX);
b4b5798cea8f40a Dan Williams         2017-12-21  1015  		}
6d79125bba55ee8 Carsten Otte         2005-06-23  1016  	}
6d79125bba55ee8 Carsten Otte         2005-06-23  1017  
^1da177e4c3f415 Linus Torvalds       2005-04-16  1018  	/* If the blocksize doesn't match, re-read the thing.. */
^1da177e4c3f415 Linus Torvalds       2005-04-16  1019  	if (sb->s_blocksize != blocksize) {
^1da177e4c3f415 Linus Torvalds       2005-04-16  1020  		brelse(bh);
^1da177e4c3f415 Linus Torvalds       2005-04-16  1021  
^1da177e4c3f415 Linus Torvalds       2005-04-16  1022  		if (!sb_set_blocksize(sb, blocksize)) {
4e299c1d9113b5c Robin Dong           2011-05-05  1023  			ext2_msg(sb, KERN_ERR,
4e299c1d9113b5c Robin Dong           2011-05-05  1024  				"error: bad blocksize %d", blocksize);
^1da177e4c3f415 Linus Torvalds       2005-04-16  1025  			goto failed_sbi;
^1da177e4c3f415 Linus Torvalds       2005-04-16  1026  		}
^1da177e4c3f415 Linus Torvalds       2005-04-16  1027  
^1da177e4c3f415 Linus Torvalds       2005-04-16  1028  		logic_sb_block = (sb_block*BLOCK_SIZE) / blocksize;
^1da177e4c3f415 Linus Torvalds       2005-04-16  1029  		offset = (sb_block*BLOCK_SIZE) % blocksize;
^1da177e4c3f415 Linus Torvalds       2005-04-16  1030  		bh = sb_bread(sb, logic_sb_block);
^1da177e4c3f415 Linus Torvalds       2005-04-16  1031  		if(!bh) {
2314b07cb47ef7d Oleksij Rempel       2009-11-19  1032  			ext2_msg(sb, KERN_ERR, "error: couldn't read"
2314b07cb47ef7d Oleksij Rempel       2009-11-19  1033  				"superblock on 2nd try");
^1da177e4c3f415 Linus Torvalds       2005-04-16  1034  			goto failed_sbi;
^1da177e4c3f415 Linus Torvalds       2005-04-16  1035  		}
^1da177e4c3f415 Linus Torvalds       2005-04-16  1036  		es = (struct ext2_super_block *) (((char *)bh->b_data) + offset);
^1da177e4c3f415 Linus Torvalds       2005-04-16  1037  		sbi->s_es = es;
^1da177e4c3f415 Linus Torvalds       2005-04-16  1038  		if (es->s_magic != cpu_to_le16(EXT2_SUPER_MAGIC)) {
2314b07cb47ef7d Oleksij Rempel       2009-11-19  1039  			ext2_msg(sb, KERN_ERR, "error: magic mismatch");
^1da177e4c3f415 Linus Torvalds       2005-04-16  1040  			goto failed_mount;
^1da177e4c3f415 Linus Torvalds       2005-04-16  1041  		}
^1da177e4c3f415 Linus Torvalds       2005-04-16  1042  	}
^1da177e4c3f415 Linus Torvalds       2005-04-16  1043  
^1da177e4c3f415 Linus Torvalds       2005-04-16  1044  	sb->s_maxbytes = ext2_max_size(sb->s_blocksize_bits);
8de52778798fe39 Al Viro              2012-02-06  1045  	sb->s_max_links = EXT2_LINK_MAX;
22b139691f9eb8b Deepa Dinamani       2019-07-30  1046  	sb->s_time_min = S32_MIN;
22b139691f9eb8b Deepa Dinamani       2019-07-30  1047  	sb->s_time_max = S32_MAX;
^1da177e4c3f415 Linus Torvalds       2005-04-16  1048  
^1da177e4c3f415 Linus Torvalds       2005-04-16  1049  	if (le32_to_cpu(es->s_rev_level) == EXT2_GOOD_OLD_REV) {
^1da177e4c3f415 Linus Torvalds       2005-04-16  1050  		sbi->s_inode_size = EXT2_GOOD_OLD_INODE_SIZE;
^1da177e4c3f415 Linus Torvalds       2005-04-16  1051  		sbi->s_first_ino = EXT2_GOOD_OLD_FIRST_INO;
^1da177e4c3f415 Linus Torvalds       2005-04-16  1052  	} else {
^1da177e4c3f415 Linus Torvalds       2005-04-16  1053  		sbi->s_inode_size = le16_to_cpu(es->s_inode_size);
^1da177e4c3f415 Linus Torvalds       2005-04-16  1054  		sbi->s_first_ino = le32_to_cpu(es->s_first_ino);
^1da177e4c3f415 Linus Torvalds       2005-04-16  1055  		if ((sbi->s_inode_size < EXT2_GOOD_OLD_INODE_SIZE) ||
d8ea6cf89991000 vignesh babu         2007-10-16  1056  		    !is_power_of_2(sbi->s_inode_size) ||
^1da177e4c3f415 Linus Torvalds       2005-04-16  1057  		    (sbi->s_inode_size > blocksize)) {
2314b07cb47ef7d Oleksij Rempel       2009-11-19  1058  			ext2_msg(sb, KERN_ERR,
2314b07cb47ef7d Oleksij Rempel       2009-11-19  1059  				"error: unsupported inode size: %d",
^1da177e4c3f415 Linus Torvalds       2005-04-16  1060  				sbi->s_inode_size);
^1da177e4c3f415 Linus Torvalds       2005-04-16  1061  			goto failed_mount;
^1da177e4c3f415 Linus Torvalds       2005-04-16  1062  		}
^1da177e4c3f415 Linus Torvalds       2005-04-16  1063  	}
^1da177e4c3f415 Linus Torvalds       2005-04-16  1064  
^1da177e4c3f415 Linus Torvalds       2005-04-16  1065  	sbi->s_blocks_per_group = le32_to_cpu(es->s_blocks_per_group);
^1da177e4c3f415 Linus Torvalds       2005-04-16  1066  	sbi->s_inodes_per_group = le32_to_cpu(es->s_inodes_per_group);
^1da177e4c3f415 Linus Torvalds       2005-04-16  1067  
^1da177e4c3f415 Linus Torvalds       2005-04-16  1068  	sbi->s_inodes_per_block = sb->s_blocksize / EXT2_INODE_SIZE(sb);
607eb266aea9dd2 Andries Brouwer      2006-08-27  1069  	if (sbi->s_inodes_per_block == 0 || sbi->s_inodes_per_group == 0)
^1da177e4c3f415 Linus Torvalds       2005-04-16  1070  		goto cantfind_ext2;
^1da177e4c3f415 Linus Torvalds       2005-04-16  1071  	sbi->s_itb_per_group = sbi->s_inodes_per_group /
^1da177e4c3f415 Linus Torvalds       2005-04-16  1072  					sbi->s_inodes_per_block;
^1da177e4c3f415 Linus Torvalds       2005-04-16  1073  	sbi->s_desc_per_block = sb->s_blocksize /
^1da177e4c3f415 Linus Torvalds       2005-04-16  1074  					sizeof (struct ext2_group_desc);
^1da177e4c3f415 Linus Torvalds       2005-04-16  1075  	sbi->s_sbh = bh;
^1da177e4c3f415 Linus Torvalds       2005-04-16  1076  	sbi->s_mount_state = le16_to_cpu(es->s_state);
^1da177e4c3f415 Linus Torvalds       2005-04-16  1077  	sbi->s_addr_per_block_bits =
f0d1b0b30d250a0 David Howells        2006-12-08  1078  		ilog2 (EXT2_ADDR_PER_BLOCK(sb));
^1da177e4c3f415 Linus Torvalds       2005-04-16  1079  	sbi->s_desc_per_block_bits =
f0d1b0b30d250a0 David Howells        2006-12-08  1080  		ilog2 (EXT2_DESC_PER_BLOCK(sb));
^1da177e4c3f415 Linus Torvalds       2005-04-16  1081  
^1da177e4c3f415 Linus Torvalds       2005-04-16  1082  	if (sb->s_magic != EXT2_SUPER_MAGIC)
^1da177e4c3f415 Linus Torvalds       2005-04-16  1083  		goto cantfind_ext2;
^1da177e4c3f415 Linus Torvalds       2005-04-16  1084  
^1da177e4c3f415 Linus Torvalds       2005-04-16  1085  	if (sb->s_blocksize != bh->b_size) {
^1da177e4c3f415 Linus Torvalds       2005-04-16  1086  		if (!silent)
2314b07cb47ef7d Oleksij Rempel       2009-11-19  1087  			ext2_msg(sb, KERN_ERR, "error: unsupported blocksize");
^1da177e4c3f415 Linus Torvalds       2005-04-16  1088  		goto failed_mount;
^1da177e4c3f415 Linus Torvalds       2005-04-16  1089  	}
^1da177e4c3f415 Linus Torvalds       2005-04-16  1090  
404615d7f1dcd4c Jan Kara             2023-06-13  1091  	if (es->s_log_frag_size != es->s_log_block_size) {
2314b07cb47ef7d Oleksij Rempel       2009-11-19  1092  		ext2_msg(sb, KERN_ERR,
404615d7f1dcd4c Jan Kara             2023-06-13  1093  			"error: fragsize log %u != blocksize log %u",
404615d7f1dcd4c Jan Kara             2023-06-13  1094  			le32_to_cpu(es->s_log_frag_size), sb->s_blocksize_bits);
^1da177e4c3f415 Linus Torvalds       2005-04-16  1095  		goto failed_mount;
^1da177e4c3f415 Linus Torvalds       2005-04-16  1096  	}
^1da177e4c3f415 Linus Torvalds       2005-04-16  1097  
^1da177e4c3f415 Linus Torvalds       2005-04-16  1098  	if (sbi->s_blocks_per_group > sb->s_blocksize * 8) {
2314b07cb47ef7d Oleksij Rempel       2009-11-19  1099  		ext2_msg(sb, KERN_ERR,
2314b07cb47ef7d Oleksij Rempel       2009-11-19  1100  			"error: #blocks per group too big: %lu",
^1da177e4c3f415 Linus Torvalds       2005-04-16  1101  			sbi->s_blocks_per_group);
^1da177e4c3f415 Linus Torvalds       2005-04-16  1102  		goto failed_mount;
^1da177e4c3f415 Linus Torvalds       2005-04-16  1103  	}
d766f2d1e3e3bd4 Jan Kara             2022-09-14  1104  	/* At least inode table, bitmaps, and sb have to fit in one group */
d766f2d1e3e3bd4 Jan Kara             2022-09-14  1105  	if (sbi->s_blocks_per_group <= sbi->s_itb_per_group + 3) {
d766f2d1e3e3bd4 Jan Kara             2022-09-14  1106  		ext2_msg(sb, KERN_ERR,
d766f2d1e3e3bd4 Jan Kara             2022-09-14  1107  			"error: #blocks per group smaller than metadata size: %lu <= %lu",
d766f2d1e3e3bd4 Jan Kara             2022-09-14  1108  			sbi->s_blocks_per_group, sbi->s_inodes_per_group + 3);
d766f2d1e3e3bd4 Jan Kara             2022-09-14  1109  		goto failed_mount;
d766f2d1e3e3bd4 Jan Kara             2022-09-14  1110  	}
fa78f336937240d Jan Kara             2022-07-26  1111  	if (sbi->s_inodes_per_group < sbi->s_inodes_per_block ||
fa78f336937240d Jan Kara             2022-07-26  1112  	    sbi->s_inodes_per_group > sb->s_blocksize * 8) {
2314b07cb47ef7d Oleksij Rempel       2009-11-19  1113  		ext2_msg(sb, KERN_ERR,
fa78f336937240d Jan Kara             2022-07-26  1114  			"error: invalid #inodes per group: %lu",
^1da177e4c3f415 Linus Torvalds       2005-04-16  1115  			sbi->s_inodes_per_group);
^1da177e4c3f415 Linus Torvalds       2005-04-16  1116  		goto failed_mount;
^1da177e4c3f415 Linus Torvalds       2005-04-16  1117  	}
d766f2d1e3e3bd4 Jan Kara             2022-09-14  1118  	if (sb_bdev_nr_blocks(sb) < le32_to_cpu(es->s_blocks_count)) {
d766f2d1e3e3bd4 Jan Kara             2022-09-14  1119  		ext2_msg(sb, KERN_ERR,
d766f2d1e3e3bd4 Jan Kara             2022-09-14  1120  			 "bad geometry: block count %u exceeds size of device (%u blocks)",
d766f2d1e3e3bd4 Jan Kara             2022-09-14  1121  			 le32_to_cpu(es->s_blocks_count),
d766f2d1e3e3bd4 Jan Kara             2022-09-14  1122  			 (unsigned)sb_bdev_nr_blocks(sb));
d766f2d1e3e3bd4 Jan Kara             2022-09-14  1123  		goto failed_mount;
d766f2d1e3e3bd4 Jan Kara             2022-09-14  1124  	}
^1da177e4c3f415 Linus Torvalds       2005-04-16  1125  
41f04d852e35958 Eric Sandeen         2006-09-27  1126  	sbi->s_groups_count = ((le32_to_cpu(es->s_blocks_count) -
41f04d852e35958 Eric Sandeen         2006-09-27  1127  				le32_to_cpu(es->s_first_data_block) - 1)
41f04d852e35958 Eric Sandeen         2006-09-27  1128  					/ EXT2_BLOCKS_PER_GROUP(sb)) + 1;
fa78f336937240d Jan Kara             2022-07-26  1129  	if ((u64)sbi->s_groups_count * sbi->s_inodes_per_group !=
fa78f336937240d Jan Kara             2022-07-26  1130  	    le32_to_cpu(es->s_inodes_count)) {
fa78f336937240d Jan Kara             2022-07-26  1131  		ext2_msg(sb, KERN_ERR, "error: invalid #inodes: %u vs computed %llu",
fa78f336937240d Jan Kara             2022-07-26  1132  			 le32_to_cpu(es->s_inodes_count),
fa78f336937240d Jan Kara             2022-07-26  1133  			 (u64)sbi->s_groups_count * sbi->s_inodes_per_group);
fa78f336937240d Jan Kara             2022-07-26  1134  		goto failed_mount;
fa78f336937240d Jan Kara             2022-07-26  1135  	}
^1da177e4c3f415 Linus Torvalds       2005-04-16  1136  	db_count = (sbi->s_groups_count + EXT2_DESC_PER_BLOCK(sb) - 1) /
^1da177e4c3f415 Linus Torvalds       2005-04-16  1137  		   EXT2_DESC_PER_BLOCK(sb);
e7c7fbb9a8574eb Jan Kara             2022-09-14  1138  	sbi->s_group_desc = kvmalloc_array(db_count,
6da2ec56059c3c7 Kees Cook            2018-06-12  1139  					   sizeof(struct buffer_head *),
6da2ec56059c3c7 Kees Cook            2018-06-12  1140  					   GFP_KERNEL);
^1da177e4c3f415 Linus Torvalds       2005-04-16  1141  	if (sbi->s_group_desc == NULL) {
6a03e6a8dcf573d Chengguang Xu        2019-01-01  1142  		ret = -ENOMEM;
2314b07cb47ef7d Oleksij Rempel       2009-11-19  1143  		ext2_msg(sb, KERN_ERR, "error: not enough memory");
^1da177e4c3f415 Linus Torvalds       2005-04-16  1144  		goto failed_mount;
^1da177e4c3f415 Linus Torvalds       2005-04-16  1145  	}
18a82eb9f980b5e Pekka J Enberg       2009-01-07  1146  	bgl_lock_init(sbi->s_blockgroup_lock);
dd00cc486ab1c17 Yoann Padioleau      2007-07-19  1147  	sbi->s_debts = kcalloc(sbi->s_groups_count, sizeof(*sbi->s_debts), GFP_KERNEL);
^1da177e4c3f415 Linus Torvalds       2005-04-16  1148  	if (!sbi->s_debts) {
6a03e6a8dcf573d Chengguang Xu        2019-01-01  1149  		ret = -ENOMEM;
2314b07cb47ef7d Oleksij Rempel       2009-11-19  1150  		ext2_msg(sb, KERN_ERR, "error: not enough memory");
^1da177e4c3f415 Linus Torvalds       2005-04-16  1151  		goto failed_mount_group_desc;
^1da177e4c3f415 Linus Torvalds       2005-04-16  1152  	}
^1da177e4c3f415 Linus Torvalds       2005-04-16  1153  	for (i = 0; i < db_count; i++) {
^1da177e4c3f415 Linus Torvalds       2005-04-16  1154  		block = descriptor_loc(sb, logic_sb_block, i);
^1da177e4c3f415 Linus Torvalds       2005-04-16  1155  		sbi->s_group_desc[i] = sb_bread(sb, block);
^1da177e4c3f415 Linus Torvalds       2005-04-16  1156  		if (!sbi->s_group_desc[i]) {
^1da177e4c3f415 Linus Torvalds       2005-04-16  1157  			for (j = 0; j < i; j++)
^1da177e4c3f415 Linus Torvalds       2005-04-16  1158  				brelse (sbi->s_group_desc[j]);
2314b07cb47ef7d Oleksij Rempel       2009-11-19  1159  			ext2_msg(sb, KERN_ERR,
2314b07cb47ef7d Oleksij Rempel       2009-11-19  1160  				"error: unable to read group descriptors");
^1da177e4c3f415 Linus Torvalds       2005-04-16  1161  			goto failed_mount_group_desc;
^1da177e4c3f415 Linus Torvalds       2005-04-16  1162  		}
^1da177e4c3f415 Linus Torvalds       2005-04-16  1163  	}
^1da177e4c3f415 Linus Torvalds       2005-04-16  1164  	if (!ext2_check_descriptors (sb)) {
2314b07cb47ef7d Oleksij Rempel       2009-11-19  1165  		ext2_msg(sb, KERN_ERR, "group descriptors corrupted");
^1da177e4c3f415 Linus Torvalds       2005-04-16  1166  		goto failed_mount2;
^1da177e4c3f415 Linus Torvalds       2005-04-16  1167  	}
^1da177e4c3f415 Linus Torvalds       2005-04-16  1168  	sbi->s_gdb_count = db_count;
^1da177e4c3f415 Linus Torvalds       2005-04-16  1169  	get_random_bytes(&sbi->s_next_generation, sizeof(u32));
^1da177e4c3f415 Linus Torvalds       2005-04-16  1170  	spin_lock_init(&sbi->s_next_gen_lock);
0216bfcffe424a5 Mingming Cao         2006-06-23  1171  
e312c97ea253f07 Liu xuzhi            2021-03-18  1172  	/* per filesystem reservation list head & lock */
a686cd898bd999f Martin J. Bligh      2007-10-16  1173  	spin_lock_init(&sbi->s_rsv_window_lock);
a686cd898bd999f Martin J. Bligh      2007-10-16  1174  	sbi->s_rsv_window_root = RB_ROOT;
a686cd898bd999f Martin J. Bligh      2007-10-16  1175  	/*
a686cd898bd999f Martin J. Bligh      2007-10-16  1176  	 * Add a single, static dummy reservation to the start of the
a686cd898bd999f Martin J. Bligh      2007-10-16  1177  	 * reservation window list --- it gives us a placeholder for
a686cd898bd999f Martin J. Bligh      2007-10-16  1178  	 * append-at-start-of-list which makes the allocation logic
a686cd898bd999f Martin J. Bligh      2007-10-16  1179  	 * _much_ simpler.
a686cd898bd999f Martin J. Bligh      2007-10-16  1180  	 */
a686cd898bd999f Martin J. Bligh      2007-10-16  1181  	sbi->s_rsv_window_head.rsv_start = EXT2_RESERVE_WINDOW_NOT_ALLOCATED;
a686cd898bd999f Martin J. Bligh      2007-10-16  1182  	sbi->s_rsv_window_head.rsv_end = EXT2_RESERVE_WINDOW_NOT_ALLOCATED;
a686cd898bd999f Martin J. Bligh      2007-10-16  1183  	sbi->s_rsv_window_head.rsv_alloc_hit = 0;
a686cd898bd999f Martin J. Bligh      2007-10-16  1184  	sbi->s_rsv_window_head.rsv_goal_size = 0;
a686cd898bd999f Martin J. Bligh      2007-10-16  1185  	ext2_rsv_window_add(sb, &sbi->s_rsv_window_head);
a686cd898bd999f Martin J. Bligh      2007-10-16  1186  
833f4077bf7c2dc Peter Zijlstra       2007-10-16  1187  	err = percpu_counter_init(&sbi->s_freeblocks_counter,
908c7f1949cb7cc Tejun Heo            2014-09-08  1188  				ext2_count_free_blocks(sb), GFP_KERNEL);
833f4077bf7c2dc Peter Zijlstra       2007-10-16  1189  	if (!err) {
833f4077bf7c2dc Peter Zijlstra       2007-10-16  1190  		err = percpu_counter_init(&sbi->s_freeinodes_counter,
908c7f1949cb7cc Tejun Heo            2014-09-08  1191  				ext2_count_free_inodes(sb), GFP_KERNEL);
833f4077bf7c2dc Peter Zijlstra       2007-10-16  1192  	}
833f4077bf7c2dc Peter Zijlstra       2007-10-16  1193  	if (!err) {
833f4077bf7c2dc Peter Zijlstra       2007-10-16  1194  		err = percpu_counter_init(&sbi->s_dirs_counter,
908c7f1949cb7cc Tejun Heo            2014-09-08  1195  				ext2_count_dirs(sb), GFP_KERNEL);
833f4077bf7c2dc Peter Zijlstra       2007-10-16  1196  	}
833f4077bf7c2dc Peter Zijlstra       2007-10-16  1197  	if (err) {
34e92542da96430 Chengguang Xu        2019-11-29  1198  		ret = err;
2314b07cb47ef7d Oleksij Rempel       2009-11-19  1199  		ext2_msg(sb, KERN_ERR, "error: insufficient memory");
833f4077bf7c2dc Peter Zijlstra       2007-10-16  1200  		goto failed_mount3;
833f4077bf7c2dc Peter Zijlstra       2007-10-16  1201  	}
be0726d33cb8f41 Jan Kara             2016-02-22  1202  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

