Return-Path: <linux-ext4+bounces-11915-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E446BC6E870
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Nov 2025 13:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 9F2CE2DEAA
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Nov 2025 12:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55859351FDE;
	Wed, 19 Nov 2025 12:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UTVwk4Uv"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB8B2EDD7E
	for <linux-ext4@vger.kernel.org>; Wed, 19 Nov 2025 12:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763556113; cv=none; b=j9PQuBTiYdPcK6oBAWGooZIPrczc3zgk0GZES0HMmYFwqco0r3YlRwcvI5wPTd6IcM9fRkbUoqNN7tMHUw4mQ7zpausGO9jPGyxh/HDtuTtinrcBMoJzUqYkiunxJZdLfCKYmG5ZvF81WxbO3BiyVYhIl7TOk3HPvvTgyLr6/v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763556113; c=relaxed/simple;
	bh=Pruivijvad7aFnsUBCc2JgwxgpOVvtj91o1Ox/7AbLs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GphWGS58dYH68q8u3KcF0nyVWReyMYWQU88zquuiw2+o58u9JwoKESNWtxetxGJ/5Owzl+Dnfy9yloTt5cXX26YExsb8XEjny2d2hXWTj5jTr9bCVTG3WTKHoWMHsYh3ZNj7RNOTS2xWZKFTkY9fexhl2hDc2/bijxPqN+VBgBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UTVwk4Uv; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59583505988so1279933e87.1
        for <linux-ext4@vger.kernel.org>; Wed, 19 Nov 2025 04:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763556108; x=1764160908; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cqaNfGBajUlIexaUVfmPu0iXh8haQirgtAK0qMIGmPw=;
        b=UTVwk4UvlGT45tU3pX8zCeoE9aIFotlZYbYT0VaI/d9VhlhUjEGJe5f0DpU355BOlX
         odLRxLH+hjrmRjV3ykVRKs/uoEln03HIVembDyKVbD6vGSAmR8+fhS2wrgrqAaKNlFAG
         g6BWnAsG/M49svElFP2f6jMvCAV8UyOXsMP40EAe1YQ+YU+6kQij2cs/bMdLVomGMDxU
         sW2YPG1t21ndZTVcZfePyXCN5uvsR8X51PjcJo1HCWY1vqRAbY4k8eauXOmgnYTY3hq8
         fsOn0m0ebxHHVAG6PjDYLwOow6vSjDlpMJgMKyksxulOu8VqUScvqrMbuGFEtaoY+S08
         hBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763556108; x=1764160908;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqaNfGBajUlIexaUVfmPu0iXh8haQirgtAK0qMIGmPw=;
        b=Eu3VrGCGftGak53ioVxt6GswGdaeXxD3uAATZAs4JsAUEwJtdA57mW7jy7VGpwy9WR
         +ADhiAbr8/l+NcepXV3KCudTH+UVdJFUQaluh7o9lBHzEgqDbDa3pqUkLpESlUz1r3ar
         14f/SSAHBOryCW/QmgSVsO8LJM6hvv/D7HJxq6E5jbJOBHw4a8dMNxjKe9sTvrGvNbEe
         DxfTKeeC8SI/dL67PFeVAq/0PknfEHyP9iY+hfqyYQPLl2gUg0gbUmWeDjwfmgHy9Ru5
         gg9/wGOMYiazRJguP5gZTQkEoysH9XNrvWgj+krgcwENrkY+jNX4hdpnLseFbiR4CQFO
         12iw==
X-Forwarded-Encrypted: i=1; AJvYcCW1eWQvYsU9bqksOWUxruXxb7kmivZJYgUaYC1jWwpDdKMK+esw3lQ+SvpcUb/63zNgcPTho1lG221F@vger.kernel.org
X-Gm-Message-State: AOJu0YyP8Qg2PzoHSVH3i/hpx88pdCAIanXgLa+0FI9W0lS7tHzvrcOT
	hf3U5WoRJtzHCzC9Sd8EaAs70TEYLnT2egqnx0/ghHYhZFCxVnsMnWu5kxoJKy6Dquc=
