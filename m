Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCA269A9F2
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Feb 2023 12:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjBQLLm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Feb 2023 06:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjBQLLf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Feb 2023 06:11:35 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D5F66649
        for <linux-ext4@vger.kernel.org>; Fri, 17 Feb 2023 03:10:53 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 07F8521BF3;
        Fri, 17 Feb 2023 11:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676632250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GHtcHkBz4RPUHd8he8whZ7gK9SsG3EVbcaHXQaSctwQ=;
        b=Yeua7yzKotL0znqtTlkZ9K486ZJF0jPmGmPliJm9X8jGgjd9DpvXT+EC/R9BaXZNp1gV7E
        gMp/VVEEhIMPJlAlwFraUg5no56DByLjM1NWQualNPQEkz+4Ykhs/EHWzygqeOKLLi7GzJ
        wb9TYbK1ig0Jr71q6TD881SY6tTV1/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676632250;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GHtcHkBz4RPUHd8he8whZ7gK9SsG3EVbcaHXQaSctwQ=;
        b=5Up/lG2u12VKb69+b82L4cTOC9SKNXtFBA3BkK63Qlgg2P3OUpjTeakTWDibsTWHJPjby7
        mW690ESrfZoCj6Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EAB66138E3;
        Fri, 17 Feb 2023 11:10:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JVxKOblg72MCQwAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 17 Feb 2023 11:10:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 68A30A06E1; Fri, 17 Feb 2023 12:10:49 +0100 (CET)
Date:   Fri, 17 Feb 2023 12:10:49 +0100
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 1/2] e2fsck: save EXT2_ERROR_FS flag during journal replay
Message-ID: <20230217111049.itrmawqzjvtjpmf7@quack3>
References: <20230217100922.588961-1-libaokun1@huawei.com>
 <20230217100922.588961-2-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217100922.588961-2-libaokun1@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 17-02-23 18:09:21, Baokun Li wrote:
> When repairing a file system with s_errno missing from the journal
> superblock but the file system superblock contains the ERROR_FS flag,
> the ERROR_FS flag on the file system image is overwritten after the
> journal replay, followed by a reload of the file system data from disk
> and the ERROR_FS flag in memory is overwritten. Also s_errno is not set
> and the ERROR_FS flag is not reset. Therefore, when checked later, no
> forced check is performed, which makes it possible to have some errors
> hidden in the disk image, which may make it read-only when using the
> file system. So we save the ERROR_FS flag to the superblock after the
> journal replay, instead of just relying on the jsb->s_errno to do this.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  e2fsck/journal.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/e2fsck/journal.c b/e2fsck/journal.c
> index c7868d89..0144aa45 100644
> --- a/e2fsck/journal.c
> +++ b/e2fsck/journal.c
> @@ -1683,6 +1683,7 @@ errcode_t e2fsck_run_ext3_journal(e2fsck_t ctx)
>  	errcode_t	retval, recover_retval;
>  	io_stats	stats = 0;
>  	unsigned long long kbytes_written = 0;
> +	__u16 s_error_state;
>  
>  	printf(_("%s: recovering journal\n"), ctx->device_name);
>  	if (ctx->options & E2F_OPT_READONLY) {
> @@ -1705,6 +1706,7 @@ errcode_t e2fsck_run_ext3_journal(e2fsck_t ctx)
>  		ctx->fs->io->manager->get_stats(ctx->fs->io, &stats);
>  	if (stats && stats->bytes_written)
>  		kbytes_written = stats->bytes_written >> 10;
> +	s_error_state = ctx->fs->super->s_state & EXT2_ERROR_FS;
>  
>  	ext2fs_mmp_stop(ctx->fs);
>  	ext2fs_free(ctx->fs);
> @@ -1721,6 +1723,7 @@ errcode_t e2fsck_run_ext3_journal(e2fsck_t ctx)
>  	ctx->fs->now = ctx->now;
>  	ctx->fs->flags |= EXT2_FLAG_MASTER_SB_ONLY;
>  	ctx->fs->super->s_kbytes_written += kbytes_written;
> +	ctx->fs->super->s_state |= s_error_state;
>  
>  	/* Set the superblock flags */
>  	e2fsck_clear_recover(ctx, recover_retval != 0);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
