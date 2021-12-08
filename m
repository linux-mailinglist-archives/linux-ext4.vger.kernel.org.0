Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC9246D5DB
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Dec 2021 15:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbhLHOkz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Dec 2021 09:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbhLHOky (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Dec 2021 09:40:54 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68473C061746;
        Wed,  8 Dec 2021 06:37:22 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id r11so8946971edd.9;
        Wed, 08 Dec 2021 06:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QvvZ2fkysQ5rF8RYcRn/4oTATeY96pP6kNxCUPgpnUY=;
        b=it+aj+VQqF5zZSzChLCl8+vf54hQKFdHIMMcA66ftcNDEVDJOfhGY2C3XOWrqVGS3r
         0XJ2C/vQ3Jd5tQ9dCvuKFiLnZ14z25DGIdI8YEzcjg73+c0xxfNQvkV/URXaOLVus6AI
         h8i5ou/luPEvtA9xCiKzhd3/eqUqwOO802NRBV3bule+9QIwRizZLkgq0jHTlntzs7r6
         sHqkuZr5E5NpKmOtcU8uMEiEWWgZq549It6vaRSry39v6baDXylwQG/OPZ/i9YRhBVb2
         FEGbG1SxTBKDYQofaysUePqqzJUyw7s6L2LEUHBCsbfGfbPJpLpbjcLCqO3omL+MiShq
         p/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QvvZ2fkysQ5rF8RYcRn/4oTATeY96pP6kNxCUPgpnUY=;
        b=PdTQYkYItncCHyllKp6FoVq9E05MBEU6Kj4P5pZNW7drgoaMAPIXwwMtnq1A86lnc1
         RqSWwKd0dBCBw7Dz4UG3ZIXDDcy/W1/XOoSoFbL7nkpI9Hoo6dvuV/3wneFTL8jln6eK
         wmlLVVwV6h4GCeiON4L7+AH7+zMyvlPrf+I53+Swn71cnwxC4vFwOVQsDrdt+WUfJ5qH
         ACJfbFJg0ObszxqWOWaklrpYJQBurh2PZklY5ujNvD7UecFf3pwyuuY8BQrOE+y/40Wo
         qv6Q35CbwjK4cUhIMiIQ61UkrBns+bWcugprSPXZlbL7BrynEQ0wWumaLHUCMV6Ol2kY
         /Knw==
X-Gm-Message-State: AOAM530qeDPlQTxs/B+ece+eCLxBrzVKQ6mWBQ4Kvvx0AUDs+Y2nGu6G
        r63t/s54RmdYTDWSGf+G1hhyPYNAFBu6skqb0zlIRCGH2LhcJnAjm70=
X-Google-Smtp-Source: ABdhPJwPdc8KUsRkGH2HocpMgPNNS/SorjtPfNiFwMWwgaMEH3w+0JQmpxQo+j5VVX2Jih0+ABuw7eSqWOZUW4EeHvc=
X-Received: by 2002:a17:906:b1c6:: with SMTP id bv6mr7862301ejb.30.1638974239905;
 Wed, 08 Dec 2021 06:37:19 -0800 (PST)
MIME-Version: 1.0
References: <20211124110308.2053-1-urezki@gmail.com> <20211124110308.2053-3-urezki@gmail.com>
In-Reply-To: <20211124110308.2053-3-urezki@gmail.com>
From:   Uladzislau Rezki <urezki@gmail.com>
Date:   Wed, 8 Dec 2021 15:37:07 +0100
Message-ID: <CA+KHdyXK7P6WrAEY516CPq6Cx7Qp_udnb7Je2wj_xkX4pud5Bg@mail.gmail.com>
Subject: Re: [PATCH 2/9] ext4: Replace ext4_kvfree_array_rcu() by kvfree_rcu() API
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

+ linux-ext4@vger.kernel.org

On Wed, Nov 24, 2021 at 12:03 PM Uladzislau Rezki (Sony)
<urezki@gmail.com> wrote:
>
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
> CC: "Theodore Ts'o" <tytso@mit.edu>
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
>                                 struct ext4_new_group_data *input);
>  extern int ext4_group_extend(struct super_block *sb,
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 215b7068f548..b0469f7a5c55 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3109,7 +3109,7 @@ int ext4_mb_alloc_groupinfo(struct super_block *sb, ext4_group_t ngroups)
>         rcu_assign_pointer(sbi->s_group_info, new_groupinfo);
>         sbi->s_group_info_size = size / sizeof(*sbi->s_group_info);
>         if (old_groupinfo)
> -               ext4_kvfree_array_rcu(old_groupinfo);
> +               kvfree_rcu(old_groupinfo);
>         ext4_debug("allocated s_groupinfo array for %d meta_bg's\n",
>                    sbi->s_group_info_size);
>         return 0;
> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
> index b63cb88ccdae..ac6aa037aaab 100644
> --- a/fs/ext4/resize.c
> +++ b/fs/ext4/resize.c
> @@ -17,33 +17,6 @@
>
>  #include "ext4_jbd2.h"
>
> -struct ext4_rcu_ptr {
> -       struct rcu_head rcu;
> -       void *ptr;
> -};
> -
> -static void ext4_rcu_ptr_callback(struct rcu_head *head)
> -{
> -       struct ext4_rcu_ptr *ptr;
> -
> -       ptr = container_of(head, struct ext4_rcu_ptr, rcu);
> -       kvfree(ptr->ptr);
> -       kfree(ptr);
> -}
> -
> -void ext4_kvfree_array_rcu(void *to_free)
> -{
> -       struct ext4_rcu_ptr *ptr = kzalloc(sizeof(*ptr), GFP_KERNEL);
> -
> -       if (ptr) {
> -               ptr->ptr = to_free;
> -               call_rcu(&ptr->rcu, ext4_rcu_ptr_callback);
> -               return;
> -       }
> -       synchronize_rcu();
> -       kvfree(to_free);
> -}
> -
>  int ext4_resize_begin(struct super_block *sb)
>  {
>         struct ext4_sb_info *sbi = EXT4_SB(sb);
> @@ -906,7 +879,7 @@ static int add_new_gdb(handle_t *handle, struct inode *inode,
>         n_group_desc[gdb_num] = gdb_bh;
>         rcu_assign_pointer(EXT4_SB(sb)->s_group_desc, n_group_desc);
>         EXT4_SB(sb)->s_gdb_count++;
> -       ext4_kvfree_array_rcu(o_group_desc);
> +       kvfree_rcu(o_group_desc);
>
>         lock_buffer(EXT4_SB(sb)->s_sbh);
>         le16_add_cpu(&es->s_reserved_gdt_blocks, -1);
> @@ -969,7 +942,7 @@ static int add_new_gdb_meta_bg(struct super_block *sb,
>
>         rcu_assign_pointer(EXT4_SB(sb)->s_group_desc, n_group_desc);
>         EXT4_SB(sb)->s_gdb_count++;
> -       ext4_kvfree_array_rcu(o_group_desc);
> +       kvfree_rcu(o_group_desc);
>         return err;
>  }
>
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 111b0498a232..3942cd271a00 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -2759,7 +2759,7 @@ int ext4_alloc_flex_bg_array(struct super_block *sb, ext4_group_t ngroup)
>         rcu_assign_pointer(sbi->s_flex_groups, new_groups);
>         sbi->s_flex_groups_allocated = size;
>         if (old_groups)
> -               ext4_kvfree_array_rcu(old_groups);
> +               kvfree_rcu(old_groups);
>         return 0;
>  }
>
> --
> 2.30.2
>


-- 
Uladzislau Rezki
