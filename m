Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A5647DDC9
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Dec 2021 03:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345847AbhLWCl0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Dec 2021 21:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbhLWCl0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 22 Dec 2021 21:41:26 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A30C061574;
        Wed, 22 Dec 2021 18:41:25 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id m21so17024982edc.0;
        Wed, 22 Dec 2021 18:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bg3jjRZ+lxoTNYTRY1TdvP2BIH4Co9AsKyazy1E9U3Y=;
        b=qpqQPotDQNvD/1Mp0Fz1Ks/zQDKP6TKj1ttF4zQHhnvsBEiKzV9eKvPsDPH8yhjJ2/
         rj4xNdYe9emeXzlCBIxYwgLBAswlo3i35/OY1I/2vANP9U6Zq4MBYrCOdRY1MxiL5/Rf
         XfMwlN8OeSS9WWI0uz1+BYopYIrHA7WOoGh+bPsOo+NMoN2+TFY1rKUPbPob3M22MRo2
         bet2NPUqyVoefysAdrDlj3+uCukCIUGMAjXzJ1E0oShyqplqYNhQsbX2p7T8hPKI/pXo
         OYz6XYvCEd9GfkgAtBXaBFUaJnvkdcaW4CjV7LJiaqRb3N1dRaGZ8EqOqMdcBr9ZR/jg
         X3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bg3jjRZ+lxoTNYTRY1TdvP2BIH4Co9AsKyazy1E9U3Y=;
        b=EGU/q5hC4fLSMAzU2AhJ2XONSJ76A4q/AEQa3tlpl7KTH4+/6mR9ylW7VsE6xB8AFa
         rcYq7BtEqP9Vqo2scPBOTnhT8AzL/ytpOBvRhv8Z0D6IFwIuKwWCdGOKk4EahWH1PfxC
         GyrBy1z5qKNVKk1P+1H7zSce8e1QWx1DzjMi75x6gB/RwGmfH65ORvAoll+a45elWHMy
         0nef3kNLCdTc3CzHmqnaxjuoi6kX0zD6L6xS0QzzsOb9k9WHh18nxq7NyZ66qT42w/IC
         8oGbS1uw3JoT8CsTtpOvjrT2DOuhYhyCkhbrD+Q9m1XZeAGT2aErKCbi+AZrvLWljt1m
         pCSQ==
X-Gm-Message-State: AOAM5312Aohvae/pDmyKjTXN8+IEo0rsjan6MPnAsCYPtcFmdpd+9ChZ
        emNJemE31jjzVJpL7CUrtOWFCDtmx6x99K10/VIeAubF
X-Google-Smtp-Source: ABdhPJzuQ5w8vJUJmuEhwHQdFXussH6ZxaD7IQN7I79SmHGY1SApbrFN4dXzkQEofrLH9WWoRGa6/i48et9dYypfBsE=
X-Received: by 2002:a17:906:c156:: with SMTP id dp22mr381092ejc.283.1640227284164;
 Wed, 22 Dec 2021 18:41:24 -0800 (PST)
MIME-Version: 1.0
References: <20211221022839.374606-1-yinxin.x@bytedance.com>
In-Reply-To: <20211221022839.374606-1-yinxin.x@bytedance.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Wed, 22 Dec 2021 18:41:12 -0800
Message-ID: <CAD+ocbzN9FODr5b-pNBJoCB82Gy=J6JLUEooMVqUfCPky-J0cA@mail.gmail.com>
Subject: Re: [PATCH v2] ext4: fix fast commit may miss tracking range for FALLOC_FL_ZERO_RANGE
To:     Xin Yin <yinxin.x@bytedance.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Looks good, thanks!

Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

On Mon, Dec 20, 2021 at 6:28 PM Xin Yin <yinxin.x@bytedance.com> wrote:
>
> when call falloc with FALLOC_FL_ZERO_RANGE, to set an range to unwritten,
> which has been already initialized. If the range is align to blocksize,
> fast commit will not track range for this change.
>
> Also track range for unwritten range in ext4_map_blocks().
>
> Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
> ---
> v2: change to track unwritten range in ext4_map_blocks()
> ---
>  fs/ext4/extents.c | 2 --
>  fs/ext4/inode.c   | 7 ++++---
>  2 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 9229ab1f99c5..6bce319f3bcd 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4599,8 +4599,6 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>         ret = ext4_mark_inode_dirty(handle, inode);
>         if (unlikely(ret))
>                 goto out_handle;
> -       ext4_fc_track_range(handle, inode, offset >> inode->i_sb->s_blocksize_bits,
> -                       (offset + len - 1) >> inode->i_sb->s_blocksize_bits);
>         /* Zero out partial block at the edges of the range */
>         ret = ext4_zero_partial_blocks(handle, inode, offset, len);
>         if (ret >= 0)
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 0afab6d5c65b..47ad4b8cb503 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -741,10 +741,11 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
>                         if (ret)
>                                 return ret;
>                 }
> -               ext4_fc_track_range(handle, inode, map->m_lblk,
> -                           map->m_lblk + map->m_len - 1);
>         }
> -
> +       if (retval > 0 && (map->m_flags & EXT4_MAP_UNWRITTEN ||
> +                               map->m_flags & EXT4_MAP_MAPPED))
> +               ext4_fc_track_range(handle, inode, map->m_lblk,
> +                                       map->m_lblk + map->m_len - 1);
>         if (retval < 0)
>                 ext_debug(inode, "failed with err %d\n", retval);
>         return retval;
> --
> 2.20.1
>
