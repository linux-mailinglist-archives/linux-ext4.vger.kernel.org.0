Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5523839A5B6
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Jun 2021 18:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhFCQap (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Jun 2021 12:30:45 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43864 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhFCQap (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Jun 2021 12:30:45 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BBFD21FD4E;
        Thu,  3 Jun 2021 16:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622737739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r3b5V6hWqhRifzETnYFu5TUec6aWRDq9Hi/WRpJibP0=;
        b=PbbZ/SvJJfimU7g6J1jLXqQe1R+ENrdYQcTMR0Thvcypul34VW7e4cHlDYBQa9laAm7MK3
        mAIBek86lDvyxog+KS4JgidNIRM6i5jCfYxs0HaP1V+ai7TttbImNX8oW6CpYEzd9JgyOn
        uEEm26z7XpOIXSr8bLJDqwg7+sayclw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622737739;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r3b5V6hWqhRifzETnYFu5TUec6aWRDq9Hi/WRpJibP0=;
        b=VP3Z6VUPpd6Xt4zf6r9B9RRqpCuohh+AWmuQJYZ9FKjhAz87CZpQyBkZK3Uha0PtBiOoIp
        1NgRgc4T+CdBKWAA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id AF51DA3B85;
        Thu,  3 Jun 2021 16:28:59 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8A50F1F2C96; Thu,  3 Jun 2021 18:28:59 +0200 (CEST)
Date:   Thu, 3 Jun 2021 18:28:59 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yukuai3@huawei.com
Subject: Re: [RFC PATCH v3 4/8] jbd2: remove redundant buffer io error checks
Message-ID: <20210603162859.GN23647@quack2.suse.cz>
References: <20210527135641.420514-1-yi.zhang@huawei.com>
 <20210527135641.420514-5-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527135641.420514-5-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 27-05-21 21:56:37, Zhang Yi wrote:
> Now that __jbd2_journal_remove_checkpoint() can detect buffer io error
> and mark journal checkpoint error, then we abort the journal later
> before updating log tail to ensure the filesystem works consistently.
> So we could remove other redundant buffer io error checkes.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/jbd2/checkpoint.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
> index 2cbac0e3cff3..c1f746a5cc1a 100644
> --- a/fs/jbd2/checkpoint.c
> +++ b/fs/jbd2/checkpoint.c
> @@ -91,8 +91,7 @@ static int __try_to_free_cp_buf(struct journal_head *jh)
>  	int ret = 0;
>  	struct buffer_head *bh = jh2bh(jh);
>  
> -	if (jh->b_transaction == NULL && !buffer_locked(bh) &&
> -	    !buffer_dirty(bh) && !buffer_write_io_error(bh)) {
> +	if (!jh->b_transaction && !buffer_locked(bh) && !buffer_dirty(bh)) {
>  		JBUFFER_TRACE(jh, "remove from checkpoint list");
>  		ret = __jbd2_journal_remove_checkpoint(jh) + 1;
>  	}
> @@ -295,8 +294,6 @@ int jbd2_log_do_checkpoint(journal_t *journal)
>  			goto restart;
>  		}
>  		if (!buffer_dirty(bh)) {
> -			if (unlikely(buffer_write_io_error(bh)) && !result)
> -				result = -EIO;
>  			BUFFER_TRACE(bh, "remove from checkpoint");
>  			if (__jbd2_journal_remove_checkpoint(jh))
>  				/* The transaction was released; we're done */
> @@ -356,8 +353,6 @@ int jbd2_log_do_checkpoint(journal_t *journal)
>  			spin_lock(&journal->j_list_lock);
>  			goto restart2;
>  		}
> -		if (unlikely(buffer_write_io_error(bh)) && !result)
> -			result = -EIO;
>  
>  		/*
>  		 * Now in whatever state the buffer currently is, we

You can also drop:

	if (result < 0)
                jbd2_journal_abort(journal, result);

in jbd2_log_do_checkpoint() as there's now nothing which can set 'result'
in the loops... Otherwise looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
