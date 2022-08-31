Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D5B5A7C3F
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Aug 2022 13:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiHaLgb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 31 Aug 2022 07:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiHaLga (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 31 Aug 2022 07:36:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15EBA6AD2
        for <linux-ext4@vger.kernel.org>; Wed, 31 Aug 2022 04:36:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5DEBE1F8B4;
        Wed, 31 Aug 2022 11:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661945788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9t76qdQOJd/gLpGXNVGsr2iRn9MPPJLcnjdhRgBxN2Y=;
        b=TK+nggGWwfUDH/sgpP6MnK1UTMX6XFeOV/i+BQMY6VOXRCCWzQ1b9XRCzhpAfzW6ueepo+
        2fP+GhOZFKnz7nZHwc+qpf5u3nIZ0IKUmKlzUaMKh8IHJeI4uEGMhNWLe+nqzDDPnf+jvA
        5CLSdTlpHXMfp+gSJbrAj5YfQlWHj0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661945788;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9t76qdQOJd/gLpGXNVGsr2iRn9MPPJLcnjdhRgBxN2Y=;
        b=CJtgWj8uOJwhogtFUvSzCEtRkECRPaWo6f5LlcjMkxidsgaK1Dq6+Mzzjn9vN6WG5Bc1Lq
        xjv87i0b6WXQ5WAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3B9E61332D;
        Wed, 31 Aug 2022 11:36:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EreADrxHD2PkAgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 31 Aug 2022 11:36:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B427CA067B; Wed, 31 Aug 2022 13:36:27 +0200 (CEST)
Date:   Wed, 31 Aug 2022 13:36:27 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        ritesh.list@gmail.com, lczerner@redhat.com,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 01/13] ext4: goto right label 'failed_mount3a'
Message-ID: <20220831113627.i4qizr5rhabv2h26@quack3>
References: <20220830120411.2371968-1-yanaijie@huawei.com>
 <20220830120411.2371968-2-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830120411.2371968-2-yanaijie@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 30-08-22 20:03:59, Jason Yan wrote:
> Before these two branches neither loaded the journal nor created the
> xattr cache. So the right label to goto is 'failed_mount3a'. Although
> this did not cause any issues because the error handler validated if the
> pointer is null. However this still made me confused when reading
> the code. So it's still worth to modify to goto the right label.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 9a66abcca1a8..6126da867b26 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5079,30 +5079,30 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  		   ext4_has_feature_journal_needs_recovery(sb)) {
>  		ext4_msg(sb, KERN_ERR, "required journal recovery "
>  		       "suppressed and not mounted read-only");
> -		goto failed_mount_wq;
> +		goto failed_mount3a;
>  	} else {
>  		/* Nojournal mode, all journal mount options are illegal */
>  		if (test_opt2(sb, EXPLICIT_JOURNAL_CHECKSUM)) {
>  			ext4_msg(sb, KERN_ERR, "can't mount with "
>  				 "journal_checksum, fs mounted w/o journal");
> -			goto failed_mount_wq;
> +			goto failed_mount3a;
>  		}
>  		if (test_opt(sb, JOURNAL_ASYNC_COMMIT)) {
>  			ext4_msg(sb, KERN_ERR, "can't mount with "
>  				 "journal_async_commit, fs mounted w/o journal");
> -			goto failed_mount_wq;
> +			goto failed_mount3a;
>  		}
>  		if (sbi->s_commit_interval != JBD2_DEFAULT_MAX_COMMIT_AGE*HZ) {
>  			ext4_msg(sb, KERN_ERR, "can't mount with "
>  				 "commit=%lu, fs mounted w/o journal",
>  				 sbi->s_commit_interval / HZ);
> -			goto failed_mount_wq;
> +			goto failed_mount3a;
>  		}
>  		if (EXT4_MOUNT_DATA_FLAGS &
>  		    (sbi->s_mount_opt ^ sbi->s_def_mount_opt)) {
>  			ext4_msg(sb, KERN_ERR, "can't mount with "
>  				 "data=, fs mounted w/o journal");
> -			goto failed_mount_wq;
> +			goto failed_mount3a;
>  		}
>  		sbi->s_def_mount_opt &= ~EXT4_MOUNT_JOURNAL_CHECKSUM;
>  		clear_opt(sb, JOURNAL_CHECKSUM);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
