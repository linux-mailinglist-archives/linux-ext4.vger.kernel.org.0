Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C69B240120E
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Sep 2021 01:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbhIEXUx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 5 Sep 2021 19:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbhIEXUw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 5 Sep 2021 19:20:52 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B3AC061575;
        Sun,  5 Sep 2021 16:19:48 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id u1so2834660plq.5;
        Sun, 05 Sep 2021 16:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7BZXdqPIIbX0lmfQ4SwtNY8oiLwmuMvBZoqm565+qZM=;
        b=MJSm/ehKryiK4KHSbaVd1Bq9pjHb6JwWb4gkXn/IJsRe6yPqfykinE6UE8Koi4DMvf
         BTz8DtzdBUophSXgxJqKXEL9HiHjM8W25/w4Cv9gznDkiw7d3+So26uM6pvsHgOPr49o
         j8MrSVf1rAUTWtIH0Ot2cwQcYVxu3pPtDr8jASbgL/cQHsC731RX7adz1bxJCRcqxwjd
         Kzbug6y3/2StJO5YRBbBIsvpMwTjN6K3ykHkICuV+E2+gZZR9z1AiIIkE9/aBxkT2f80
         xJjXOlaHmoqCiTI8PZpoEVjcHvXnCOp03q3+sh+EQ8X1T7+wGTtZLh4nCg5vMOtNnZ3a
         9llw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7BZXdqPIIbX0lmfQ4SwtNY8oiLwmuMvBZoqm565+qZM=;
        b=SAlKL2kJLXebt7DiVn9I/ogrggrPO9rA7CLcsy1INYHMmPP8rviHL55iNBeEE5YSy1
         l+CNIRnNPQl4Yywamj3KZV9FAYD5gztRnmTT1o5qp7fx+HJ1+3T2fJVVCwzhG2DlCAmx
         xFM7bEA5axXI7e6Rw2izC+heT4XLSM5NL/vPFS7UTL6MDLTdaD5ru5BPrws3M88myEhZ
         FJtk93g6/8BYuWtF54J9lRrznhXECGQdbL9uTwq93AIU1sJc9PxOnrJd9VBwv7n1Qbrg
         qI+iOGV4f/4VQpDoC4vmxhewYgP7Kjv8QzdUJ2A8wz83a43etiGlJZiILhBeWLVcIlf4
         4JaQ==
X-Gm-Message-State: AOAM531ubdNS3rpe6aHu43OgQUubC4p04FJrmSkyjppMnDoyLgYCNAlO
        ZDDRZu9xchjsDbSq/zPd/92moUYtBZsSn8kD7f4=
X-Google-Smtp-Source: ABdhPJxsH5A5v5b+7DWL2nI/OixOXfS7188Aze7SkaMeitjT4fO59ORtgY3F3G5cd+2rqSKYKy3vOXeftTmUTQke1D0=
X-Received: by 2002:a17:90b:1085:: with SMTP id gj5mr10789472pjb.66.1630883988225;
 Sun, 05 Sep 2021 16:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210824034929.GA13415@raspberrypi>
In-Reply-To: <20210824034929.GA13415@raspberrypi>
From:   Austin Kim <austindh.kim@gmail.com>
Date:   Mon, 6 Sep 2021 08:19:38 +0900
Message-ID: <CADLLry4tZjHKpJq7cQ3Rmhc_OOvHK+Wmss=8x_8KA-aHP++oLw@mail.gmail.com>
Subject: Re: [PATCH] ext4: remove an unused variable warning with CONFIG_QUOTA=n
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?6rmA64+Z7ZiE?= <austin.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

2021=EB=85=84 8=EC=9B=94 24=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 12:49, =
Austin Kim <austindh.kim@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> The 'enable_quota' variable is only used in an CONFIG_QUOTA.
> With CONFIG_QUOTA=3Dn, compiler causes a harmless warning:
>
> fs/ext4/super.c: In function =E2=80=98ext4_remount=E2=80=99:
> fs/ext4/super.c:5840:6: warning: variable =E2=80=98enable_quota=E2=80=99 =
set but not used
>   [-Wunused-but-set-variable]
>   int enable_quota =3D 0;
>               ^~~~~
>
> Move 'enable_quota' into the same #ifdef CONFIG_QUOTA block
> to remove an unused variable warning.
>
> Signed-off-by: Austin Kim <austindh.kim@gmail.com>
> ---
>  fs/ext4/super.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 6b03e4281f6f..6adb570f4b31 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5845,10 +5845,10 @@ static int ext4_remount(struct super_block *sb, i=
nt *flags, char *data)
>         struct ext4_sb_info *sbi =3D EXT4_SB(sb);
>         unsigned long old_sb_flags, vfs_flags;
>         struct ext4_mount_options old_opts;
> -       int enable_quota =3D 0;
>         ext4_group_t g;
>         int err =3D 0;
>  #ifdef CONFIG_QUOTA
> +       int enable_quota =3D 0;
>         int i, j;
>         char *to_free[EXT4_MAXQUOTAS];
>  #endif
> @@ -6053,7 +6053,9 @@ static int ext4_remount(struct super_block *sb, int=
 *flags, char *data)
>                                         err =3D -EROFS;
>                                         goto restore_opts;
>                                 }
> +#ifdef CONFIG_QUOTA
>                         enable_quota =3D 1;
> +#endif
>                 }
>         }
>
> --
> 2.20.1
>

If you are available, would you please review this patch?
It will not take long.

BR,
Austin Kim
