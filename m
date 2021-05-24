Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C8838E38C
	for <lists+linux-ext4@lfdr.de>; Mon, 24 May 2021 11:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbhEXJx3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 May 2021 05:53:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:35936 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232397AbhEXJx2 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 24 May 2021 05:53:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621849920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V94tQyRRYIwVKaaBiAPg0kbhd2VPS9WcgAHlQGyLYJ0=;
        b=Bvg3zXvSC8aSxo2hWCKNh7EkWKZV2YwVB8XH49ppsLlKiH/7/b6iYB97m1ARq2qMrEw4BL
        XKdofDBNY4APhG7g94w+344oet9eDyM7Gly+Exb/YjOILUX1WmBuGPiVP51Rz1oXVP1YWp
        PgqCPmjOli7U7kQMcIOcatjLCwK1BuQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621849920;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V94tQyRRYIwVKaaBiAPg0kbhd2VPS9WcgAHlQGyLYJ0=;
        b=CPywBdvn61T8BnXIHn8Fc9DaZK6hHqMjHguWxqbaaCqyjvGaWUVHwyzzIG4AgLd6nWYtq5
        7zum3QO++4DwTaCg==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0A253AB6D;
        Mon, 24 May 2021 09:52:00 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 934081F2CA2; Mon, 24 May 2021 11:51:59 +0200 (CEST)
Date:   Mon, 24 May 2021 11:51:59 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yukuai3@huawei.com
Subject: Re: [PATCH 1/2] ext4: remove check for zero nr_to_scan in
 ext4_es_scan()
Message-ID: <20210524095159.GG32705@quack2.suse.cz>
References: <20210522103045.690103-1-yi.zhang@huawei.com>
 <20210522103045.690103-2-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210522103045.690103-2-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 22-05-21 18:30:44, Zhang Yi wrote:
> After converting fs shrinkers to new scan/count API, we are no longer
> pass zero nr_to_scan parameter to detect the number of objects to free,
> just remove this check.
> 
> Fixes: 1ab6c4997e04 ("fs: convert fs shrinkers to new scan/count API")
> Cc: stable@vger.kernel.org # 3.12+
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Thanks for the patch. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents_status.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index 0a729027322d..db3cd70a72e4 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -1574,9 +1574,6 @@ static unsigned long ext4_es_scan(struct shrinker *shrink,
>  	ret = percpu_counter_read_positive(&sbi->s_es_stats.es_stats_shk_cnt);
>  	trace_ext4_es_shrink_scan_enter(sbi->s_sb, nr_to_scan, ret);
>  
> -	if (!nr_to_scan)
> -		return ret;
> -
>  	nr_shrunk = __es_shrink(sbi, nr_to_scan, NULL);
>  
>  	trace_ext4_es_shrink_scan_exit(sbi->s_sb, nr_shrunk, ret);
> -- 
> 2.25.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
