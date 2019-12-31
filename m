Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26EFA12D591
	for <lists+linux-ext4@lfdr.de>; Tue, 31 Dec 2019 02:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbfLaBl7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Dec 2019 20:41:59 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53588 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfLaBl7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 30 Dec 2019 20:41:59 -0500
Received: by mail-wm1-f66.google.com with SMTP id m24so890240wmc.3
        for <linux-ext4@vger.kernel.org>; Mon, 30 Dec 2019 17:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GVC3eSLUwitobPrin6NlR3ButN9j0vLqUYVpOx5nqN8=;
        b=tZN3Im8Pqqk+5NWNekbMKSNnMqL3+RxU+5BSyzkf82bxpMuTXJzExTEJoESjk8QH8y
         as8Yf1RuOP6HBM7DFOqm8la82tng8YCgmFIPtDjtMZSetwTgCIO41Uu3qZWPs6R88i+d
         5LxcmPjN3Xe4Nlr4wDs2mrkVMqEG7rpbDkb7tr4ysTeY2WVCOGkRHVGJK3beP96Wv9b5
         3l5jjZifQfskMxaD59yiWc0hFSl2Qt1FqUJLB/FrcGb8NQbqDbf+viFJxmTD/PWxypTy
         kSJ31MRTbMv6fdZZaXB2wLp6ymNvQGLrxtVvMQBxxmrcbqUOdJBC5Z1NDygpjxG7D6G1
         MvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GVC3eSLUwitobPrin6NlR3ButN9j0vLqUYVpOx5nqN8=;
        b=uRzhWgytDJek2FlRguN1WMHwqicYyd8HtGTPNqof/krxqyxnd2DEK0sGP3Vj/Oad15
         yGIV9QZd5TWdmGeA6ihKKKTFdsG3wQ76B09yTOm9WIW7Qan97GZhBL1LDW3OCbPgZyIo
         RSckooDK2zF4aGvLUugjTRkxIWOB4p0goJo/5oCVINcvJe4qOblPUTYxGHFo/pdTDbTG
         S3C41gj9mLJrup3NK1lIP8ul/PfHiTmIvFObwRT2VInRyKijJW360u0cxbbqy9pipmaK
         4+D26KR9qXQ3gDP/6oF5YGuXn7SmaI/7aLQE5WHRsvvpzkaI0k+aVMVwamwUcyLI7Gs9
         lY8g==
X-Gm-Message-State: APjAAAUoQ6U4onsnnWog5vkla7Ab0g2mgB9KXtOuJz0uQ0JfjGVKa6Cd
        XykutIgQg3mjxlhMGl37Yem7nk4MUh7n/LdjZgU=
X-Google-Smtp-Source: APXvYqz51tmjCGDQEsA4fpLymhs98aHxC9rpGBeDwd3w34PFuMgJ6HKzm9RCINpN/aWrLV+G2/4hjgNw+VTFzgPrekg=
X-Received: by 2002:a1c:3c8b:: with SMTP id j133mr1594147wma.66.1577756517094;
 Mon, 30 Dec 2019 17:41:57 -0800 (PST)
MIME-Version: 1.0
References: <1574759039-7429-1-git-send-email-wangshilong1991@gmail.com>
 <1574759039-7429-2-git-send-email-wangshilong1991@gmail.com> <20191231005713.GA3669@mit.edu>
In-Reply-To: <20191231005713.GA3669@mit.edu>
From:   Wang Shilong <wangshilong1991@gmail.com>
Date:   Tue, 31 Dec 2019 09:41:36 +0800
Message-ID: <CAP9B-QmL_GMeOX5Tpgd80zMzx4PAWP65yxC7Kz3wXNThfmVeZA@mail.gmail.com>
Subject: Re: [PATCH 2/2] e2fsck: fix use after free in calculate_tree()
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Andreas Dilger <adilger@dilger.ca>, Li Xi <lixi@ddn.com>,
        Wang Shilong <wshilong@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Looks good to me, thanks for refresh the patch!


On Tue, Dec 31, 2019 at 8:57 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> Here is the version which I plan to use in e2fsprogs's maint branch.
>
>                                  - Ted
>
> commit aacc234471a9a0ab6d8d6f610a0e4996e9bfc785
> Author: Wang Shilong <wshilong@ddn.com>
> Date:   Mon Dec 30 19:52:39 2019 -0500
>
>     e2fsck: fix use after free in calculate_tree()
>
>     The problem is alloc_blocks() will call get_next_block() which might
>     reallocate outdir->buf, and memory address could be changed after
>     this.  To fix this, pointers that point into outdir->buf, such as
>     int_limit and root need to be recaulated based on the new starting
>     address of outdir->buf.
>
>     [ Changed to correctly recalculate int_limit, and to optimize how we
>       reallocate outdir->buf.  -TYT ]
>
>     Signed-off-by: Wang Shilong <wshilong@ddn.com>
>     Signed-off-by: Theodore Ts'o <tytso@mit.edu>
>
> diff --git a/e2fsck/rehash.c b/e2fsck/rehash.c
> index 392cfe9f..54bc6803 100644
> --- a/e2fsck/rehash.c
> +++ b/e2fsck/rehash.c
> @@ -301,7 +301,11 @@ static errcode_t get_next_block(ext2_filsys fs, struct out_dir *outdir,
>         errcode_t       retval;
>
>         if (outdir->num >= outdir->max) {
> -               retval = alloc_size_dir(fs, outdir, outdir->max + 50);
> +               int increment = outdir->max / 10;
> +
> +               if (increment < 50)
> +                       increment = 50;
> +               retval = alloc_size_dir(fs, outdir, outdir->max + increment);
>                 if (retval)
>                         return retval;
>         }
> @@ -645,6 +649,9 @@ static int alloc_blocks(ext2_filsys fs,
>         if (retval)
>                 return retval;
>
> +       /* outdir->buf might be reallocated */
> +       *prev_ent = (struct ext2_dx_entry *) (outdir->buf + *prev_offset);
> +
>         *next_ent = set_int_node(fs, block_start);
>         *limit = (struct ext2_dx_countlimit *)(*next_ent);
>         if (next_offset)
> @@ -734,6 +741,9 @@ static errcode_t calculate_tree(ext2_filsys fs,
>                                         return retval;
>                         }
>                         if (c3 == 0) {
> +                               int delta1 = (char *)int_limit - outdir->buf;
> +                               int delta2 = (char *)root - outdir->buf;
> +
>                                 retval = alloc_blocks(fs, &limit, &int_ent,
>                                                       &dx_ent, &int_offset,
>                                                       NULL, outdir, i, &c2,
> @@ -741,6 +751,11 @@ static errcode_t calculate_tree(ext2_filsys fs,
>                                 if (retval)
>                                         return retval;
>
> +                               /* outdir->buf might be reallocated */
> +                               int_limit = (struct ext2_dx_countlimit *)
> +                                       (outdir->buf + delta1);
> +                               root = (struct ext2_dx_entry *)
> +                                       (outdir->buf + delta2);
>                         }
>                         dx_ent->block = ext2fs_cpu_to_le32(i);
>                         if (c3 != limit->limit)
>