X-Gm-Gg: ASbGncvFiB/tpw+jnluCYdx9FB2K5qJHpBWoF+o2Pnq4DA7cq1p57K1beI9sLQMM9J8
	7xg6Ofqk/50/nd59Z6SCRVBpg1Jd5yQ+kObAwjUqmjaW02ZIgtuM+gWqpcpten0OyjAubFrdZ83
	2dvBIVsgR1Nf+L2Hge5ra1Jzb/oOVr3ROgZ2wYS7rc/129HM40crweEgrlVqWZHGFqAaiek2S48
	etmfcrxImYH5fuLdylgF3EJ+LNm05DiVNgFM3r4coAoR3zhJupX0xrhsmX7C4CajxWmdM3Jwms7
	SwZ3rpIw2Btda+Xhn/ARrLNFQ1bM26ifEkdqV+0Rmcgz9mFK58PU9JVnBDJ1IpVidvTi2rFMjeV
	pIbQkAx1xR8ZLy4if6eYd+TDSEtmmrR54u8wNtPsMpP/7BX0iLu5mqnuXpAup8vGg97yBxA406A
	FKRcarzSHGk0B0I1gR
X-Google-Smtp-Source: AGHT+IGgG9JwgGKJ3aKQY4BUnqqvqt+Oxcxat25JrhW0w3XxBuj8j1nqWa4ogvFwuEprR6Opl3Q7pw==
X-Received: by 2002:a05:6512:ac6:b0:57b:56d8:95a1 with SMTP id 2adb3069b0e04-59651cb11cdmr771821e87.19.1763556108220;
        Wed, 19 Nov 2025 04:41:48 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-595803ac925sm4694070e87.10.2025.11.19.04.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 04:41:47 -0800 (PST)
Date: Wed, 19 Nov 2025 15:41:44 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, libaokun@huaweicloud.com,
	linux-ext4@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz,
	linux-kernel@vger.kernel.org, kernel@pankajraghav.com,
	mcgrof@kernel.org, ebiggers@kernel.org, willy@infradead.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com,
	libaokun1@huawei.com, libaokun@huaweicloud.com
Subject: Re: [PATCH v3 21/24] ext4: make data=journal support large block size
Message-ID: <202511161433.qI6uGU0m-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111142634.3301616-22-libaokun@huaweicloud.com>

