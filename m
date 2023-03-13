Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7626B74AB
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Mar 2023 11:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjCMKwE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Mar 2023 06:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjCMKwD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Mar 2023 06:52:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAD136098;
        Mon, 13 Mar 2023 03:52:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CE7C722A45;
        Mon, 13 Mar 2023 10:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678704719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WXT5bOKDI1On4YwL16iXq87G5h5z/0nU/e/zlL7PG2I=;
        b=HQRI0no5IDpFfQvgXHNnrWyzJm9mULHecwmB+g+WcZNyD+lvWSxbreSprAE86CP9WmG5nI
        2ME8NEXMLN0Py5H6mN+6w9j+o4SZ3lxRhzE5x0sMYO/V64QBNQncq6UM/7RxECGQJg9EJV
        J/ywD0iJ3bytcjLk7VUQPNAdlwLC/yY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678704719;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WXT5bOKDI1On4YwL16iXq87G5h5z/0nU/e/zlL7PG2I=;
        b=QH3+LwTm4ZcCPb4+MEDjLHFcc3XaIVN4oTu/2AFkHqD3nuCsBdIZ9vK3RpxNpC7IUcchT+
        jjs+kO6gkH0zeeBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BF56813582;
        Mon, 13 Mar 2023 10:51:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id o/GnLk8AD2S6TAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 13 Mar 2023 10:51:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4EC4FA06FD; Mon, 13 Mar 2023 11:51:59 +0100 (CET)
Date:   Mon, 13 Mar 2023 11:51:59 +0100
From:   Jan Kara <jack@suse.cz>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH 1/5] ext4: Fix reusing stale buffer heads from last
 failed mounting
Message-ID: <20230313105159.4y3ddscjj6zykflk@quack3>
References: <20230310125206.2867822-1-chengzhihao1@huawei.com>
 <20230310125206.2867822-2-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310125206.2867822-2-chengzhihao1@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 10-03-23 20:52:02, Zhihao Cheng wrote:
> Following process makes ext4 load stale buffer heads from last failed
> mounting in a new mounting operation:
> mount_bdev
>  ext4_fill_super
>  | ext4_load_and_init_journal
>  |  ext4_load_journal
>  |   jbd2_journal_load
>  |    load_superblock
>  |     journal_get_superblock
>  |      set_buffer_verified(bh) // buffer head is verified
>  |   jbd2_journal_recover // failed caused by EIO
>  | goto failed_mount3a // skip 'sb->s_root' initialization
>  deactivate_locked_super
>   kill_block_super
>    generic_shutdown_super
>     if (sb->s_root)
>     // false, skip ext4_put_super->invalidate_bdev->
>     // invalidate_mapping_pages->mapping_evict_folio->
>     // filemap_release_folio->try_to_free_buffers, which
>     // cannot drop buffer head.
>    blkdev_put
>     blkdev_put_whole
>      if (atomic_dec_and_test(&bdev->bd_openers))
>      // false, systemd-udev happens to open the device. Then
>      // blkdev_flush_mapping->kill_bdev->truncate_inode_pages->
>      // truncate_inode_folio->truncate_cleanup_folio->
>      // folio_invalidate->block_invalidate_folio->
>      // filemap_release_folio->try_to_free_buffers will be skipped,
>      // dropping buffer head is missed again.
> 
> Second mount:
> ext4_fill_super
>  ext4_load_and_init_journal
>   ext4_load_journal
>    ext4_get_journal
>     jbd2_journal_init_inode
>      journal_init_common
>       bh = getblk_unmovable
>        bh = __find_get_block // Found stale bh in last failed mounting
>       journal->j_sb_buffer = bh
>    jbd2_journal_load
>     load_superblock
>      journal_get_superblock
>       if (buffer_verified(bh))
>       // true, skip journal->j_format_version = 2, value is 0
>     jbd2_journal_recover
>      do_one_pass
>       next_log_block += count_tags(journal, bh)
>       // According to journal_tag_bytes(), 'tag_bytes' calculating is
>       // affected by jbd2_has_feature_csum3(), jbd2_has_feature_csum3()
>       // returns false because 'j->j_format_version >= 2' is not true,
>       // then we get wrong next_log_block. The do_one_pass may exit
>       // early whenoccuring non JBD2_MAGIC_NUMBER in 'next_log_block'.
> 
> The filesystem is corrupted here, journal is partially replayed, and
> new journal sequence number actually is already used by last mounting.
> 
> The invalidate_bdev() can drop all buffer heads even racing with bare
> reading block device(eg. systemd-udev), so we can fix it by invalidating
> bdev in error handling path in __ext4_fill_super().
> 
> Fetch a reproducer in [Link].
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217171
> Cc: <stable@kernel.org>
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>

The fix looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 88f7b8a88c76..7e990637bc48 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1126,6 +1126,12 @@ static void ext4_blkdev_remove(struct ext4_sb_info *sbi)
>  	struct block_device *bdev;
>  	bdev = sbi->s_journal_bdev;
>  	if (bdev) {
> +		/*
> +		 * Invalidate the journal device's buffers.  We don't want them
> +		 * floating about in memory - the physical journal device may
> +		 * hotswapped, and it breaks the `ro-after' testing code.
> +		 */
> +		invalidate_bdev(bdev);
>  		ext4_blkdev_put(bdev);
>  		sbi->s_journal_bdev = NULL;
>  	}
> @@ -1271,14 +1277,8 @@ static void ext4_put_super(struct super_block *sb)
>  
>  	sync_blockdev(sb->s_bdev);
>  	invalidate_bdev(sb->s_bdev);
> -	if (sbi->s_journal_bdev && sbi->s_journal_bdev != sb->s_bdev) {
> -		/*
> -		 * Invalidate the journal device's buffers.  We don't want them
> -		 * floating about in memory - the physical journal device may
> -		 * hotswapped, and it breaks the `ro-after' testing code.
> -		 */
> +	if (sbi->s_journal_bdev) {
>  		sync_blockdev(sbi->s_journal_bdev);
> -		invalidate_bdev(sbi->s_journal_bdev);
>  		ext4_blkdev_remove(sbi);
>  	}
>  
> @@ -5610,6 +5610,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  	brelse(sbi->s_sbh);
>  	ext4_blkdev_remove(sbi);
>  out_fail:
> +	invalidate_bdev(sb->s_bdev);
>  	sb->s_fs_info = NULL;
>  	return err ? err : ret;
>  }
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
