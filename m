Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A865E479557
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Dec 2021 21:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238902AbhLQURh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Dec 2021 15:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbhLQURh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Dec 2021 15:17:37 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDEDC061574;
        Fri, 17 Dec 2021 12:17:36 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id t5so12420060edd.0;
        Fri, 17 Dec 2021 12:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ddHzoh2SnFa8Ihzb+s1Ks+vEv62gGgp3RT64mr1TiOs=;
        b=nm6etoeSk6CHFmb/wL67BYcuhQj0kqVTR2NQvPndqusV2IHv27Uw3CISU5zgHVbSkq
         iYDrY9OPFBm3DxggLHDLXjNaiWfNfbDuwjcjjvht+65dYsCKP2mlgWZfewBtMqNS/kfD
         quzYb6ZcjG/tYkC1I31jMoe6OQPXtUCCJH7PVxmcwZtG7+xidI82duVKBPaADMrfqBOB
         EXZ7DStRmWe/pLfKT4lQ9BuCOdBWaAFO/cjB7SfOH29keUnP5vVioPfG6ZfWg8m6ynLP
         hFtoPxz8y2tFFXbwB+FHe5fsuHx7fnCYk/fns6toIWyUjwsS/4Os+cR2RfirZfcy1HJS
         ljnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ddHzoh2SnFa8Ihzb+s1Ks+vEv62gGgp3RT64mr1TiOs=;
        b=2EpghhUcBx6S98tlsdc6Zs0s+LR7LyZSas1mIgxmJkCALSUDHpWpjA0zdWuQGyx77k
         VfUX0nf8BR71L9v7SffwIelf8KkoaDY+UNZnhHCbiurVh4Qsx0c9Xgvy8d4ma9qTbaox
         9HNi1g8RJIvxc2AjPX5rdwF+6ndsnioI9wg+7lSx7W9qACXJdCJa6eKkU2bDqxVLEC1T
         gJbk1W8CNe88mIzGXQaBoLUGte7gIKiR0FR1FeBnZkCGsE6MFUNuQxVcotB5ZX3dCHlx
         SYjensJn0GCZzD6ZjS/8JJdMc2c+XSI2wjYmHxdUBCrJ3zxXKepIvNmw59LkY/HGV/M5
         SByA==
X-Gm-Message-State: AOAM533z0Z0cBvHd0z6HbfTR4xQw5u8SnoLTLgMOWEtP286dUtrvpHnL
        D89y7IScNyyMjpLrpPXPB6hd0JhdU9HGW+gTCi5Yipd7
X-Google-Smtp-Source: ABdhPJxoKzRNJxkQskgEeclGY6VNdM1cP3+dRF29gXOjNOSevYLe5CcjKKvoE+mlIIRz73nehlvpUIIo9d+KDjHp4Zo=
X-Received: by 2002:a17:906:f283:: with SMTP id gu3mr3724576ejb.768.1639772255175;
 Fri, 17 Dec 2021 12:17:35 -0800 (PST)
MIME-Version: 1.0
References: <20211216080303.388139-1-yinxin.x@bytedance.com>
In-Reply-To: <20211216080303.388139-1-yinxin.x@bytedance.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Fri, 17 Dec 2021 12:17:24 -0800
Message-ID: <CAD+ocbzWryj6FnHR4naiBvNHN4WqyuGo_n-52J_42jpLVLeAew@mail.gmail.com>
Subject: Re: [PATCH] ext4: call fallocate may cause process to hang when using
 fast commit
To:     Xin Yin <yinxin.x@bytedance.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks for the patch Xin, it looks good to me. I think there are a few
other places where we are not stopping the transaction before calling
commit. I'm trying to find them out.

Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

On Thu, Dec 16, 2021 at 12:04 AM Xin Yin <yinxin.x@bytedance.com> wrote:
>
> If open a file with O_SYNC, and call fallocate with mode=0.when using
> fast commit, will cause the process to hang.
>
> During the fast_commit procedure, it will wait for inode update done.
> call ext4_fc_stop_update() before ext4_fc_commit() to mark inode
> complete update.
>
> Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
> ---
>  fs/ext4/extents.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 4108896d471b..92db33887b6c 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4707,8 +4707,12 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>                 goto out;
>
>         if (file->f_flags & O_SYNC && EXT4_SB(inode->i_sb)->s_journal) {
> +               ext4_fc_stop_update(inode);
>                 ret = ext4_fc_commit(EXT4_SB(inode->i_sb)->s_journal,
>                                         EXT4_I(inode)->i_sync_tid);
> +               inode_unlock(inode);
> +               trace_ext4_fallocate_exit(inode, offset, max_blocks, ret);
> +               return ret;
>         }
>  out:
>         inode_unlock(inode);
> --
> 2.20.1
>