Hi,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/libaokun-huaweicloud-com/ext4-remove-page-offset-calculation-in-ext4_block_zero_page_range/20251111-224944
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
patch link:    https://lore.kernel.org/r/20251111142634.3301616-22-libaokun%40huaweicloud.com
patch subject: [PATCH v3 21/24] ext4: make data=journal support large block size
config: arm64-randconfig-r071-20251114 (https://download.01.org/0day-ci/archive/20251116/202511161433.qI6uGU0m-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 0bba1e76581bad04e7d7f09f5115ae5e2989e0d9)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202511161433.qI6uGU0m-lkp@intel.com/

New smatch warnings:
fs/ext4/inode.c:6612 ext4_change_inode_journal_flag() warn: inconsistent returns '&inode->i_mapping->invalidate_lock'.

vim +6612 fs/ext4/inode.c

617ba13b31fbf5 Mingming Cao       2006-10-11  6527  int ext4_change_inode_journal_flag(struct inode *inode, int val)
ac27a0ec112a08 Dave Kleikamp      2006-10-11  6528  {
ac27a0ec112a08 Dave Kleikamp      2006-10-11  6529  	journal_t *journal;
ac27a0ec112a08 Dave Kleikamp      2006-10-11  6530  	handle_t *handle;
ac27a0ec112a08 Dave Kleikamp      2006-10-11  6531  	int err;
00d873c17e29cc Jan Kara           2023-05-04  6532  	int alloc_ctx;
ac27a0ec112a08 Dave Kleikamp      2006-10-11  6533  
ac27a0ec112a08 Dave Kleikamp      2006-10-11  6534  	/*
ac27a0ec112a08 Dave Kleikamp      2006-10-11  6535  	 * We have to be very careful here: changing a data block's
ac27a0ec112a08 Dave Kleikamp      2006-10-11  6536  	 * journaling status dynamically is dangerous.  If we write a
ac27a0ec112a08 Dave Kleikamp      2006-10-11  6537  	 * data block to the journal, change the status and then delete
ac27a0ec112a08 Dave Kleikamp      2006-10-11  6538  	 * that block, we risk forgetting to revoke the old log record
ac27a0ec112a08 Dave Kleikamp      2006-10-11  6539  	 * from the journal and so a subsequent replay can corrupt data.
ac27a0ec112a08 Dave Kleikamp      2006-10-11  6540  	 * So, first we make sure that the journal is empty and that
ac27a0ec112a08 Dave Kleikamp      2006-10-11  6541  	 * nobody is changing anything.
ac27a0ec112a08 Dave Kleikamp      2006-10-11  6542  	 */
ac27a0ec112a08 Dave Kleikamp      2006-10-11  6543  
617ba13b31fbf5 Mingming Cao       2006-10-11  6544  	journal = EXT4_JOURNAL(inode);
0390131ba84fd3 Frank Mayhar       2009-01-07  6545  	if (!journal)
0390131ba84fd3 Frank Mayhar       2009-01-07  6546  		return 0;
d699594dc151c6 Dave Hansen        2007-07-18  6547  	if (is_journal_aborted(journal))
ac27a0ec112a08 Dave Kleikamp      2006-10-11  6548  		return -EROFS;
ac27a0ec112a08 Dave Kleikamp      2006-10-11  6549  
17335dcc471199 Dmitry Monakhov    2012-09-29  6550  	/* Wait for all existing dio workers */
17335dcc471199 Dmitry Monakhov    2012-09-29  6551  	inode_dio_wait(inode);
17335dcc471199 Dmitry Monakhov    2012-09-29  6552  
4c54659269ecb7 Daeho Jeong        2016-04-25  6553  	/*
4c54659269ecb7 Daeho Jeong        2016-04-25  6554  	 * Before flushing the journal and switching inode's aops, we have
4c54659269ecb7 Daeho Jeong        2016-04-25  6555  	 * to flush all dirty data the inode has. There can be outstanding
4c54659269ecb7 Daeho Jeong        2016-04-25  6556  	 * delayed allocations, there can be unwritten extents created by
4c54659269ecb7 Daeho Jeong        2016-04-25  6557  	 * fallocate or buffered writes in dioread_nolock mode covered by
4c54659269ecb7 Daeho Jeong        2016-04-25  6558  	 * dirty data which can be converted only after flushing the dirty
4c54659269ecb7 Daeho Jeong        2016-04-25  6559  	 * data (and journalled aops don't know how to handle these cases).
4c54659269ecb7 Daeho Jeong        2016-04-25  6560  	 */
d4f5258eae7b38 Jan Kara           2021-02-04  6561  	filemap_invalidate_lock(inode->i_mapping);
4c54659269ecb7 Daeho Jeong        2016-04-25  6562  	err = filemap_write_and_wait(inode->i_mapping);
4c54659269ecb7 Daeho Jeong        2016-04-25  6563  	if (err < 0) {
d4f5258eae7b38 Jan Kara           2021-02-04  6564  		filemap_invalidate_unlock(inode->i_mapping);
4c54659269ecb7 Daeho Jeong        2016-04-25  6565  		return err;
4c54659269ecb7 Daeho Jeong        2016-04-25  6566  	}
f893fb965834e9 Baokun Li          2025-11-11  6567  	/* Before switch the inode journalling mode evict all the page cache. */
f893fb965834e9 Baokun Li          2025-11-11  6568  	truncate_pagecache(inode, 0);
4c54659269ecb7 Daeho Jeong        2016-04-25  6569  
00d873c17e29cc Jan Kara           2023-05-04  6570  	alloc_ctx = ext4_writepages_down_write(inode->i_sb);
dab291af8d6307 Mingming Cao       2006-10-11  6571  	jbd2_journal_lock_updates(journal);
ac27a0ec112a08 Dave Kleikamp      2006-10-11  6572  
ac27a0ec112a08 Dave Kleikamp      2006-10-11  6573  	/*
ac27a0ec112a08 Dave Kleikamp      2006-10-11  6574  	 * OK, there are no updates running now, and all cached data is
ac27a0ec112a08 Dave Kleikamp      2006-10-11  6575  	 * synced to disk.  We are now in a completely consistent state
ac27a0ec112a08 Dave Kleikamp      2006-10-11  6576  	 * which doesn't have anything in the journal, and we know that
ac27a0ec112a08 Dave Kleikamp      2006-10-11  6577  	 * no filesystem updates are running, so it is safe to modify
ac27a0ec112a08 Dave Kleikamp      2006-10-11  6578  	 * the inode's in-core data-journaling state flag now.
ac27a0ec112a08 Dave Kleikamp      2006-10-11  6579  	 */
ac27a0ec112a08 Dave Kleikamp      2006-10-11  6580  
ac27a0ec112a08 Dave Kleikamp      2006-10-11  6581  	if (val)
12e9b892002d9a Dmitry Monakhov    2010-05-16  6582  		ext4_set_inode_flag(inode, EXT4_INODE_JOURNAL_DATA);
5872ddaaf05bf2 Yongqiang Yang     2011-12-28  6583  	else {
01d5d96542fd4e Leah Rumancik      2021-05-18  6584  		err = jbd2_journal_flush(journal, 0);
4f879ca687a5f2 Jan Kara           2014-10-30  6585  		if (err < 0) {
4f879ca687a5f2 Jan Kara           2014-10-30  6586  			jbd2_journal_unlock_updates(journal);
00d873c17e29cc Jan Kara           2023-05-04  6587  			ext4_writepages_up_write(inode->i_sb, alloc_ctx);
4f879ca687a5f2 Jan Kara           2014-10-30  6588  			return err;

filemap_invalidate_unlock(inode->i_mapping) before returning?

4f879ca687a5f2 Jan Kara           2014-10-30  6589  		}
12e9b892002d9a Dmitry Monakhov    2010-05-16  6590  		ext4_clear_inode_flag(inode, EXT4_INODE_JOURNAL_DATA);
5872ddaaf05bf2 Yongqiang Yang     2011-12-28  6591  	}
617ba13b31fbf5 Mingming Cao       2006-10-11  6592  	ext4_set_aops(inode);
f893fb965834e9 Baokun Li          2025-11-11  6593  	ext4_set_inode_mapping_order(inode);
ac27a0ec112a08 Dave Kleikamp      2006-10-11  6594  
dab291af8d6307 Mingming Cao       2006-10-11  6595  	jbd2_journal_unlock_updates(journal);
00d873c17e29cc Jan Kara           2023-05-04  6596  	ext4_writepages_up_write(inode->i_sb, alloc_ctx);
d4f5258eae7b38 Jan Kara           2021-02-04  6597  	filemap_invalidate_unlock(inode->i_mapping);
ac27a0ec112a08 Dave Kleikamp      2006-10-11  6598  
ac27a0ec112a08 Dave Kleikamp      2006-10-11  6599  	/* Finally we can mark the inode as dirty. */
ac27a0ec112a08 Dave Kleikamp      2006-10-11  6600  
9924a92a8c2175 Theodore Ts'o      2013-02-08  6601  	handle = ext4_journal_start(inode, EXT4_HT_INODE, 1);
ac27a0ec112a08 Dave Kleikamp      2006-10-11  6602  	if (IS_ERR(handle))
ac27a0ec112a08 Dave Kleikamp      2006-10-11  6603  		return PTR_ERR(handle);
ac27a0ec112a08 Dave Kleikamp      2006-10-11  6604  
aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  6605  	ext4_fc_mark_ineligible(inode->i_sb,
e85c81ba8859a4 Xin Yin            2022-01-17  6606  		EXT4_FC_REASON_JOURNAL_FLAG_CHANGE, handle);
617ba13b31fbf5 Mingming Cao       2006-10-11  6607  	err = ext4_mark_inode_dirty(handle, inode);
0390131ba84fd3 Frank Mayhar       2009-01-07  6608  	ext4_handle_sync(handle);
617ba13b31fbf5 Mingming Cao       2006-10-11  6609  	ext4_journal_stop(handle);
617ba13b31fbf5 Mingming Cao       2006-10-11  6610  	ext4_std_error(inode->i_sb, err);
ac27a0ec112a08 Dave Kleikamp      2006-10-11  6611  
ac27a0ec112a08 Dave Kleikamp      2006-10-11 @6612  	return err;
ac27a0ec112a08 Dave Kleikamp      2006-10-11  6613  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


