Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42DB5135664
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Jan 2020 11:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729885AbgAIKAN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Jan 2020 05:00:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:39294 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729848AbgAIKAN (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 9 Jan 2020 05:00:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DF24169899;
        Thu,  9 Jan 2020 10:00:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 889BD1E0798; Thu,  9 Jan 2020 11:00:07 +0100 (CET)
Date:   Thu, 9 Jan 2020 11:00:07 +0100
From:   Jan Kara <jack@suse.cz>
To:     Naoto Kobayashi <naoto.kobayashi4c@gmail.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 2/3] ext4: Rename ext4_kvmalloc() to
 ext4_kvmalloc_nofs() and drop its flags argument
Message-ID: <20200109100007.GC27035@quack2.suse.cz>
References: <20191227080523.31808-1-naoto.kobayashi4c@gmail.com>
 <20191227080523.31808-3-naoto.kobayashi4c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191227080523.31808-3-naoto.kobayashi4c@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 27-12-19 17:05:22, Naoto Kobayashi wrote:
> Rename ext4_kvmalloc() to ext4_kvmalloc_nofs() and drop
> its flags argument, because ext4_kvmalloc() callers must be
> under GFP_NOFS (otherwise, they should use generic kvmalloc()
> helper function).
> 
> Signed-off-by: Naoto Kobayashi <naoto.kobayashi4c@gmail.com>

Thanks for the patch but I don't think this or the following patch is
actually needed. Did you ever see the deadlock with reclaim you mention in
the initial message with a recent kernel? The reason is that in all three
call sites of ext4_kvmalloc() in ext4 we have a transaction started (which
is the reason for GFP_NOFS there after all) but since commit 81378da64de
"jbd2: mark the transaction context with the scope GFP_NOFS context" the
transaction machinery takes care of updating reclaim context as needed...
So I'd be almost inclined to just drop 'flags' argument from
ext4_kvmalloc() instead and if we ever create a callsite for which current
memalloc_nofs machinery won't be enough, I'd rather extend that than
randomly sprinkle GFP_NOFS flags in the code.

								Honza

> ---
>  fs/ext4/ext4.h   |  2 +-
>  fs/ext4/resize.c | 10 ++++------
>  fs/ext4/super.c  |  6 +++---
>  fs/ext4/xattr.c  |  2 +-
>  4 files changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index b25089e3896d..e1bdeffca0ad 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2677,7 +2677,7 @@ extern struct buffer_head *ext4_sb_bread(struct super_block *sb,
>  extern int ext4_seq_options_show(struct seq_file *seq, void *offset);
>  extern int ext4_calculate_overhead(struct super_block *sb);
>  extern void ext4_superblock_csum_set(struct super_block *sb);
> -extern void *ext4_kvmalloc(size_t size, gfp_t flags);
> +extern void *ext4_kvmalloc_nofs(size_t size);
>  extern int ext4_alloc_flex_bg_array(struct super_block *sb,
>  				    ext4_group_t ngroup);
>  extern const char *ext4_decode_error(struct super_block *sb, int errno,
> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
> index a8c0f2b5b6e1..7998bbe66eed 100644
> --- a/fs/ext4/resize.c
> +++ b/fs/ext4/resize.c
> @@ -824,9 +824,8 @@ static int add_new_gdb(handle_t *handle, struct inode *inode,
>  	if (unlikely(err))
>  		goto errout;
> 
> -	n_group_desc = ext4_kvmalloc((gdb_num + 1) *
> -				     sizeof(struct buffer_head *),
> -				     GFP_NOFS);
> +	n_group_desc = ext4_kvmalloc_nofs((gdb_num + 1) *
> +				     sizeof(struct buffer_head *));
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
> +	n_group_desc = ext4_kvmalloc_nofs((gdb_num + 1) *
> +				     sizeof(struct buffer_head *));
>  	if (!n_group_desc) {
>  		brelse(gdb_bh);
>  		err = -ENOMEM;
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 83a231dedcbf..e8965aa6ecce 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -204,13 +204,13 @@ void ext4_superblock_csum_set(struct super_block *sb)
>  	es->s_checksum = ext4_superblock_csum(sb, es);
>  }
> 
> -void *ext4_kvmalloc(size_t size, gfp_t flags)
> +void *ext4_kvmalloc_nofs(size_t size)
>  {
>  	void *ret;
> 
> -	ret = kmalloc(size, flags | __GFP_NOWARN);
> +	ret = kmalloc(size, GFP_NOFS | __GFP_NOWARN);
>  	if (!ret)
> -		ret = __vmalloc(size, flags, PAGE_KERNEL);
> +		ret = __vmalloc(size, GFP_NOFS, PAGE_KERNEL);
>  	return ret;
>  }
> 
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 8966a5439a22..d5bc970ef331 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -1456,7 +1456,7 @@ ext4_xattr_inode_cache_find(struct inode *inode, const void *value,
>  	if (!ce)
>  		return NULL;
> 
> -	ea_data = ext4_kvmalloc(value_len, GFP_NOFS);
> +	ea_data = ext4_kvmalloc_nofs(value_len);
>  	if (!ea_data) {
>  		mb_cache_entry_put(ea_inode_cache, ce);
>  		return NULL;
> --
> 2.16.6
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
