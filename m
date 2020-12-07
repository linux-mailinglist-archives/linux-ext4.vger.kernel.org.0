Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166C42D0911
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Dec 2020 03:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgLGCBk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 6 Dec 2020 21:01:40 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34506 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgLGCBk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 6 Dec 2020 21:01:40 -0500
Received: by mail-ot1-f67.google.com with SMTP id h19so11180573otr.1
        for <linux-ext4@vger.kernel.org>; Sun, 06 Dec 2020 18:01:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JfYmUPAAlrymRQqo0pgKHbc4HLF/AdhMYwzqTSFzOmA=;
        b=bglF8JwCCKPoPM+D617pJlNBnAG9sruY2Z1TUz2P6s90+l4kIL3ajXMB3d0gqn2YSg
         VbE8ex1HScCHorHHKhSOw48ROiO5CM3Mc4wZrgUvX5rdHLyZv6WLQfMYOWajTrIIAs1D
         HU01XpPqHKkKHpQTAVxnSUd6Q3tcwdeEKN8SDZVzyrMlkIAKBkXCv4CIcQB8uRf5Z5S6
         KRorzIJ3wjDLgc21GV7UC8cvM4QUQ9pSnqdCY0bd06s/MxZFkDizYzoQzdkc3CM6FvN0
         rzYNx1M/HRxvNT7thV3wE7/W3/MlAVhWSBBSy+v8+dJF4nP/D/CNL14mIuE0qODPat+Q
         /VqQ==
X-Gm-Message-State: AOAM531Mgc+y1D3dLermvwbsXopAwv7UsqxQBEZuT/0drzqylLpKmiLa
        LEmU3LSUhuS7f/+nslEciQ6Oo6pmMqdrshGItPYvzQ==
X-Google-Smtp-Source: ABdhPJzFuDYy2HXirVSN8m4kVSxyFtzu/rAqQO+HWXXTu4ckBtBlTMt0JZv9nbNGkSAiXqdJK67uZvxsc5Dt0T3oK2I=
X-Received: by 2002:a9d:2ab:: with SMTP id 40mr11799803otl.280.1607306453303;
 Sun, 06 Dec 2020 18:00:53 -0800 (PST)
MIME-Version: 1.0
References: <fea4dd48-fd8b-823c-0a4b-20ebcd804597@molgen.mpg.de>
 <20201204152802.GQ441757@mit.edu> <93fab357-5ed2-403d-3371-6580aedecaf4@molgen.mpg.de>
 <20201204180541.GC577125@mit.edu> <51a1939c-2a99-e86a-1799-c31248e21d89@molgen.mpg.de>
 <20201206144416.GM13361@riva.ucam.org> <20201206182748.GA30693@riva.ucam.org>
In-Reply-To: <20201206182748.GA30693@riva.ucam.org>
From:   Dimitri John Ledkov <xnox@ubuntu.com>
Date:   Mon, 7 Dec 2020 02:00:42 +0000
Message-ID: <CANBHLUjzMSvFmUD-vBxQdAcGuyjvQ1pBSP3DzphqvXNTc4MJPA@mail.gmail.com>
Subject: Re: ext4: Funny characters appended to file names
To:     Colin Watson <cjwatson@debian.org>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

On Sun, 6 Dec 2020, 18:28 Colin Watson, <cjwatson@debian.org> wrote:
>
> On Sun, Dec 06, 2020 at 02:44:16PM +0000, Colin Watson wrote:
> > So, in the RESTORE_BACKUP case, shouldn't that be:
> >
> >   char *dstf = grub_util_path_concat (2, di, de->d_name);
> >
> > ... rather than grub_util_path_concat_ext?  Otherwise it seems to me
> > that it's going to try to append an additional argument which doesn't
> > exist, and may well add random uninitialised stuff from memory.  Running
> > grub-install under valgrind would probably show this up (I can't get it
> > to do it for me so far, but most likely I just haven't set up quite the
> > right initial conditions).
>
> While I couldn't reproduce this on amd64 (and valgrind didn't show any
> errors), I can reproduce it just fine on i386, which is what Paul is
> using.  I guess the va_list layout in memory is different enough between
> the two ABIs to tickle this.
>

Indeed, my patch was not tested on i386 and has had limited reviews
before landing in Ubuntu. Still not reviewed on the upstream mailing
list.

I am sorry for causing this issue.

> I'll apply this patch for Debian grub2 2.04-11, which I've confirmed
> fixes it for me:
>
> diff --git a/util/grub-install-common.c b/util/grub-install-common.c
> index a883b6dae..61f9075bc 100644
> --- a/util/grub-install-common.c
> +++ b/util/grub-install-common.c
> @@ -247,7 +247,7 @@ clean_grub_dir_real (const char *di, enum clean_grub_dir_mode mode)
>             }
>           else if (mode == RESTORE_BACKUP)
>             {
> -             char *dstf = grub_util_path_concat_ext (2, di, de->d_name);
> +             char *dstf = grub_util_path_concat (2, di, de->d_name);
>               dstf[strlen (dstf) - 1] = 0;
>               if (grub_util_rename (srcf, dstf) < 0)
>                 grub_util_error (_("cannot restore `%s': %s"), dstf,
>
> Dimitri, I know Ubuntu isn't very interested in supporting i386, but IMO
> you should apply this patch to Ubuntu in any case; it might affect other
> architectures, and anyway leaving known undefined behaviour around isn't
> a good idea.
>

Will do. And will resend it to the grub mailing list.

> Paul, note that you'll also need to run "sudo rm -f
> /boot/grub/i386-pc/*.{img,lst,mo,mod,o,sh}-*" to clean up the stray
> files created by this bug.

Thank you everyone for the code review.
