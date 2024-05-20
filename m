Return-Path: <linux-ext4+bounces-2611-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A518CA272
	for <lists+linux-ext4@lfdr.de>; Mon, 20 May 2024 20:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FA99B21A96
	for <lists+linux-ext4@lfdr.de>; Mon, 20 May 2024 18:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFEA1384B0;
	Mon, 20 May 2024 18:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O5lqunol"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29AE4AEE3
	for <linux-ext4@vger.kernel.org>; Mon, 20 May 2024 18:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716231555; cv=none; b=upMuC22p93JOE4kJkl2+dgsSuvj4uzHbcOYZ7boG61amYgQTzyDmoyf+xG2t9fmrKrp9wT9CX4BdEms/W3SQH4njS4EzXC8v4OL2nV5pCZiYWFJda/H9E6pj/f89S6NxJWrS3hrI1YY2Wx6Wozut9/Uvi1MfNlcw7fcmxytERUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716231555; c=relaxed/simple;
	bh=FGPgOMM8WtZ3iBZnP3NJEWFGaaaJ7NvY3p6np4B0pGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJas9nROfeT/BecpWsVPppkjQ7NvwFNFXTOI19uNzOdTqb11oP6vjEFtgV9109SAqvMnZ8Sf9mmA3dnYuy9sgOSwQI+kV7JDdJyV41vGdmZx34Fne+88k8RcwsaVqH3LRCJMYMLJntuKblsRZqH1EVHjIwUo+MUngMAC/BBW8OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O5lqunol; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716231554; x=1747767554;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FGPgOMM8WtZ3iBZnP3NJEWFGaaaJ7NvY3p6np4B0pGQ=;
  b=O5lqunolGpb8t7LASi4WiGfgdiNcedCoEbSuQGwRqUaEoNzvSOGJyW1Z
   4OtFccSkMwWFde1XNUnhl+yVMRLALbXRQS8ZpSYiqL2BjoT11nLIHakg+
   SDnmFB2n8w9JhpQ/+nAsjLkcnip0HU3dX8mNVIyAKDUZWVcwdOPY0ni8F
   WsvJKdODg+oPfMm2vwd35OFpXy85jXg2y7Z1BNM8Uf1fdCa/TmP7Lqcs3
   Un7pYTjEd82Bli5hBPZXQw6OgEh6RNO5OtA6ml6wQy8JfVRJiTL/yncM4
   e21I4QZfVnmNT2lfc0kIGm2z5Ny4tILJ91kWmNztZvUCh2yog+a1sL1Ks
   g==;
X-CSE-ConnectionGUID: g3rYQ0m8QWKroyY1K/sdPw==
X-CSE-MsgGUID: ovLzMTC0RhSvz/yc+btnfQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12492724"
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="12492724"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 11:59:14 -0700
X-CSE-ConnectionGUID: +MJMrbs8SZC+V1EICc9ipw==
X-CSE-MsgGUID: as/S58l4Qw2B6utu2QFRQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="32624782"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 20 May 2024 11:59:11 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s98Dj-00054y-0D;
	Mon, 20 May 2024 18:58:56 +0000
Date: Tue, 21 May 2024 02:58:06 +0800
From: kernel test robot <lkp@intel.com>
To: Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
	linux-ext4@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, tytso@mit.edu, saukad@google.com,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: [PATCH 10/10] ext4: make fast commit ineligible on
 ext4_reserve_inode_write failure
Message-ID: <202405210233.ZNN50qLq-lkp@intel.com>
References: <20240520055153.136091-11-harshadshirwadkar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520055153.136091-11-harshadshirwadkar@gmail.com>

