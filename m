Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4165578C9F
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Jul 2019 15:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387420AbfG2NRw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 29 Jul 2019 09:17:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:46942 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727268AbfG2NRv (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 29 Jul 2019 09:17:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DA8A5AE84;
        Mon, 29 Jul 2019 13:17:50 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7D6D81E3C1F; Mon, 29 Jul 2019 15:17:48 +0200 (CEST)
Date:   Mon, 29 Jul 2019 15:17:48 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@zoho.com.cn>
Cc:     Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext2: show more accurate free block count in debug
 message
Message-ID: <20190729131748.GD17833@quack2.suse.cz>
References: <20190718012236.22618-1-cgxu519@zoho.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718012236.22618-1-cgxu519@zoho.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 18-07-19 09:22:36, Chengguang Xu wrote:
> Show more accurate free block count in debug message by replacing
> es->s_free_blocks_count to sbi->s_freeblocks_counter in
> ext2_count_free_blocks().
> 
> Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>

Thanks for the patch but I don't think this really makes any big
difference. So let's just not introduce unnecessary churn.

								Honza

> ---
>  fs/ext2/balloc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
> index 547c165299c0..8c587533cead 100644
> --- a/fs/ext2/balloc.c
> +++ b/fs/ext2/balloc.c
> @@ -1495,7 +1495,8 @@ unsigned long ext2_count_free_blocks (struct super_block * sb)
>  		brelse(bitmap_bh);
>  	}
>  	printk("ext2_count_free_blocks: stored = %lu, computed = %lu, %lu\n",
> -		(long)le32_to_cpu(es->s_free_blocks_count),
> +		(unsigned long)
> +		percpu_counter_read(&EXT2_SB(sb)->s_freeblocks_counter),
>  		desc_count, bitmap_count);
>  	return bitmap_count;
>  #else
> -- 
> 2.21.0
> 
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
