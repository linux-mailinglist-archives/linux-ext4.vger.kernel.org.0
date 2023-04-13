Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C5C6E0B32
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Apr 2023 12:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjDMKOx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Apr 2023 06:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjDMKM3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 13 Apr 2023 06:12:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D929750;
        Thu, 13 Apr 2023 03:12:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 585052183F;
        Thu, 13 Apr 2023 10:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681380722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hf55BhKINP1L+Xd3BxYZAkmZBMcD2m94S6WBz92mpIY=;
        b=UIfw/TRhEbPKpHQsYQvxYyuOxsr68jxK5JLtJqz5eBjNtjnyaIZ94sUB5vEh+hltzgan64
        FuU1jHF9DzYL/owjiSSO12TP7OpCn9ES7lNdnBw700UtT096fcoq+j1ZrCkiqtd9oSgXoq
        DxYXN6yaT2DxWVO8nfv91MeRuEg3TOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681380722;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hf55BhKINP1L+Xd3BxYZAkmZBMcD2m94S6WBz92mpIY=;
        b=1H90D2HdSCUPQAnZmtD5OifPVpItgik2eloaM60sMcy3xMIKBTqWQtueinX1bR/hz93qR+
        28g9IoiiYLYnlTDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 39B971390E;
        Thu, 13 Apr 2023 10:12:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jXGMDXLVN2TyQwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 13 Apr 2023 10:12:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 932CAA0732; Thu, 13 Apr 2023 12:12:01 +0200 (CEST)
Date:   Thu, 13 Apr 2023 12:12:01 +0200
From:   Jan Kara <jack@suse.cz>
To:     Guoqing Cai <u202112087@hust.edu.cn>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        HUST OS Kernel Contribution 
        <hust-os-kernel-patches@googlegroups.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs: jbd2: fix an incorrect warn log
Message-ID: <20230413101201.gqtqhuecra3fk7x4@quack3>
References: <20230413095740.2222066-1-u202112087@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413095740.2222066-1-u202112087@hust.edu.cn>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 13-04-23 17:57:39, Guoqing Cai wrote:
> In jbd2_journal_load(), when journal_reset fails, it prints an incorrect
> warn log.
> 
> Fix this by changing the goto statement to return statement.
> 
> Also, return actual error code from jbd2_journal_recover() and journal_reset().
> 
> Signed-off-by: Guoqing Cai <u202112087@hust.edu.cn>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> changelog:
> - Add a warning log when journal_reset failed.
> - Return the actual error code.
> ---
>  fs/jbd2/journal.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index e80c781731f8..147733dd5cc3 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -2082,8 +2082,11 @@ int jbd2_journal_load(journal_t *journal)
>  
>  	/* Let the recovery code check whether it needs to recover any
>  	 * data from the journal. */
> -	if (jbd2_journal_recover(journal))
> -		goto recovery_error;
> +	err = jbd2_journal_recover(journal);
> +	if (err) {
> +		pr_warn("JBD2: journal recovery failed\n");
> +		return err;
> +	}
>  
>  	if (journal->j_failed_commit) {
>  		printk(KERN_ERR "JBD2: journal transaction %u on %s "
> @@ -2100,15 +2103,14 @@ int jbd2_journal_load(journal_t *journal)
>  	/* OK, we've finished with the dynamic journal bits:
>  	 * reinitialise the dynamic contents of the superblock in memory
>  	 * and reset them on disk. */
> -	if (journal_reset(journal))
> -		goto recovery_error;
> +	err = journal_reset(journal);
> +	if (err) {
> +		pr_warn("JBD2: journal reset failed\n");
> +		return err;
> +	}
>  
>  	journal->j_flags |= JBD2_LOADED;
>  	return 0;
> -
> -recovery_error:
> -	printk(KERN_WARNING "JBD2: recovery failed\n");
> -	return -EIO;
>  }
>  
>  /**
> -- 
> 2.40.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
