Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C152C307E
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Nov 2020 20:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404418AbgKXTGY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Nov 2020 14:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404416AbgKXTGW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 Nov 2020 14:06:22 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4919DC0617A6
        for <linux-ext4@vger.kernel.org>; Tue, 24 Nov 2020 11:06:22 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id q3so22011768edr.12
        for <linux-ext4@vger.kernel.org>; Tue, 24 Nov 2020 11:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UJx0vHStpjdpABeEWpHqZ5R1kGbrDvDIbtQyZ0Zhqxc=;
        b=dmXydy1iMYMcd0XA86NtUQBuK77rLN5v+kCemhoSI8sSKW0ZRUU4BOa40Nc/j8TZ1H
         sUEPaPfvxYlaUXBxTnerkp0eTXuq+POTIYnXmeE1NOsrDnQWhHfi6trKluzdjlU1lbtI
         5f/uYvPlgWdyj4CpKpPEHo4H4FSJGyyvBfUWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UJx0vHStpjdpABeEWpHqZ5R1kGbrDvDIbtQyZ0Zhqxc=;
        b=J+j+N/NNGy2ylWzo1ABdHAeSBSyafElLb1VahJS8yo+4uVJcHfTCq0g+g1Z56Bz5N5
         0y27Z+FyIeTkc3T8HMhttVlOyElJjOs38T7Y+NoNqBJLh+D/+UPA2etuzNJjb+R28zba
         rT31nRzesqBmISNrFHW/AKdgnhAwSWAlXefepTrrFofRa9B54NjzuYIyLZnYXtE68UoW
         gTC2dsAiWLFuEhdi6WkKa1gyY7nvgC4oZHpfWMIJgWCSjt5zHbIcT/kXjbSkLoGCmUy+
         9bQYVnytTjTK/vlH+UBs93v32POCjWje+EaXiYZez2SC734jSmkEbzgq0bwKi+Ufpate
         Vvkw==
X-Gm-Message-State: AOAM530W/2FDx6ZdMibtP709I6ApwMBSG0qRI84OzEjkpNZIxGtEn7pT
        DMZdfCfNpVfaB0uIpaS+3t/lrdb1t/nzQw==
X-Google-Smtp-Source: ABdhPJxdxSkakxhCNQqEEdAGj6/etWjAtB0WQ2jEijQVFFKaWApCJ5jBTYglMATfGEXQbP5WWLwMYg==
X-Received: by 2002:aa7:c2d6:: with SMTP id m22mr5632914edp.368.1606244780725;
        Tue, 24 Nov 2020 11:06:20 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id j6sm7546209edy.87.2020.11.24.11.06.20
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 11:06:20 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id q16so22031683edv.10
        for <linux-ext4@vger.kernel.org>; Tue, 24 Nov 2020 11:06:20 -0800 (PST)
X-Received: by 2002:a05:651c:339:: with SMTP id b25mr2577530ljp.285.1606244458511;
 Tue, 24 Nov 2020 11:00:58 -0800 (PST)
MIME-Version: 1.0
References: <000000000000d3a33205add2f7b2@google.com> <20200828100755.GG7072@quack2.suse.cz>
 <20200831100340.GA26519@quack2.suse.cz> <CAHk-=wivRS_1uy326sLqKuwerbL0APyKYKwa+vWVGsQg8sxhLw@mail.gmail.com>
 <alpine.LSU.2.11.2011231928140.4305@eggly.anvils> <20201124121912.GZ4327@casper.infradead.org>
 <alpine.LSU.2.11.2011240810470.1029@eggly.anvils> <20201124183351.GD4327@casper.infradead.org>
In-Reply-To: <20201124183351.GD4327@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Nov 2020 11:00:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjtGAUP5fydxR8iWbzB65p2XvM0BrHE=PkPLQcJ=kq_8A@mail.gmail.com>
Message-ID: <CAHk-=wjtGAUP5fydxR8iWbzB65p2XvM0BrHE=PkPLQcJ=kq_8A@mail.gmail.com>
Subject: Re: kernel BUG at fs/ext4/inode.c:LINE!
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
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

On Tue, Nov 24, 2020 at 10:33 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> We could fix this by turning that 'if' into a 'while' in
> write_cache_pages().

That might be the simplest patch indeed.

At the same time, I do worry about other cases like this: while
spurious wakeup events are normal and happen in other places, this is
a bit different.

This is literally a wakeup that leaks from a previous use of a page,
and makes us think that something could have happened to the new use.

The unlock_page() case presumably never hits that, because even if we
have some unlock without a page ref (which I don't think can happen,
but whatever..), the exclusive nature of "lock_page()" means that no
locker can care - once you get the lock, you own the page./

The writeback code is special in that the writeback bit isn't some
kind of exclusive bit, but this code kind of expected it to be that.

So I'd _like_ to have something like

        WARN_ON_ONCE(!page_count(page));

in the wake_up_page_bit() function, to catch things that wake up a
page that has already been released and might be reused..

And that would require the "get_page()" to be done when we set the
writeback bit and queue the page up for IO (so that then
end_page_writeback() would clear the bit, do the wakeup, and then drop
the ref).

Hugh's second patch isn't pretty - I think the "get_page()" is
conceptually in the wrong place - but it "works" in that it keeps that
"implicit page reference" being kept by the PG_writeback bit, and then
it takes an explicit page reference before it clears the bit.

So while I don't love the whole "PG_writeback is an implicit reference
to the page" model, Hugh's patch at least makes that model much more
straightforward: we really either have that PG_writeback, _or_ we have
a real ref to the page, and we never have that odd "we could actually
lose the page" situation.

So I think I prefer Hugh's two-liner over your one-liner suggestion.

But your one-liner is technically not just smaller, it obviously also
avoids the whole mucking with the atomic page ref.

I don't _think_ that the extra get/put overhead could possibly really
matter: doing the writeback is going to be a lot more expensive
anyway. And an atomic access to a 'struct page' sounds expensive, but
that cacheline is already likely dirty in the L1 cache because we've
touch page->flags and done other things to it).

So I'd personally be inclined to go with Hugh's patch. Comments?

                 Linus
