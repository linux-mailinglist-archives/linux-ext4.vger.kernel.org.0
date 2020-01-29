Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F52714CE20
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Jan 2020 17:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgA2QUl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Jan 2020 11:20:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:53096 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbgA2QUl (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 29 Jan 2020 11:20:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id ADD1CAEE9;
        Wed, 29 Jan 2020 16:20:35 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DD1531E0D4F; Wed, 29 Jan 2020 17:20:34 +0100 (CET)
Date:   Wed, 29 Jan 2020 17:20:34 +0100
From:   Jan Kara <jack@suse.cz>
To:     Liu Song <fishland@aliyun.com>
Cc:     tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, liu.song11@zte.com.cn
Subject: Re: [RFC PATCH] jbd2: no need to repeat in
 jbd2_journal_add_journal_head
Message-ID: <20200129162034.GB8591@quack2.suse.cz>
References: <20200129095700.3043-1-fishland@aliyun.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129095700.3043-1-fishland@aliyun.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 29-01-20 17:57:00, Liu Song wrote:
> From: Liu Song <liu.song11@zte.com.cn>
> 
> In "journal_alloc_journal_head" use "GFP_NOFS | __GFP_NOFAIL"
> as the alloc flag, so it will retry until memory allocation
> is successful. Then we do not need to do extra repeat.
> 
> Signed-off-by: Liu Song <liu.song11@zte.com.cn>

Thanks for the patch. It looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/journal.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 5e408ee24a1a..1a9aaf07cecd 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -2503,7 +2503,6 @@ struct journal_head *jbd2_journal_add_journal_head(struct buffer_head *bh)
>  	struct journal_head *jh;
>  	struct journal_head *new_jh = NULL;
>  
> -repeat:
>  	if (!buffer_jbd(bh))
>  		new_jh = journal_alloc_journal_head();
>  
> @@ -2515,11 +2514,6 @@ struct journal_head *jbd2_journal_add_journal_head(struct buffer_head *bh)
>  			(atomic_read(&bh->b_count) > 0) ||
>  			(bh->b_page && bh->b_page->mapping));
>  
> -		if (!new_jh) {
> -			jbd_unlock_bh_journal_head(bh);
> -			goto repeat;
> -		}
> -
>  		jh = new_jh;
>  		new_jh = NULL;		/* We consumed it */
>  		set_buffer_jbd(bh);
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
