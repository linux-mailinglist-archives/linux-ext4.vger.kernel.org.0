Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC31372F49
	for <lists+linux-ext4@lfdr.de>; Tue,  4 May 2021 19:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbhEDR4x (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 May 2021 13:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbhEDR4w (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 May 2021 13:56:52 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6C8C061574
        for <linux-ext4@vger.kernel.org>; Tue,  4 May 2021 10:55:56 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id bf4so11462875edb.11
        for <linux-ext4@vger.kernel.org>; Tue, 04 May 2021 10:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qtuEpSCg/7s4b5vl3KazTzn9xnICLhC5I6tlL0eGJGI=;
        b=Kfq66d1WcChUHakszW35qenu9Sc+JOxKgfrF6Bq7FhyTDKQnPhldOygya/2r7BtUKM
         AShVj6X7hBNm5fRr5KJfONTHa6G+a0ULuD+qh9AHiUgjTqTqALTH976xF2g1EM3LDOyQ
         /BIftHLMwAnEH0ZgMmy+F8sI2Ug5yYBv5XR3XEh95G1gw1QleiABd9SByJl1DevXTWMr
         GwZzB2x5l1AYGOIIEGUFD7yL0tXa3dvz3Y1+1PWMUhOvJrVh1U/jlSFPr8ws/fC/ZRKw
         PufSVvC8wx0EqqwNMJ8qjIgwUtAJRGPRAkl9R+YxuteAfIfO30fgTAMQ8o/er9HvoyMo
         z3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qtuEpSCg/7s4b5vl3KazTzn9xnICLhC5I6tlL0eGJGI=;
        b=aKUE/4lE01r1jAJBUZXlhT8PuIJR/up0hJYLmIN3CY/QjoqyEfRWEg0pg90rbNi8WD
         yCUs8L+n3iVXvfKynuU9BVOE7Ir2xEI4MFCjQD6DeVqHesqKpgpo6EltW9nV5ApSh751
         fPBuzyPCMngGuk1q1jAV+CSXJPFwHHd64+lPn6X7b87Jq5odsmKlyNYe/8aIwrF+hleS
         KFwon3KLre+ThF+D3uXIuxYa3MhBGJ+evKiTiKqpF0ujcpntBi6XehJ95PICz3oItEfk
         EIsriLXZWilGXsN8JpjF0qI/mMWKZQQfGsEC373vtUrhDUXv3bbTpiCan50oLYak80Vw
         R0YA==
X-Gm-Message-State: AOAM533fu8AI+jXUuDRwGq80JU+wKj4l9DrP6bfoxwytvIMctFbZO0Y3
        DuOfECzXnjx87DFARW0YjBT3Vg1eZeQv+YNU26o=
X-Google-Smtp-Source: ABdhPJztkDHEWQnh5B3Me1uicAqloc8tCUuNp4N9ywTpWMJLhAKbbu915rCWpPjVpM0ejcf+RuPW7/tLbkRkBrx+m/Y=
X-Received: by 2002:a50:bb27:: with SMTP id y36mr27492912ede.365.1620150955456;
 Tue, 04 May 2021 10:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210504031024.3888676-1-tytso@mit.edu> <8E9C71E8-FE5F-4CB8-BA62-8D8895DCA92A@dilger.ca>
 <CAD+ocbx9STMGrE0xkHtR8J_c_TgMEz1A6MmNOQyrQtakoZjq3Q@mail.gmail.com>
 <YJFQ20rLK16rise2@mit.edu> <YJF6W7WHZBcVZexU@gmail.com>
In-Reply-To: <YJF6W7WHZBcVZexU@gmail.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Tue, 4 May 2021 10:55:44 -0700
Message-ID: <CAD+ocby+01k9kx3-gEY_z+Ub9GFxi=AwxRS4Ax5-HUFDrVkT0w@mail.gmail.com>
Subject: Re: [PATCH] e2fsck: fix portability problems caused by unaligned accesses
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Harshad Shirwadkar <harshads@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, May 4, 2021 at 9:46 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Tue, May 04, 2021 at 09:49:15AM -0400, Theodore Ts'o wrote:
> > On Tue, May 04, 2021 at 02:40:08AM -0700, harshad shirwadkar wrote:
> > > Hi Ted,
> > >
> > > Thanks for the patch. While I now see that these accesses are safe,
> > > ubsan still complains about it the dereferences not being aligned.
> > > With your changes, the way we read journal_block_tag_t is now safe.
> > > But IIUC, ubsan still complains mainly because we still pass the
> > > pointer as "&tag->t_flags" and at which point ubsan thinks that we are
> > > accessing member t_flags in an aligned way. Is there a way to silence
> > > these errors?
> >
> > Yeah, I had noticed that.  I was thinking perhaps of doing something
> > like casting the pointer to void * or char *, and then adding offsetof
> > to work around the UBSAN warning.  Or maybe asking the compiler folks
> > if they can make the UBSAN warning smarter, since what we're doing
> > should be perfectly safe.
>
> This does seem to be an UBSAN bug, although both gcc and clang report this same
> error, which is odd...  Dereferencing a misaligned field would be undefined
> behavior, but just taking its address isn't (AFAIK).
>
> >
> > >
> > > I was wondering if it makes sense to do something like this for known
> > > unaligned structures:
> > >
> > > journal_block_tag_t local, *unaligned;
> > > ...
> > > memcpy(&local, unaligned, sizeof(&local));
> >
> > I guess that would work too.  The extra memory copy is unfortunate,
> > although I suspect the performance hit isn't measurable, and journal
> > replay isn't really a hot path in either the kernel or e2fsprogs.
> > (Note that want to keep recovery.c in sync between the kernel and
> > e2fsprogs, so whatever we do needs to be something we're happy with in
> > both places.)
> >
>
> Modern compilers will optimize out the memcpy().
>
> However, wouldn't it be easier to just add __attribute__((packed)) to the
> definition of struct journal_block_tag_t?
While we know that journal_block_tag_t can be unaligned, our code
should still ensure that we are reading this struct in an
alignment-safe way (like Ted's patch does). IIUC, using
__attribute__((packed)) might result in us keeping the door open for
unaligned accesses in future. If someone tries to read 4 bytes
starting at &journal_block_tag_t->t_flags, with attribute packed,
UBSAN won't complain but this may still cause issues on some
architectures.

Another option would be to define wrappers that access known unaligned
structures in an alignment safe way and declare those wrappers with
__attribute__((no_sanitize("undefined")). This would both make sure
that we always access unaligned structs in an alignment safe way and
also would get rid of UBSAN warnings.

- Harshad

>
> - Eric
