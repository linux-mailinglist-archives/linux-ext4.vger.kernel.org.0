Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 765101407FB
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jan 2020 11:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgAQKaw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Jan 2020 05:30:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:40132 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbgAQKav (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 17 Jan 2020 05:30:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 49C5CABBD;
        Fri, 17 Jan 2020 10:30:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 979461E0D53; Fri, 17 Jan 2020 11:30:48 +0100 (CET)
Date:   Fri, 17 Jan 2020 11:30:48 +0100
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>, jack@suse.cz,
        naoto.kobayashi4c@gmail.com
Subject: Re: [PATCH] ext4: drop ext4_kvmalloc()
Message-ID: <20200117103048.GB17141@quack2.suse.cz>
References: <20200116151239.GA253859@mit.edu>
 <20200116155031.266620-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116155031.266620-1-tytso@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 16-01-20 10:50:31, Theodore Ts'o wrote:
> As Jan pointed out[1], as of commit 81378da64de ("jbd2: mark the
> transaction context with the scope GFP_NOFS context") we use
> memalloc_nofs_{save,restore}() while a jbd2 handle is active.  So
> ext4_kvmalloc() so we can call allocate using GFP_NOFS is no longer
> necessary.
> 
> [1] https://lore.kernel.org/r/20200109100007.GC27035@quack2.suse.cz

Your signed-off-by is missing but otherwise the patch looks good to me. You
can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h   |  1 -
>  fs/ext4/resize.c | 10 ++++------
>  fs/ext4/super.c  | 10 ----------
>  fs/ext4/xattr.c  |  2 +-
>  4 files changed, 5 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 5e621b0da4da..9a2ee2428ecc 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2740,7 +2740,6 @@ extern struct buffer_head *ext4_sb_bread(struct super_block *sb,
>  extern int ext4_seq_options_show(struct seq_file *seq, void *offset);
>  extern int ext4_calculate_overhead(struct super_block *sb);
>  extern void ext4_superblock_csum_set(struct super_block *sb);
> -extern void *ext4_kvmalloc(size_t size, gfp_t flags);
>  extern int ext4_alloc_flex_bg_array(struct super_block *sb,
>  				    ext4_group_t ngroup);
>  extern const char *ext4_decode_error(struct super_block *sb, int errno,
> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
> index a8c0f2b5b6e1..86a2500ed292 100644
> --- a/fs/ext4/resize.c
> +++ b/fs/ext4/resize.c
> @@ -824,9 +824,8 @@ static int add_new_gdb(handle_t *handle, struct inode *inode,
>  	if (unlikely(err))
>  		goto errout;
>  
> -	n_group_desc = ext4_kvmalloc((gdb_num + 1) *
> -				     sizeof(struct buffer_head *),
> -				     GFP_NOFS);
> +	n_group_desc = kvmalloc((gdb_num + 1) * sizeof(struct buffer_head *),
> +				GFP_KERNEL);
>  	if (!n_group_desc) {
>  		err = -ENOMEM;
>  		ext4_warning(sb, "not enough memory for %lu groups",
> @@ -900,9 +899,8 @@ static int add_new_gdb_meta_bg(struct super_block *sb,
>  	gdb_bh = ext4_sb_bread(sb, gdblock, 0);
>  	if (IS_ERR(gdb_bh))
>  		return PTR_ERR(gdb_bh);
> -	n_group_desc = ext4_kvmalloc((gdb_num + 1) *
> -				     sizeof(struct buffer_head *),
> -				     GFP_NOFS);
> +	n_group_desc = kvmalloc((gdb_num + 1) * sizeof(struct buffer_head *),
> +				GFP_KERNEL);
>  	if (!n_group_desc) {
>  		brelse(gdb_bh);
>  		err = -ENOMEM;
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 84a86d9b790f..ecf36a23e0c4 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -204,16 +204,6 @@ void ext4_superblock_csum_set(struct super_block *sb)
>  	es->s_checksum = ext4_superblock_csum(sb, es);
>  }
>  
> -void *ext4_kvmalloc(size_t size, gfp_t flags)
> -{
> -	void *ret;
> -
> -	ret = kmalloc(size, flags | __GFP_NOWARN);
> -	if (!ret)
> -		ret = __vmalloc(size, flags, PAGE_KERNEL);
> -	return ret;
> -}
> -
>  ext4_fsblk_t ext4_block_bitmap(struct super_block *sb,
>  			       struct ext4_group_desc *bg)
>  {
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 246fbeeb6366..8cac7d95c3ad 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -1456,7 +1456,7 @@ ext4_xattr_inode_cache_find(struct inode *inode, const void *value,
>  	if (!ce)
>  		return NULL;
>  
> -	ea_data = ext4_kvmalloc(value_len, GFP_NOFS);
> +	ea_data = kvmalloc(value_len, GFP_KERNEL);
>  	if (!ea_data) {
>  		mb_cache_entry_put(ea_inode_cache, ce);
>  		return NULL;
> -- 
> 2.24.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
