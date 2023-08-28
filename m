Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC71378AF4B
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Aug 2023 13:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjH1Ls7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Aug 2023 07:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbjH1Lst (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Aug 2023 07:48:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F2D122
        for <linux-ext4@vger.kernel.org>; Mon, 28 Aug 2023 04:48:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8C8F61F86B;
        Mon, 28 Aug 2023 11:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693223324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e1IBlJ6MBMtvi9NM8X238226PxoYe6djXq3S0g8zQ3Q=;
        b=lhNCNPNjDYS/Dlu9j8kx0Q/Z+fVGESdL4yoMxTdqBj0tVXSk+quYug9BwIWzLEQMewkObq
        Pft5J3NRvsGKvbrlFAEwOhZD1cj9ct5VDm0eFKBAg8yIcFDvoofvpprHONq5pBGcbBcVV8
        hqliAd0W2DwWP9Y2wDuuw+aXl5Gj76k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693223324;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e1IBlJ6MBMtvi9NM8X238226PxoYe6djXq3S0g8zQ3Q=;
        b=gP4ZOMOyNtv13sygOhZlPhrJUYUeIKY+Qyb4EXDlvc+Z7azoMuTM8ZGxDxwoxIDc6XXroK
        2CXGE0ZvsaUe5gDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7CC31139CC;
        Mon, 28 Aug 2023 11:48:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bldtHpyJ7GTdAQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 28 Aug 2023 11:48:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E6AC4A0774; Mon, 28 Aug 2023 13:48:43 +0200 (CEST)
Date:   Mon, 28 Aug 2023 13:48:43 +0200
From:   Jan Kara <jack@suse.cz>
To:     vk.en.mail@gmail.com
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz,
        adilger@dilger.ca
Subject: Re: [PATCH v3] ext4: Add periodic superblock update check
Message-ID: <20230828114843.lkaiusxm27gw6iwc@quack3>
References: <169285281338.4146427.4994363470834118959.b4-ty@mit.edu>
 <20230826195841.12496-1-vk.en.mail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230826195841.12496-1-vk.en.mail@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 26-08-23 23:58:41, vk.en.mail@gmail.com wrote:
> From: Vitaliy Kuznetsov <vk.en.mail@gmail.com>
> 
> This patch introduces a mechanism to periodically check and update
> the superblock within the ext4 file system. The main purpose of this
> patch is to keep the disk superblock up to date. The update will be
> performed if more than one hour has passed since the last update, and
> if more than 16MB of data have been written to disk.
> 
> This check and update is performed within the ext4_journal_commit_callback
> function, ensuring that the superblock is written while the disk is
> active, rather than based on a timer that may trigger during disk idle
> periods.
> 
> Discussion https://www.spinics.net/lists/linux-ext4/msg85865.html
> 
> Signed-off-by: Vitaliy Kuznetsov <vk.en.mail@gmail.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 61 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index c94ebf704616..8bee05118c7a 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -433,6 +433,57 @@ static time64_t __ext4_get_tstamp(__le32 *lo, __u8 *hi)
>  #define ext4_get_tstamp(es, tstamp) \
>  	__ext4_get_tstamp(&(es)->tstamp, &(es)->tstamp ## _hi)
> 
> +#define EXT4_SB_REFRESH_INTERVAL_SEC (3600) /* seconds (1 hour) */
> +#define EXT4_SB_REFRESH_INTERVAL_KB (16384) /* kilobytes (16MB) */
> +
> +/*
> + * The ext4_maybe_update_superblock() function checks and updates the
> + * superblock if needed.
> + *
> + * This function is designed to update the on-disk superblock only under
> + * certain conditions to prevent excessive disk writes and unnecessary
> + * waking of the disk from sleep. The superblock will be updated if:
> + * 1. More than an hour has passed since the last superblock update, and
> + * 2. More than 16MB have been written since the last superblock update.
> + *
> + * @sb: The superblock
> + */
> +static void ext4_maybe_update_superblock(struct super_block *sb)
> +{
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +	struct ext4_super_block *es = sbi->s_es;
> +	journal_t *journal = sbi->s_journal;
> +	time64_t now;
> +	__u64 last_update;
> +	__u64 lifetime_write_kbytes;
> +	__u64 diff_size;
> +
> +	if (sb_rdonly(sb) || !(sb->s_flags & SB_ACTIVE) ||
> +	    !journal || (journal->j_flags & JBD2_UNMOUNT))
> +		return;
> +
> +	now = ktime_get_real_seconds();
> +	last_update = ext4_get_tstamp(es, s_wtime);
> +
> +	if (likely(now - last_update < EXT4_SB_REFRESH_INTERVAL_SEC))
> +		return;
> +
> +	lifetime_write_kbytes = sbi->s_kbytes_written +
> +		((part_stat_read(sb->s_bdev, sectors[STAT_WRITE]) -
> +		  sbi->s_sectors_written_start) >> 1);
> +
> +	/* Get the number of kilobytes not written to disk to account
> +	 * for statistics and compare with a multiple of 16 MB. This
> +	 * is used to determine when the next superblock commit should
> +	 * occur (i.e. not more often than once per 16MB if there was
> +	 * less written in an hour).
> +	 */
> +	diff_size = lifetime_write_kbytes - le64_to_cpu(es->s_kbytes_written);
> +
> +	if (diff_size > EXT4_SB_REFRESH_INTERVAL_KB)
> +		schedule_work(&EXT4_SB(sb)->s_error_work);
> +}
> +
>  /*
>   * The del_gendisk() function uninitializes the disk-specific data
>   * structures, including the bdi structure, without telling anyone
> @@ -459,6 +510,7 @@ static void ext4_journal_commit_callback(journal_t *journal, transaction_t *txn)
>  	BUG_ON(txn->t_state == T_FINISHED);
> 
>  	ext4_process_freed_data(sb, txn->t_tid);
> +	ext4_maybe_update_superblock(sb);
> 
>  	spin_lock(&sbi->s_md_lock);
>  	while (!list_empty(&txn->t_private_list)) {
> @@ -715,6 +767,7 @@ static void flush_stashed_error_work(struct work_struct *work)
>  	 */
>  	if (!sb_rdonly(sbi->s_sb) && journal) {
>  		struct buffer_head *sbh = sbi->s_sbh;
> +		bool call_notify_err = false;
>  		handle = jbd2_journal_start(journal, 1);
>  		if (IS_ERR(handle))
>  			goto write_directly;
> @@ -722,6 +775,10 @@ static void flush_stashed_error_work(struct work_struct *work)
>  			jbd2_journal_stop(handle);
>  			goto write_directly;
>  		}
> +
> +		if (sbi->s_add_error_count > 0)
> +			call_notify_err = true;
> +
>  		ext4_update_super(sbi->s_sb);
>  		if (buffer_write_io_error(sbh) || !buffer_uptodate(sbh)) {
>  			ext4_msg(sbi->s_sb, KERN_ERR, "previous I/O error to "
> @@ -735,7 +792,10 @@ static void flush_stashed_error_work(struct work_struct *work)
>  			goto write_directly;
>  		}
>  		jbd2_journal_stop(handle);
> -		ext4_notify_error_sysfs(sbi);
> +
> +		if (call_notify_err)
> +			ext4_notify_error_sysfs(sbi);
> +
>  		return;
>  	}
>  write_directly:
> --
> 2.39.2
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
