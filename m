Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C006B91AD
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Mar 2023 12:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjCNLdr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Mar 2023 07:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjCNLdq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Mar 2023 07:33:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C03DE4;
        Tue, 14 Mar 2023 04:33:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 10D7721F2B;
        Tue, 14 Mar 2023 11:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678793623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UKBeb/n9qZHzr/Y9UQOZZSaollO6V1LuQcwYazTCJ5c=;
        b=K9DhKnHDdXfqWo/6v2lQdmVyIpY3S7rE0cR5EATEHrFq0u6Xyu1C+JJTzK+2wDzJMboRpX
        M3fU+CnQGVR1J9zM62mmWnQTXAC9Rok4msbISXAr0enWZHAwu2fSiaslHVmJ2AavNq9EE8
        leZEWTKZd9FgWKOGKzpI/1LaUqyrXx0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678793623;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UKBeb/n9qZHzr/Y9UQOZZSaollO6V1LuQcwYazTCJ5c=;
        b=NDH9QibHy9Q2qn4+QsiskcKcxVmCvnQWNaOe6zVXKYK5Ql3WWCk1bM8P6J1LveRWUrdswR
        GOjgFef7nnVQJkDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 01BAF13A1B;
        Tue, 14 Mar 2023 11:33:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wItVAJdbEGR/NgAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 14 Mar 2023 11:33:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 88456A06FD; Tue, 14 Mar 2023 12:33:42 +0100 (CET)
Date:   Tue, 14 Mar 2023 12:33:42 +0100
From:   Jan Kara <jack@suse.cz>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com,
        tudor.ambarus@linaro.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH v2 1/5] ext4: Fix reusing stale buffer heads from last
 failed mounting
Message-ID: <20230314113342.74g2pfwe5y7b5poa@quack3>
References: <20230313132021.672134-1-chengzhihao1@huawei.com>
 <20230313132021.672134-2-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313132021.672134-2-chengzhihao1@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 13-03-23 21:20:17, Zhihao Cheng wrote:
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

...

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

Hum, but this will invalidate bhs only if journal is stored on a block
device. If journal is in the inode (the common case), we won't invalidate
anything (sbi->s_journal_bdev is NULL) and the same problem can happen?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
