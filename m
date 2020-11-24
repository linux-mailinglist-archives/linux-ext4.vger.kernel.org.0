Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B872C1D28
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Nov 2020 05:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbgKXExm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Nov 2020 23:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbgKXExm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Nov 2020 23:53:42 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CE6C0613CF
        for <linux-ext4@vger.kernel.org>; Mon, 23 Nov 2020 20:53:41 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id f18so2566824ljg.9
        for <linux-ext4@vger.kernel.org>; Mon, 23 Nov 2020 20:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=39gr2tFdgeuXdCwWbn22GRnP3K3VvibhIlGf9k17rGw=;
        b=SwaVIz6ZuT6iXE5tagOrwT7N6KNmmSkcEsDFfOdmzj5yjFEuDkdXhaHbzf22ipogzf
         zWRWhpolqbEMbnZmb7w8SY8YssaOfvRbra2P6MvkDrdQIcceCNS8eCPycSxvqCyBE/Wt
         Aogcb79k9z8ri+jJ6nmyXvkP8hv8F792ZSl3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=39gr2tFdgeuXdCwWbn22GRnP3K3VvibhIlGf9k17rGw=;
        b=H4/E+Nqou9VJU2TgKksux4pZ3bX38e3gFUuHg+6EqT9J8xD5SieZH2Hmr32LuI1RI/
         VYs2wZ0c/JIZSL40h8LOArs17qpk9MY9EGd/E2Vf+EMMzvHjFWgMISKWJu6W7ZXMJgdC
         6etq6GwPPcRvUa+rqz4F6uvtbWAov1X+nFIIKj/kcdHk52oiYRQxMS4VCwCtdYYswIyr
         Wt2hQAVw0dME2VkXs5JEesLQcKHp6ZR3m4/BsoetnZoTpxQqk0wOKZFGhTC497rKCaTw
         d82+y0/wkxJzX3TugiuZoxMHI0T3JCGHc+PueDqffmQCGTT/RIzwvM5HFtBCyQSJIayZ
         yyfQ==
X-Gm-Message-State: AOAM533ZfPCSaDjO+DnZi5Nt9yR9xt25hbLWgKXn2UfnTsgFpGQ/T/v6
        iOZN0npRCOrFyhF/spZKeNb40s8zxFSfOQ==
X-Google-Smtp-Source: ABdhPJxn3C0pHQVud2XIlM8Ul2wzBIeAAvhCPdPCDGo+XR77s02drQHBVM1gSzbts41a23IOmBFCZg==
X-Received: by 2002:a2e:544e:: with SMTP id y14mr1143534ljd.9.1606193619874;
        Mon, 23 Nov 2020 20:53:39 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id v9sm1598605lfd.287.2020.11.23.20.53.37
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2020 20:53:38 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id z21so26981741lfe.12
        for <linux-ext4@vger.kernel.org>; Mon, 23 Nov 2020 20:53:37 -0800 (PST)
X-Received: by 2002:a19:ae06:: with SMTP id f6mr1057406lfc.133.1606193616810;
 Mon, 23 Nov 2020 20:53:36 -0800 (PST)
MIME-Version: 1.0
References: <000000000000d3a33205add2f7b2@google.com> <20200828100755.GG7072@quack2.suse.cz>
 <20200831100340.GA26519@quack2.suse.cz> <CAHk-=wivRS_1uy326sLqKuwerbL0APyKYKwa+vWVGsQg8sxhLw@mail.gmail.com>
 <alpine.LSU.2.11.2011231928140.4305@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2011231928140.4305@eggly.anvils>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 Nov 2020 20:53:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=whYO5v09E8oHoYQDn7qqV0hBu713AjF+zxJ9DCr1+WOtQ@mail.gmail.com>
Message-ID: <CAHk-=whYO5v09E8oHoYQDn7qqV0hBu713AjF+zxJ9DCr1+WOtQ@mail.gmail.com>
Subject: Re: kernel BUG at fs/ext4/inode.c:LINE!
To:     Hugh Dickins <hughd@google.com>
Cc:     Jan Kara <jack@suse.cz>,
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
        Matthew Wilcox <willy@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Nov 23, 2020 at 8:07 PM Hugh Dickins <hughd@google.com> wrote:
>
> Then on crashing a second time, realized there's a stronger reason against
> that approach.  If my testing just occasionally crashes on that check,
> when the page is reused for part of a compound page, wouldn't it be much
> more common for the page to get reused as an order-0 page before reaching
> wake_up_page()?  And on rare occasions, might that reused page already be
> marked PageWriteback by its new user, and already be waited upon?  What
> would that look like?
>
> It would look like BUG_ON(PageWriteback) after wait_on_page_writeback()
> in write_cache_pages() (though I have never seen that crash myself).

So looking more at the patch, I started looking at this part:

> +       writeback = TestClearPageWriteback(page);
> +       /* No need for smp_mb__after_atomic() after TestClear */
> +       waiters = PageWaiters(page);
> +       if (waiters) {
> +               /*
> +                * Writeback doesn't hold a page reference on its own, relying
> +                * on truncation to wait for the clearing of PG_writeback.
> +                * We could safely wake_up_page_bit(page, PG_writeback) here,
> +                * while holding i_pages lock: but that would be a poor choice
> +                * if the page is on a long hash chain; so instead choose to
> +                * get_page+put_page - though atomics will add some overhead.
> +                */
> +               get_page(page);
> +       }

and thinking more about this, my first reaction was "but that has the
same race, just a smaller window".

And then reading the comment more, I realize you relied on the i_pages
lock, and that this odd ordering was to avoid the possible latency.

But what about the non-mapping case? I'm not sure how that happens,
but this does seem very fragile.

I'm wondering why you didn't want to just do the get_page()
unconditionally and early. Is avoiding the refcount really such a big
optimization?

            Linus
