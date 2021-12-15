Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E9B4761FA
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Dec 2021 20:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhLOTka (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Dec 2021 14:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhLOTka (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 Dec 2021 14:40:30 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10BBC061574;
        Wed, 15 Dec 2021 11:40:29 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 13so34818662ljj.11;
        Wed, 15 Dec 2021 11:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8HtAgUhr/NsiGqKq9VgMDhC8R9rDE1DfVxbnNun+dH8=;
        b=S/mLeu1UJTdOu5UTWcv2jQOYG/Z5fRndaHXfBTr2MjSRTsJEYJQzqTCeNyQIDyzMYb
         3RHvEK2EySGmD0ovvTKAV+004wUR1sWZUW4+GhHpusD8yfgbLQYB9m4rwPdz5/Rvr9mE
         3XCF7U9UyioGkn4i0fEwZkClnBWwZ8Gf9gMUbLK6+hMC8ySk075wPD+d2VeccDp6a/ke
         x/EGRVRgwZI/z+FohTFJGdm0C5fQgWa1Bd2wdQWGE1eOyTJvtVTeiVmfZ8hdkTJMaaN/
         As6vLEkL3J9+x1nzbMY63pLV7JZ9EbsIkhHY30rZiZ4dxiWmoOCUc3XfzUhPILirE5zb
         BiPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8HtAgUhr/NsiGqKq9VgMDhC8R9rDE1DfVxbnNun+dH8=;
        b=wmHJOeQIqq1U9ixfGXRyjlYTMOOAhExC7olJSKrCw6NMVmRYRwLsVwBm403Di0iIDt
         JBLQnJcYoRn7PFzyC9CYZTpk08g09OslNPPBt37h2weOcCu/+Pr9Ylrj2p5i8cXtkOti
         aZcOi4uaI+ustk8TXBGA4qfWGIJN53D7UQDuqS/RYQI2OzWefQfhPWBLAQMZWrOvvzzM
         i/NAhJKUD3AjdpnhzP5TrWTe5OL0VDIajyKVfIXwjirp8KsDyTzYc1ulHHXHfZtqmdqo
         vrA9uPvWh3yqsvYgb4tJw+8ukNupQzCkCHUnPyekYOVG4xNkiPxVLxk/CacaCNsfmcxA
         U0kA==
X-Gm-Message-State: AOAM530/1UQthqkQ7JlhJEaKvUMRtFp38qYx0TIWC6YtfDYGefo0eyWr
        dnO2aLNj/P9Cq56fj0sm4Qc=
X-Google-Smtp-Source: ABdhPJyRHySmqWpVFF6JU+B67GThGTAe/tyYhvgk9PzNlEOLyQHiSplDlcCt3qEGZ7jC0n6elYy7Yg==
X-Received: by 2002:a2e:a279:: with SMTP id k25mr11876627ljm.37.1639597228072;
        Wed, 15 Dec 2021 11:40:28 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id v8sm464263lfq.177.2021.12.15.11.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 11:40:27 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Wed, 15 Dec 2021 20:40:25 +0100
To:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH RESEND] ext4: Replace ext4_kvfree_array_rcu() by
 kvfree_rcu() API
Message-ID: <YbpEqWAH6r1Dz8HC@pc638.lan>
References: <20211215111845.2514-1-urezki@gmail.com>
 <20211215111845.2514-2-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215111845.2514-2-urezki@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Dec 15, 2021 at 12:18:38PM +0100, Uladzislau Rezki (Sony) wrote:
> The ext4_kvfree_array_rcu() function was introduced in order to
> release some memory after a grace period during resizing of a
> partition. An object that is freed does not contain any rcu_head
> filed.
> 
> To do so, it requires to allocate some extra memory for a special
> structure that has an rcu_head filed and pointer one where a freed
> memory is attached. Finally call_rcu() API is invoked.
> 
> Since we have a single argument of kvfree_rcu() API, we can easily
> replace all that tricky code by one single call that does the same
> but in more efficient way.
> 
> TO: "Theodore Ts'o" <tytso@mit.edu>
> TO: linux-ext4@vger.kernel.org
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  fs/ext4/ext4.h    |  1 -
>  fs/ext4/mballoc.c |  2 +-
>  fs/ext4/resize.c  | 31 ++-----------------------------
>  fs/ext4/super.c   |  2 +-
>  4 files changed, 4 insertions(+), 32 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 404dd50856e5..7e8ff3ac2beb 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3089,7 +3089,6 @@ extern int ext4_generic_delete_entry(struct inode *dir,
>  extern bool ext4_empty_dir(struct inode *inode);
>  
>  /* resize.c */
> -extern void ext4_kvfree_array_rcu(void *to_free);
>  extern int ext4_group_add(struct super_block *sb,
>  				struct ext4_new_group_data *input);
>  extern int ext4_group_extend(struct super_block *sb,
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 215b7068f548..b0469f7a5c55 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3109,7 +3109,7 @@ int ext4_mb_alloc_groupinfo(struct super_block *sb, ext4_group_t ngroups)
>  	rcu_assign_pointer(sbi->s_group_info, new_groupinfo);
>  	sbi->s_group_info_size = size / sizeof(*sbi->s_group_info);
>  	if (old_groupinfo)
> -		ext4_kvfree_array_rcu(old_groupinfo);
> +		kvfree_rcu(old_groupinfo);
>  	ext4_debug("allocated s_groupinfo array for %d meta_bg's\n",
>  		   sbi->s_group_info_size);
>  	return 0;
> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
> index b63cb88ccdae..ac6aa037aaab 100644
> --- a/fs/ext4/resize.c
> +++ b/fs/ext4/resize.c
> @@ -17,33 +17,6 @@
>  
>  #include "ext4_jbd2.h"
>  
> -struct ext4_rcu_ptr {
> -	struct rcu_head rcu;
> -	void *ptr;
> -};
> -
> -static void ext4_rcu_ptr_callback(struct rcu_head *head)
> -{
> -	struct ext4_rcu_ptr *ptr;
> -
> -	ptr = container_of(head, struct ext4_rcu_ptr, rcu);
> -	kvfree(ptr->ptr);
> -	kfree(ptr);
> -}
> -
> -void ext4_kvfree_array_rcu(void *to_free)
> -{
> -	struct ext4_rcu_ptr *ptr = kzalloc(sizeof(*ptr), GFP_KERNEL);
> -
> -	if (ptr) {
> -		ptr->ptr = to_free;
> -		call_rcu(&ptr->rcu, ext4_rcu_ptr_callback);
> -		return;
> -	}
> -	synchronize_rcu();
> -	kvfree(to_free);
> -}
> -
>  int ext4_resize_begin(struct super_block *sb)
>  {
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
> @@ -906,7 +879,7 @@ static int add_new_gdb(handle_t *handle, struct inode *inode,
>  	n_group_desc[gdb_num] = gdb_bh;
>  	rcu_assign_pointer(EXT4_SB(sb)->s_group_desc, n_group_desc);
>  	EXT4_SB(sb)->s_gdb_count++;
> -	ext4_kvfree_array_rcu(o_group_desc);
> +	kvfree_rcu(o_group_desc);
>  
>  	lock_buffer(EXT4_SB(sb)->s_sbh);
>  	le16_add_cpu(&es->s_reserved_gdt_blocks, -1);
> @@ -969,7 +942,7 @@ static int add_new_gdb_meta_bg(struct super_block *sb,
>  
>  	rcu_assign_pointer(EXT4_SB(sb)->s_group_desc, n_group_desc);
>  	EXT4_SB(sb)->s_gdb_count++;
> -	ext4_kvfree_array_rcu(o_group_desc);
> +	kvfree_rcu(o_group_desc);
>  	return err;
>  }
>  
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 111b0498a232..3942cd271a00 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -2759,7 +2759,7 @@ int ext4_alloc_flex_bg_array(struct super_block *sb, ext4_group_t ngroup)
>  	rcu_assign_pointer(sbi->s_flex_groups, new_groups);
>  	sbi->s_flex_groups_allocated = size;
>  	if (old_groups)
> -		ext4_kvfree_array_rcu(old_groups);
> +		kvfree_rcu(old_groups);
>  	return 0;
>  }
>  
> -- 
> 2.30.2
> 
+ "Theodore Ts'o" <tytso@mit.edu>
+ linux-ext4@vger.kernel.org

--
Vlad Rezki