Hi Harshad,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tytso-ext4/dev]
[also build test WARNING on linus/master v6.9 next-20240520]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Harshad-Shirwadkar/ext4-convert-i_fc_lock-to-spinlock/20240520-135501
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
patch link:    https://lore.kernel.org/r/20240520055153.136091-11-harshadshirwadkar%40gmail.com
patch subject: [PATCH 10/10] ext4: make fast commit ineligible on ext4_reserve_inode_write failure
config: i386-randconfig-141-20240520 (https://download.01.org/0day-ci/archive/20240521/202405210233.ZNN50qLq-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405210233.ZNN50qLq-lkp@intel.com/

New smatch warnings:
fs/ext4/inode.c:5423 ext4_setattr() warn: inconsistent indenting

Old smatch warnings:
fs/ext4/inode.c:2422 mpage_prepare_extent_to_map() warn: missing error code 'err'
fs/ext4/inode.c:5437 ext4_setattr() error: uninitialized symbol 'old_disksize'.
fs/ext4/inode.c:6150 ext4_page_mkwrite() error: uninitialized symbol 'get_block'.

vim +5423 fs/ext4/inode.c

53e872681fed6a Jan Kara           2012-12-25  5251  
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5252  /*
617ba13b31fbf5 Mingming Cao       2006-10-11  5253   * ext4_setattr()
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5254   *
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5255   * Called from notify_change.
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5256   *
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5257   * We want to trap VFS attempts to truncate the file as soon as
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5258   * possible.  In particular, we want to make sure that when the VFS
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5259   * shrinks i_size, we put the inode on the orphan list and modify
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5260   * i_disksize immediately, so that during the subsequent flushing of
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5261   * dirty pages and freeing of disk blocks, we can guarantee that any
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5262   * commit will leave the blocks being flushed in an unused state on
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5263   * disk.  (On recovery, the inode will get truncated and the blocks will
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5264   * be freed, so we have a strong guarantee that no future commit will
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5265   * leave these blocks visible to the user.)
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5266   *
678aaf481496b0 Jan Kara           2008-07-11  5267   * Another thing we have to assure is that if we are in ordered mode
678aaf481496b0 Jan Kara           2008-07-11  5268   * and inode is still attached to the committing transaction, we must
678aaf481496b0 Jan Kara           2008-07-11  5269   * we start writeout of all the dirty pages which are being truncated.
678aaf481496b0 Jan Kara           2008-07-11  5270   * This way we are sure that all the data written in the previous
678aaf481496b0 Jan Kara           2008-07-11  5271   * transaction are already on disk (truncate waits for pages under
678aaf481496b0 Jan Kara           2008-07-11  5272   * writeback).
678aaf481496b0 Jan Kara           2008-07-11  5273   *
f340b3d9027485 hongnanli          2022-01-21  5274   * Called with inode->i_rwsem down.
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5275   */
c1632a0f112093 Christian Brauner  2023-01-13  5276  int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
549c7297717c32 Christian Brauner  2021-01-21  5277  		 struct iattr *attr)
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5278  {
2b0143b5c986be David Howells      2015-03-17  5279  	struct inode *inode = d_inode(dentry);
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5280  	int error, rc = 0;
3d287de3b82822 Dmitry Monakhov    2010-10-27  5281  	int orphan = 0;
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5282  	const unsigned int ia_valid = attr->ia_valid;
a642c2c0827f56 Jeff Layton        2022-09-08  5283  	bool inc_ivers = true;
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5284  
eb8ab4443aec5f Jan Kara           2023-06-16  5285  	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
0db1ff222d40f1 Theodore Ts'o      2017-02-05  5286  		return -EIO;
0db1ff222d40f1 Theodore Ts'o      2017-02-05  5287  
02b016ca7f9922 Theodore Ts'o      2019-06-09  5288  	if (unlikely(IS_IMMUTABLE(inode)))
02b016ca7f9922 Theodore Ts'o      2019-06-09  5289  		return -EPERM;
02b016ca7f9922 Theodore Ts'o      2019-06-09  5290  
02b016ca7f9922 Theodore Ts'o      2019-06-09  5291  	if (unlikely(IS_APPEND(inode) &&
02b016ca7f9922 Theodore Ts'o      2019-06-09  5292  		     (ia_valid & (ATTR_MODE | ATTR_UID |
02b016ca7f9922 Theodore Ts'o      2019-06-09  5293  				  ATTR_GID | ATTR_TIMES_SET))))
02b016ca7f9922 Theodore Ts'o      2019-06-09  5294  		return -EPERM;
02b016ca7f9922 Theodore Ts'o      2019-06-09  5295  
c1632a0f112093 Christian Brauner  2023-01-13  5296  	error = setattr_prepare(idmap, dentry, attr);
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5297  	if (error)
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5298  		return error;
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5299  
3ce2b8ddd84d50 Eric Biggers       2017-10-18  5300  	error = fscrypt_prepare_setattr(dentry, attr);
3ce2b8ddd84d50 Eric Biggers       2017-10-18  5301  	if (error)
3ce2b8ddd84d50 Eric Biggers       2017-10-18  5302  		return error;
3ce2b8ddd84d50 Eric Biggers       2017-10-18  5303  
c93d8f88580921 Eric Biggers       2019-07-22  5304  	error = fsverity_prepare_setattr(dentry, attr);
c93d8f88580921 Eric Biggers       2019-07-22  5305  	if (error)
c93d8f88580921 Eric Biggers       2019-07-22  5306  		return error;
c93d8f88580921 Eric Biggers       2019-07-22  5307  
f861646a65623b Christian Brauner  2023-01-13  5308  	if (is_quota_modification(idmap, inode, attr)) {
a7cdadee0e8948 Jan Kara           2015-06-29  5309  		error = dquot_initialize(inode);
a7cdadee0e8948 Jan Kara           2015-06-29  5310  		if (error)
a7cdadee0e8948 Jan Kara           2015-06-29  5311  			return error;
a7cdadee0e8948 Jan Kara           2015-06-29  5312  	}
2729cfdcfa1cc4 Harshad Shirwadkar 2021-12-23  5313  
0dbe12f2e49c04 Christian Brauner  2023-01-13  5314  	if (i_uid_needs_update(idmap, attr, inode) ||
0dbe12f2e49c04 Christian Brauner  2023-01-13  5315  	    i_gid_needs_update(idmap, attr, inode)) {
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5316  		handle_t *handle;
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5317  
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5318  		/* (user+group)*(old+new) structure, inode write (sb,
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5319  		 * inode block, ? - but truncate inode update has it) */
9924a92a8c2175 Theodore Ts'o      2013-02-08  5320  		handle = ext4_journal_start(inode, EXT4_HT_QUOTA,
9924a92a8c2175 Theodore Ts'o      2013-02-08  5321  			(EXT4_MAXQUOTAS_INIT_BLOCKS(inode->i_sb) +
194074acacebc1 Dmitry Monakhov    2009-12-08  5322  			 EXT4_MAXQUOTAS_DEL_BLOCKS(inode->i_sb)) + 3);
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5323  		if (IS_ERR(handle)) {
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5324  			error = PTR_ERR(handle);
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5325  			goto err_out;
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5326  		}
7a9ca53aea10ad Tahsin Erdogan     2017-06-22  5327  
7a9ca53aea10ad Tahsin Erdogan     2017-06-22  5328  		/* dquot_transfer() calls back ext4_get_inode_usage() which
7a9ca53aea10ad Tahsin Erdogan     2017-06-22  5329  		 * counts xattr inode references.
7a9ca53aea10ad Tahsin Erdogan     2017-06-22  5330  		 */
7a9ca53aea10ad Tahsin Erdogan     2017-06-22  5331  		down_read(&EXT4_I(inode)->xattr_sem);
f861646a65623b Christian Brauner  2023-01-13  5332  		error = dquot_transfer(idmap, inode, attr);
7a9ca53aea10ad Tahsin Erdogan     2017-06-22  5333  		up_read(&EXT4_I(inode)->xattr_sem);
7a9ca53aea10ad Tahsin Erdogan     2017-06-22  5334  
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5335  		if (error) {
617ba13b31fbf5 Mingming Cao       2006-10-11  5336  			ext4_journal_stop(handle);
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5337  			return error;
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5338  		}
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5339  		/* Update corresponding info in inode so that everything is in
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5340  		 * one transaction */
0dbe12f2e49c04 Christian Brauner  2023-01-13  5341  		i_uid_update(idmap, attr, inode);
0dbe12f2e49c04 Christian Brauner  2023-01-13  5342  		i_gid_update(idmap, attr, inode);
617ba13b31fbf5 Mingming Cao       2006-10-11  5343  		error = ext4_mark_inode_dirty(handle, inode);
617ba13b31fbf5 Mingming Cao       2006-10-11  5344  		ext4_journal_stop(handle);
512c15ef05d73a Pan Bian           2021-01-17  5345  		if (unlikely(error)) {
4209ae12b12265 Harshad Shirwadkar 2020-04-26  5346  			return error;
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5347  		}
512c15ef05d73a Pan Bian           2021-01-17  5348  	}
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5349  
3da40c7b089810 Josef Bacik        2015-06-22  5350  	if (attr->ia_valid & ATTR_SIZE) {
5208386c501276 Jan Kara           2013-08-17  5351  		handle_t *handle;
3da40c7b089810 Josef Bacik        2015-06-22  5352  		loff_t oldsize = inode->i_size;
f4534c9fc94d22 Ye Bin             2022-03-26  5353  		loff_t old_disksize;
b9c1c26739ec2d Jan Kara           2019-05-30  5354  		int shrink = (attr->ia_size < inode->i_size);
562c72aa57c36b Christoph Hellwig  2011-06-24  5355  
12e9b892002d9a Dmitry Monakhov    2010-05-16  5356  		if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))) {
e2b4657453c0d5 Eric Sandeen       2008-01-28  5357  			struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
e2b4657453c0d5 Eric Sandeen       2008-01-28  5358  
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  5359  			if (attr->ia_size > sbi->s_bitmap_maxbytes) {
0c095c7f113e9f Theodore Ts'o      2010-07-27  5360  				return -EFBIG;
e2b4657453c0d5 Eric Sandeen       2008-01-28  5361  			}
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  5362  		}
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  5363  		if (!S_ISREG(inode->i_mode)) {
3da40c7b089810 Josef Bacik        2015-06-22  5364  			return -EINVAL;
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  5365  		}
dff6efc326a4d5 Christoph Hellwig  2013-11-19  5366  
a642c2c0827f56 Jeff Layton        2022-09-08  5367  		if (attr->ia_size == inode->i_size)
a642c2c0827f56 Jeff Layton        2022-09-08  5368  			inc_ivers = false;
dff6efc326a4d5 Christoph Hellwig  2013-11-19  5369  
b9c1c26739ec2d Jan Kara           2019-05-30  5370  		if (shrink) {
b9c1c26739ec2d Jan Kara           2019-05-30  5371  			if (ext4_should_order_data(inode)) {
5208386c501276 Jan Kara           2013-08-17  5372  				error = ext4_begin_ordered_truncate(inode,
5208386c501276 Jan Kara           2013-08-17  5373  							    attr->ia_size);
5208386c501276 Jan Kara           2013-08-17  5374  				if (error)
5208386c501276 Jan Kara           2013-08-17  5375  					goto err_out;
5208386c501276 Jan Kara           2013-08-17  5376  			}
b9c1c26739ec2d Jan Kara           2019-05-30  5377  			/*
b9c1c26739ec2d Jan Kara           2019-05-30  5378  			 * Blocks are going to be removed from the inode. Wait
b9c1c26739ec2d Jan Kara           2019-05-30  5379  			 * for dio in flight.
b9c1c26739ec2d Jan Kara           2019-05-30  5380  			 */
b9c1c26739ec2d Jan Kara           2019-05-30  5381  			inode_dio_wait(inode);
b9c1c26739ec2d Jan Kara           2019-05-30  5382  		}
b9c1c26739ec2d Jan Kara           2019-05-30  5383  
d4f5258eae7b38 Jan Kara           2021-02-04  5384  		filemap_invalidate_lock(inode->i_mapping);
b9c1c26739ec2d Jan Kara           2019-05-30  5385  
b9c1c26739ec2d Jan Kara           2019-05-30  5386  		rc = ext4_break_layouts(inode);
b9c1c26739ec2d Jan Kara           2019-05-30  5387  		if (rc) {
d4f5258eae7b38 Jan Kara           2021-02-04  5388  			filemap_invalidate_unlock(inode->i_mapping);
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  5389  			goto err_out;
b9c1c26739ec2d Jan Kara           2019-05-30  5390  		}
b9c1c26739ec2d Jan Kara           2019-05-30  5391  
3da40c7b089810 Josef Bacik        2015-06-22  5392  		if (attr->ia_size != inode->i_size) {
9924a92a8c2175 Theodore Ts'o      2013-02-08  5393  			handle = ext4_journal_start(inode, EXT4_HT_INODE, 3);
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5394  			if (IS_ERR(handle)) {
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5395  				error = PTR_ERR(handle);
b9c1c26739ec2d Jan Kara           2019-05-30  5396  				goto out_mmap_sem;
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5397  			}
3da40c7b089810 Josef Bacik        2015-06-22  5398  			if (ext4_handle_valid(handle) && shrink) {
617ba13b31fbf5 Mingming Cao       2006-10-11  5399  				error = ext4_orphan_add(handle, inode);
3d287de3b82822 Dmitry Monakhov    2010-10-27  5400  				orphan = 1;
3d287de3b82822 Dmitry Monakhov    2010-10-27  5401  			}
911af577de4e44 Eryu Guan          2015-07-28  5402  			/*
911af577de4e44 Eryu Guan          2015-07-28  5403  			 * Update c/mtime on truncate up, ext4_truncate() will
911af577de4e44 Eryu Guan          2015-07-28  5404  			 * update c/mtime in shrink case below
911af577de4e44 Eryu Guan          2015-07-28  5405  			 */
1bc33893e79a79 Jeff Layton        2023-07-05  5406  			if (!shrink)
b898ab233611f7 Jeff Layton        2023-10-04  5407  				inode_set_mtime_to_ts(inode,
b898ab233611f7 Jeff Layton        2023-10-04  5408  						      inode_set_ctime_current(inode));
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  5409  
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  5410  			if (shrink)
a80f7fcf18672a Harshad Shirwadkar 2020-11-05  5411  				ext4_fc_track_range(handle, inode,
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  5412  					(attr->ia_size > 0 ? attr->ia_size - 1 : 0) >>
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  5413  					inode->i_sb->s_blocksize_bits,
9725958bb75cdf Xin Yin            2021-12-23  5414  					EXT_MAX_BLOCKS - 1);
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  5415  			else
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  5416  				ext4_fc_track_range(
a80f7fcf18672a Harshad Shirwadkar 2020-11-05  5417  					handle, inode,
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  5418  					(oldsize > 0 ? oldsize - 1 : oldsize) >>
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  5419  					inode->i_sb->s_blocksize_bits,
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  5420  					(attr->ia_size > 0 ? attr->ia_size - 1 : 0) >>
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  5421  					inode->i_sb->s_blocksize_bits);
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  5422  
617ba13b31fbf5 Mingming Cao       2006-10-11 @5423  						rc = ext4_mark_inode_dirty(handle, inode);
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5424  			if (!error)
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5425  				error = rc;
a879a75fe2d0ce Harshad Shirwadkar 2024-05-20  5426  			down_write(&EXT4_I(inode)->i_data_sem);
a879a75fe2d0ce Harshad Shirwadkar 2024-05-20  5427  			EXT4_I(inode)->i_disksize = attr->ia_size;
a879a75fe2d0ce Harshad Shirwadkar 2024-05-20  5428  
90e775b71ac4e6 Jan Kara           2013-08-17  5429  			/*
90e775b71ac4e6 Jan Kara           2013-08-17  5430  			 * We have to update i_size under i_data_sem together
90e775b71ac4e6 Jan Kara           2013-08-17  5431  			 * with i_disksize to avoid races with writeback code
90e775b71ac4e6 Jan Kara           2013-08-17  5432  			 * running ext4_wb_update_i_disksize().
90e775b71ac4e6 Jan Kara           2013-08-17  5433  			 */
90e775b71ac4e6 Jan Kara           2013-08-17  5434  			if (!error)
90e775b71ac4e6 Jan Kara           2013-08-17  5435  				i_size_write(inode, attr->ia_size);
f4534c9fc94d22 Ye Bin             2022-03-26  5436  			else
f4534c9fc94d22 Ye Bin             2022-03-26  5437  				EXT4_I(inode)->i_disksize = old_disksize;
90e775b71ac4e6 Jan Kara           2013-08-17  5438  			up_write(&EXT4_I(inode)->i_data_sem);
617ba13b31fbf5 Mingming Cao       2006-10-11  5439  			ext4_journal_stop(handle);
b9c1c26739ec2d Jan Kara           2019-05-30  5440  			if (error)
b9c1c26739ec2d Jan Kara           2019-05-30  5441  				goto out_mmap_sem;
82a25b027ca48d Jan Kara           2019-05-23  5442  			if (!shrink) {
b9c1c26739ec2d Jan Kara           2019-05-30  5443  				pagecache_isize_extended(inode, oldsize,
b9c1c26739ec2d Jan Kara           2019-05-30  5444  							 inode->i_size);
b9c1c26739ec2d Jan Kara           2019-05-30  5445  			} else if (ext4_should_journal_data(inode)) {
82a25b027ca48d Jan Kara           2019-05-23  5446  				ext4_wait_for_tail_page_commit(inode);
b9c1c26739ec2d Jan Kara           2019-05-30  5447  			}
430657b6be896d Ross Zwisler       2018-07-29  5448  		}
430657b6be896d Ross Zwisler       2018-07-29  5449  
53e872681fed6a Jan Kara           2012-12-25  5450  		/*
53e872681fed6a Jan Kara           2012-12-25  5451  		 * Truncate pagecache after we've waited for commit
53e872681fed6a Jan Kara           2012-12-25  5452  		 * in data=journal mode to make pages freeable.
53e872681fed6a Jan Kara           2012-12-25  5453  		 */
7caef26767c172 Kirill A. Shutemov 2013-09-12  5454  		truncate_pagecache(inode, inode->i_size);
b9c1c26739ec2d Jan Kara           2019-05-30  5455  		/*
b9c1c26739ec2d Jan Kara           2019-05-30  5456  		 * Call ext4_truncate() even if i_size didn't change to
b9c1c26739ec2d Jan Kara           2019-05-30  5457  		 * truncate possible preallocated blocks.
b9c1c26739ec2d Jan Kara           2019-05-30  5458  		 */
b9c1c26739ec2d Jan Kara           2019-05-30  5459  		if (attr->ia_size <= oldsize) {
2c98eb5ea24976 Theodore Ts'o      2016-11-13  5460  			rc = ext4_truncate(inode);
2c98eb5ea24976 Theodore Ts'o      2016-11-13  5461  			if (rc)
2c98eb5ea24976 Theodore Ts'o      2016-11-13  5462  				error = rc;
2c98eb5ea24976 Theodore Ts'o      2016-11-13  5463  		}
b9c1c26739ec2d Jan Kara           2019-05-30  5464  out_mmap_sem:
d4f5258eae7b38 Jan Kara           2021-02-04  5465  		filemap_invalidate_unlock(inode->i_mapping);
3da40c7b089810 Josef Bacik        2015-06-22  5466  	}
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5467  
2c98eb5ea24976 Theodore Ts'o      2016-11-13  5468  	if (!error) {
a642c2c0827f56 Jeff Layton        2022-09-08  5469  		if (inc_ivers)
a642c2c0827f56 Jeff Layton        2022-09-08  5470  			inode_inc_iversion(inode);
c1632a0f112093 Christian Brauner  2023-01-13  5471  		setattr_copy(idmap, inode, attr);
1025774ce411f2 Christoph Hellwig  2010-06-04  5472  		mark_inode_dirty(inode);
1025774ce411f2 Christoph Hellwig  2010-06-04  5473  	}
1025774ce411f2 Christoph Hellwig  2010-06-04  5474  
1025774ce411f2 Christoph Hellwig  2010-06-04  5475  	/*
1025774ce411f2 Christoph Hellwig  2010-06-04  5476  	 * If the call to ext4_truncate failed to get a transaction handle at
1025774ce411f2 Christoph Hellwig  2010-06-04  5477  	 * all, we need to clean up the in-core orphan list manually.
1025774ce411f2 Christoph Hellwig  2010-06-04  5478  	 */
3d287de3b82822 Dmitry Monakhov    2010-10-27  5479  	if (orphan && inode->i_nlink)
617ba13b31fbf5 Mingming Cao       2006-10-11  5480  		ext4_orphan_del(NULL, inode);
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5481  
2c98eb5ea24976 Theodore Ts'o      2016-11-13  5482  	if (!error && (ia_valid & ATTR_MODE))
13e83a4923bea7 Christian Brauner  2023-01-13  5483  		rc = posix_acl_chmod(idmap, dentry, inode->i_mode);
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5484  
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5485  err_out:
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  5486  	if  (error)
617ba13b31fbf5 Mingming Cao       2006-10-11  5487  		ext4_std_error(inode->i_sb, error);
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5488  	if (!error)
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5489  		error = rc;
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5490  	return error;
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5491  }
ac27a0ec112a08 Dave Kleikamp      2006-10-11  5492  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

