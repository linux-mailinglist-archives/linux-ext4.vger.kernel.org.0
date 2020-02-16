Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 300821603F6
	for <lists+linux-ext4@lfdr.de>; Sun, 16 Feb 2020 13:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgBPMMw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 16 Feb 2020 07:12:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:53934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728054AbgBPMMw (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 16 Feb 2020 07:12:52 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [12.246.51.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D91EE2084E;
        Sun, 16 Feb 2020 12:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581855170;
        bh=01/2FLld32dbQDoXLq9J71ZaKVQH4uAeZROUYE6c+ks=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=MLaT2R3tJToNnkr8CfHLaBhSNHxJyHVU+mpVrVQk1Zhd1rE+dV0+F39GBD1LdL7B0
         GFA0HjkMwQmSgzLU/rJA9VJ5cD/7YXLvER5f31RABmQjZDB5xwKX62RmSztOPn0hEX
         HDdARkZ9+og9NB9TOyaEXZEyrXoTvPaTPhoA3Mg0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4B11A3520D7D; Sun, 16 Feb 2020 04:12:46 -0800 (PST)
Date:   Sun, 16 Feb 2020 04:12:46 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Suraj Jitindar Singh <surajjs@amazon.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH RFC] ext4: fix potential race between online resizing and
 write operations
Message-ID: <20200216121246.GG2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200215233817.GA670792@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200215233817.GA670792@mit.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Feb 15, 2020 at 06:38:17PM -0500, Theodore Y. Ts'o wrote:
> This is a revision of a proposed patch[1] to fix a bug[2] to fix a
> reported crash caused by the fact that we are growing an array, it's
> possible for another process to try to dereference that array, get the
> old copy of the array, and then before it fetch an element of the
> array and use it, it could get reused for something else.
> 
> [1] https://bugzilla.kernel.org/attachment.cgi?id=287189
> [2] https://bugzilla.kernel.org/show_bug.cgi?id=206443
> 
> So this is a pretty classical case of RCU, and in the original version
> of the patch[1], it used synchronize_rcu_expedited() followed by a
> call kvfree().  If you read the RCU documentation it states that you
> really shouldn't call synchronize_rcu() and kfree() in a loop, and
> while synchronize_rcu_expedited() does speed things up, it does so by
> impacting the performance of all the other CPU's.
> 
> And unfortunately add_new_gdb() get's called in a loop.  If you expand
> a file system by say, 1TB, add_new_gdb() and/or add_new_gdb_meta_gb()
> will get called 8,192 times.
> 
> To fix this, I added ext4_kvfree_array_rcu() which allocates an object
> containing a void *ptr and the rcu_head, and then uses call_rcu() to
> free the pointer and the stub object.  I'm cc'ing Paul because I'm a
> bit surprised no one else has needed something like this before; so
> I'm wondering if I'm missing something.  If not, would it make sense
> to make something like kvfree_array_rcu as a more general facility?

Good point!

Now that kfree_rcu() is on its way to being less of a hack deeply
entangled into the bowels of RCU, this might be fairly easy to implement.
It might well be simply a matter of a function pointer and a kvfree_rcu()
API.  Adding Uladzislau Rezki and Joel Fernandez on CC for their thoughts.

							Thanx, Paul

> >From 5ab7e4d38318c125246a4aa899dd614a37c803ef Mon Sep 17 00:00:00 2001
> From: Theodore Ts'o <tytso@mit.edu>
> Date: Sat, 15 Feb 2020 16:40:37 -0500
> Subject: [PATCH] ext4: fix potential race between online resizing and write operations
> 
> During an online resize an array of pointers to buffer heads gets
> replaced so it can get enlarged.  If there is a racing block
> allocation or deallocation which uses the old array, and the old array
> has gotten reused this can lead to a GPF or some other random kernel
> memory getting modified.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206443
> Reported-by: Suraj Jitindar Singh <surajjs@amazon.com>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> Cc: stable@kernel.org
> ---
>  fs/ext4/resize.c | 35 +++++++++++++++++++++++++++++++----
>  fs/ext4/balloc.c | 15 ++++++++++++---
>  fs/ext4/ext4.h   |  1 +
>  3 files changed, 44 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
> index 86a2500ed292..98d3b4ec3422 100644
> --- a/fs/ext4/resize.c
> +++ b/fs/ext4/resize.c
> @@ -17,6 +17,33 @@
>  
>  #include "ext4_jbd2.h"
>  
> +struct ext4_rcu_ptr {
> +	struct rcu_head rcu;
> +	void *ptr;
> +};
> +
> +static void ext4_rcu_ptr_callback(struct rcu_head *head)
> +{
> +	struct ext4_rcu_ptr *ptr;
> +
> +	ptr = container_of(head, struct ext4_rcu_ptr, rcu);
> +	kvfree(ptr->ptr);
> +	kfree(ptr);
> +}
> +
> +void ext4_kvfree_array_rcu(void *to_free)
> +{
> +	struct ext4_rcu_ptr *ptr = kzalloc(sizeof(*ptr), GFP_KERNEL);
> +
> +	if (ptr) {
> +		ptr->ptr = to_free;
> +		call_rcu(&ptr->rcu, ext4_rcu_ptr_callback);
> +		return;
> +	}
> +	synchronize_rcu();
> +	kvfree(ptr);
> +}
> +
>  int ext4_resize_begin(struct super_block *sb)
>  {
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
> @@ -864,9 +891,9 @@ static int add_new_gdb(handle_t *handle, struct inode *inode,
>  	memcpy(n_group_desc, o_group_desc,
>  	       EXT4_SB(sb)->s_gdb_count * sizeof(struct buffer_head *));
>  	n_group_desc[gdb_num] = gdb_bh;
> -	EXT4_SB(sb)->s_group_desc = n_group_desc;
> +	rcu_assign_pointer(EXT4_SB(sb)->s_group_desc, n_group_desc);
>  	EXT4_SB(sb)->s_gdb_count++;
> -	kvfree(o_group_desc);
> +	ext4_kvfree_array_rcu(o_group_desc);
>  
>  	le16_add_cpu(&es->s_reserved_gdt_blocks, -1);
>  	err = ext4_handle_dirty_super(handle, sb);
> @@ -922,9 +949,9 @@ static int add_new_gdb_meta_bg(struct super_block *sb,
>  		return err;
>  	}
>  
> -	EXT4_SB(sb)->s_group_desc = n_group_desc;
> +	rcu_assign_pointer(EXT4_SB(sb)->s_group_desc, n_group_desc);
>  	EXT4_SB(sb)->s_gdb_count++;
> -	kvfree(o_group_desc);
> +	ext4_kvfree_array_rcu(o_group_desc);
>  	return err;
>  }
>  
> diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
> index 5f993a411251..5368bf67300b 100644
> --- a/fs/ext4/balloc.c
> +++ b/fs/ext4/balloc.c
> @@ -270,6 +270,7 @@ struct ext4_group_desc * ext4_get_group_desc(struct super_block *sb,
>  	ext4_group_t ngroups = ext4_get_groups_count(sb);
>  	struct ext4_group_desc *desc;
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +	struct buffer_head *bh_p;
>  
>  	if (block_group >= ngroups) {
>  		ext4_error(sb, "block_group >= groups_count - block_group = %u,"
> @@ -280,7 +281,15 @@ struct ext4_group_desc * ext4_get_group_desc(struct super_block *sb,
>  
>  	group_desc = block_group >> EXT4_DESC_PER_BLOCK_BITS(sb);
>  	offset = block_group & (EXT4_DESC_PER_BLOCK(sb) - 1);
> -	if (!sbi->s_group_desc[group_desc]) {
> +	rcu_read_lock();
> +	bh_p = rcu_dereference(sbi->s_group_desc)[group_desc];
> +	/*
> +	 * We can unlock here since the pointer being dereferenced won't be
> +	 * dereferenced again. By looking at the usage in add_new_gdb() the
> +	 * value isn't modified, just the pointer, and so it remains valid.
> +	 */
> +	rcu_read_unlock();
> +	if (!bh_p) {
>  		ext4_error(sb, "Group descriptor not loaded - "
>  			   "block_group = %u, group_desc = %u, desc = %u",
>  			   block_group, group_desc, offset);
> @@ -288,10 +297,10 @@ struct ext4_group_desc * ext4_get_group_desc(struct super_block *sb,
>  	}
>  
>  	desc = (struct ext4_group_desc *)(
> -		(__u8 *)sbi->s_group_desc[group_desc]->b_data +
> +		(__u8 *)bh_p->b_data +
>  		offset * EXT4_DESC_SIZE(sb));
>  	if (bh)
> -		*bh = sbi->s_group_desc[group_desc];
> +		*bh = bh_p;
>  	return desc;
>  }
>  
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 4441331d06cc..b7824d56b968 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2730,8 +2730,8 @@ extern int ext4_generic_delete_entry(handle_t *handle,
>  extern bool ext4_empty_dir(struct inode *inode);
>  
>  /* resize.c */
> +extern void ext4_kvfree_array_rcu(void *to_free);
>  extern int ext4_group_add(struct super_block *sb,
>  				struct ext4_new_group_data *input);
>  extern int ext4_group_extend(struct super_block *sb,
> 
> -- 
> 2.24.1
> 
