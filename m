Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD9C2C49EB
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Nov 2020 22:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732201AbgKYVao (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 Nov 2020 16:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732177AbgKYVao (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 Nov 2020 16:30:44 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A32C0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 25 Nov 2020 13:30:44 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id d8so5194016lfa.1
        for <linux-ext4@vger.kernel.org>; Wed, 25 Nov 2020 13:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tOPQoHjgvYUvh+HHnKxiG8jONSzsA15qJMnLlNlgP0M=;
        b=g9y81DNQmmhmWGTiGwiN1BpWJR901eSsmOaWRaDAPAF045hxvt7onry/8Zvu9QMIoO
         Mj7cMnjDGxU6hMF6tVoIt4bsojN6gPJ4SXLznmP+jMHmyniwn5WHjj2vQ6xOOO0OJlr6
         V8poGWCE2wHSk99omymX/xHLo/xmK1pAoTF0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tOPQoHjgvYUvh+HHnKxiG8jONSzsA15qJMnLlNlgP0M=;
        b=Qk/FqGTNgckvOg6htY6RrjA6VAdNtWwP/r6l+yhAFzRVl98fADAGSXF3I/XH/C9onO
         2Sr1qZMY08QRj9HIsNF9RXnwSMrAJrS2JrVYr8rFA0ZKqLVNVdIlMCDZNXSQY7Z1Ubf3
         UQTVemijM0Lj8QYja6V3j+OR/Z+c+OUNAcHttBhTBB+QMYUf9bDMGIudjQVXoa9vXwA3
         +54/OViL/M9fB77izlGnonePilhlI9xbrdTNKZAK5ps1batadgYPcWI59adHThMVOx3a
         B7xXZLhzPBZN5CppBYvbGxqs76uuOeX6KfjFYnKd+tz9fYVpks8DNbTYQ42+xbeot3MN
         4uLg==
X-Gm-Message-State: AOAM531ouAolcy2nYi6we/2//t8lXNNLkG0DRG7JXAknyLTNdJTKwfGC
        YTqkkGn2K21bd/bM9nxf2SDs2zgSZsbU5Q==
X-Google-Smtp-Source: ABdhPJzX5FCG8T58fXRuXsdHHHK4rC2nb5UyPxd9ZWMclCtVcORYTb169VndGqEscqQ2SyfXaNXTgw==
X-Received: by 2002:a19:c705:: with SMTP id x5mr76577lff.16.1606339842181;
        Wed, 25 Nov 2020 13:30:42 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id j131sm60234lfd.209.2020.11.25.13.30.37
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2020 13:30:40 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id f24so3773315ljk.13
        for <linux-ext4@vger.kernel.org>; Wed, 25 Nov 2020 13:30:37 -0800 (PST)
X-Received: by 2002:a05:651c:339:: with SMTP id b25mr15104ljp.285.1606339837289;
 Wed, 25 Nov 2020 13:30:37 -0800 (PST)
MIME-Version: 1.0
References: <000000000000d3a33205add2f7b2@google.com> <20200828100755.GG7072@quack2.suse.cz>
 <20200831100340.GA26519@quack2.suse.cz> <CAHk-=wivRS_1uy326sLqKuwerbL0APyKYKwa+vWVGsQg8sxhLw@mail.gmail.com>
 <alpine.LSU.2.11.2011231928140.4305@eggly.anvils> <20201124121912.GZ4327@casper.infradead.org>
 <alpine.LSU.2.11.2011240810470.1029@eggly.anvils> <20201124183351.GD4327@casper.infradead.org>
 <CAHk-=wjtGAUP5fydxR8iWbzB65p2XvM0BrHE=PkPLQcJ=kq_8A@mail.gmail.com>
 <20201124201552.GE4327@casper.infradead.org> <CAHk-=wj9n5y7pu=SVVGwd5-FbjMGS6uoFU4RpzVLbuOfwBifUA@mail.gmail.com>
 <alpine.LSU.2.11.2011241322540.1777@eggly.anvils> <CAHk-=wjiVtroOvNkuptH0GofVUvOMw4wmmaXdnGPPT8y8+MbyQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjiVtroOvNkuptH0GofVUvOMw4wmmaXdnGPPT8y8+MbyQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 25 Nov 2020 13:30:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wix0YNq1U8iroRLpx+fCUGE8RG3asY8Zm4vyH-g4UhbPg@mail.gmail.com>
Message-ID: <CAHk-=wix0YNq1U8iroRLpx+fCUGE8RG3asY8Zm4vyH-g4UhbPg@mail.gmail.com>
Subject: Re: kernel BUG at fs/ext4/inode.c:LINE!
To:     Hugh Dickins <hughd@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        syzbot <syzbot+3622cea378100f45d59f@syzkaller.appspotmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Linux-MM <linux-mm@kvack.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>, Qian Cai <cai@lca.pw>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Nov 24, 2020 at 3:24 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I've applied your second patch (the smaller one that just takes a ref
> around the critical section). If somebody comes up with some great
> alternative, we can always revisit this.

Hmm.

I'm not sure about "great alternative", but it strikes me that we
*could* move the clearing of the PG_writeback bit _into_
wake_up_page_bit(), under the page waitqueue lock.

IOW, we could make the rule be that the bit isn't actually cleared
before calling wake_up_page() at all, and we'd clear it with something
like

    unsigned long flags = READ_ONCE(page->flags);

    // We can clear PG_writeback directly if PG_waiters isn't set
    while (!(flags & (1ul << PG_waiters))) {
        unsigned long new = flags & ~(1ul << PG_writeback);
        // PG_writeback was already clear??!!?
        if (WARN_ON_ONCE(new == flags))
            return;
        new = cmpxchg(&page->flags, flags, new);
        if (likely(flags == new))
            return;
        flags = new;
    }

    // Otherwise, clear the bit at the end - but under the
    // page waitqueue lock - inside wake_up_page_bit()
    return wake_up_page_bit(..);

instead.

That would basically make the bit clearing atomic wrt the PG_waiters
flags - either using that atomic cmpxchg, or by doing it under the
page queue lock so that it's atomic wrt any new waiters.

This seems conceptually like the right thing to do - and if would also
make the (fair) exclusive lock hand-off case atomic too, because the
bit we're waking up on would never be cleared if it gets handed off
directly.

The above is entirely untested crap written in my MUA, and obviously
requires that all callers of wake_up_page() be moved to that new world
order, but I think we only have two cases: unlock_page() and
end_page_writeback().

And unlock_page() already has that
"clear_bit_unlock_is_negative_byte()" special case that is an ugly
special case of PG_waiters atomicity. So we'd get rid of that, because
the cmpxchg loop would be the better model.

I'm not sure I'm willing to write and test the real patch, but it
doesn't look _too_ nasty from just looking at the code. The bookmark
thing makes it important to only actually clear the bit at the end (as
does the handoff case anyway), but the way wake_up_page_bit() is
written, that's actually very straightforward - just after the
while-loop. That's when we've woken up everybody.

So I'm sending this idea out to see if somebody can shoot it down, or
even wants to possibly even try to do it..

                Linus
