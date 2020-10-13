Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D363F28C5A6
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Oct 2020 02:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgJMA17 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Oct 2020 20:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgJMA17 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Oct 2020 20:27:59 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92660C0613D0
        for <linux-ext4@vger.kernel.org>; Mon, 12 Oct 2020 17:27:57 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id md26so25777566ejb.10
        for <linux-ext4@vger.kernel.org>; Mon, 12 Oct 2020 17:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jU7d2T/khEATEDcvFC6me0bLeg9QZQH9KX2l9d+78bk=;
        b=ZWjs0UCH7ILo3RePIQjYSq/6SLDC6kCMeZ38X5vUdsE9wL6w7dDsISML/sgq7y2Wfq
         BpwDe9NcNEEsCYL9wDF9pq/22CsrewIFnnvxBRBbR9owCjMX3OacqsdyYW4hNnCmbftg
         JtKQR6e5fZ6AvZsbTdP8uGc9cvivMR4Hh5asJZdqo1EYttla89CORaFblCe9aGYOmWPM
         Y7tUgEdcIn6S+dAflfWOXkAVtE86M7/R7JTuV7hsArVLxOIKHzwysKS9BOUumlWzNv+i
         6ALrC0xsIXwY7m97ThDjL7YWsRCNGAgHaeDRZdXeEzyW8M5L6WQwOErSoRUzFl4PcXBg
         LloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jU7d2T/khEATEDcvFC6me0bLeg9QZQH9KX2l9d+78bk=;
        b=dLCV12ERU47B85kplrilJDqLCOUNaAI5zbLPth3DDGNDrH7zU95McRz0Ex2+ybm60k
         BwIo4SGgyDGo4NbWfzZaHK2i2Jd6QRSZuQBgvAh3JzgilGZUG/LTSVDiyvWLxmPazKHv
         EjgEnSyLDEzxw9W8cB3QcnUNZJI87KRVq2Kzjba+kqn7V7PyzGg/tGUpS/m7i2RKSb64
         +Mzv4Xbzlnyh5NKqk/1TnnqcDTOgF10HAqfBMONWeAo6Q9TkiapW5zmofRwhrZLlhj8d
         GdOEZ9DSGt5RWKMjxYrSnUEwHxdLGyz3eBiQKODzevU78MTrdszo5aakoXzd76kQOLY9
         MAjw==
X-Gm-Message-State: AOAM533MrL+lc1deLna6sepvAS3L5CxgFrPkk2g4Ku5pKWIXqQF75hlC
        ziKl5WRpoasi4MVfJtfCLG1ZT9ouqfzYY0+gKwI=
X-Google-Smtp-Source: ABdhPJwMxISklr3Hfz73QOkm/zkenZkmH7OgeJxUCIIDpMkPCf3YiSOy2BRB5MKUoGq5TBY8cVmNMVPXbX3nP0frlX0=
X-Received: by 2002:a17:906:354e:: with SMTP id s14mr15001012eja.192.1602548876298;
 Mon, 12 Oct 2020 17:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200919005451.3899779-1-harshadshirwadkar@gmail.com>
 <20200919005451.3899779-3-harshadshirwadkar@gmail.com> <20201009175836.GM235506@mit.edu>
In-Reply-To: <20201009175836.GM235506@mit.edu>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Mon, 12 Oct 2020 17:27:44 -0700
Message-ID: <CAD+ocbzqkEu-s7j+An+b3bLUq35cxQwOhH8sFH_CyG8xyszosw@mail.gmail.com>
Subject: Re: [PATCH v9 2/9] ext4: add fast_commit feature and handling for
 extended mount options
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Oct 9, 2020 at 10:58 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Fri, Sep 18, 2020 at 05:54:44PM -0700, Harshad Shirwadkar wrote:
> > We are running out of mount option bits. Add handling for using
> > s_mount_opt2. Add ext4 and jbd2 fast commit feature flag and also add
> > ability to turn on / off the fast commit feature in Ext4.
>
> Shouldn't that read "...ability to turn off the fast commit feature via a
> mount option"?
>
> > @@ -2207,10 +2211,17 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
> >                       WARN_ON(1);
> >                       return -1;
> >               }
> > -             if (arg != 0)
> > -                     sbi->s_mount_opt |= m->mount_opt;
> > -             else
> > -                     sbi->s_mount_opt &= ~m->mount_opt;
> > +             if (m->flags & MOPT_2) {
> > +                     if (arg != 0)
> > +                             sbi->s_mount_opt2 |= m->mount_opt;
> > +                     else
> > +                             sbi->s_mount_opt2 &= ~m->mount_opt;
> > +             } else {
> > +                     if (arg != 0)
> > +                             sbi->s_mount_opt |= m->mount_opt;
> > +                     else
> > +                             sbi->s_mount_opt &= ~m->mount_opt;
> > +             }
> >       }
> >       return 1;
> >  }
>
>
> This requires a matching change in _ext4_show_options(), so that the
> MOPT_2 options are properly displayed in /proc/mounts.
Thanks for pointing that out, I'll add this in V10.

Thanks,
Harshad
>
>                                                 - Ted
