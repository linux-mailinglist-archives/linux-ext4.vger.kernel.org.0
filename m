Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A827812CFA6
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Dec 2019 12:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfL3Li4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Dec 2019 06:38:56 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34561 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbfL3Li4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 30 Dec 2019 06:38:56 -0500
Received: by mail-wm1-f67.google.com with SMTP id c127so11431412wme.1
        for <linux-ext4@vger.kernel.org>; Mon, 30 Dec 2019 03:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zo0RsNMMLTv4ram+JJCohreDJrgaJjQ48w8OlJtUVb4=;
        b=KKkTGyhX7DCENFxSENp4msaFU7acPutGa5HZcm05WxIsJlHO8kQJqxOudxcvvyVBNP
         Zy1Kd2ItBcKlD/gLNUzrR3IXqAW+hho07zm0vVC6RC3kpIjd8KXoFwKIOzbVlEAvsPZ2
         GOu24QmsEZif/dpLi3OU6VMagyf+K16AEG2ECGSCsuTg4UW62Jqr/9mlQmzo8SytBiik
         g8SVf4K3HWqhT832BywfZKw0mN7LGzq2QAyAixUwjXI69KTmtF5izl18VpPY3KoYS6Ix
         oMUGiwFsO8Ge9qqnLU2wvdV7sTRQxLNz/qZ3BereWmIjROVsswzPSh3IzyI3f27VDcMb
         tcdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zo0RsNMMLTv4ram+JJCohreDJrgaJjQ48w8OlJtUVb4=;
        b=VahPLezZlI/M0YvYaJRGJPpKch/w4zIC4sF2DzbPwxfoPkr3ocQ9Ppmdj6EBGqWq0/
         1RQcyCC+M0AniFv9ebSHcjcOjap+t7AEB1OPGaq2WfQAJpd8turw5e44+yTj82SWz8LC
         RxvwXPfBrsn7ircjaIO0wHsSmc4ANamTLt05wrWa3UrtV5gXKXNgLdwSKqd+r9O7A4KS
         PeM1tiCOMHp/HkKmzT9ztuTAFQwwZoNKSEqPzOujXy5KVWvY2bcMqiTF6h9clzu64+Te
         MzkTIOKqHR+Eay8rr0CJZgKBBmEE78KV7VRKQE+y+bFRqtY9s9PWPcyQCttQ6UTUzn9j
         zV5w==
X-Gm-Message-State: APjAAAUYpnWrI/V8g1J3BekXntJ6tirxOz5OVSY7LsRFiju1Xhz3JY91
        eJsmm0XgtWxFK1tGrCayIqDPRKkM2QfFRR54D1iO4YTE
X-Google-Smtp-Source: APXvYqzVDiH7Y+75Bp3Dj6P34WoVG29QnjF7JclR3XEk0MtUgncuFXoIECa4yuSQ6stUmyIKPiYJ+QfWLorPbtfbda0=
X-Received: by 2002:a1c:a949:: with SMTP id s70mr33796316wme.69.1577705934113;
 Mon, 30 Dec 2019 03:38:54 -0800 (PST)
MIME-Version: 1.0
References: <1574759039-7429-1-git-send-email-wangshilong1991@gmail.com> <1574759039-7429-2-git-send-email-wangshilong1991@gmail.com>
In-Reply-To: <1574759039-7429-2-git-send-email-wangshilong1991@gmail.com>
From:   Wang Shilong <wangshilong1991@gmail.com>
Date:   Mon, 30 Dec 2019 19:38:33 +0800
Message-ID: <CAP9B-QksOYmoSX=ExH6HO9iuuj64SLp5Av_tKnXjQ8Kije4ZSg@mail.gmail.com>
Subject: Re: [PATCH 2/2] e2fsck: fix use after free in calculate_tree()
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     Andreas Dilger <adilger@dilger.ca>, Li Xi <lixi@ddn.com>,
        Wang Shilong <wshilong@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Ping...

