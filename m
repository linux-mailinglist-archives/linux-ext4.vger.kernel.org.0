Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF2861FD26
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 19:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbiKGSRG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 13:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbiKGSQq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 13:16:46 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AA8264A5
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 10:15:34 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id l14so17519023wrw.2
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 10:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5Tz8IZfGoPgnfx/bQHxfKSF03+PZq5dd5NjP7qUsSs=;
        b=q87MNd8TtB8j20rP7SQgYBe7eJa/izf+IQTU+g2EyNF4m8pvl7EyUoYj4f9NN3+wx9
         tuHKhYIQDJDbYfVVqyv/ik018CcgrMU1u5qiLNAsNE4wKHjC6d64WuH+KHGV03jXdhT3
         yX6vAqPzOpUdJ91YtBJK/ww1FnfByqZD6vMfht79PSmix3/gcoxj0lvZ3RSxoKKljFj2
         JKEifxkXSzrhDVljef8LIp3Gf3Si9GLbBQUB8ZEt9ekxtyY7gpTBC3xfUZSbhs54jbG4
         1Tm+gahWSUWclNTLtyo08PHGViCe19g1+k1FAprPwfkDnI2HcpcGYxHOlSB6mkLQYCyv
         VooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5Tz8IZfGoPgnfx/bQHxfKSF03+PZq5dd5NjP7qUsSs=;
        b=smGmn6Rqq+iXmIy5+6oLVnCipoPo7wEHszKT34R+/kWTSlOpjlgNOvhy8bfqeEqTrV
         Pt3AMCO0mjMYSUo4X1xnpe1dJA0fXJA236aWx0mMtknmX5A71e+a/ychKtKT0Ima7Wdv
         9Mcym1NbJZUKjpk2XYlrG42GfzWT2eiQj7j8M4PG8HpKjicnlKhKKZM+XyRy5S/Saq+n
         kJYoSXDr5rRhDeITCCs1p+KmcWHe6Za+N8+9TKzTxee3wX2LRr7d3BO77tJKnBqj/Y3f
         f5YgAa5Ez0QbrjKZh2pl7gue5JftHlfswbRL0wo7yMJFxJt2rRX1TxlipHL9oRMeK5XJ
         Rvlg==
X-Gm-Message-State: ACrzQf32kdgD0gPM7jKYn/O+QzXIkj1s7XsnaO/578fyY1JeMINZQvkE
        g+Mgr+GzyR6RCGSJy3WXc3Pfrn6nCD5CjQxtoeF1f/E3ZZDPPgsR
X-Google-Smtp-Source: AMsMyM7jqFk+lQGLmFgct3ETFMtVuA20zKX36vz22AqlnyD6XF6a5durGSLgZo0vlOBZi6pAsAAsf0OlTEYpWzWByGY=
X-Received: by 2002:adf:ec4f:0:b0:236:60c6:6e59 with SMTP id
 w15-20020adfec4f000000b0023660c66e59mr600213wrn.102.1667844932778; Mon, 07
 Nov 2022 10:15:32 -0800 (PST)
MIME-Version: 1.0
References: <00000000000058d01705ecddccb0@google.com> <CAG_fn=WAyOc+1GEC+P3PpTM2zLcLcepAX1pPXkj5C6aPyrDVUA@mail.gmail.com>
 <Y2lGu/QTIWNpzFI3@sol.localdomain>
In-Reply-To: <Y2lGu/QTIWNpzFI3@sol.localdomain>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 7 Nov 2022 19:14:55 +0100
Message-ID: <CAG_fn=VQBv-sgPhT0gLVChAtMNx0F3RcQYDKdvhBL4mBpiDkFA@mail.gmail.com>
Subject: Re: [syzbot] KMSAN: uninit-value in pagecache_write
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     syzbot <syzbot+9767be679ef5016b6082@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Nov 7, 2022 at 6:56 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Mon, Nov 07, 2022 at 10:46:13AM +0100, 'Alexander Potapenko' via syzka=
ller-bugs wrote:
> >    ext4: initialize fsdata in pagecache_write()
> >
> >     When aops->write_begin() does not initialize fsdata, KMSAN reports
> >     an error passing the latter to aops->write_end().
> >
> >     Fix this by unconditionally initializing fsdata.
> >
> >     Fixes: c93d8f885809 ("ext4: add basic fs-verity support")
> >     Reported-by: syzbot+9767be679ef5016b6082@syzkaller.appspotmail.com
> >     Signed-off-by: Alexander Potapenko <glider@google.com>
> >
> > diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
> > index 3c640bd7ecaeb..30e3b65798b50 100644
> > --- a/fs/ext4/verity.c
> > +++ b/fs/ext4/verity.c
> > @@ -79,7 +79,7 @@ static int pagecache_write(struct inode *inode,
> > const void *buf, size_t count,
> >                 size_t n =3D min_t(size_t, count,
> >                                  PAGE_SIZE - offset_in_page(pos));
> >                 struct page *page;
> > -               void *fsdata;
> > +               void *fsdata =3D NULL;
> >                 int res;
> >
> >                 res =3D aops->write_begin(NULL, mapping, pos, n, &page,=
 &fsdata);
>
> Are you sure that KMSAN should be reporting this?  The uninitialized valu=
e is
> passed as a function parameter, but it's never actually used.

To summarize what's written here:
https://lore.kernel.org/lkml/20220701142310.2188015-44-glider@google.com/
:
 - this is UB from the C11 standpoint;
 - Linus despises UB in general, but expecting function arguments to
be initialized is reasonable;
 - if a function ends up being a no-op, tools should not warn about
uninits passed to it;
 - KMSAN only warns about functions that survive inlining.

In addition, one cannot really rely on write_end() being consistent
with write_begin(), in particular if fsdata was ignored initially and
only appeared at a later point.

>
> Anyway, this patch doesn't hurt, I suppose.  Can please you send it out a=
s a
> formal patch to linux-ext4?  It would be easy for people to miss this pat=
ch
> buried in this thread.  Also, can you please send a patch to linux-f2fs-d=
evel
> for the same code in fs/f2fs/verity.c?

Will do!

> Thanks!
>
> - Eric



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
