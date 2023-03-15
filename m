Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9649E6BAAFD
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Mar 2023 09:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjCOIno (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Mar 2023 04:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjCOInn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 Mar 2023 04:43:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C92D303D6;
        Wed, 15 Mar 2023 01:43:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B8E89218B8;
        Wed, 15 Mar 2023 08:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678869819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jdfjl7r58ynOxMImiVSmOehMe7AqSUKJoyPwgWIwDws=;
        b=YnBFSgry3UgYK8JubCsYyWnCvYVakNs/cF6nbnrrnFrEEcyxF5sKgpSNPGLcrhvl9+69+7
        2Vrz/qxvvpXjIgZBkhMz2QIItHHCqcWs2mLpY1nl0XuiFJixT0fBZ+t42WYBSz9aw6+Y2h
        y1tUeyFYgEQlCEndY7glQeVAIQO5+TU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678869819;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jdfjl7r58ynOxMImiVSmOehMe7AqSUKJoyPwgWIwDws=;
        b=QPYoT6m5W6qRP2aWxnylCBY2xmyNyN6J4HR5kUmSNkels5OjVefDm2i88MUwYHiWvl67WI
        LcoeP5B1qVxL5CAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AB80013A00;
        Wed, 15 Mar 2023 08:43:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gq7WKTuFEWQ/EgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 15 Mar 2023 08:43:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8AAFCA06FD; Wed, 15 Mar 2023 09:43:38 +0100 (CET)
Date:   Wed, 15 Mar 2023 09:43:38 +0100
From:   Jan Kara <jack@suse.cz>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com,
        tudor.ambarus@linaro.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH v3 1/6] ext4: Fix reusing stale buffer heads from last
 failed mounting
Message-ID: <20230315084338.opsx6enpp7n6t22y@quack3>
References: <20230315013128.3911115-1-chengzhihao1@huawei.com>
 <20230315013128.3911115-2-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315013128.3911115-2-chengzhihao1@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 15-03-23 09:31:23, Zhihao Cheng wrote:
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
> Fixes: 25ed6e8a54df ("jbd2: enable journal clients to enable v2 checksumming")
> Cc: stable@vger.kernel.org # v3.5
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index f43e526112ae..61511b7ba017 100644
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
> @@ -1272,13 +1278,7 @@ static void ext4_put_super(struct super_block *sb)
>  	sync_blockdev(sb->s_bdev);
>  	invalidate_bdev(sb->s_bdev);
>  	if (sbi->s_journal_bdev && sbi->s_journal_bdev != sb->s_bdev) {
> -		/*
> -		 * Invalidate the journal device's buffers.  We don't want them
> -		 * floating about in memory - the physical journal device may
> -		 * hotswapped, and it breaks the `ro-after' testing code.
> -		 */
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
