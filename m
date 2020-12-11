Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2F32D819C
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Dec 2020 23:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405803AbgLKWIT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 11 Dec 2020 17:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405427AbgLKWID (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 11 Dec 2020 17:08:03 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D25C0613CF
        for <linux-ext4@vger.kernel.org>; Fri, 11 Dec 2020 14:07:23 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id w1so9734075ejf.11
        for <linux-ext4@vger.kernel.org>; Fri, 11 Dec 2020 14:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JdktN6z2LJffzE8nZjAjtGP4wGDGRZwL0WS3wZGxG9w=;
        b=RhIyAsHp+XJH3z0G9lKhbAoBc/wPxwXgIY6SQ15/AMk8rUKcumXSJycJf5qrBHfWqc
         j131KAaeaPvjq4ZVNzUfauVMKSICZ4VYl6jfT1LghxvaU+yvfY6Ic7x34884GOxC7hX5
         sPHTbwttLU1lMmcZP/pGebJKicVctLRMYgk12/WpjMJTzMpIdVM3g0yOoDhd3Qm2LgQ7
         +BUgi7pF2Cmp7RaNMg8P8RakyY2ss28XQOPob/PgeIaJkl35LGlbbSwIKFnMn5qPyKJN
         jfGzqZJICMKU6VluH4wN15jkMcB7AB58uCbIfxC9K4TY29M6QZuYJxy2g6tyKE/2BMsA
         Ww0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JdktN6z2LJffzE8nZjAjtGP4wGDGRZwL0WS3wZGxG9w=;
        b=oAhdY6ObPbNF7Ac76emMN83YZTkusW29rIrRkXCi9PEfQw/XrQYbhRT2pXFAgRvwcA
         j4Ws0WHRHQDa0hFUrLtZSvDC+jdCT23KoVe+j2NzC7ORaLcAEsSD7p0Efouti2ZpOa1z
         AgjSvBjH+EqM13Vhg9zLYCRm3eB9amCgj+3SfcVio05hIS9hjPoEoJPELbcitqRgzZGR
         tidQkM0I3HcuuBXFb4gmDIRjpb3yfUrTJHCyPxIBgXRRY/869ZOc0u/qFj+t6HpBFi49
         6KqDNHSt4DzVKM5YBoy+vOwFvZt3EXvvQ6fE7YaaVFVM5itvONzLp5C/m1heW7nKFBtZ
         tkOg==
X-Gm-Message-State: AOAM532ovjqko4YX+pEr7F2Oxuj/lfH4dD1B7QoFe3Adj9SUjEnLqbYx
        X4fXQ38qREgpg9/87snPrt1G8xSlcYIjnaPv8CudN3f+xj60Pw==
X-Google-Smtp-Source: ABdhPJzkwr/xwqDepHrvQudJR9v9nqWoX7RFdaxabR4WorYOO3qQgAFDRIyMe2fqF5rLbY67BwZVm5MkJsTG4DAuEcI=
X-Received: by 2002:a17:906:b0c2:: with SMTP id bk2mr12858555ejb.223.1607724441716;
 Fri, 11 Dec 2020 14:07:21 -0800 (PST)
MIME-Version: 1.0
References: <1bb3c556-4635-061b-c2dc-df10c15e6398@huawei.com>
In-Reply-To: <1bb3c556-4635-061b-c2dc-df10c15e6398@huawei.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Fri, 11 Dec 2020 14:07:10 -0800
Message-ID: <CAD+ocbxAyyFqoD6AYQVjQyqFzZde3+QOnUhC-VikAq4A3_t8JA@mail.gmail.com>
Subject: Re: [PATCH] e2fsck: Avoid changes on recovery flags when
 jbd2_journal_recover() failed
To:     Haotian Li <lihaotian9@huawei.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "liuzhiqiang (I)" <liuzhiqiang26@huawei.com>,
        linfeilong <linfeilong@huawei.com>, tytso@alum.mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Haotian,

Thanks for your patch. I noticed that the following test fails:

$ make -j 64
...
365 tests succeeded     1 tests failed
Tests failed: j_corrupt_revoke_rcount
make: *** [Makefile:397: test_post] Error 1

This test fails because the test expects e2fsck to continue even if
the journal superblock is corrupt and with your patch e2fsck exits
immediately. This brings up a higher level question - if we abort on
errors when recovery fails during fsck, how would that problem get
fixed if we don't run fsck? In this particular example, the journal
superblock is corrupt and that is an unrecoverable error. I wonder if
instead we should check for certain specific transient errors such as
-ENOMEM and only then exit? I suspect even in those cases we probably
should ask the user if they would like to continue or not. What do you
think?

Thanks,
Harshad


On Fri, Dec 11, 2020 at 4:19 AM Haotian Li <lihaotian9@huawei.com> wrote:
>
> jbd2_journal_revocer() may fail when some error occers
> such as ENOMEM. However, jsb->s_start is still cleared
> by func e2fsck_journal_release(). This may break
> consistency between metadata and data in disk. Sometimes,
> failure in jbd2_journal_revocer() is temporary but retry
> e2fsck will skip the journal recovery when the temporary
> problem is fixed.
>
> To fix this case, we use "fatal_error" instead "goto errout"
> when recover journal failed. We think if journal recovery
> fails, we need send error message to user and reserve the
> recovery flags to recover the journal when try e2fsck again.
>
> Reported-by: Liangyun <liangyun2@huawei.com>
> Signed-off-by: Haotian Li <lihaotian9@huawei.com>
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> ---
>  e2fsck/journal.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/e2fsck/journal.c b/e2fsck/journal.c
> index 7d9f1b40..546beafd 100644
> --- a/e2fsck/journal.c
> +++ b/e2fsck/journal.c
> @@ -952,8 +952,13 @@ static errcode_t recover_ext3_journal(e2fsck_t ctx)
>                 goto errout;
>
>         retval = -jbd2_journal_recover(journal);
> -       if (retval)
> -               goto errout;
> +       if (retval && retval != EFSBADCRC && retval != EFSCORRUPTED) {
> +               ctx->fs->flags &= ~EXT2_FLAG_VALID;
> +               com_err(ctx->program_name, 0,
> +                                       _("Journal recovery failed "
> +                                         "on %s\n"), ctx->device_name);
> +               fatal_error(ctx, 0);
> +       }
>
>         if (journal->j_failed_commit) {
>                 pctx.ino = journal->j_failed_commit;
> --
> 2.19.1
>
