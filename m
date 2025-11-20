Return-Path: <linux-ext4+bounces-11927-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4060C71ACF
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Nov 2025 02:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 617F64E32C8
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Nov 2025 01:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A53023D7E6;
	Thu, 20 Nov 2025 01:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="X9PjzlxR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02431DE8AE;
	Thu, 20 Nov 2025 01:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763601691; cv=none; b=HEZt33WkC/mxxsrrstEoc4coLzmAj7HqBIa/deHQ9ekRADOnD9h6oc2i/r36pErY+0DTWFF46YKv+LxPhWXCM3AmsEjEV+MvG3ZRKFGx4j2YAtl51XVEVxh2DF7gv2jVMF6WUXzh23GS/9Vi1+DldoY29oNTux5+maaJTa89CS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763601691; c=relaxed/simple;
	bh=i4wxgjtKrhIGUq1NanlDCU86AlRZgyMavb9FCRKldVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FQlBdzGYWpLy5/i7C2BYjaS/6GQVkdEc/TnUrN8XyfhzsXkSvVZESmpd0rbigo19NEXTTDaCqQBFZ+i+HEaMFqO65C1TZgaqV3Igq8gUN9KzTiafQlOOMOgKKdjCip2mUfn3JXhpM4k4mW0d/agYV2l5PXJHBI0cdQypWmpXo00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=X9PjzlxR; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=CxjUVIcD25U44jI58/lzCsIjg0A1Iaqvili4aT6WUXI=;
	b=X9PjzlxRsZ10KV8qrPgal2nX+zn1MXl5hPfPl0OoOu63Uxvh63+z+ThgVanBK4Z/C7oNMyXgB
	mjRa914Wc+DPOhOQbWLAVOj+o6yGFne9YD1hX9qw1fvvS8wYn41dcKHAL70VjN7lWLHA+ElaFdz
	jmAsSrZ+8lWmSjFDQIS644U=
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dBgWM0D9lznTV8;
	Thu, 20 Nov 2025 09:19:59 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 2F7FD1A016C;
	Thu, 20 Nov 2025 09:21:26 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 20 Nov
 2025 09:21:24 +0800
Message-ID: <ce363839-18af-4372-b7c2-e08cb053e403@huawei.com>
Date: Thu, 20 Nov 2025 09:21:23 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 21/24] ext4: make data=journal support large block size
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: <oe-kbuild@lists.linux.dev>, <libaokun@huaweicloud.com>,
	<linux-ext4@vger.kernel.org>, <lkp@intel.com>,
	<oe-kbuild-all@lists.linux.dev>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<jack@suse.cz>, <linux-kernel@vger.kernel.org>, <kernel@pankajraghav.com>,
	<mcgrof@kernel.org>, <ebiggers@kernel.org>, <willy@infradead.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <chengzhihao1@huawei.com>,
	Baokun Li <libaokun1@huawei.com>
