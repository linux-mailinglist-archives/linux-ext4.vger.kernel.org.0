Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2723F38E38F
	for <lists+linux-ext4@lfdr.de>; Mon, 24 May 2021 11:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbhEXJzk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 May 2021 05:55:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:37488 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232313AbhEXJzk (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 24 May 2021 05:55:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621850052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nd9KlTubE21KSPSGULr1+2oPHWFu3hMy3W9SEQvRuGE=;
        b=WVJ9B5+Th5T147R0t0PBGe70XdJWFxN4kGznQWqT3YhFTqW9y6++XcECGxlOOqhGeiXAGO
        +kjyoJbY/w/yG32npSmzHeaAd4a2mq7V5jugqDyKJRG1limZ69Yvm5xV2fOETMgAW8NR5W
        KbLWFrau2Tvewhf885PApaHm9L69sCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621850052;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nd9KlTubE21KSPSGULr1+2oPHWFu3hMy3W9SEQvRuGE=;
        b=Cz1RQijWEgfNbk2ygJnMeK1jGhZ9xisV8RsuwkzahJ7mypXWhf/EGPu56zGQJ0sfUgR5du
        51BlyHKdFQFGtwAg==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E65B2ABB1;
        Mon, 24 May 2021 09:54:11 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7701A1F2CA2; Mon, 24 May 2021 11:54:11 +0200 (CEST)
Date:   Mon, 24 May 2021 11:54:11 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yukuai3@huawei.com
Subject: Re: [PATCH 2/2] ext4: correct the cache_nr in tracepoint
 ext4_es_shrink_exit
Message-ID: <20210524095411.GH32705@quack2.suse.cz>
References: <20210522103045.690103-1-yi.zhang@huawei.com>
 <20210522103045.690103-3-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210522103045.690103-3-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 22-05-21 18:30:45, Zhang Yi wrote:
> The cache_cnt parameter of tracepoint ext4_es_shrink_exit means the
> remaining cache count after shrink, but now it is the cache count before
> shrink, fix it by read sbi->s_extent_cache_cnt again.
> 
> Fixes: 1ab6c4997e04 ("fs: convert fs shrinkers to new scan/count API")
> Cc: stable@vger.kernel.org # 3.12+
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Yeah, probably it is better this way. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents_status.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index db3cd70a72e4..9a3a8996aacf 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -1576,6 +1576,7 @@ static unsigned long ext4_es_scan(struct shrinker *shrink,
>  
>  	nr_shrunk = __es_shrink(sbi, nr_to_scan, NULL);
>  
> +	ret = percpu_counter_read_positive(&sbi->s_es_stats.es_stats_shk_cnt);
>  	trace_ext4_es_shrink_scan_exit(sbi->s_sb, nr_shrunk, ret);
>  	return nr_shrunk;
>  }
> -- 
> 2.25.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
