Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7323A0F15
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Jun 2021 10:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbhFII60 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Jun 2021 04:58:26 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47984 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbhFII60 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Jun 2021 04:58:26 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 068D71FD3C;
        Wed,  9 Jun 2021 08:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623228991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=glnzZfjZDM+qODk3DeZv6aAijLgp6fs8K4SCiJbJQC0=;
        b=hPVrS+cZhlwFV8nf8J6b9/URpXLxA8H6LeMfRsEfpNtGBmx5mxB4s+thCHWzEKWnB2gPa9
        jyFJC1HdprVJoiGfYTjAkgEaZB9sO3poiLs5T3A0Wz2B3rzeMtaodMSZRzhJqurICD3pmm
        zXHOkWpsLs4FgqqMCSWXRqV5JzJsytg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623228991;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=glnzZfjZDM+qODk3DeZv6aAijLgp6fs8K4SCiJbJQC0=;
        b=0JfbSdYG2mQ0/HSdjAvquXtI+kJLcQsIfko0zttZClELeQz/1t6fwGpIgo7K69igRdxz4C
        4jGXW1ikZKMjAUAQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id BA99CA3B89;
        Wed,  9 Jun 2021 08:56:30 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9180A1F2C98; Wed,  9 Jun 2021 10:56:30 +0200 (CEST)
Date:   Wed, 9 Jun 2021 10:56:30 +0200
From:   Jan Kara <jack@suse.cz>
To:     yangerkun <yangerkun@huawei.com>
Cc:     tytso@mit.edu, jack@suse.com, harshadshirwadkar@gmail.com,
        linux-ext4@vger.kernel.org, yukuai3@huawei.com
Subject: Re: [PATCH] jbd2: clean up misleading comments for
 jbd2_fc_release_bufs
Message-ID: <20210609085630.GJ5562@quack2.suse.cz>
References: <20210608141236.459441-1-yangerkun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608141236.459441-1-yangerkun@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 08-06-21 22:12:36, yangerkun wrote:
> This comments was for jbd2_fc_wait_bufs, not for jbd2_fc_release_bufs.
> Remove this misleading comments.
> 
> Signed-off-by: yangerkun <yangerkun@huawei.com>

Good point! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/journal.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 2dc944442802..ea46e5ad6b59 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -934,10 +934,6 @@ int jbd2_fc_wait_bufs(journal_t *journal, int num_blks)
>  }
>  EXPORT_SYMBOL(jbd2_fc_wait_bufs);
>  
> -/*
> - * Wait on fast commit buffers that were allocated by jbd2_fc_get_buf
> - * for completion.
> - */
>  int jbd2_fc_release_bufs(journal_t *journal)
>  {
>  	struct buffer_head *bh;
> @@ -945,10 +941,6 @@ int jbd2_fc_release_bufs(journal_t *journal)
>  
>  	j_fc_off = journal->j_fc_off;
>  
> -	/*
> -	 * Wait in reverse order to minimize chances of us being woken up before
> -	 * all IOs have completed
> -	 */
>  	for (i = j_fc_off - 1; i >= 0; i--) {
>  		bh = journal->j_fc_wbuf[i];
>  		if (!bh)
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