On Tue, Nov 26, 2019 at 5:04 PM Wang Shilong <wangshilong1991@gmail.com> wrote:
>
> From: Wang Shilong <wshilong@ddn.com>
>
> Hit following Seg errors randomly when running f_large_dir test:
>
> +Signal (11) SIGSEGV si_code=SEGV_MAPERR fault addr=0x7f02cfffbc1a
> +../e2fsck/e2fsck[0x43766e]
> +/lib64/libpthread.so.0(+0xf7e0)[0x7f02d8c9a7e0]
> +../e2fsck/e2fsck(e2fsck_rehash_dir+0x10f3)[0x436173]
> +../e2fsck/e2fsck(e2fsck_rehash_directories+0xf4)[0x4362d4]
> +../e2fsck/e2fsck(e2fsck_pass3+0x722)[0x4292c2]
> +../e2fsck/e2fsck(e2fsck_run+0x47)[0x414ef7]
> +../e2fsck/e2fsck(main+0x1c1d)[0x41319d]
> +/lib64/libc.so.6(__libc_start_main+0x100)[0x7f02d8915d20]
> +../e2fsck/e2fsck[0x40fc59]
> +Exit status is 8
>
> gdb output is:
> 0x436173 is in e2fsck_rehash_dir (rehash.c:752).
> warning: Source file is more recent than executable.
> 747                                     dx_ent->hash =
> 748                                             ext2fs_cpu_to_le32(outdir->hashes[i]);
> 749                             dx_ent++;
> 750                             c3--;
> 751                     }
> 752                     int_limit->count = ext2fs_cpu_to_le16(limit->limit - c2);
> 753                     int_limit->limit = ext2fs_cpu_to_le16(limit->limit);
> 754
> 755                     limit->count = ext2fs_cpu_to_le16(limit->limit - c3);
> 756                     limit->limit = ext2fs_cpu_to_le16(limit->limit);
>
> The problem is alloc_blocks() will call get_next_block()
> which might reallocate @outdir->buf, and memory address
> could be changed after this. @int_limit and @root should
> be recalculated based on new start address. Otherwise,
> it will try to access freed memory and cause SEGV_MAPERR
> errors.
>
> Signed-off-by: Wang Shilong <wshilong@ddn.com>
> ---
>  e2fsck/rehash.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/e2fsck/rehash.c b/e2fsck/rehash.c
> index 5250652e..0eb99328 100644
> --- a/e2fsck/rehash.c
> +++ b/e2fsck/rehash.c
> @@ -636,6 +636,9 @@ static int alloc_blocks(ext2_filsys fs,
>         if (retval)
>                 return retval;
>
> +       /* outdir->buf might be reallocated */
> +       *prev_ent = (struct ext2_dx_entry *) (outdir->buf + *prev_offset);
> +
>         *next_ent = set_int_node(fs, block_start);
>         *limit = (struct ext2_dx_countlimit *)(*next_ent);
>         if (next_offset)
> @@ -725,12 +728,18 @@ static errcode_t calculate_tree(ext2_filsys fs,
>                                         return retval;
>                         }
>                         if (c3 == 0) {
> +                               int delta1 = int_offset;;
> +                               int delta2 = (char *)root - outdir->buf;
> +
>                                 retval = alloc_blocks(fs, &limit, &int_ent,
>                                                       &dx_ent, &int_offset,
>                                                       NULL, outdir, i, &c2,
>                                                       &c3);
>                                 if (retval)
>                                         return retval;
> +                               /* outdir->buf might be reallocated */
> +                               int_limit = (struct ext2_dx_countlimit *)(outdir->buf + delta1);
> +                               root = (struct ext2_dx_entry *)(outdir->buf + delta2);
>
>                         }
>                         dx_ent->block = ext2fs_cpu_to_le32(i);
> --
> 2.21.0
>
