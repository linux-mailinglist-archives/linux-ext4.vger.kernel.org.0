Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417672580F4
	for <lists+linux-ext4@lfdr.de>; Mon, 31 Aug 2020 20:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbgHaSWL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 31 Aug 2020 14:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729702AbgHaSWL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 31 Aug 2020 14:22:11 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB57C061575
        for <linux-ext4@vger.kernel.org>; Mon, 31 Aug 2020 11:22:11 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id k25so4813598ljg.9
        for <linux-ext4@vger.kernel.org>; Mon, 31 Aug 2020 11:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jTgzspytD7DuzYJj7jRzial3MrRwpGnfxvjiXd0RJrg=;
        b=N2g1q/JlCxdx+13x2JZxaLmluk+WXW7bphbyfghBpkD0grHOsaVxOS8iWElJyflhut
         uEXYE1QCTv5zYzdWdWQOCnGSPE6RMGzxGSXeCBlSKmDD75jiddhL9VLF8BzVEifBSp3x
         TiMDN4tgP6a/sYMe98YwS0rxdCl8ccDfbJ8cU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jTgzspytD7DuzYJj7jRzial3MrRwpGnfxvjiXd0RJrg=;
        b=tqomXUdVq6WDGGbN9BArk5YZaHoimhg8jP6mDtMcjwwhlFHxJvFVma0dvz+7bVJCu5
         cYNe//rwPZ67VgWL/dYJWu0DYIuPBYS24HR814VPi6EfYD2Clp2whEyxEkHwUOlwyf2T
         a/D8kzdKMD4IlgetjRTUSpw7Kxm8sYq/bD4YQch8UAIVC7PFCCtqKSaSwWtk7brhAWmT
         /LzoywGjYyjGKyHuPYiEsGAB2wyZM2dZ4htcbgKqBv2oeQt+aHsvYd8URE7toAHjGz1v
         Yw03CyoH5IXxp9uQDFYldiudnyvdDU4Mj3vOq8jV1Rk3AjWzBd4iXM97xwdJdhbwysVv
         t8Mg==
X-Gm-Message-State: AOAM5318YanWjstnfO4w3KUE8kJVK63nJIe46o3Kb61ZaUBiQclaccLR
        QekUXmar3JxXzIskLQiJU7R+pcLtDSq3hw==
X-Google-Smtp-Source: ABdhPJzQ8PO+ZBp0O2HlA4TLAf85XqT5VDx+ss3vrDsLcm9YlCKuO0+beTGnq4qf8eADspSnKuKwwQ==
X-Received: by 2002:a05:651c:1119:: with SMTP id d25mr1070321ljo.300.1598898128684;
        Mon, 31 Aug 2020 11:22:08 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id w6sm2144020lfn.73.2020.08.31.11.22.07
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 11:22:07 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id i10so7860706ljn.2
        for <linux-ext4@vger.kernel.org>; Mon, 31 Aug 2020 11:22:07 -0700 (PDT)
X-Received: by 2002:a05:651c:219:: with SMTP id y25mr1144547ljn.314.1598898126633;
 Mon, 31 Aug 2020 11:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000d3a33205add2f7b2@google.com> <20200828100755.GG7072@quack2.suse.cz>
 <20200831100340.GA26519@quack2.suse.cz>
In-Reply-To: <20200831100340.GA26519@quack2.suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 31 Aug 2020 11:21:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wivRS_1uy326sLqKuwerbL0APyKYKwa+vWVGsQg8sxhLw@mail.gmail.com>
Message-ID: <CAHk-=wivRS_1uy326sLqKuwerbL0APyKYKwa+vWVGsQg8sxhLw@mail.gmail.com>
Subject: Re: kernel BUG at fs/ext4/inode.c:LINE!
To:     Jan Kara <jack@suse.cz>
Cc:     syzbot <syzbot+3622cea378100f45d59f@syzkaller.appspotmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Linux-MM <linux-mm@kvack.org>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 31, 2020 at 3:03 AM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 28-08-20 12:07:55, Jan Kara wrote:
> >
> > Doh, so this is:
> >
> >                         wait_on_page_writeback(page);
> > >>>                     BUG_ON(PageWriteback(page));
> >
> > in mpage_prepare_extent_to_map(). So we have PageWriteback() page after we
> > have called wait_on_page_writeback() on a locked page. Not sure how this
> > could ever happen even less how ext4 could cause this...
>
> I was poking a bit into this and there were actually recent changes into
> page bit waiting logic by Linus. Linus, any idea?

So the main change is that now if somebody does a wake_up_page(), the
page waiter will be released - even if somebody else then set the bit
again (or possible if the waker never cleared it!).

It used to be that the waiter went back to sleep.

Which really shouldn't matter, but if we had any code that did something like

        end_page_writeback();
        .. something does set_page_writeback() on the page again ..

then the old BUG_ON() would likely never have triggered (because the
waiter would have seen the writeback bit being set again and gone back
to sleep), but now it will.

So I would suspect a pre-existing issue that was just hidden by the
old behavior and was basically impossible to trigger unless you hit
*just* the right timing.

And now it's easy to trigger, because the first time somebody clears
PG_writeback, the wait_on_page_writeback() will just return *without*
re-testing and *without* going back to sleep.

Could there be somebody who does set_page_writeback() without holding
the page lock?

Maybe adding a

        WARN_ON_ONCE(!PageLocked(page));

at the top of __test_set_page_writeback() might find something?

Note that it looks like this problem has been reported on Android
before according to that syzbot thing. Ie, this thing:

    https://groups.google.com/g/syzkaller-android-bugs/c/2CfEdQd4EE0/m/xk_GRJEHBQAJ

looks very similar, and predates the wake_up_page() changes.

So it was probably just much _harder_ to hit before, and got easier to hit.

Hmm. In fact, googling for

        mpage_prepare_extent_to_map "kernel BUG"

seems to find stuff going back years. Here's a patchwork discussion
where you had a debug patch to try to figure it out back in 2016:

    https://patchwork.ozlabs.org/project/linux-ext4/patch/20161122133452.GF3973@quack2.suse.cz/

although that one seems to be a different BUG_ON() in the same area.

Maybe entirely unrelated, but the fact that this function shows up a
fair amount is perhaps a sign of some long-running issue..

              Linus
