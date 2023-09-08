Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0BF798654
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Sep 2023 13:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241194AbjIHLPF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 8 Sep 2023 07:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236689AbjIHLPE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 8 Sep 2023 07:15:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2738173B
        for <linux-ext4@vger.kernel.org>; Fri,  8 Sep 2023 04:14:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 73BE91FDB9;
        Fri,  8 Sep 2023 11:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694171696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F2xEgFIdfRuKYrhew5pFeCAFTejqPO/CIBZotbVoE94=;
        b=ygkQUqmDqBOZ2NxTM5HsRUIiIuX9hbmEMpEarGFuWaAPcEukyHA6rvDjuOuByzvPmBL5Kg
        Mi8WXybV7Rz8e4BnNkalK8xpkyKrcKWy8kFeRZ50Ni03igT5E9AZ8Lk08e3hmmCkasv31d
        W99J1UVPQm2WAAr5FRbvJZVcI9z4M9k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694171696;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F2xEgFIdfRuKYrhew5pFeCAFTejqPO/CIBZotbVoE94=;
        b=KwhwfJvpBp7Iv1ZBLZ05Q4Zt2IbwDJk/yivWHcXyfZy3I4O4lGK+fwNkb4E6HR+BvL8N6P
        ybVZ5iqsDtGfFIBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 663D6131FD;
        Fri,  8 Sep 2023 11:14:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Kyb2GDAC+2T5EAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 08 Sep 2023 11:14:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C724FA0774; Fri,  8 Sep 2023 13:14:55 +0200 (CEST)
Date:   Fri, 8 Sep 2023 13:14:55 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH] jbd2: Fix potential data lost in recovering journal
 raced with synchronizing fs bdev
Message-ID: <20230908111455.koi76sueeved5jpm@quack3>
References: <20230908092808.2929317-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908092808.2929317-1-chengzhihao1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 08-09-23 17:28:08, Zhihao Cheng wrote:
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
> into disk, and ext4/ocfs2 could become corrupted.
> 
> Fix it by comparing the wb_err state in fs block device before recovering
> and after recovering.
> 
> Fetch a reproducer in [Link].
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217888
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Thanks for the patch! It makes sense but it is somewhat inconsistent with
how we deal with other checks for metadata IO errors in ext4. We do those
checks in ext4 through ext4_check_bdev_write_error(). So I wonder if in
this case we shouldn't move the errseq_check_and_advance() in
__ext4_fill_super() earlier (before journal setup) and then use it in
ext4_load_and_init_journal() to detect errors during background metadata
writeback. What do you think?

								Honza

> ---
>  fs/jbd2/recovery.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index c269a7d29a46..0fecaa6a3ac6 100644
> --- a/fs/jbd2/recovery.c
> +++ b/fs/jbd2/recovery.c
> @@ -289,6 +289,8 @@ int jbd2_journal_recover(journal_t *journal)
>  	journal_superblock_t *	sb;
>  
>  	struct recovery_info	info;
> +	errseq_t		wb_err;
> +	struct address_space	*mapping;
>  
>  	memset(&info, 0, sizeof(info));
>  	sb = journal->j_superblock;
> @@ -306,6 +308,8 @@ int jbd2_journal_recover(journal_t *journal)
>  		return 0;
>  	}
>  
> +	mapping = journal->j_fs_dev->bd_inode->i_mapping;
> +	errseq_check_and_advance(&mapping->wb_err, &wb_err);
>  	err = do_one_pass(journal, &info, PASS_SCAN);
>  	if (!err)
>  		err = do_one_pass(journal, &info, PASS_REVOKE);
> @@ -327,6 +331,9 @@ int jbd2_journal_recover(journal_t *journal)
>  
>  	jbd2_journal_clear_revoke(journal);
>  	err2 = sync_blockdev(journal->j_fs_dev);
> +	if (!err)
> +		err = err2;
> +	err2 = errseq_check_and_advance(&mapping->wb_err, &wb_err);
>  	if (!err)
>  		err = err2;
>  	/* Make sure all replayed data is on permanent storage */
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
