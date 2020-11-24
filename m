Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957B02C3205
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Nov 2020 21:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731233AbgKXUey (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Nov 2020 15:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731184AbgKXUex (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 Nov 2020 15:34:53 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9F0C061A4D
        for <linux-ext4@vger.kernel.org>; Tue, 24 Nov 2020 12:34:53 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id j205so30747329lfj.6
        for <linux-ext4@vger.kernel.org>; Tue, 24 Nov 2020 12:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AEOjqbrPL7ThHmqZn4HHPdQNZCU9KRjN0OANoYqF+LI=;
        b=YiUauuLl4oDGTRL45zuGDHR2J5VSlaFB7O6pBpiLin0jYi4oMDEyJ6WnB0ezsU1+lJ
         /Xr+VMmFy6Yl0v0tfocLf0a2OpJoR4jkrZf+QWqP87nKzXSlOFC8xx9JTBLeqme23GEA
         yBj2rHCTti3flo3PfXBjCwjdx6z70F417NynU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AEOjqbrPL7ThHmqZn4HHPdQNZCU9KRjN0OANoYqF+LI=;
        b=YCQJ5LjWDWh9mWC4G/fbYfEPkYdLoBZ4YuHgLjXntX1IwYaQsm7HPDmNNMyryGhp+V
         bPMGxsEFBPGbwzU/jEfua25X3bm22D4QdZQJxbs2Hr2XHjK7jqsvxmv1N3biJPHrkUdf
         v17WVY7mEiipxjV/vRY/Rlsg2u2lQfPANcMlXpAXJrMY0vlAF+LMDexZbVYyZsLZ20wS
         nMqdLhpMNXv4KSHkZkOo2J9pdyO///6jLXlDSqNv0kV+gLlOtik2p5GYwRjCETPUN1oy
         0HjRmArWoIDJStD8+96YmZtBqRRQUdZ7qQmjcOIBjcqaMsm4Af8T5/fsJjxSXJFxRHV/
         5+fQ==
X-Gm-Message-State: AOAM531yfUXmp5SbuStG9QTV30XBMPYmFRCx7SwolyxnsMiN5hrTbl3a
        RotSE5WMeFHAwPeitbMjRHeBXVmKzXBKMQ==
X-Google-Smtp-Source: ABdhPJyOEyZ0HAi8JsIR6lDhiAt1rBL5NKL2hFo+UuEdZBJzFthe81apF+VpYbDcFgtjVmBSgN4iZQ==
X-Received: by 2002:ac2:490c:: with SMTP id n12mr2233819lfi.311.1606250091131;
        Tue, 24 Nov 2020 12:34:51 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id r16sm18050lji.8.2020.11.24.12.34.49
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 12:34:50 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id b17so23534212ljf.12
        for <linux-ext4@vger.kernel.org>; Tue, 24 Nov 2020 12:34:49 -0800 (PST)
X-Received: by 2002:a2e:8701:: with SMTP id m1mr27321lji.314.1606250089295;
 Tue, 24 Nov 2020 12:34:49 -0800 (PST)
MIME-Version: 1.0
References: <000000000000d3a33205add2f7b2@google.com> <20200828100755.GG7072@quack2.suse.cz>
 <20200831100340.GA26519@quack2.suse.cz> <CAHk-=wivRS_1uy326sLqKuwerbL0APyKYKwa+vWVGsQg8sxhLw@mail.gmail.com>
 <alpine.LSU.2.11.2011231928140.4305@eggly.anvils> <20201124121912.GZ4327@casper.infradead.org>
 <alpine.LSU.2.11.2011240810470.1029@eggly.anvils> <20201124183351.GD4327@casper.infradead.org>
 <CAHk-=wjtGAUP5fydxR8iWbzB65p2XvM0BrHE=PkPLQcJ=kq_8A@mail.gmail.com> <20201124201552.GE4327@casper.infradead.org>
In-Reply-To: <20201124201552.GE4327@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Nov 2020 12:34:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj9n5y7pu=SVVGwd5-FbjMGS6uoFU4RpzVLbuOfwBifUA@mail.gmail.com>
Message-ID: <CAHk-=wj9n5y7pu=SVVGwd5-FbjMGS6uoFU4RpzVLbuOfwBifUA@mail.gmail.com>
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

On Tue, Nov 24, 2020 at 12:16 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> So my s/if/while/ suggestion is wrong and we need to do something to
> prevent spurious wakeups.  Unless we bury the spurious wakeup logic
> inside wait_on_page_writeback() ...

We can certainly make the "if()" in that loop be a "while()'.

That's basically what the old code did - simply by virtue of the
wakeup not happening if the writeback bit was set in
wake_page_function():

        if (test_bit(key->bit_nr, &key->page->flags))
                return -1;

of course, the race was still there - because the writeback bit might
be clear at that point, but another CPU would reallocate and dirty it,
and then autoremove_wake_function() would happen anyway.

But back in the bad old days, the wait_on_page_bit_common() code would
then double-check in a loop, so it would catch that case, re-insert
itself on the wait queue, and try again. Except for the DROP case,
which isn't used by writeback.

Anyway, making that "if()" be a "while()" in wait_on_page_writeback()
would basically re-introduce that old behavior. I don't really care,
because it was the lock bit that really mattered, the writeback bit is
not really all that interesting (except from a "let's fix this bug"
angle)

I'm not 100% sure I like the fragility of this writeback thing.

Anyway, I'm certainly happy with either model, whether it be an added
while() in wait_on_page_writeback(), or it be the page reference count
in end_page_writeback().

Strong opinions?

            Linus
