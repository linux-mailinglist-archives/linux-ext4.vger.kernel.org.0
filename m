Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B732239E13A
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Jun 2021 17:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhFGPv7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Jun 2021 11:51:59 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39268 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhFGPv6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Jun 2021 11:51:58 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E802E219B6;
        Mon,  7 Jun 2021 15:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623081006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GQ3+P57PHK8BLbTG6n2bsfDDr/8Z0E/zti303yPV8rI=;
        b=NEEkpGP9nZIs2g3WBXDXkhAscww5ED1TP+yN1IcSiUa9+oAH9dbvUPcXNyyCvyJ/qaucyS
        PDIjypGOkLzIl3N7V3JrB9SOug5salB5KEO+iqQR6j0AjNcvzPAaqf0c99QdkuMiLzZkFO
        KEJFC6FG7vt4GrpdWtfqwmpwf+2ua/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623081006;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GQ3+P57PHK8BLbTG6n2bsfDDr/8Z0E/zti303yPV8rI=;
        b=BnzC9pHb5hPJJ6qEL43xCeBtkX6lGcN8sVZgFKXL3S886+amCajOIaHOEB3qznXzCLzZxf
        Rg5zdJBJGUssXPDQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 8CACEA3B81;
        Mon,  7 Jun 2021 15:50:06 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 44EE81F2CA8; Mon,  7 Jun 2021 17:50:06 +0200 (CEST)
Date:   Mon, 7 Jun 2021 17:50:06 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yukuai3@huawei.com
Subject: Re: [RFC PATCH v3 6/8] jbd2: simplify journal_clean_one_cp_list()
Message-ID: <20210607155006.GB29326@quack2.suse.cz>
References: <20210527135641.420514-1-yi.zhang@huawei.com>
 <20210527135641.420514-7-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527135641.420514-7-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 27-05-21 21:56:39, Zhang Yi wrote:
> Now that __try_to_free_cp_buf() remove checkpointed buffer or transaction
> when the buffer is not 'busy', which is only called by
> journal_clean_one_cp_list(). This patch simplify this function by remove
> __try_to_free_cp_buf() and invoke __cp_buffer_busy() directly.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  fs/jbd2/checkpoint.c | 30 ++++--------------------------
>  1 file changed, 4 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
> index 727389185d24..7dea46cc7099 100644
> --- a/fs/jbd2/checkpoint.c
> +++ b/fs/jbd2/checkpoint.c
> @@ -91,25 +91,6 @@ static inline bool __cp_buffer_busy(struct journal_head *jh)
>  	return (jh->b_transaction || buffer_locked(bh) || buffer_dirty(bh));
>  }
>  
> -/*
> - * Try to release a checkpointed buffer from its transaction.
> - * Returns 1 if we released it and 2 if we also released the
> - * whole transaction.
> - *
> - * Requires j_list_lock
> - */
> -static int __try_to_free_cp_buf(struct journal_head *jh)
> -{
> -	int ret = 0;
> -	struct buffer_head *bh = jh2bh(jh);
> -
> -	if (!jh->b_transaction && !buffer_locked(bh) && !buffer_dirty(bh)) {
> -		JBUFFER_TRACE(jh, "remove from checkpoint list");
> -		ret = __jbd2_journal_remove_checkpoint(jh) + 1;
> -	}
> -	return ret;
> -}
> -
>  /*
>   * __jbd2_log_wait_for_space: wait until there is space in the journal.
>   *
> @@ -444,7 +425,6 @@ static int journal_clean_one_cp_list(struct journal_head *jh, bool destroy)
>  {
>  	struct journal_head *last_jh;
>  	struct journal_head *next_jh = jh;
> -	int ret;
>  
>  	if (!jh)
>  		return 0;
> @@ -453,13 +433,11 @@ static int journal_clean_one_cp_list(struct journal_head *jh, bool destroy)
>  	do {
>  		jh = next_jh;
>  		next_jh = jh->b_cpnext;
> -		if (!destroy)
> -			ret = __try_to_free_cp_buf(jh);
> -		else
> -			ret = __jbd2_journal_remove_checkpoint(jh) + 1;
> -		if (!ret)
> +
> +		if (!destroy && __cp_buffer_busy(jh))
>  			return 0;
> -		if (ret == 2)
> +
> +		if (__jbd2_journal_remove_checkpoint(jh))
>  			return 1;
>  		/*
>  		 * This function only frees up some memory
> -- 
> 2.25.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
