Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BFC6B759D
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Mar 2023 12:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjCMLOK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Mar 2023 07:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjCMLNy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Mar 2023 07:13:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F17659C;
        Mon, 13 Mar 2023 04:12:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 48A8022307;
        Mon, 13 Mar 2023 11:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678705974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PyPbrfHYWFQCCiwZiljZOcWCO28QaHvZqP2C1c3Ai1o=;
        b=FpvWrYS6st5WdBdhRRoAj5X/LtSsik7zQCutxRzno1R0/9L+0fKb6/FjHWgHomd+5YiU+r
        nIxjTZfN0EjUeo5ir1L+BOWTkyE2EU2UNIM6HU4wXttIx61hKEVxtj4gLC1npIrt9iJ3Tr
        MQRTP/EEVZoJD95rQP/Dbigvao2HIlo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678705974;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PyPbrfHYWFQCCiwZiljZOcWCO28QaHvZqP2C1c3Ai1o=;
        b=nk1JZCnRgx6o/SbVfXh9rZRwirOZiUMTq744ofMpPS+yo1YR/rEDelqtlfHc1oRgGuAEmE
        tyBzbFOvYSVCLFBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3C04813517;
        Mon, 13 Mar 2023 11:12:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +fSZDjYFD2TTWAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 13 Mar 2023 11:12:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C4594A06FD; Mon, 13 Mar 2023 12:12:53 +0100 (CET)
Date:   Mon, 13 Mar 2023 12:12:53 +0100
From:   Jan Kara <jack@suse.cz>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH 4/5] jbd2: factor out journal initialization from
 journal_get_superblock()
Message-ID: <20230313111253.2eoplgfhcgbaqri2@quack3>
References: <20230310125206.2867822-1-chengzhihao1@huawei.com>
 <20230310125206.2867822-5-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310125206.2867822-5-chengzhihao1@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 10-03-23 20:52:05, Zhihao Cheng wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Current journal_get_superblock() couple journal superblock checking and
> partial journal initialization, factor out initialization part from it
> to make things clear.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> ---
>  fs/jbd2/journal.c | 52 ++++++++++++++++++++---------------------------
>  1 file changed, 22 insertions(+), 30 deletions(-)

The patch looks mostly good. Just one style nit below.

> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index b991d5c21d16..cd94d068b4e6 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1921,26 +1921,15 @@ static int journal_get_superblock(journal_t *journal)
>  		printk(KERN_WARNING "JBD2: no valid journal superblock found\n");
>  		goto out;
>  	}
> -
> -	switch(be32_to_cpu(sb->s_header.h_blocktype)) {
> -	case JBD2_SUPERBLOCK_V1:
> -		journal->j_format_version = 1;
> -		break;
> -	case JBD2_SUPERBLOCK_V2:
> -		journal->j_format_version = 2;
> -		break;
> -	default:
> +	if (be32_to_cpu(sb->s_header.h_blocktype) != JBD2_SUPERBLOCK_V1 &&
> +	    be32_to_cpu(sb->s_header.h_blocktype) != JBD2_SUPERBLOCK_V2) {
>  		printk(KERN_WARNING "JBD2: unrecognised superblock format ID\n");
>  		goto out;
>  	}
> -
> -	if (be32_to_cpu(sb->s_maxlen) < journal->j_total_len)
> -		journal->j_total_len = be32_to_cpu(sb->s_maxlen);
> -	else if (be32_to_cpu(sb->s_maxlen) > journal->j_total_len) {
> +	if (be32_to_cpu(sb->s_maxlen) > journal->j_total_len) {
>  		printk(KERN_WARNING "JBD2: journal file too short\n");
>  		goto out;
>  	}
> -

Please keep this empty line here. It actually makes the code more readable,
separating logically different checks. Same with three empty lines below...

>  	if (be32_to_cpu(sb->s_first) == 0 ||
>  	    be32_to_cpu(sb->s_first) >= journal->j_total_len) {
>  		printk(KERN_WARNING
> @@ -1956,7 +1945,6 @@ static int journal_get_superblock(journal_t *journal)
>  		       "at the same time!\n");
>  		goto out;
>  	}
> -
>  	if (jbd2_journal_has_csum_v2or3_feature(journal) &&
>  	    jbd2_has_feature_checksum(journal)) {
>  		/* Can't have checksum v1 and v2 on at the same time! */
> @@ -1964,12 +1952,10 @@ static int journal_get_superblock(journal_t *journal)
>  		       "at the same time!\n");
>  		goto out;
>  	}
> -
>  	if (!jbd2_verify_csum_type(journal, sb)) {
>  		printk(KERN_ERR "JBD2: Unknown checksum type\n");
>  		goto out;
>  	}
> -
>  	/* Load the checksum driver */
>  	if (jbd2_journal_has_csum_v2or3_feature(journal)) {
>  		journal->j_chksum_driver = crypto_alloc_shash("crc32c", 0, 0);

Otherwise the patch looks good.

									Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
