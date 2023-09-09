Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F290799627
	for <lists+linux-ext4@lfdr.de>; Sat,  9 Sep 2023 05:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbjIIDlU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 8 Sep 2023 23:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbjIIDlT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 8 Sep 2023 23:41:19 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046251FE3
        for <linux-ext4@vger.kernel.org>; Fri,  8 Sep 2023 20:41:14 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RjJbq1lmbzVk3Y;
        Sat,  9 Sep 2023 11:38:31 +0800 (CST)
Received: from [10.174.176.34] (10.174.176.34) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 9 Sep 2023 11:41:12 +0800
Subject: Re: [PATCH v2] ext4: Fix potential data lost in recovering journal
 raced with synchronizing fs bdev
To:     Zhihao Cheng <chengzhihao1@huawei.com>, <tytso@mit.edu>,
        <jack@suse.com>
CC:     <linux-ext4@vger.kernel.org>
References: <20230908124317.2955345-1-chengzhihao1@huawei.com>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <2b2718a4-7d8b-e0bc-c045-59fe7562392d@huawei.com>
Date:   Sat, 9 Sep 2023 11:41:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20230908124317.2955345-1-chengzhihao1@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.34]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello!

On 2023/9/8 20:43, Zhihao Cheng wrote:
> JBD2 makes sure journal data is fallen on fs device by sync_blockdev(),
> however, other process could intercept the EIO information from bdev's
> mapping, which leads journal recovering successful even EIO occurs during
> data written back to fs device.
> 
> We found this problem in our product, iscsi + multipath is chosen for block
> device of ext4. Unstable network may trigger kpartx to rescan partitions in
> device mapper layer. Detailed process is shown as following:
> 
>   mount          kpartx          irq
> jbd2_journal_recover
>  do_one_pass
>   memcpy(nbh->b_data, obh->b_data) // copy data to fs dev from journal
>   mark_buffer_dirty // mark bh dirty
>          vfs_read
> 	  generic_file_read_iter // dio
> 	   filemap_write_and_wait_range
> 	    __filemap_fdatawrite_range
> 	     do_writepages
> 	      block_write_full_folio
> 	       submit_bh_wbc
> 	            >>  EIO occurs in disk  <<
> 	                     end_buffer_async_write
> 			      mark_buffer_write_io_error
> 			       mapping_set_error
> 			        set_bit(AS_EIO, &mapping->flags) // set!
> 	    filemap_check_errors
> 	     test_and_clear_bit(AS_EIO, &mapping->flags) // clear!
>  err2 = sync_blockdev
>   filemap_write_and_wait
>    filemap_check_errors
>     test_and_clear_bit(AS_EIO, &mapping->flags) // false
>  err2 = 0
> 
> Filesystem is mounted successfully even data from journal is failed written
> into disk, and ext4 could become corrupted.
> 
> Fix it by comparing 'sbi->s_bdev_wb_err' before loading journal and after
> loading journal.
> 
> Fetch a reproducer in [Link].
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217888
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  v1->v2: Checks wb_err from block device only in ext4.
>  fs/ext4/super.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 38217422f938..4dcaad2403be 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4907,6 +4907,14 @@ static int ext4_load_and_init_journal(struct super_block *sb,
>  	if (err)
>  		return err;
>  
> +	err = errseq_check_and_advance(&sb->s_bdev->bd_inode->i_mapping->wb_err,
> +				       &sbi->s_bdev_wb_err);
> +	if (err) {
> +		ext4_msg(sb, KERN_ERR, "Background error %d when loading journal",
> +			 err);
> +		goto out;
> +	}
> +

This solution cannot solve the problem, because the journal tail is
still updated in journal_reset() even if we detect the writeback error
and refuse to mount the ext4 filesystem here. So I suppose we have to
check the I/O error by jbd2 module itself like v1 does.

Thanks,
Yi.

>  	if (ext4_has_feature_64bit(sb) &&
>  	    !jbd2_journal_set_features(EXT4_SB(sb)->s_journal, 0, 0,
>  				       JBD2_FEATURE_INCOMPAT_64BIT)) {
> @@ -5365,6 +5373,13 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  			goto failed_mount3a;
>  	}
>  
> +	/*
> +	 * Save the original bdev mapping's wb_err value which could be
> +	 * used to detect the metadata async write error.
> +	 */
> +	spin_lock_init(&sbi->s_bdev_wb_lock);
> +	errseq_check_and_advance(&sb->s_bdev->bd_inode->i_mapping->wb_err,
> +				 &sbi->s_bdev_wb_err);
>  	err = -EINVAL;
>  	/*
>  	 * The first inode we look at is the journal inode.  Don't try
> @@ -5571,13 +5586,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  	}
>  #endif  /* CONFIG_QUOTA */
>  
> -	/*
> -	 * Save the original bdev mapping's wb_err value which could be
> -	 * used to detect the metadata async write error.
> -	 */
> -	spin_lock_init(&sbi->s_bdev_wb_lock);
> -	errseq_check_and_advance(&sb->s_bdev->bd_inode->i_mapping->wb_err,
> -				 &sbi->s_bdev_wb_err);
>  	EXT4_SB(sb)->s_mount_state |= EXT4_ORPHAN_FS;
>  	ext4_orphan_cleanup(sb, es);
>  	EXT4_SB(sb)->s_mount_state &= ~EXT4_ORPHAN_FS;
> 
