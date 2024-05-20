Return-Path: <linux-ext4+bounces-2595-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EE68C997C
	for <lists+linux-ext4@lfdr.de>; Mon, 20 May 2024 09:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B46871C20B7C
	for <lists+linux-ext4@lfdr.de>; Mon, 20 May 2024 07:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A724107A9;
	Mon, 20 May 2024 07:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H8+D92cm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AF633EE
	for <linux-ext4@vger.kernel.org>; Mon, 20 May 2024 07:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716191192; cv=none; b=W+1hjf84KL4BVEBxbor0LhC7nZeyZmucRMdqVbbrWGTS7JtZLXvoSFj2QXy4XB7ytTvVaK2IcldiEO9TVEelIZHQGqm8lBaHrAgr+cWtQ1GFL5vVK1hefwtk1G+wmAjy45aFFfmLviqehm9ZgqglM8vBY5tVfPod33xR6f3iaco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716191192; c=relaxed/simple;
	bh=zoThElw5XfZBkT5mjoaYsFhNxUVWJrcZ60e5UncjPXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0dDoRSOQFyYdYzbqBDwx17hNmnNoIgD/cTNo8kBnWIqbAsLNPbzXc7LHrKhf1dJ2j741aN+OyppqLiH31GgKWg0D9QNaeqEwImf+v4qTRoqETusjT795sHSFTCmuPI9pQP6f/SaOm93JMcofgciuHFVZ/71OQIweDnpBJ/Q8kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H8+D92cm; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716191190; x=1747727190;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zoThElw5XfZBkT5mjoaYsFhNxUVWJrcZ60e5UncjPXs=;
  b=H8+D92cmgfUOGcgZXjuM0aYFxgFDSsqyRj7ssKyLHz3CpbE9JLsybQPy
   zxf7anVUTyOUp7CW5jhOTGhLx8AvJN7/hsPVaPxyRsE79eJT3n1VEEKdK
   /oFuQZ7ASV6cyhjITylNfZ+doSAa0GbZC8/Q0MW/LqFCoQ/umfDfMbDd6
   wQo/mw1Ql9jvJIxDpicaMFzYpXNueMipMLEX99E53YNEP1AAhCkwMVobH
   3Jxx6qoDmvqDhnt4/IsNWTL1ECRekLJd3XDwETCq/s/FNmwFSemL6XtwW
   DRNVXSW/2MVHItG9gIn4HgS5G3PWQ9oNTCOmyKvF28FlRY++axDs2XD8m
   g==;
X-CSE-ConnectionGUID: Es04mDHtSxmeGD03MhhfFw==
X-CSE-MsgGUID: HTlkjMC3QZqK2J5Sk5SLmA==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="16131525"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="16131525"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 00:46:30 -0700
X-CSE-ConnectionGUID: gEuQmXU8SgCIkNXytps2nw==
X-CSE-MsgGUID: aX6WdCdHTnWQCKP56bqmag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="32470893"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 20 May 2024 00:46:27 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s8xiy-0004kO-26;
	Mon, 20 May 2024 07:46:24 +0000
Date: Mon, 20 May 2024 15:45:18 +0800
From: kernel test robot <lkp@intel.com>
To: Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
	linux-ext4@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, tytso@mit.edu,
	saukad@google.com, harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: [PATCH 03/10] ext4: mark inode dirty before grabbing i_data_sem
 in ext4_setattr
Message-ID: <202405201505.ZqZypxE6-lkp@intel.com>
References: <20240520055153.136091-4-harshadshirwadkar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520055153.136091-4-harshadshirwadkar@gmail.com>

