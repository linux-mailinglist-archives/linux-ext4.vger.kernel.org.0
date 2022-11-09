Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34AFF622A82
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Nov 2022 12:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiKIL33 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Nov 2022 06:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiKIL32 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Nov 2022 06:29:28 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A225DDE9A;
        Wed,  9 Nov 2022 03:29:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 617C0224D5;
        Wed,  9 Nov 2022 11:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667993366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6t6ywLtduHdfWo42pRm3bPhGBiGRAuMPXEPNm4DRpFk=;
        b=FCOVDYB4HsskKJ4A6aqxklETHj/nB9bXTGlQ0BZI0yJdxfi3d/4HM5FNN89stnpEBqdPOR
        KIlRfRbhddC2EJHNkTFsnYhVoPxf8BwMRWhiMw2cUT0tFKLTIEUAq13rb8DSuHsP0pdGk+
        cH7RRtNEG3otstICBOfLBAfUfhexZUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667993366;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6t6ywLtduHdfWo42pRm3bPhGBiGRAuMPXEPNm4DRpFk=;
        b=ZJZf/mQ1TVNFOUwro7ubr7AUaCD9iTe2tPI09b4LytNwCXjjrr3B/hRwizfA+1Ed/NqUMX
        kJzOLMViMaZ6RwAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 521F91331F;
        Wed,  9 Nov 2022 11:29:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Hy3+ExaPa2NtPAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 09 Nov 2022 11:29:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 04FE1A0704; Wed,  9 Nov 2022 12:29:24 +0100 (CET)
Date:   Wed, 9 Nov 2022 12:29:24 +0100
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH] ext4: correct inconsistent error msg in nojournal mode
Message-ID: <20221109112924.7vl3r47xqmtf3cxo@quack3>
References: <20221109074343.4184862-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109074343.4184862-1-libaokun1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 09-11-22 15:43:43, Baokun Li wrote:
> When we used the journal_async_commit mounting option in nojournal mode,
> the kernel told me that "can't mount with journal_checksum", was very
> confusing. I find that when we mount with journal_async_commit, both the
> JOURNAL_ASYNC_COMMIT and EXPLICIT_JOURNAL_CHECKSUM flags are set. However,
> in the error branch, CHECKSUM is checked before ASYNC_COMMIT. As a result,
> the above inconsistency occurs, and the ASYNC_COMMIT branch becomes dead
> code that cannot be executed. Therefore, we exchange the positions of the
> two judgments to make the error msg more accurate.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Yeah, this is probably more consistent error message. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 63ef74eb8091..e4ababd0f132 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5286,14 +5286,15 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  		goto failed_mount3a;
>  	} else {
>  		/* Nojournal mode, all journal mount options are illegal */
> -		if (test_opt2(sb, EXPLICIT_JOURNAL_CHECKSUM)) {
> +		if (test_opt(sb, JOURNAL_ASYNC_COMMIT)) {
>  			ext4_msg(sb, KERN_ERR, "can't mount with "
> -				 "journal_checksum, fs mounted w/o journal");
> +				 "journal_async_commit, fs mounted w/o journal");
>  			goto failed_mount3a;
>  		}
> -		if (test_opt(sb, JOURNAL_ASYNC_COMMIT)) {
> +
> +		if (test_opt2(sb, EXPLICIT_JOURNAL_CHECKSUM)) {
>  			ext4_msg(sb, KERN_ERR, "can't mount with "
> -				 "journal_async_commit, fs mounted w/o journal");
> +				 "journal_checksum, fs mounted w/o journal");
>  			goto failed_mount3a;
>  		}
>  		if (sbi->s_commit_interval != JBD2_DEFAULT_MAX_COMMIT_AGE*HZ) {
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
