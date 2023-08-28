Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41EE78A95E
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Aug 2023 11:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjH1Jye (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Aug 2023 05:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjH1JyK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Aug 2023 05:54:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C50C6
        for <linux-ext4@vger.kernel.org>; Mon, 28 Aug 2023 02:54:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5DBDB1F38A;
        Mon, 28 Aug 2023 09:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693216444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gHlFLrvwyaozvG6Co+cbZa/4VzoN0FLBhAFI7XorIeQ=;
        b=R/lBXcb6BmZRKm39fOnwuqjosPRvlQvMPYAZthfEbzqJTDQLDc61jIQjeqH9usBtjCblbv
        VRfuqGjfoPLS1NtiyHe2aPeUiVFe+3eCo9pZoOrJ5KR1CZC9n11qYSyb6rteQIg3fPNKpH
        X/9EJ8cuPzfjpLxhxed9Ze8/qjvCkLg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693216444;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gHlFLrvwyaozvG6Co+cbZa/4VzoN0FLBhAFI7XorIeQ=;
        b=UldidxThsl+VVGFReLpd/C9NBeKHfuf3cTyVnRtPa0XN6NnwqIwV/aGZL3H5AMFiCUdo0r
        fI4Qs0c3kA1tgBDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4ACB3139CC;
        Mon, 28 Aug 2023 09:54:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tOIpErxu7GTjQQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 28 Aug 2023 09:54:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BD052A0774; Mon, 28 Aug 2023 11:54:03 +0200 (CEST)
Date:   Mon, 28 Aug 2023 11:54:03 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, darrick.wong@oracle.com,
        yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2] e2fsck: delay quotas loading in
 release_orphan_inodes()
Message-ID: <20230828095403.ypnstkl55ouxr6e4@quack3>
References: <20230825132237.2869251-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230825132237.2869251-1-libaokun1@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 25-08-23 21:22:37, Baokun Li wrote:
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
> image that contains orphan inodes and has the wrong bbitmap checksum. So
> delaying quota loading until after the EXT2_ERROR_FS judgment avoids the
> above problem. Moreover, since we don't care if the bitmap checksum is
> wrong before Pass5, e2fsck_read_bitmaps() is called before loading the
> quota to avoid bitmap checksum errors that would cause e2fsck to exit.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
> V1->V2:
> 	Add e2fsck_read_bitmaps() to avoid bitmap checksum errors causing
> 	e2fsck to exit.

Looks good, just one nit below:

> @@ -525,10 +516,18 @@ static int release_orphan_inodes(e2fsck_t ctx)
>  	 * be running a full e2fsck run anyway... We clear orphan file contents
>  	 * after filesystem is checked to avoid clearing someone else's data.
>  	 */
> -	if (fs->super->s_state & EXT2_ERROR_FS) {
> -		if (ctx->qctx)
> -			quota_release_context(&ctx->qctx);
> +	if (fs->super->s_state & EXT2_ERROR_FS)
>  		return 0;
> +
> +	e2fsck_read_bitmaps(ctx);
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

Just a few lines below this place is another call to e2fsck_read_bitmaps()
so you can just delete it when you are adding one here. Otherwise feel free
to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
