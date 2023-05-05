Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2966F839A
	for <lists+linux-ext4@lfdr.de>; Fri,  5 May 2023 15:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbjEENNf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 May 2023 09:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbjEENNb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 5 May 2023 09:13:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645881E9A3
        for <linux-ext4@vger.kernel.org>; Fri,  5 May 2023 06:13:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 14FE920012;
        Fri,  5 May 2023 13:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683292409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NZX3yQsDOM47yVaMn1oodRDSXXcbQmXQ/GP7jrGkvFI=;
        b=nwj4PhdwMd7Pp6P1JgR1ITN368MaiQMJTg26q5fjx+H//zgKvgM5F/j3Smi95IoQx41F+i
        jrkambIM4Nf7xuhNN6IysMPBTt8FN5/Skh4zIFWpJgmyQX1fSg0Fb/+rxEi6UxwyAuyHOn
        i+MAiJuC3g6oE8vhbq/rRDDSJvkbPhU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683292409;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NZX3yQsDOM47yVaMn1oodRDSXXcbQmXQ/GP7jrGkvFI=;
        b=FqCL22V1mlKVMLP3j1IXi9nXs0SeJLJnVTGfJEtJFXHti2+vOvFuQL5wfnTF4r7J6lg0g8
        lL3cA68Qm0/lwdDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 083B113488;
        Fri,  5 May 2023 13:13:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LSP8AfkAVWRhTgAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 05 May 2023 13:13:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A3B61A0729; Fri,  5 May 2023 15:13:28 +0200 (CEST)
Date:   Fri, 5 May 2023 15:13:28 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        yukuai3@huawei.com, chengzhihao1@huawei.com
Subject: Re: [PATCH v2 3/3] jbd2: remove released parameter in
 journal_shrink_one_cp_list()
Message-ID: <20230505131328.hh2x5v7w7yzmgksx@quack3>
References: <20230505123219.4135141-1-yi.zhang@huaweicloud.com>
 <20230505123219.4135141-3-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505123219.4135141-3-yi.zhang@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 05-05-23 20:32:19, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> After t_checkpoint_io_list is gone, the 'released' parameter in
> journal_shrink_one_cp_list() becomes useless, just remove it.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/checkpoint.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
> index 2b62154e9f1e..7b6320081f11 100644
> --- a/fs/jbd2/checkpoint.c
> +++ b/fs/jbd2/checkpoint.c
> @@ -387,15 +387,13 @@ static int journal_clean_one_cp_list(struct journal_head *jh, bool destroy)
>   * journal_shrink_one_cp_list
>   *
>   * Find 'nr_to_scan' written-back checkpoint buffers in the given list
> - * and try to release them. If the whole transaction is released, set
> - * the 'released' parameter. Return the number of released checkpointed
> + * and try to release them. Return the number of released checkpointed
>   * buffers.
>   *
>   * Called with j_list_lock held.
>   */
>  static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
> -						unsigned long *nr_to_scan,
> -						bool *released)
> +						unsigned long *nr_to_scan)
>  {
>  	struct journal_head *last_jh;
>  	struct journal_head *next_jh = jh;
> @@ -416,10 +414,8 @@ static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
>  
>  		nr_freed++;
>  		ret = __jbd2_journal_remove_checkpoint(jh);
> -		if (ret) {
> -			*released = true;
> +		if (ret)
>  			break;
> -		}
>  
>  		if (need_resched())
>  			break;
> @@ -441,7 +437,6 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
>  						  unsigned long *nr_to_scan)
>  {
>  	transaction_t *transaction, *last_transaction, *next_transaction;
> -	bool released;
>  	tid_t first_tid = 0, last_tid = 0, next_tid = 0;
>  	tid_t tid = 0;
>  	unsigned long nr_freed = 0;
> @@ -474,10 +469,9 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
>  		transaction = next_transaction;
>  		next_transaction = transaction->t_cpnext;
>  		tid = transaction->t_tid;
> -		released = false;
>  
>  		nr_freed += journal_shrink_one_cp_list(transaction->t_checkpoint_list,
> -						       nr_to_scan, &released);
> +						       nr_to_scan);
>  		if (*nr_to_scan == 0)
>  			break;
>  		if (need_resched() || spin_needbreak(&journal->j_list_lock))
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
