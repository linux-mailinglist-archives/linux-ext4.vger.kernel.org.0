Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F6547E8A2
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Dec 2021 21:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350210AbhLWUMM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Dec 2021 15:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbhLWUML (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Dec 2021 15:12:11 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F2BC061401;
        Thu, 23 Dec 2021 12:12:11 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id y22so25608857edq.2;
        Thu, 23 Dec 2021 12:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ql7JHWbpBacxfnANpRJ0y6Ne37lRfrh7MoiffzaYpUA=;
        b=d1voRlNyVBYT5j0NYkHBmvYcwhZrdNsCwdKM/bXC3xjPAxl53B3ueB1myuSN0iBMSE
         cuYl4wSCE1BIg5q4RWIXhDFNB7WGE4UHi9HI0C4EqkdGkvaCahBw0hH3o9kcJhS25LDn
         IULzlCCCPJviJG565aQM9Uih1YO8598acqGf+euwfW5dCfQGIXmIEFsA6CJ9snz96tTU
         h/Ll/vVvWp8Nl87zFNOtTEBdm2Z5VUoDACC53yolUmfrN/mdoTFywL22cHOCIsUzy/2t
         beVLz5+/uKvsj0KANs+bxB0vzM4XzpGRkY99k3hPEYYB3VZ42e90oBCeX3Dx5yOcbC6J
         aEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ql7JHWbpBacxfnANpRJ0y6Ne37lRfrh7MoiffzaYpUA=;
        b=h/4P95N5qKXWdgzjh2hVTwJZKt0+BR0Q/+BFPAvaNAMOkqNX1VbelXNoNEj/+jwJ8W
         owfyGdmCBxqm0XP0rMkytoRCcu2Pr6JBaWd9KvLckM2nZWquJTeQ1vS3cI5haLtYgo6g
         zSaGBD8j0cbhPwK4FWozzzrh9RYCI/LgPH781J+Igq/Tu8n8i0dckrNPWKimo/m4Af4z
         5yM1gVWcwNkQ+uCFRwCYHa1KpKD7qtZhhLcPm0ODdiepw5K08iRCq7OgvJrs+fhKHpHT
         LAYPgavQ9ZcHtDES2haCKmf8iUJj16pLrFUM3j72Ku6uQ8Dff+6zAdxQWutFH4CFFpLH
         9F4w==
X-Gm-Message-State: AOAM531B5cUwjO1SU9HY/qS2o1FMYJYIkOE92qs/lprCE9XFHy4XS/MQ
        o38XAazQUUpay57i+Imh42l20fY39463EOgeYiw=
X-Google-Smtp-Source: ABdhPJxh9PPia1qcBdbOdFfqHrTh4HiYmGRP06JjpEnXQXNJqhNANBjIeLcGET9B12Sb/uCQ4Ie3LWFgcDIzDRQ4zNE=
X-Received: by 2002:a17:907:6d03:: with SMTP id sa3mr3077994ejc.156.1640290329688;
 Thu, 23 Dec 2021 12:12:09 -0800 (PST)
MIME-Version: 1.0
References: <20211223032337.5198-1-yinxin.x@bytedance.com> <20211223032337.5198-3-yinxin.x@bytedance.com>
In-Reply-To: <20211223032337.5198-3-yinxin.x@bytedance.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Thu, 23 Dec 2021 12:11:58 -0800
Message-ID: <CAD+ocbzJ2_uvc5SV1YhnAOXB4t8m0OikLCXhYTBhF-vnH1hAjQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ext4: fast commit may miss tracking unwritten range
 during ftruncate
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
> If use FALLOC_FL_KEEP_SIZE to alloc unwritten range at bottom, the
> inode->i_size will not include the unwritten range. When call
> ftruncate with fast commit enabled, it will miss to track the
> unwritten range.
>
> Change to trace the full range during ftruncate.
>
> Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
> ---
>  fs/ext4/inode.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 82f555d26980..1d2ba63874ad 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5423,8 +5423,7 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
>                                 ext4_fc_track_range(handle, inode,
>                                         (attr->ia_size > 0 ? attr->ia_size - 1 : 0) >>
>                                         inode->i_sb->s_blocksize_bits,
> -                                       (oldsize > 0 ? oldsize - 1 : 0) >>
> -                                       inode->i_sb->s_blocksize_bits);
> +                                       EXT_MAX_BLOCKS - 1);
>                         else
>                                 ext4_fc_track_range(
>                                         handle, inode,
> --
> 2.20.1
>
