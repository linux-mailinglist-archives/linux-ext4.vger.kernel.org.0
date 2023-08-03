Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3FD76EEA0
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Aug 2023 17:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbjHCPt5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Aug 2023 11:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237233AbjHCPt5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Aug 2023 11:49:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6012AE6B
        for <linux-ext4@vger.kernel.org>; Thu,  3 Aug 2023 08:49:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0526721972;
        Thu,  3 Aug 2023 15:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691077795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0KtPDmDzwP18ze0S0C2NQyTwBqH1HPgePYgsE9Izx0E=;
        b=pDTWNguEihCDH6GJFVUqJ9tzcV/QU7im5pU3gaBU/jGHC6HEReZlqndHfFyJ8N6C1IlwOg
        F7Ex4GSGQ9GPn9oLHDD1vmaolBJJdbUXlpTP0Qh/JtdDBtw62/mVOKme2Adag+GGazbio3
        HGsfggrcwI7idVBWLZzZu9QVek1dC5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691077795;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0KtPDmDzwP18ze0S0C2NQyTwBqH1HPgePYgsE9Izx0E=;
        b=C8P19h2AqovbfL/RkdZvy1VxYd+XmPgpIFPtw2B1We9rMzqNgTUMxINVKeeFGdF8jnkYD2
        ZpHyBW+6oxuhqaBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EBBB5134B0;
        Thu,  3 Aug 2023 15:49:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OHiJOaLMy2TEOQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 03 Aug 2023 15:49:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 927BCA076B; Thu,  3 Aug 2023 17:49:54 +0200 (CEST)
Date:   Thu, 3 Aug 2023 17:49:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 09/12] jbd2: drop useless error tag in jbd2_journal_wipe()
Message-ID: <20230803154954.6rhr4m4qqer2si6r@quack3>
References: <20230704134233.110812-1-yi.zhang@huaweicloud.com>
 <20230704134233.110812-10-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704134233.110812-10-yi.zhang@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 04-07-23 21:42:30, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> no_recovery is redundant, just drop it.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/journal.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 065b5e789299..cc344b8d7476 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -2506,12 +2506,12 @@ int jbd2_journal_flush(journal_t *journal, unsigned int flags)
>  
>  int jbd2_journal_wipe(journal_t *journal, int write)
>  {
> -	int err = 0;
> +	int err;
>  
>  	J_ASSERT (!(journal->j_flags & JBD2_LOADED));
>  
>  	if (!journal->j_tail)
> -		goto no_recovery;
> +		return 0;
>  
>  	printk(KERN_WARNING "JBD2: %s recovery information on journal\n",
>  		write ? "Clearing" : "Ignoring");
> @@ -2524,7 +2524,6 @@ int jbd2_journal_wipe(journal_t *journal, int write)
>  		mutex_unlock(&journal->j_checkpoint_mutex);
>  	}
>  
> - no_recovery:
>  	return err;
>  }
>  
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
