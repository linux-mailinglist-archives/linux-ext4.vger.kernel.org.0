Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418A1785E0E
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Aug 2023 19:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236969AbjHWRFf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 23 Aug 2023 13:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236995AbjHWRFe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 23 Aug 2023 13:05:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8295E6D
        for <linux-ext4@vger.kernel.org>; Wed, 23 Aug 2023 10:05:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A871520981;
        Wed, 23 Aug 2023 17:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692810325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uJvzLIw1M+dhnQSwUSq3hqcwmJdwBpJplC69lFvisck=;
        b=KHvdouPAK89WgO4HIzw9kp+2LqkIeTfEL2kSv3t/B9Dh0RjBPFBMiHmbLgQhPoEbA8DnKu
        6LWAF+hRG6cQobvMOpUS5Md2rF0JJ3/SBuFJxZxI7PA/A3rm7rKl4LVal3QkhZ+bnO8HWB
        dZ5bQ7KtpypRl+Sn6/FMzBJH84+zoeA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692810325;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uJvzLIw1M+dhnQSwUSq3hqcwmJdwBpJplC69lFvisck=;
        b=+3Ysw1Wiru2b5Jb8or9992SOYChWPozrgMHxkVv9Hgb0+8yV26NoszgXWa+Z/I1YmQYYIO
        LThr7lDvt5AtAYAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8C74A1351F;
        Wed, 23 Aug 2023 17:05:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id snNAIlU85mT5VAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 23 Aug 2023 17:05:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A3918A0774; Wed, 23 Aug 2023 19:05:24 +0200 (CEST)
Date:   Wed, 23 Aug 2023 19:05:24 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, darrick.wong@oracle.com,
        yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH] e2fsck: delay quotas loading in release_orphan_inodes()
Message-ID: <20230823170524.xox66gceoqrigtyo@quack3>
References: <20230817081828.934259-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230817081828.934259-1-libaokun1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 17-08-23 16:18:28, Baokun Li wrote:
> After 7d79b40b ("e2fsck: adjust quota counters when clearing orphaned
> inodes"), we load all the quotas before we process the orphaned inodes,
> and when we load the quotas, we check the checsum of the bbitmap for each
> group. If one of the bbitmap checksums is wrong, the following error will
> be reported:
> 
> “Error initializing quota context in support library:
>  Block bitmap checksum does not match bitmap”
> 
> But loading quotas comes before checking the current superblock for the
> EXT2_ERROR_FS flag, which makes it impossible to use e2fsck to repair any
> image that contains orphan inodes and has the wrong bbitmap checksum.
> So delaying quota loading until after the EXT2_ERROR_FS judgment avoids
> the above problem.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

This certainly looks better but I wonder if there still isn't a problem if
the bitmap checksums are wrong but EXT2_ERROR_FS is not set. Shouldn't we
rather move the initialization of the quota files after the call to
e2fsck_read_bitmaps()?

								Honza

> ---
>  e2fsck/super.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/e2fsck/super.c b/e2fsck/super.c
> index 9495e029..b1aaaed6 100644
> --- a/e2fsck/super.c
> +++ b/e2fsck/super.c
> @@ -503,15 +503,6 @@ static int release_orphan_inodes(e2fsck_t ctx)
>  	    !ext2fs_has_feature_orphan_present(fs->super))
>  		return 0;
>  
> -	clear_problem_context(&pctx);
> -	ino = fs->super->s_last_orphan;
> -	pctx.ino = ino;
> -	pctx.errcode = e2fsck_read_all_quotas(ctx);
> -	if (pctx.errcode) {
> -		fix_problem(ctx, PR_0_QUOTA_INIT_CTX, &pctx);
> -		return 1;
> -	}
> -
>  	/*
>  	 * Win or lose, we won't be using the head of the orphan inode
>  	 * list again.
> @@ -525,10 +516,16 @@ static int release_orphan_inodes(e2fsck_t ctx)
>  	 * be running a full e2fsck run anyway... We clear orphan file contents
>  	 * after filesystem is checked to avoid clearing someone else's data.
>  	 */
> -	if (fs->super->s_state & EXT2_ERROR_FS) {
> -		if (ctx->qctx)
> -			quota_release_context(&ctx->qctx);
> +	if (fs->super->s_state & EXT2_ERROR_FS)
>  		return 0;
> +
> +	clear_problem_context(&pctx);
> +	ino = fs->super->s_last_orphan;
> +	pctx.ino = ino;
> +	pctx.errcode = e2fsck_read_all_quotas(ctx);
> +	if (pctx.errcode) {
> +		fix_problem(ctx, PR_0_QUOTA_INIT_CTX, &pctx);
> +		return 1;
>  	}
>  
>  	if (ino && ((ino < EXT2_FIRST_INODE(fs->super)) ||
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
