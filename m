Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99BF142701
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Jun 2019 15:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731948AbfFLNIR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Jun 2019 09:08:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:55902 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728322AbfFLNIR (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 12 Jun 2019 09:08:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E1424B014;
        Wed, 12 Jun 2019 13:08:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5FCDE1E4328; Wed, 12 Jun 2019 15:08:15 +0200 (CEST)
Date:   Wed, 12 Jun 2019 15:08:15 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@zoho.com.cn>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext2: fix a typo in comment
Message-ID: <20190612130815.GA21189@quack2.suse.cz>
References: <20190612045753.12398-1-cgxu519@zoho.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612045753.12398-1-cgxu519@zoho.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 12-06-19 12:57:53, Chengguang Xu wrote:
> Just fix a typo in comment and remove redundant blank line
> in ext2_data_block_valid().
> 
> Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>

Thanks. Applied to my tree.

								Honza

> ---
>  fs/ext2/balloc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
> index 33db13365c5e..547c165299c0 100644
> --- a/fs/ext2/balloc.c
> +++ b/fs/ext2/balloc.c
> @@ -1197,7 +1197,7 @@ static int ext2_has_free_blocks(struct ext2_sb_info *sbi)
>  
>  /*
>   * Returns 1 if the passed-in block region is valid; 0 if some part overlaps
> - * with filesystem metadata blocksi.
> + * with filesystem metadata blocks.
>   */
>  int ext2_data_block_valid(struct ext2_sb_info *sbi, ext2_fsblk_t start_blk,
>  			  unsigned int count)
> @@ -1212,7 +1212,6 @@ int ext2_data_block_valid(struct ext2_sb_info *sbi, ext2_fsblk_t start_blk,
>  	    (start_blk + count >= sbi->s_sb_block))
>  		return 0;
>  
> -
>  	return 1;
>  }
>  
> -- 
> 2.20.1
> 
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
