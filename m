Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13FC294B31
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Oct 2020 12:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441681AbgJUKZH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Oct 2020 06:25:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:33788 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441675AbgJUKZG (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 21 Oct 2020 06:25:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 25446ACE5;
        Wed, 21 Oct 2020 10:25:05 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5A5521E0E97; Wed, 21 Oct 2020 12:25:03 +0200 (CEST)
Date:   Wed, 21 Oct 2020 12:25:03 +0200
From:   Jan Kara <jack@suse.cz>
To:     Xianting Tian <tian.xianting@h3c.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: remove the null check of bio_vec page
Message-ID: <20201021102503.GC19726@quack2.suse.cz>
References: <20201020082201.34257-1-tian.xianting@h3c.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020082201.34257-1-tian.xianting@h3c.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 20-10-20 16:22:01, Xianting Tian wrote:
> bv_page can't be NULL in a valid bio_vec, so we can remove the NULL check,
> as we did in other places when calling bio_for_each_segment_all() to go
> through all bio_vec of a bio.
> 
> Signed-off-by: Xianting Tian <tian.xianting@h3c.com>

Thanks for the patch. It looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/page-io.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
> index defd2e10d..cb135a944 100644
> --- a/fs/ext4/page-io.c
> +++ b/fs/ext4/page-io.c
> @@ -111,9 +111,6 @@ static void ext4_finish_bio(struct bio *bio)
>  		unsigned under_io = 0;
>  		unsigned long flags;
>  
> -		if (!page)
> -			continue;
> -
>  		if (fscrypt_is_bounce_page(page)) {
>  			bounce_page = page;
>  			page = fscrypt_pagecache_page(bounce_page);
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