Hi Harshad,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tytso-ext4/dev]
[also build test WARNING on linus/master v6.9 next-20240520]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Harshad-Shirwadkar/ext4-convert-i_fc_lock-to-spinlock/20240520-135501
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
patch link:    https://lore.kernel.org/r/20240520055153.136091-4-harshadshirwadkar%40gmail.com
patch subject: [PATCH 03/10] ext4: mark inode dirty before grabbing i_data_sem in ext4_setattr
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240520/202405201505.ZqZypxE6-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240520/202405201505.ZqZypxE6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405201505.ZqZypxE6-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/ext4/inode.c:5427:33: warning: variable 'old_disksize' is uninitialized when used here [-Wuninitialized]
                                   EXT4_I(inode)->i_disksize = old_disksize;
                                                               ^~~~~~~~~~~~
   fs/ext4/inode.c:5343:22: note: initialize the variable 'old_disksize' to silence this warning
                   loff_t old_disksize;
                                      ^
                                       = 0
   1 warning generated.


vim +/old_disksize +5427 fs/ext4/inode.c

53e872681fed6a4 Jan Kara           2012-12-25  5241  
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5242  /*
617ba13b31fbf50 Mingming Cao       2006-10-11  5243   * ext4_setattr()
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5244   *
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5245   * Called from notify_change.
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5246   *
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5247   * We want to trap VFS attempts to truncate the file as soon as
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5248   * possible.  In particular, we want to make sure that when the VFS
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5249   * shrinks i_size, we put the inode on the orphan list and modify
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5250   * i_disksize immediately, so that during the subsequent flushing of
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5251   * dirty pages and freeing of disk blocks, we can guarantee that any
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5252   * commit will leave the blocks being flushed in an unused state on
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5253   * disk.  (On recovery, the inode will get truncated and the blocks will
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5254   * be freed, so we have a strong guarantee that no future commit will
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5255   * leave these blocks visible to the user.)
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5256   *
678aaf481496b01 Jan Kara           2008-07-11  5257   * Another thing we have to assure is that if we are in ordered mode
678aaf481496b01 Jan Kara           2008-07-11  5258   * and inode is still attached to the committing transaction, we must
678aaf481496b01 Jan Kara           2008-07-11  5259   * we start writeout of all the dirty pages which are being truncated.
678aaf481496b01 Jan Kara           2008-07-11  5260   * This way we are sure that all the data written in the previous
678aaf481496b01 Jan Kara           2008-07-11  5261   * transaction are already on disk (truncate waits for pages under
678aaf481496b01 Jan Kara           2008-07-11  5262   * writeback).
678aaf481496b01 Jan Kara           2008-07-11  5263   *
f340b3d90274859 hongnanli          2022-01-21  5264   * Called with inode->i_rwsem down.
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5265   */
c1632a0f1120933 Christian Brauner  2023-01-13  5266  int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
549c7297717c32e Christian Brauner  2021-01-21  5267  		 struct iattr *attr)
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5268  {
2b0143b5c986be1 David Howells      2015-03-17  5269  	struct inode *inode = d_inode(dentry);
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5270  	int error, rc = 0;
3d287de3b828226 Dmitry Monakhov    2010-10-27  5271  	int orphan = 0;
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5272  	const unsigned int ia_valid = attr->ia_valid;
a642c2c0827f560 Jeff Layton        2022-09-08  5273  	bool inc_ivers = true;
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5274  
eb8ab4443aec5ff Jan Kara           2023-06-16  5275  	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
0db1ff222d40f16 Theodore Ts'o      2017-02-05  5276  		return -EIO;
0db1ff222d40f16 Theodore Ts'o      2017-02-05  5277  
02b016ca7f99229 Theodore Ts'o      2019-06-09  5278  	if (unlikely(IS_IMMUTABLE(inode)))
02b016ca7f99229 Theodore Ts'o      2019-06-09  5279  		return -EPERM;
02b016ca7f99229 Theodore Ts'o      2019-06-09  5280  
02b016ca7f99229 Theodore Ts'o      2019-06-09  5281  	if (unlikely(IS_APPEND(inode) &&
02b016ca7f99229 Theodore Ts'o      2019-06-09  5282  		     (ia_valid & (ATTR_MODE | ATTR_UID |
02b016ca7f99229 Theodore Ts'o      2019-06-09  5283  				  ATTR_GID | ATTR_TIMES_SET))))
02b016ca7f99229 Theodore Ts'o      2019-06-09  5284  		return -EPERM;
02b016ca7f99229 Theodore Ts'o      2019-06-09  5285  
c1632a0f1120933 Christian Brauner  2023-01-13  5286  	error = setattr_prepare(idmap, dentry, attr);
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5287  	if (error)
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5288  		return error;
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5289  
3ce2b8ddd84d507 Eric Biggers       2017-10-18  5290  	error = fscrypt_prepare_setattr(dentry, attr);
3ce2b8ddd84d507 Eric Biggers       2017-10-18  5291  	if (error)
3ce2b8ddd84d507 Eric Biggers       2017-10-18  5292  		return error;
3ce2b8ddd84d507 Eric Biggers       2017-10-18  5293  
c93d8f88580921c Eric Biggers       2019-07-22  5294  	error = fsverity_prepare_setattr(dentry, attr);
c93d8f88580921c Eric Biggers       2019-07-22  5295  	if (error)
c93d8f88580921c Eric Biggers       2019-07-22  5296  		return error;
c93d8f88580921c Eric Biggers       2019-07-22  5297  
f861646a65623bc Christian Brauner  2023-01-13  5298  	if (is_quota_modification(idmap, inode, attr)) {
a7cdadee0e89486 Jan Kara           2015-06-29  5299  		error = dquot_initialize(inode);
a7cdadee0e89486 Jan Kara           2015-06-29  5300  		if (error)
a7cdadee0e89486 Jan Kara           2015-06-29  5301  			return error;
a7cdadee0e89486 Jan Kara           2015-06-29  5302  	}
2729cfdcfa1cc49 Harshad Shirwadkar 2021-12-23  5303  
0dbe12f2e49c046 Christian Brauner  2023-01-13  5304  	if (i_uid_needs_update(idmap, attr, inode) ||
0dbe12f2e49c046 Christian Brauner  2023-01-13  5305  	    i_gid_needs_update(idmap, attr, inode)) {
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5306  		handle_t *handle;
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5307  
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5308  		/* (user+group)*(old+new) structure, inode write (sb,
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5309  		 * inode block, ? - but truncate inode update has it) */
9924a92a8c21757 Theodore Ts'o      2013-02-08  5310  		handle = ext4_journal_start(inode, EXT4_HT_QUOTA,
9924a92a8c21757 Theodore Ts'o      2013-02-08  5311  			(EXT4_MAXQUOTAS_INIT_BLOCKS(inode->i_sb) +
194074acacebc16 Dmitry Monakhov    2009-12-08  5312  			 EXT4_MAXQUOTAS_DEL_BLOCKS(inode->i_sb)) + 3);
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5313  		if (IS_ERR(handle)) {
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5314  			error = PTR_ERR(handle);
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5315  			goto err_out;
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5316  		}
7a9ca53aea10ad4 Tahsin Erdogan     2017-06-22  5317  
7a9ca53aea10ad4 Tahsin Erdogan     2017-06-22  5318  		/* dquot_transfer() calls back ext4_get_inode_usage() which
7a9ca53aea10ad4 Tahsin Erdogan     2017-06-22  5319  		 * counts xattr inode references.
7a9ca53aea10ad4 Tahsin Erdogan     2017-06-22  5320  		 */
7a9ca53aea10ad4 Tahsin Erdogan     2017-06-22  5321  		down_read(&EXT4_I(inode)->xattr_sem);
f861646a65623bc Christian Brauner  2023-01-13  5322  		error = dquot_transfer(idmap, inode, attr);
7a9ca53aea10ad4 Tahsin Erdogan     2017-06-22  5323  		up_read(&EXT4_I(inode)->xattr_sem);
7a9ca53aea10ad4 Tahsin Erdogan     2017-06-22  5324  
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5325  		if (error) {
617ba13b31fbf50 Mingming Cao       2006-10-11  5326  			ext4_journal_stop(handle);
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5327  			return error;
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5328  		}
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5329  		/* Update corresponding info in inode so that everything is in
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5330  		 * one transaction */
0dbe12f2e49c046 Christian Brauner  2023-01-13  5331  		i_uid_update(idmap, attr, inode);
0dbe12f2e49c046 Christian Brauner  2023-01-13  5332  		i_gid_update(idmap, attr, inode);
617ba13b31fbf50 Mingming Cao       2006-10-11  5333  		error = ext4_mark_inode_dirty(handle, inode);
617ba13b31fbf50 Mingming Cao       2006-10-11  5334  		ext4_journal_stop(handle);
512c15ef05d73a0 Pan Bian           2021-01-17  5335  		if (unlikely(error)) {
4209ae12b12265d Harshad Shirwadkar 2020-04-26  5336  			return error;
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5337  		}
512c15ef05d73a0 Pan Bian           2021-01-17  5338  	}
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5339  
3da40c7b089810a Josef Bacik        2015-06-22  5340  	if (attr->ia_valid & ATTR_SIZE) {
5208386c501276d Jan Kara           2013-08-17  5341  		handle_t *handle;
3da40c7b089810a Josef Bacik        2015-06-22  5342  		loff_t oldsize = inode->i_size;
f4534c9fc94d223 Ye Bin             2022-03-26  5343  		loff_t old_disksize;
b9c1c26739ec2d4 Jan Kara           2019-05-30  5344  		int shrink = (attr->ia_size < inode->i_size);
562c72aa57c36b1 Christoph Hellwig  2011-06-24  5345  
12e9b892002d9af Dmitry Monakhov    2010-05-16  5346  		if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))) {
e2b4657453c0d55 Eric Sandeen       2008-01-28  5347  			struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
e2b4657453c0d55 Eric Sandeen       2008-01-28  5348  
aa75f4d3daaeb13 Harshad Shirwadkar 2020-10-15  5349  			if (attr->ia_size > sbi->s_bitmap_maxbytes) {
0c095c7f113e9fd Theodore Ts'o      2010-07-27  5350  				return -EFBIG;
e2b4657453c0d55 Eric Sandeen       2008-01-28  5351  			}
aa75f4d3daaeb13 Harshad Shirwadkar 2020-10-15  5352  		}
aa75f4d3daaeb13 Harshad Shirwadkar 2020-10-15  5353  		if (!S_ISREG(inode->i_mode)) {
3da40c7b089810a Josef Bacik        2015-06-22  5354  			return -EINVAL;
aa75f4d3daaeb13 Harshad Shirwadkar 2020-10-15  5355  		}
dff6efc326a4d5f Christoph Hellwig  2013-11-19  5356  
a642c2c0827f560 Jeff Layton        2022-09-08  5357  		if (attr->ia_size == inode->i_size)
a642c2c0827f560 Jeff Layton        2022-09-08  5358  			inc_ivers = false;
dff6efc326a4d5f Christoph Hellwig  2013-11-19  5359  
b9c1c26739ec2d4 Jan Kara           2019-05-30  5360  		if (shrink) {
b9c1c26739ec2d4 Jan Kara           2019-05-30  5361  			if (ext4_should_order_data(inode)) {
5208386c501276d Jan Kara           2013-08-17  5362  				error = ext4_begin_ordered_truncate(inode,
5208386c501276d Jan Kara           2013-08-17  5363  							    attr->ia_size);
5208386c501276d Jan Kara           2013-08-17  5364  				if (error)
5208386c501276d Jan Kara           2013-08-17  5365  					goto err_out;
5208386c501276d Jan Kara           2013-08-17  5366  			}
b9c1c26739ec2d4 Jan Kara           2019-05-30  5367  			/*
b9c1c26739ec2d4 Jan Kara           2019-05-30  5368  			 * Blocks are going to be removed from the inode. Wait
b9c1c26739ec2d4 Jan Kara           2019-05-30  5369  			 * for dio in flight.
b9c1c26739ec2d4 Jan Kara           2019-05-30  5370  			 */
b9c1c26739ec2d4 Jan Kara           2019-05-30  5371  			inode_dio_wait(inode);
b9c1c26739ec2d4 Jan Kara           2019-05-30  5372  		}
b9c1c26739ec2d4 Jan Kara           2019-05-30  5373  
d4f5258eae7b38c Jan Kara           2021-02-04  5374  		filemap_invalidate_lock(inode->i_mapping);
b9c1c26739ec2d4 Jan Kara           2019-05-30  5375  
b9c1c26739ec2d4 Jan Kara           2019-05-30  5376  		rc = ext4_break_layouts(inode);
b9c1c26739ec2d4 Jan Kara           2019-05-30  5377  		if (rc) {
d4f5258eae7b38c Jan Kara           2021-02-04  5378  			filemap_invalidate_unlock(inode->i_mapping);
aa75f4d3daaeb13 Harshad Shirwadkar 2020-10-15  5379  			goto err_out;
b9c1c26739ec2d4 Jan Kara           2019-05-30  5380  		}
b9c1c26739ec2d4 Jan Kara           2019-05-30  5381  
3da40c7b089810a Josef Bacik        2015-06-22  5382  		if (attr->ia_size != inode->i_size) {
9924a92a8c21757 Theodore Ts'o      2013-02-08  5383  			handle = ext4_journal_start(inode, EXT4_HT_INODE, 3);
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5384  			if (IS_ERR(handle)) {
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5385  				error = PTR_ERR(handle);
b9c1c26739ec2d4 Jan Kara           2019-05-30  5386  				goto out_mmap_sem;
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5387  			}
3da40c7b089810a Josef Bacik        2015-06-22  5388  			if (ext4_handle_valid(handle) && shrink) {
617ba13b31fbf50 Mingming Cao       2006-10-11  5389  				error = ext4_orphan_add(handle, inode);
3d287de3b828226 Dmitry Monakhov    2010-10-27  5390  				orphan = 1;
3d287de3b828226 Dmitry Monakhov    2010-10-27  5391  			}
911af577de4e444 Eryu Guan          2015-07-28  5392  			/*
911af577de4e444 Eryu Guan          2015-07-28  5393  			 * Update c/mtime on truncate up, ext4_truncate() will
911af577de4e444 Eryu Guan          2015-07-28  5394  			 * update c/mtime in shrink case below
911af577de4e444 Eryu Guan          2015-07-28  5395  			 */
1bc33893e79a79d Jeff Layton        2023-07-05  5396  			if (!shrink)
b898ab233611f79 Jeff Layton        2023-10-04  5397  				inode_set_mtime_to_ts(inode,
b898ab233611f79 Jeff Layton        2023-10-04  5398  						      inode_set_ctime_current(inode));
aa75f4d3daaeb13 Harshad Shirwadkar 2020-10-15  5399  
aa75f4d3daaeb13 Harshad Shirwadkar 2020-10-15  5400  			if (shrink)
a80f7fcf18672ae Harshad Shirwadkar 2020-11-05  5401  				ext4_fc_track_range(handle, inode,
aa75f4d3daaeb13 Harshad Shirwadkar 2020-10-15  5402  					(attr->ia_size > 0 ? attr->ia_size - 1 : 0) >>
aa75f4d3daaeb13 Harshad Shirwadkar 2020-10-15  5403  					inode->i_sb->s_blocksize_bits,
9725958bb75cdfa Xin Yin            2021-12-23  5404  					EXT_MAX_BLOCKS - 1);
aa75f4d3daaeb13 Harshad Shirwadkar 2020-10-15  5405  			else
aa75f4d3daaeb13 Harshad Shirwadkar 2020-10-15  5406  				ext4_fc_track_range(
a80f7fcf18672ae Harshad Shirwadkar 2020-11-05  5407  					handle, inode,
aa75f4d3daaeb13 Harshad Shirwadkar 2020-10-15  5408  					(oldsize > 0 ? oldsize - 1 : oldsize) >>
aa75f4d3daaeb13 Harshad Shirwadkar 2020-10-15  5409  					inode->i_sb->s_blocksize_bits,
aa75f4d3daaeb13 Harshad Shirwadkar 2020-10-15  5410  					(attr->ia_size > 0 ? attr->ia_size - 1 : 0) >>
aa75f4d3daaeb13 Harshad Shirwadkar 2020-10-15  5411  					inode->i_sb->s_blocksize_bits);
aa75f4d3daaeb13 Harshad Shirwadkar 2020-10-15  5412  
617ba13b31fbf50 Mingming Cao       2006-10-11  5413  			rc = ext4_mark_inode_dirty(handle, inode);
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5414  			if (!error)
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5415  				error = rc;
a879a75fe2d0cec Harshad Shirwadkar 2024-05-20  5416  			down_write(&EXT4_I(inode)->i_data_sem);
a879a75fe2d0cec Harshad Shirwadkar 2024-05-20  5417  			EXT4_I(inode)->i_disksize = attr->ia_size;
a879a75fe2d0cec Harshad Shirwadkar 2024-05-20  5418  
90e775b71ac4e68 Jan Kara           2013-08-17  5419  			/*
90e775b71ac4e68 Jan Kara           2013-08-17  5420  			 * We have to update i_size under i_data_sem together
90e775b71ac4e68 Jan Kara           2013-08-17  5421  			 * with i_disksize to avoid races with writeback code
90e775b71ac4e68 Jan Kara           2013-08-17  5422  			 * running ext4_wb_update_i_disksize().
90e775b71ac4e68 Jan Kara           2013-08-17  5423  			 */
90e775b71ac4e68 Jan Kara           2013-08-17  5424  			if (!error)
90e775b71ac4e68 Jan Kara           2013-08-17  5425  				i_size_write(inode, attr->ia_size);
f4534c9fc94d223 Ye Bin             2022-03-26  5426  			else
f4534c9fc94d223 Ye Bin             2022-03-26 @5427  				EXT4_I(inode)->i_disksize = old_disksize;
90e775b71ac4e68 Jan Kara           2013-08-17  5428  			up_write(&EXT4_I(inode)->i_data_sem);
617ba13b31fbf50 Mingming Cao       2006-10-11  5429  			ext4_journal_stop(handle);
b9c1c26739ec2d4 Jan Kara           2019-05-30  5430  			if (error)
b9c1c26739ec2d4 Jan Kara           2019-05-30  5431  				goto out_mmap_sem;
82a25b027ca48d7 Jan Kara           2019-05-23  5432  			if (!shrink) {
b9c1c26739ec2d4 Jan Kara           2019-05-30  5433  				pagecache_isize_extended(inode, oldsize,
b9c1c26739ec2d4 Jan Kara           2019-05-30  5434  							 inode->i_size);
b9c1c26739ec2d4 Jan Kara           2019-05-30  5435  			} else if (ext4_should_journal_data(inode)) {
82a25b027ca48d7 Jan Kara           2019-05-23  5436  				ext4_wait_for_tail_page_commit(inode);
b9c1c26739ec2d4 Jan Kara           2019-05-30  5437  			}
430657b6be896db Ross Zwisler       2018-07-29  5438  		}
430657b6be896db Ross Zwisler       2018-07-29  5439  
53e872681fed6a4 Jan Kara           2012-12-25  5440  		/*
53e872681fed6a4 Jan Kara           2012-12-25  5441  		 * Truncate pagecache after we've waited for commit
53e872681fed6a4 Jan Kara           2012-12-25  5442  		 * in data=journal mode to make pages freeable.
53e872681fed6a4 Jan Kara           2012-12-25  5443  		 */
7caef26767c1727 Kirill A. Shutemov 2013-09-12  5444  		truncate_pagecache(inode, inode->i_size);
b9c1c26739ec2d4 Jan Kara           2019-05-30  5445  		/*
b9c1c26739ec2d4 Jan Kara           2019-05-30  5446  		 * Call ext4_truncate() even if i_size didn't change to
b9c1c26739ec2d4 Jan Kara           2019-05-30  5447  		 * truncate possible preallocated blocks.
b9c1c26739ec2d4 Jan Kara           2019-05-30  5448  		 */
b9c1c26739ec2d4 Jan Kara           2019-05-30  5449  		if (attr->ia_size <= oldsize) {
2c98eb5ea249767 Theodore Ts'o      2016-11-13  5450  			rc = ext4_truncate(inode);
2c98eb5ea249767 Theodore Ts'o      2016-11-13  5451  			if (rc)
2c98eb5ea249767 Theodore Ts'o      2016-11-13  5452  				error = rc;
2c98eb5ea249767 Theodore Ts'o      2016-11-13  5453  		}
b9c1c26739ec2d4 Jan Kara           2019-05-30  5454  out_mmap_sem:
d4f5258eae7b38c Jan Kara           2021-02-04  5455  		filemap_invalidate_unlock(inode->i_mapping);
3da40c7b089810a Josef Bacik        2015-06-22  5456  	}
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5457  
2c98eb5ea249767 Theodore Ts'o      2016-11-13  5458  	if (!error) {
a642c2c0827f560 Jeff Layton        2022-09-08  5459  		if (inc_ivers)
a642c2c0827f560 Jeff Layton        2022-09-08  5460  			inode_inc_iversion(inode);
c1632a0f1120933 Christian Brauner  2023-01-13  5461  		setattr_copy(idmap, inode, attr);
1025774ce411f2b Christoph Hellwig  2010-06-04  5462  		mark_inode_dirty(inode);
1025774ce411f2b Christoph Hellwig  2010-06-04  5463  	}
1025774ce411f2b Christoph Hellwig  2010-06-04  5464  
1025774ce411f2b Christoph Hellwig  2010-06-04  5465  	/*
1025774ce411f2b Christoph Hellwig  2010-06-04  5466  	 * If the call to ext4_truncate failed to get a transaction handle at
1025774ce411f2b Christoph Hellwig  2010-06-04  5467  	 * all, we need to clean up the in-core orphan list manually.
1025774ce411f2b Christoph Hellwig  2010-06-04  5468  	 */
3d287de3b828226 Dmitry Monakhov    2010-10-27  5469  	if (orphan && inode->i_nlink)
617ba13b31fbf50 Mingming Cao       2006-10-11  5470  		ext4_orphan_del(NULL, inode);
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5471  
2c98eb5ea249767 Theodore Ts'o      2016-11-13  5472  	if (!error && (ia_valid & ATTR_MODE))
13e83a4923bea7c Christian Brauner  2023-01-13  5473  		rc = posix_acl_chmod(idmap, dentry, inode->i_mode);
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5474  
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5475  err_out:
aa75f4d3daaeb13 Harshad Shirwadkar 2020-10-15  5476  	if  (error)
617ba13b31fbf50 Mingming Cao       2006-10-11  5477  		ext4_std_error(inode->i_sb, error);
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5478  	if (!error)
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5479  		error = rc;
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5480  	return error;
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5481  }
ac27a0ec112a089 Dave Kleikamp      2006-10-11  5482  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

