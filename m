Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8AB7AD4C
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jul 2019 18:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbfG3QKV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 30 Jul 2019 12:10:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:55830 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728686AbfG3QKV (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 30 Jul 2019 12:10:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5BC2BAF27;
        Tue, 30 Jul 2019 16:10:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id EC6D31E435C; Tue, 30 Jul 2019 18:10:19 +0200 (CEST)
Date:   Tue, 30 Jul 2019 18:10:19 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@zoho.com.cn>
Cc:     Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/2] ext2: code cleanup for ext2_free_blocks()
Message-ID: <20190730161019.GH28829@quack2.suse.cz>
References: <20190723112155.20329-1-cgxu519@zoho.com.cn>
 <20190723112155.20329-2-cgxu519@zoho.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723112155.20329-2-cgxu519@zoho.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 23-07-19 19:21:55, Chengguang Xu wrote:
> Call ext2_data_block_valid() for block range validity.
> 
> Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>

Thanks for both patches. I've added them to my tree.

								Honza

> ---
>  fs/ext2/balloc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
> index 92e9a7489174..e0cc55164505 100644
> --- a/fs/ext2/balloc.c
> +++ b/fs/ext2/balloc.c
> @@ -490,9 +490,7 @@ void ext2_free_blocks (struct inode * inode, unsigned long block,
>  	struct ext2_super_block * es = sbi->s_es;
>  	unsigned freed = 0, group_freed;
>  
> -	if (block < le32_to_cpu(es->s_first_data_block) ||
> -	    block + count < block ||
> -	    block + count > le32_to_cpu(es->s_blocks_count)) {
> +	if (!ext2_data_block_valid(sbi, block, count)) {
>  		ext2_error (sb, "ext2_free_blocks",
>  			    "Freeing blocks not in datazone - "
>  			    "block = %lu, count = %lu", block, count);
> -- 
> 2.20.1
> 
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
