Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D91723ACF
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jun 2023 09:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbjFFH7n (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Jun 2023 03:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235881AbjFFH71 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Jun 2023 03:59:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883D826AE
        for <linux-ext4@vger.kernel.org>; Tue,  6 Jun 2023 00:56:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 922592199E;
        Tue,  6 Jun 2023 07:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686038187; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jXW3O8sCieWgIVTfnUQsXK68agLuES/Y9eM+kJECPPM=;
        b=zNpQSYHP4RcUSR/YGaYKFuAbxAYYYKpqaAew1xBPnWaxvx1sk6VT03/8IXiBiAcYWnyLLJ
        HPC0u0KvLXNIzcqXKRJgD1EDk/7Q4i9xRusb/3lt+qq55ulJT1eG4W5KQ9UV21NBcgbCTB
        hQQb3eqI6bz1yvSVAam/AsvrdrvLHQg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686038187;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jXW3O8sCieWgIVTfnUQsXK68agLuES/Y9eM+kJECPPM=;
        b=5L/ofzZxpDrH0cSXsZaXYsm1Crm45Vm894w1uVnoLvPqn/WDN5Kvd3gL+olv7qrSkinioK
        VwA6IUtVZ8aD+LBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 84A4A13519;
        Tue,  6 Jun 2023 07:56:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4FlhIKvmfmTLHQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 06 Jun 2023 07:56:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1CFC8A0754; Tue,  6 Jun 2023 09:56:27 +0200 (CEST)
Date:   Tue, 6 Jun 2023 09:56:27 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        yukuai3@huawei.com, chengzhihao1@huawei.com
Subject: Re: [PATCH v2 6/6] jbd2: remove __journal_try_to_free_buffer()
Message-ID: <20230606075627.a7ae6vjy5q2svrud@quack3>
References: <20230606061447.1125036-1-yi.zhang@huaweicloud.com>
 <20230606061447.1125036-7-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606061447.1125036-7-yi.zhang@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 06-06-23 14:14:47, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> __journal_try_to_free_buffer() has only one caller and it's logic is
> much simple now, so just remove it and open code in
> jbd2_journal_try_to_free_buffers().
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/transaction.c | 31 +++++++------------------------
>  1 file changed, 7 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index 6ef5022949c4..4d1fda1f7143 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -2099,29 +2099,6 @@ void jbd2_journal_unfile_buffer(journal_t *journal, struct journal_head *jh)
>  	__brelse(bh);
>  }
>  
> -/*
> - * Called from jbd2_journal_try_to_free_buffers().
> - *
> - * Called under jh->b_state_lock
> - */
> -static void
> -__journal_try_to_free_buffer(journal_t *journal, struct buffer_head *bh)
> -{
> -	struct journal_head *jh;
> -
> -	jh = bh2jh(bh);
> -
> -	if (jh->b_next_transaction != NULL || jh->b_transaction != NULL)
> -		return;
> -
> -	spin_lock(&journal->j_list_lock);
> -	/* Remove written-back checkpointed metadata buffer */
> -	if (jh->b_cp_transaction != NULL)
> -		jbd2_journal_try_remove_checkpoint(jh);
> -	spin_unlock(&journal->j_list_lock);
> -	return;
> -}
> -
>  /**
>   * jbd2_journal_try_to_free_buffers() - try to free page buffers.
>   * @journal: journal for operation
> @@ -2179,7 +2156,13 @@ bool jbd2_journal_try_to_free_buffers(journal_t *journal, struct folio *folio)
>  			continue;
>  
>  		spin_lock(&jh->b_state_lock);
> -		__journal_try_to_free_buffer(journal, bh);
> +		if (!jh->b_transaction && !jh->b_next_transaction) {
> +			spin_lock(&journal->j_list_lock);
> +			/* Remove written-back checkpointed metadata buffer */
> +			if (jh->b_cp_transaction != NULL)
> +				jbd2_journal_try_remove_checkpoint(jh);
> +			spin_unlock(&journal->j_list_lock);
> +		}
>  		spin_unlock(&jh->b_state_lock);
>  		jbd2_journal_put_journal_head(jh);
>  		if (buffer_jbd(bh))
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