References: <202511161433.qI6uGU0m-lkp@intel.com>
Content-Language: en-GB
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <202511161433.qI6uGU0m-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-11-19 20:41, Dan Carpenter wrote:
> Hi,
>
> kernel test robot noticed the following build warnings:
>
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/libaokun-huaweicloud-com/ext4-remove-page-offset-calculation-in-ext4_block_zero_page_range/20251111-224944
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
> patch link:    https://lore.kernel.org/r/20251111142634.3301616-22-libaokun%40huaweicloud.com
> patch subject: [PATCH v3 21/24] ext4: make data=journal support large block size
> config: arm64-randconfig-r071-20251114 (https://download.01.org/0day-ci/archive/20251116/202511161433.qI6uGU0m-lkp@intel.com/config)
> compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 0bba1e76581bad04e7d7f09f5115ae5e2989e0d9)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202511161433.qI6uGU0m-lkp@intel.com/
>
> New smatch warnings:
> fs/ext4/inode.c:6612 ext4_change_inode_journal_flag() warn: inconsistent returns '&inode->i_mapping->invalidate_lock'.
>
> vim +6612 fs/ext4/inode.c
>
> 617ba13b31fbf5 Mingming Cao       2006-10-11  6527  int ext4_change_inode_journal_flag(struct inode *inode, int val)
> ac27a0ec112a08 Dave Kleikamp      2006-10-11  6528  {
> ac27a0ec112a08 Dave Kleikamp      2006-10-11  6529  	journal_t *journal;
> ac27a0ec112a08 Dave Kleikamp      2006-10-11  6530  	handle_t *handle;
> ac27a0ec112a08 Dave Kleikamp      2006-10-11  6531  	int err;
> 00d873c17e29cc Jan Kara           2023-05-04  6532  	int alloc_ctx;
> ac27a0ec112a08 Dave Kleikamp      2006-10-11  6533  
> ac27a0ec112a08 Dave Kleikamp      2006-10-11  6534  	/*
> ac27a0ec112a08 Dave Kleikamp      2006-10-11  6535  	 * We have to be very careful here: changing a data block's
> ac27a0ec112a08 Dave Kleikamp      2006-10-11  6536  	 * journaling status dynamically is dangerous.  If we write a
> ac27a0ec112a08 Dave Kleikamp      2006-10-11  6537  	 * data block to the journal, change the status and then delete
> ac27a0ec112a08 Dave Kleikamp      2006-10-11  6538  	 * that block, we risk forgetting to revoke the old log record
> ac27a0ec112a08 Dave Kleikamp      2006-10-11  6539  	 * from the journal and so a subsequent replay can corrupt data.
> ac27a0ec112a08 Dave Kleikamp      2006-10-11  6540  	 * So, first we make sure that the journal is empty and that
> ac27a0ec112a08 Dave Kleikamp      2006-10-11  6541  	 * nobody is changing anything.
> ac27a0ec112a08 Dave Kleikamp      2006-10-11  6542  	 */
> ac27a0ec112a08 Dave Kleikamp      2006-10-11  6543  
> 617ba13b31fbf5 Mingming Cao       2006-10-11  6544  	journal = EXT4_JOURNAL(inode);
> 0390131ba84fd3 Frank Mayhar       2009-01-07  6545  	if (!journal)
> 0390131ba84fd3 Frank Mayhar       2009-01-07  6546  		return 0;
> d699594dc151c6 Dave Hansen        2007-07-18  6547  	if (is_journal_aborted(journal))
> ac27a0ec112a08 Dave Kleikamp      2006-10-11  6548  		return -EROFS;
> ac27a0ec112a08 Dave Kleikamp      2006-10-11  6549  
> 17335dcc471199 Dmitry Monakhov    2012-09-29  6550  	/* Wait for all existing dio workers */
> 17335dcc471199 Dmitry Monakhov    2012-09-29  6551  	inode_dio_wait(inode);
> 17335dcc471199 Dmitry Monakhov    2012-09-29  6552  
> 4c54659269ecb7 Daeho Jeong        2016-04-25  6553  	/*
> 4c54659269ecb7 Daeho Jeong        2016-04-25  6554  	 * Before flushing the journal and switching inode's aops, we have
> 4c54659269ecb7 Daeho Jeong        2016-04-25  6555  	 * to flush all dirty data the inode has. There can be outstanding
> 4c54659269ecb7 Daeho Jeong        2016-04-25  6556  	 * delayed allocations, there can be unwritten extents created by
> 4c54659269ecb7 Daeho Jeong        2016-04-25  6557  	 * fallocate or buffered writes in dioread_nolock mode covered by
> 4c54659269ecb7 Daeho Jeong        2016-04-25  6558  	 * dirty data which can be converted only after flushing the dirty
> 4c54659269ecb7 Daeho Jeong        2016-04-25  6559  	 * data (and journalled aops don't know how to handle these cases).
> 4c54659269ecb7 Daeho Jeong        2016-04-25  6560  	 */
> d4f5258eae7b38 Jan Kara           2021-02-04  6561  	filemap_invalidate_lock(inode->i_mapping);
> 4c54659269ecb7 Daeho Jeong        2016-04-25  6562  	err = filemap_write_and_wait(inode->i_mapping);
> 4c54659269ecb7 Daeho Jeong        2016-04-25  6563  	if (err < 0) {
> d4f5258eae7b38 Jan Kara           2021-02-04  6564  		filemap_invalidate_unlock(inode->i_mapping);
> 4c54659269ecb7 Daeho Jeong        2016-04-25  6565  		return err;
> 4c54659269ecb7 Daeho Jeong        2016-04-25  6566  	}
> f893fb965834e9 Baokun Li          2025-11-11  6567  	/* Before switch the inode journalling mode evict all the page cache. */
> f893fb965834e9 Baokun Li          2025-11-11  6568  	truncate_pagecache(inode, 0);
> 4c54659269ecb7 Daeho Jeong        2016-04-25  6569  
> 00d873c17e29cc Jan Kara           2023-05-04  6570  	alloc_ctx = ext4_writepages_down_write(inode->i_sb);
> dab291af8d6307 Mingming Cao       2006-10-11  6571  	jbd2_journal_lock_updates(journal);
> ac27a0ec112a08 Dave Kleikamp      2006-10-11  6572  
> ac27a0ec112a08 Dave Kleikamp      2006-10-11  6573  	/*
> ac27a0ec112a08 Dave Kleikamp      2006-10-11  6574  	 * OK, there are no updates running now, and all cached data is
> ac27a0ec112a08 Dave Kleikamp      2006-10-11  6575  	 * synced to disk.  We are now in a completely consistent state
> ac27a0ec112a08 Dave Kleikamp      2006-10-11  6576  	 * which doesn't have anything in the journal, and we know that
> ac27a0ec112a08 Dave Kleikamp      2006-10-11  6577  	 * no filesystem updates are running, so it is safe to modify
> ac27a0ec112a08 Dave Kleikamp      2006-10-11  6578  	 * the inode's in-core data-journaling state flag now.
> ac27a0ec112a08 Dave Kleikamp      2006-10-11  6579  	 */
> ac27a0ec112a08 Dave Kleikamp      2006-10-11  6580  
> ac27a0ec112a08 Dave Kleikamp      2006-10-11  6581  	if (val)
> 12e9b892002d9a Dmitry Monakhov    2010-05-16  6582  		ext4_set_inode_flag(inode, EXT4_INODE_JOURNAL_DATA);
> 5872ddaaf05bf2 Yongqiang Yang     2011-12-28  6583  	else {
> 01d5d96542fd4e Leah Rumancik      2021-05-18  6584  		err = jbd2_journal_flush(journal, 0);
> 4f879ca687a5f2 Jan Kara           2014-10-30  6585  		if (err < 0) {
> 4f879ca687a5f2 Jan Kara           2014-10-30  6586  			jbd2_journal_unlock_updates(journal);
> 00d873c17e29cc Jan Kara           2023-05-04  6587  			ext4_writepages_up_write(inode->i_sb, alloc_ctx);
> 4f879ca687a5f2 Jan Kara           2014-10-30  6588  			return err;
>
> filemap_invalidate_unlock(inode->i_mapping) before returning?

Oops! You nailed it. My bad, I totally forgot that unlock here, which
definitely left the lock unbalanced. I'll get that fixed up in v3.

Thanks a ton for doing the testing!


Cheers,
Baokun

>
> 4f879ca687a5f2 Jan Kara           2014-10-30  6589  		}
> 12e9b892002d9a Dmitry Monakhov    2010-05-16  6590  		ext4_clear_inode_flag(inode, EXT4_INODE_JOURNAL_DATA);
> 5872ddaaf05bf2 Yongqiang Yang     2011-12-28  6591  	}
> 617ba13b31fbf5 Mingming Cao       2006-10-11  6592  	ext4_set_aops(inode);
> f893fb965834e9 Baokun Li          2025-11-11  6593  	ext4_set_inode_mapping_order(inode);
> ac27a0ec112a08 Dave Kleikamp      2006-10-11  6594  
> dab291af8d6307 Mingming Cao       2006-10-11  6595  	jbd2_journal_unlock_updates(journal);
> 00d873c17e29cc Jan Kara           2023-05-04  6596  	ext4_writepages_up_write(inode->i_sb, alloc_ctx);
> d4f5258eae7b38 Jan Kara           2021-02-04  6597  	filemap_invalidate_unlock(inode->i_mapping);
> ac27a0ec112a08 Dave Kleikamp      2006-10-11  6598  
> ac27a0ec112a08 Dave Kleikamp      2006-10-11  6599  	/* Finally we can mark the inode as dirty. */
> ac27a0ec112a08 Dave Kleikamp      2006-10-11  6600  
> 9924a92a8c2175 Theodore Ts'o      2013-02-08  6601  	handle = ext4_journal_start(inode, EXT4_HT_INODE, 1);
> ac27a0ec112a08 Dave Kleikamp      2006-10-11  6602  	if (IS_ERR(handle))
> ac27a0ec112a08 Dave Kleikamp      2006-10-11  6603  		return PTR_ERR(handle);
> ac27a0ec112a08 Dave Kleikamp      2006-10-11  6604  
> aa75f4d3daaeb1 Harshad Shirwadkar 2020-10-15  6605  	ext4_fc_mark_ineligible(inode->i_sb,
> e85c81ba8859a4 Xin Yin            2022-01-17  6606  		EXT4_FC_REASON_JOURNAL_FLAG_CHANGE, handle);
> 617ba13b31fbf5 Mingming Cao       2006-10-11  6607  	err = ext4_mark_inode_dirty(handle, inode);
> 0390131ba84fd3 Frank Mayhar       2009-01-07  6608  	ext4_handle_sync(handle);
> 617ba13b31fbf5 Mingming Cao       2006-10-11  6609  	ext4_journal_stop(handle);
> 617ba13b31fbf5 Mingming Cao       2006-10-11  6610  	ext4_std_error(inode->i_sb, err);
> ac27a0ec112a08 Dave Kleikamp      2006-10-11  6611  
> ac27a0ec112a08 Dave Kleikamp      2006-10-11 @6612  	return err;
> ac27a0ec112a08 Dave Kleikamp      2006-10-11  6613  }
>


