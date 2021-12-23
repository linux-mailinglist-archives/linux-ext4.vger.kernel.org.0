Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14C2E47E89E
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Dec 2021 21:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240406AbhLWULb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Dec 2021 15:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbhLWULa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Dec 2021 15:11:30 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37019C061401;
        Thu, 23 Dec 2021 12:11:30 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id j6so25405070edw.12;
        Thu, 23 Dec 2021 12:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Z0W+uNVLefCvGenGTWY6S3Ph9n5iOBFk9YTlc8vDc8=;
        b=eMjsHlFQ7izRRsjczN5qKrPvXKW4HRt16BdOixLAkEnLdLnE/debRO8zo4NmTQAefO
         ued5YzGRMKGD5zL/kTmn+y+24slEG+iNfAkEq5kWhQTLnarzyQJoY9A+DY8AnNw2ZbSo
         TdVyinRKlG7VpiIozrCBJ/fg4meV1pUnw41KXqgavn3nTupyiUZHVw13lssjahkM3wDk
         2C5GBVoEvOU+WsXuZrBx/xGEZdM9VsjLuD3iFLsTx4ORDFsDsmadQw01JeYnLA0lSt6H
         hS0Kt2KEeeloku77jndCY5i45dAyuDxUWPTggs67SMBu0UXHDHVJhp2zp/Lazc3rjETy
         /xtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Z0W+uNVLefCvGenGTWY6S3Ph9n5iOBFk9YTlc8vDc8=;
        b=nNngSZJV9OKAlPrOj1q338nhOrZHVdpR2HZvsffD3M3uJhXGFfDjWhWgFqhdIqpU0a
         S0m5qdA9danOqKbClzXbCg5mmgomV5k0wy8+yHWWxKbVEEJfVdLsqQdnLAhANFfQXvjY
         UAYhlhMiolbO3HAqeqGRpwbuPRTN7hLmEO1xC6YTxodn8nMxCJgv1uP+qBqxjciZtb9h
         +ZcflgZ/001aG/qR+rbtX5ZKngZWkE3nanYJfxkTLQ5M9pCx2YkCvcdAAj7X22VBXRXy
         pwEHWjPhsGsolohaFBZsR/0umY4iVXAIqOvKVQwq2/Co1uZY1AVr6vpMOPquW6HfPtM1
         oATw==
X-Gm-Message-State: AOAM531UkdCKRUY+w2RSlyOwG9T2HdD1qB6Ulr490kQhhWgswWEUrJs9
        tfDrPRmf+n+BXTE2xsX/bDknMnWNAbnemUkBbx4=
X-Google-Smtp-Source: ABdhPJwrrW8MmRZCCatjVSXKEr03lsImIO+p9ufdkuSu5Vih456wCAUQfFFq0Kdeb4SrV2hEHjXB/FeGSRC7qOfpvlY=
X-Received: by 2002:a17:906:f283:: with SMTP id gu3mr3017338ejb.768.1640290288588;
 Thu, 23 Dec 2021 12:11:28 -0800 (PST)
MIME-Version: 1.0
References: <20211223032337.5198-1-yinxin.x@bytedance.com> <20211223032337.5198-2-yinxin.x@bytedance.com>
In-Reply-To: <20211223032337.5198-2-yinxin.x@bytedance.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Thu, 23 Dec 2021 12:11:17 -0800
Message-ID: <CAD+ocbxF=GdQdVryoSgbf5uJJk7H0uawLoQTKdDCKfnWgbmuxA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ext4: use ext4_ext_remove_space() for fast commit
 replay delete range
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

On Wed, Dec 22, 2021 at 7:24 PM Xin Yin <yinxin.x@bytedance.com> wrote:
>
> For now ,we use ext4_punch_hole() during fast commit replay delete range
> procedure. But it will be affected by inode->i_size, which may not
> correct during fast commit replay procedure. The following test will
> failed.
>
> -create & write foo (len 1000K)
> -falloc FALLOC_FL_ZERO_RANGE foo (range 400K - 600K)
> -create & fsync bar
> -falloc FALLOC_FL_PUNCH_HOLE foo (range 300K-500K)
> -fsync foo
> -crash before a full commit
>
> After the fast_commit reply procedure, the range 400K-500K will not be
> removed. Because in this case, when calling ext4_punch_hole() the
> inode->i_size is 0, and it just retruns with doing nothing.
>
> Change to use ext4_ext_remove_space() instead of ext4_punch_hole()
> to remove blocks of inode directly.
>
> Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
> ---
>  fs/ext4/fast_commit.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index aa05b23f9c14..3deb97b22ca4 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -1708,11 +1708,14 @@ ext4_fc_replay_del_range(struct super_block *sb, struct ext4_fc_tl *tl,
>                 }
>         }
>
> -       ret = ext4_punch_hole(inode,
> -               le32_to_cpu(lrange.fc_lblk) << sb->s_blocksize_bits,
> -               le32_to_cpu(lrange.fc_len) <<  sb->s_blocksize_bits);
> -       if (ret)
> -               jbd_debug(1, "ext4_punch_hole returned %d", ret);
> +       down_write(&EXT4_I(inode)->i_data_sem);
> +       ret = ext4_ext_remove_space(inode, lrange.fc_lblk,
> +                               lrange.fc_lblk + lrange.fc_len - 1);
> +       up_write(&EXT4_I(inode)->i_data_sem);
> +       if (ret) {
> +               iput(inode);
> +               return 0;
> +       }
>         ext4_ext_replay_shrink_inode(inode,
>                 i_size_read(inode) >> sb->s_blocksize_bits);
>         ext4_mark_inode_dirty(NULL, inode);
> --
> 2.20.1
>
