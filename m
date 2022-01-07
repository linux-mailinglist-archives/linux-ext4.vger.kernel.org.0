Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D095487DC0
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Jan 2022 21:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiAGUaX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Jan 2022 15:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiAGUaX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Jan 2022 15:30:23 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D5CC061574;
        Fri,  7 Jan 2022 12:30:23 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id f138so7083727qke.10;
        Fri, 07 Jan 2022 12:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oxt0eIg8WOWqzr1Wvc47sjlkwjKTbcvz5tPDW7K7PCA=;
        b=IC0xjhYbX1gOQUeYk7rtmhxNJqpKK+philqpK33mH8DO0/XvRQkrpv07e7K+FPtA2v
         HnfVxv++xKqy3M9yhwZDDhjgkrdf2Vy5gNl8M7E794sTHybHNDJm64FyS80nO7P/mEay
         bc4byRmxhBM6onwLq2jEmbSuZOADMH1sh94Y/dxskNgXSiriKoYX2ZTL2z/KkMb+B0lD
         N22AjRA6wvkzMDURl/Y1Q20JRTQ2Wy73f7hSPzS6F09olEc9Jg9Krf2idodP3n160eee
         xJXFrnIfYkroFOMTAneC7bOFkA7OWASpRcppDqtGhHTasnnInI9pqQ6TkqkM9qMuMyv7
         n2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oxt0eIg8WOWqzr1Wvc47sjlkwjKTbcvz5tPDW7K7PCA=;
        b=Z7HdCBKWDvuCDSGVo6+geUMIxn8Ibx6EwIEapE1HY3W+q7pN7lqV8Kf5Gxj4WC4D/K
         Sv5yY1tLVSMen7N8+Gn5I8VQTGOUaSEb6AgE++OCNaE01CjuWqfEva2uhqhXIE+ZGEBi
         0/5Oq4J5tIhlszSbMBNBjgmU6X9somCPCpoZn4JqqFBYEb+Y8phv0sDiGf0DxoXR72td
         8pwK99zGBMmdY78oUCnn+F+Uvc+g9L5S5Dkr6JwE9/CZuZ/okukx8YfaAAHzPMxxDdyn
         N03TzqC61nbsAiFQcHNa5PQf9Y8p80khgSFF+UeR6NueIY9u+iI9PXSOK1//XIY6C7pQ
         qtvQ==
X-Gm-Message-State: AOAM531kcwjiUwCybeM0oNZ3o6Yxds1wtP8TtUDfdAurwvD19Ji/0ebV
        Ci61aQkHKUkdIhhpIXz6zXKfPZVi0Q6Cn8KtI/0=
X-Google-Smtp-Source: ABdhPJxE37D0HmQ9b7ptTsWBM7YaFKJB5tVsmVXKQaLYYefU294E+/O4E/doEllwWdUc6slrSFJj0brYVxbToj+11fg=
X-Received: by 2002:a05:620a:4588:: with SMTP id bp8mr2281407qkb.556.1641587422294;
 Fri, 07 Jan 2022 12:30:22 -0800 (PST)
MIME-Version: 1.0
References: <20220106024518.8161-1-yinxin.x@bytedance.com> <20220106024518.8161-3-yinxin.x@bytedance.com>
In-Reply-To: <20220106024518.8161-3-yinxin.x@bytedance.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Fri, 7 Jan 2022 12:30:11 -0800
Message-ID: <CAD+ocbzTrYxtt6SBmzGBK3QvP+-oAtKwy4AfpPP7V-RQCgxfiA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ext4: modify the logic of ext4_mb_new_blocks_simple
To:     Xin Yin <yinxin.x@bytedance.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Looks good to me.

Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

On Wed, Jan 5, 2022 at 6:45 PM Xin Yin <yinxin.x@bytedance.com> wrote:
>
> for now in ext4_mb_new_blocks_simple, if we found a block which
> should be excluded then will switch to next group, this may
> probably cause 'group' run out of range.
>
> change to check next block in the same group when get a block should
> be excluded. Also change the searche range to EXT4_CLUSTERS_PER_GROUP
> and add error checking.
>
> Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
> ---
>  fs/ext4/mballoc.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 215b7068f548..31a00b473f3e 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -5757,7 +5757,8 @@ static ext4_fsblk_t ext4_mb_new_blocks_simple(handle_t *handle,
>         struct super_block *sb = ar->inode->i_sb;
>         ext4_group_t group;
>         ext4_grpblk_t blkoff;
> -       int i = sb->s_blocksize;
> +       ext4_grpblk_t max = EXT4_CLUSTERS_PER_GROUP(sb);
> +       ext4_grpblk_t i = 0;
>         ext4_fsblk_t goal, block;
>         struct ext4_super_block *es = EXT4_SB(sb)->s_es;
>
> @@ -5779,19 +5780,26 @@ static ext4_fsblk_t ext4_mb_new_blocks_simple(handle_t *handle,
>                 ext4_get_group_no_and_offset(sb,
>                         max(ext4_group_first_block_no(sb, group), goal),
>                         NULL, &blkoff);
> -               i = mb_find_next_zero_bit(bitmap_bh->b_data, sb->s_blocksize,
> +               while (1) {
> +                       i = mb_find_next_zero_bit(bitmap_bh->b_data, max,
>                                                 blkoff);
> +                       if (i >= max)
> +                               break;
> +                       if (ext4_fc_replay_check_excluded(sb,
> +                               ext4_group_first_block_no(sb, group) + i)) {
> +                               blkoff = i + 1;
> +                       } else
> +                               break;
> +               }
>                 brelse(bitmap_bh);
> -               if (i >= sb->s_blocksize)
> -                       continue;
> -               if (ext4_fc_replay_check_excluded(sb,
> -                       ext4_group_first_block_no(sb, group) + i))
> -                       continue;
> -               break;
> +               if (i < max)
> +                       break;
>         }
>
> -       if (group >= ext4_get_groups_count(sb) && i >= sb->s_blocksize)
> +       if (group >= ext4_get_groups_count(sb) || i >= max) {
> +               *errp = -ENOSPC;
>                 return 0;
> +       }
>
>         block = ext4_group_first_block_no(sb, group) + i;
>         ext4_mb_mark_bb(sb, block, 1, 1);
> --
> 2.20.1
>
