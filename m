Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914D579C0AD
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Sep 2023 02:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238972AbjIKVU4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 11 Sep 2023 17:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242629AbjIKP63 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 11 Sep 2023 11:58:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A451AE
        for <linux-ext4@vger.kernel.org>; Mon, 11 Sep 2023 08:58:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E02DA1F88C;
        Mon, 11 Sep 2023 15:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694447902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yV6I6wB5q3JoF1XA0a96ZkfIMmQM2zYLFU/YvDwgkKw=;
        b=WAVQc//RREqgNZOAn0KyvNVWOBxrC4dBl6MJpfKlRpKNKq89M/jT0bUoXFv0yqa+CAM2sX
        TA6IGKExFvPbpspb62iB2p8zr9aEhAQNiRB8NTcXK3GPJx86Vvn0EnCG4KbzvqLmTTu/Bv
        hxnoqYY4Xgn8vHtjvBd3AJ+V1F2H5pw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694447902;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yV6I6wB5q3JoF1XA0a96ZkfIMmQM2zYLFU/YvDwgkKw=;
        b=DHS1C2OjpMxQHNVQRhB/oj7ASfGNxCT2RzHdWTn5omcfszG209j2L99IfuUiYfY8GLEkdX
        dz9pF++YXsCBAzCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D209C13780;
        Mon, 11 Sep 2023 15:58:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sPg9Mx45/2QHegAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 11 Sep 2023 15:58:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7251BA077E; Mon, 11 Sep 2023 17:58:22 +0200 (CEST)
Date:   Mon, 11 Sep 2023 17:58:22 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH] jbd2: Fix potential data lost in recovering journal
 raced with synchronizing fs bdev
Message-ID: <20230911155822.kbg2xayc7ys24kay@quack3>
References: <20230908092808.2929317-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908092808.2929317-1-chengzhihao1@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
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

After discussion about v2 this version is the better option. Feel free to
add:

Reviewed-by: Jan Kara <jack@suse.cz>

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
