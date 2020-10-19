Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265C9292B93
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Oct 2020 18:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730404AbgJSQeY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 19 Oct 2020 12:34:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:42986 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729879AbgJSQeY (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 19 Oct 2020 12:34:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 20022ADF5;
        Mon, 19 Oct 2020 16:34:22 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5A35D1E1342; Mon, 19 Oct 2020 18:34:20 +0200 (CEST)
Date:   Mon, 19 Oct 2020 18:34:20 +0200
From:   Jan Kara <jack@suse.cz>
To:     Xianting Tian <tian.xianting@h3c.com>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext2: Remove unnecessary blank
Message-ID: <20201019163420.GI30825@quack2.suse.cz>
References: <20201010094335.39797-1-tian.xianting@h3c.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201010094335.39797-1-tian.xianting@h3c.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 10-10-20 17:43:35, Xianting Tian wrote:
> Remove unnecessary blank when calling kmalloc_array().
> 
> Signed-off-by: Xianting Tian <tian.xianting@h3c.com>

Thanks. I've added the patch to my tree.

								Honza

> ---
>  fs/ext2/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext2/super.c b/fs/ext2/super.c
> index 7fab2b3b5..551e69755 100644
> --- a/fs/ext2/super.c
> +++ b/fs/ext2/super.c
> @@ -1070,7 +1070,7 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
>  					/ EXT2_BLOCKS_PER_GROUP(sb)) + 1;
>  	db_count = (sbi->s_groups_count + EXT2_DESC_PER_BLOCK(sb) - 1) /
>  		   EXT2_DESC_PER_BLOCK(sb);
> -	sbi->s_group_desc = kmalloc_array (db_count,
> +	sbi->s_group_desc = kmalloc_array(db_count,
>  					   sizeof(struct buffer_head *),
>  					   GFP_KERNEL);
>  	if (sbi->s_group_desc == NULL) {
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
