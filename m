Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DF26BF6EC
	for <lists+linux-ext4@lfdr.de>; Sat, 18 Mar 2023 01:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjCRAbI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Mar 2023 20:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCRAbI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Mar 2023 20:31:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678DC3C7B5;
        Fri, 17 Mar 2023 17:31:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E47C660EDD;
        Sat, 18 Mar 2023 00:31:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E48C433D2;
        Sat, 18 Mar 2023 00:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679099465;
        bh=MfEFtAhXnCXN3yXbojWZKf2XyT2w1O8pFFHNP09wb3g=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=sVW18bjKf7Tg2NPuE3Y9OjFOiu7CbCSiJ82nUHzN5P2eMyiFqvPB4kSkZMhjLE/uj
         ScI7dZRvuBTv8/QG6ITVNTJsHCvnNJJYSi8C2ElbYUYF6mOg4b1cf22fDQSh7ladkN
         H6uSKPJDZcR2wWh8571jyUh+zcGiScFshODH1flJVCt/0aEeAHYw8dwX0BWRiTBqFq
         ufof641Otn81g4Aah2aMi3BPDhx2Karelxz0P2ziaVUMW5TreKdCKiQyM6DGXsrL76
         G+8NlGCRE/gc2ejnz7Hi+Zs66IZm1fvkRBXG7aaWihiU9IPQsww+Q7hFxMyYy9CpIY
         ygLktB2eMT2IA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D124D1540381; Fri, 17 Mar 2023 17:31:04 -0700 (PDT)
Date:   Fri, 17 Mar 2023 17:31:04 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-ext4@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: [PATCH 1/1] ext4: Replace ext4_kvfree_array_rcu() by
 kvfree_rcu_mightsleep()
Message-ID: <28e1585c-7062-49c2-b08e-a5d33ca06577@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230317071558.335645-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317071558.335645-1-urezki@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Mar 17, 2023 at 08:15:58AM +0100, Uladzislau Rezki (Sony) wrote:
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
> Cc: linux-ext4@vger.kernel.org
> Cc: Lukas Czerner <lczerner@redhat.com>
> Cc: Andreas Dilger <adilger.kernel@dilger.ca>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

From an RCU perspective:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  fs/ext4/ext4.h    |  1 -
>  fs/ext4/mballoc.c |  2 +-
>  fs/ext4/resize.c  | 31 ++-----------------------------
>  fs/ext4/super.c   |  2 +-
>  4 files changed, 4 insertions(+), 32 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 140e1eb300d1..e43d1a2d175e 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3057,7 +3057,6 @@ extern int ext4_generic_delete_entry(struct inode *dir,
>  extern bool ext4_empty_dir(struct inode *inode);
>  
>  /* resize.c */
> -extern void ext4_kvfree_array_rcu(void *to_free);
>  extern int ext4_group_add(struct super_block *sb,
>  				struct ext4_new_group_data *input);
>  extern int ext4_group_extend(struct super_block *sb,
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 5b2ae37a8b80..96b4e3317640 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3055,7 +3055,7 @@ int ext4_mb_alloc_groupinfo(struct super_block *sb, ext4_group_t ngroups)
>  	rcu_assign_pointer(sbi->s_group_info, new_groupinfo);
>  	sbi->s_group_info_size = size / sizeof(*sbi->s_group_info);
>  	if (old_groupinfo)
> -		ext4_kvfree_array_rcu(old_groupinfo);
> +		kvfree_rcu_mightsleep(old_groupinfo);
>  	ext4_debug("allocated s_groupinfo array for %d meta_bg's\n",
>  		   sbi->s_group_info_size);
>  	return 0;
> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
> index 6b91443d6bf3..330b81f36e10 100644
> --- a/fs/ext4/resize.c
> +++ b/fs/ext4/resize.c
> @@ -18,33 +18,6 @@
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
> @@ -931,7 +904,7 @@ static int add_new_gdb(handle_t *handle, struct inode *inode,
>  	n_group_desc[gdb_num] = gdb_bh;
>  	rcu_assign_pointer(EXT4_SB(sb)->s_group_desc, n_group_desc);
>  	EXT4_SB(sb)->s_gdb_count++;
> -	ext4_kvfree_array_rcu(o_group_desc);
> +	kvfree_rcu_mightsleep(o_group_desc);
>  
>  	lock_buffer(EXT4_SB(sb)->s_sbh);
>  	le16_add_cpu(&es->s_reserved_gdt_blocks, -1);
> @@ -994,7 +967,7 @@ static int add_new_gdb_meta_bg(struct super_block *sb,
>  
>  	rcu_assign_pointer(EXT4_SB(sb)->s_group_desc, n_group_desc);
>  	EXT4_SB(sb)->s_gdb_count++;
> -	ext4_kvfree_array_rcu(o_group_desc);
> +	kvfree_rcu_mightsleep(o_group_desc);
>  	return err;
>  }
>  
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 87aa23d047c9..34d802848d6d 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -3108,7 +3108,7 @@ int ext4_alloc_flex_bg_array(struct super_block *sb, ext4_group_t ngroup)
>  	rcu_assign_pointer(sbi->s_flex_groups, new_groups);
>  	sbi->s_flex_groups_allocated = size;
>  	if (old_groups)
> -		ext4_kvfree_array_rcu(old_groups);
> +		kvfree_rcu_mightsleep(old_groups);
>  	return 0;
>  }
>  
> -- 
> 2.30.2
> 
