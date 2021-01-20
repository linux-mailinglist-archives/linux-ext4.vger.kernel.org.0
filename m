Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5112FD773
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Jan 2021 18:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732522AbhATRrI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 Jan 2021 12:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390118AbhATRo1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 20 Jan 2021 12:44:27 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A50C0613D6;
        Wed, 20 Jan 2021 09:43:28 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id 6so34712292ejz.5;
        Wed, 20 Jan 2021 09:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8u2YlGjdBiXNxHWMGsZ9iS3g5Vphiu4Bzp3sgjIxUwE=;
        b=U0P9dEXEM4NoH+BqodC4cEeN4r/GmfP53g5aE4yK0deN5k07b4YOy9j5o1Jb0roGFw
         CIf+Dn5X/VW5cLy477UM+m1OhWII0ZvKn/6qnINuaa1zsDb4GHTrfuVb7L4FQoiAzPGs
         nv7WdkMCpzquzQOqRPn2Cg4h4AIZO4uHsW4ocdwsV3EhsTiUAnzB4n83w6nPUXmZXhqW
         Fy/21p4PQoPkFMk4gwiPuyzRvBnsCTWofgjaObT4puFWPqF286FqBjXC6+o/KzjXM7f5
         qndEFOA8fllMatsvsZQC8rLmTWPEDjtzWmmhKVQvmg397g/aPE/e3IsTcKfpmUCCyM/7
         R+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8u2YlGjdBiXNxHWMGsZ9iS3g5Vphiu4Bzp3sgjIxUwE=;
        b=LHm59uuIWXtVd/RLr15hTF0oPr2f/uZzskLo4AmRz5pVjA82hAkQ5weoUhLeHGwN28
         CgTKu4TK+uhuresTOvo4achXvWDR5oBCso+f2xHDK4kbCC4AU3j+ZdtOAPoRhqxQ1Uki
         Tw5OgoaphEzmQUso1a+PjmzCMpgc4WkQ9Pr70FT9g1b5ZffYFsV3WR8dNVBtXpJ2P/as
         5BAuCFDciBBC+eVfgZ3IBL/0BqS4T8qF226O5U9tUREPX1uhWUpazYYkljVJUgj/UMXP
         2acY0Z0WwGUheIqjvCWjfvPAH1Amli53ISJZQDh35+kOxRl8mXipk2oxDnVnGntg+yqJ
         Fv0Q==
X-Gm-Message-State: AOAM531Wg+iOn6kpWi4pJp0VmqXpLToXum7tvRpkFhubTCzAqLzahKIc
        9AZy3qS/Fjvj74eYE+OhbQnU7jkATEkwqJVsepA=
X-Google-Smtp-Source: ABdhPJzqMIq5g8wOuUcoOmqgtdw52RzWdslz8i5l1px8OWut790tQiG6dDoxTbxrnxh1dtCEnouRnXStBxSV9RAo1gU=
X-Received: by 2002:a17:906:9619:: with SMTP id s25mr6945195ejx.345.1611164607310;
 Wed, 20 Jan 2021 09:43:27 -0800 (PST)
MIME-Version: 1.0
References: <20210119110121.36656-1-bianpan2016@163.com>
In-Reply-To: <20210119110121.36656-1-bianpan2016@163.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Wed, 20 Jan 2021 09:43:16 -0800
Message-ID: <CAD+ocbz+DKHKGN=G8Vn0pjuAfVRX3UP85ZaeZEEwcNemS1kJ8A@mail.gmail.com>
Subject: Re: [PATCH] ext4: stop update inode before return
To:     Pan Bian <bianpan2016@163.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks Pan for the fix. Looks good to me.

Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

On Tue, Jan 19, 2021 at 3:04 AM Pan Bian <bianpan2016@163.com> wrote:
>
> Stop inode updating before returning the error code.
>
> Fixes: aa75f4d3daae ("ext4: main fast-commit commit path")
> Signed-off-by: Pan Bian <bianpan2016@163.com>
> ---
>  fs/ext4/inode.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index c173c8405856..64039bbb656d 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5389,8 +5389,10 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
>                         inode->i_gid = attr->ia_gid;
>                 error = ext4_mark_inode_dirty(handle, inode);
>                 ext4_journal_stop(handle);
> -               if (unlikely(error))
> +               if (unlikely(error)) {
> +                       ext4_fc_stop_update(inode);
>                         return error;
> +               }
>         }
>
>         if (attr->ia_valid & ATTR_SIZE) {
> --
> 2.17.1
>
