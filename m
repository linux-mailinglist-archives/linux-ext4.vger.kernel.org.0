Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F88405BA5
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Sep 2021 19:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239608AbhIIRCR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Sep 2021 13:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239072AbhIIRCQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 9 Sep 2021 13:02:16 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D62AC061574
        for <linux-ext4@vger.kernel.org>; Thu,  9 Sep 2021 10:01:07 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a25so4982515ejv.6
        for <linux-ext4@vger.kernel.org>; Thu, 09 Sep 2021 10:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=joo0flf3a6mQlTE3QpogIhG9kiS6TzK8iKq3QtVsV+Q=;
        b=Jbs5MCDQbXJ8W5kF1pgtBHDwJCfxZjSHclpArfz3D+ZN5gGzYDMeiJcXd719A6hoaq
         nQTGfLGHXXYf+/yJghHjf3Kf1BJop3G24QlqGgag8+VKiZd2AFkDZSXPLmRM0qRRyrXR
         +Vp3ry/EXvFPE8HDWIUE1qMV1POfPPzeFXAMIO9mVq5jYx5cwFTG3r7kuWQbA5cUDsqs
         PkKCkB11jk7df61UbuzLHMH5V3uwYL+ArUe3Qs2R4FEroV6z0tED2sbgklK+M4XMb50o
         4ygr299dtpHXm6mhEdzp4DM7B7jVr+L9/nLgFw8uibRbnl61PLd5Els8RTvcE1XpS1nS
         nmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=joo0flf3a6mQlTE3QpogIhG9kiS6TzK8iKq3QtVsV+Q=;
        b=NT8cjB5yYM1lVwVS7O66rNL0sCc9bk9G9tybH/jhNxkPDLrOoZtwRTbF7yy0QEG5mX
         hbBsk6aWKHG4cAk8AqCf7mqCf2uUY6DrHjv2uAQALb/PMwv6gS7Al8zk15H19h+AVZJY
         4xsZqhe9xgXDPK84RhIbj+NlcAX1xKSTwsg21syrmkSQD4PpCvcXWArJLSh2oc9/NWzX
         RF+oN/ObvyJVEi7KklYjD0Cg4jp+P+MKo3iuEl0AD198PDZFWUVSIzXQozfNwGUQiN65
         hDHZIi6MlSNt+iVBnSHVfdZl/rOPf6tpTMasmJVgt+V96W0TN922plrY1xPJdK6PqGa2
         mVCA==
X-Gm-Message-State: AOAM533cBm4gfcueBrPiRSXf/hU1m6Sc+2FhKHbWWnwYW8SHJ42eGqJn
        Gj7jjBAhG2fHHbRYt8FrvfLNWOUULhpxjF9breY=
X-Google-Smtp-Source: ABdhPJyIlauo1toK9iZOYo1FvaE5NpozwNvFr6LDkIR4htccONY/Hwq0PEmDgjpArPAiOmK7sLvCjdkDI05lkhh2W5g=
X-Received: by 2002:a17:906:15cf:: with SMTP id l15mr4492342ejd.568.1631206865470;
 Thu, 09 Sep 2021 10:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210902155108.381962-1-tytso@mit.edu>
In-Reply-To: <20210902155108.381962-1-tytso@mit.edu>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Thu, 9 Sep 2021 10:00:54 -0700
Message-ID: <CAD+ocbynsXNggvwq5XQcw=7bL4RS20pHifgbk9qznwxvP-ixCw@mail.gmail.com>
Subject: Re: [PATCH] ext4: add error checking to ext4_ext_replay_set_iblocks()
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks for the patch Ted. Looks good to me.

Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

On Thu, Sep 2, 2021 at 8:51 AM Theodore Ts'o <tytso@mit.edu> wrote:
>
> If the call to ext4_map_blocks() fails due to an corrupted file
> system, ext4_ext_replay_set_iblocks() can get stuck in an infinite
> loop.  This could be reproduced by running generic/526 with a file
> system that has inline_data and fast_commit enabled.  The system will
> repeatedly log to the console:
>
> EXT4-fs warning (device dm-3): ext4_block_to_path:105: block 1074800922 > max in inode 131076
>
> and the stack that it gets stuck in is:
>
>    ext4_block_to_path+0xe3/0x130
>    ext4_ind_map_blocks+0x93/0x690
>    ext4_map_blocks+0x100/0x660
>    skip_hole+0x47/0x70
>    ext4_ext_replay_set_iblocks+0x223/0x440
>    ext4_fc_replay_inode+0x29e/0x3b0
>    ext4_fc_replay+0x278/0x550
>    do_one_pass+0x646/0xc10
>    jbd2_journal_recover+0x14a/0x270
>    jbd2_journal_load+0xc4/0x150
>    ext4_load_journal+0x1f3/0x490
>    ext4_fill_super+0x22d4/0x2c00
>
> With this patch, generic/526 still fails, but system is no longer
> locking up in a tight loop.  It's likely the root casue is that
> fast_commit replay is corrupting file systems with inline_data, and we
> probably need to add better error handling in the fast commit replay
> code path beyond what is done here, which essentially just breaks the
> infinite loop without reporting the to the higher levels of the code.
>
> Fixes: 8016E29F4362 ("ext4: fast commit recovery path")
> Cc: stable@kernel.org
> Cc: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  fs/ext4/extents.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index eb1dd4f024f2..e57019cc3601 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -5913,7 +5913,7 @@ void ext4_ext_replay_shrink_inode(struct inode *inode, ext4_lblk_t end)
>  }
>
>  /* Check if *cur is a hole and if it is, skip it */
> -static void skip_hole(struct inode *inode, ext4_lblk_t *cur)
> +static int skip_hole(struct inode *inode, ext4_lblk_t *cur)
>  {
>         int ret;
>         struct ext4_map_blocks map;
> @@ -5922,9 +5922,12 @@ static void skip_hole(struct inode *inode, ext4_lblk_t *cur)
>         map.m_len = ((inode->i_size) >> inode->i_sb->s_blocksize_bits) - *cur;
>
>         ret = ext4_map_blocks(NULL, inode, &map, 0);
> +       if (ret < 0)
> +               return ret;
>         if (ret != 0)
> -               return;
> +               return 0;
>         *cur = *cur + map.m_len;
> +       return 0;
>  }
>
>  /* Count number of blocks used by this inode and update i_blocks */
> @@ -5973,7 +5976,9 @@ int ext4_ext_replay_set_iblocks(struct inode *inode)
>          * iblocks by total number of differences found.
>          */
>         cur = 0;
> -       skip_hole(inode, &cur);
> +       ret = skip_hole(inode, &cur);
> +       if (ret < 0)
> +               goto out;
>         path = ext4_find_extent(inode, cur, NULL, 0);
>         if (IS_ERR(path))
>                 goto out;
> @@ -5992,8 +5997,12 @@ int ext4_ext_replay_set_iblocks(struct inode *inode)
>                 }
>                 cur = max(cur + 1, le32_to_cpu(ex->ee_block) +
>                                         ext4_ext_get_actual_len(ex));
> -               skip_hole(inode, &cur);
> -
> +               ret = skip_hole(inode, &cur);
> +               if (ret < 0) {
> +                       ext4_ext_drop_refs(path);
> +                       kfree(path);
> +                       break;
> +               }
>                 path2 = ext4_find_extent(inode, cur, NULL, 0);
>                 if (IS_ERR(path2)) {
>                         ext4_ext_drop_refs(path);
> --
> 2.31.0
>
