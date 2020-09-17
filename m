Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4387626E398
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Sep 2020 20:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgIQSaf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Sep 2020 14:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgIQSad (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Sep 2020 14:30:33 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E506C061756
        for <linux-ext4@vger.kernel.org>; Thu, 17 Sep 2020 11:30:20 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id y11so3271251lfl.5
        for <linux-ext4@vger.kernel.org>; Thu, 17 Sep 2020 11:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=htmK6gOJ2PblkerFMS2g+5We3gbrehQll78mnvL0XTY=;
        b=bjCkIwlaKtFZnJKWxQwHG7krU4xU2kE4K4vgQFa/oFfQVRJ/3qfz1JYpMMpaX6cbRg
         p6kg57+rvSdzB7ybG9pBz31lLvN8toNTqeOWNKMpnRcB3IO0IOcF7cLQUAbzOcGfoBUy
         mUtJelB0pqUiZn7tHT612RpImUbAXNGTBchE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=htmK6gOJ2PblkerFMS2g+5We3gbrehQll78mnvL0XTY=;
        b=r8+//i7eQS+34Ww77hKaGPL3XKu/cyzruJKrmQgb2tvZpLffl9PGtYSmtHJkHGCq7P
         xcOgfxHdSKrmFCF2qJUN28+/eh19JdhDVG5ZGXIl5WUapJmi8ETpbPkWhmxWDxMi6gct
         fZlgu5INybSnciOLIZlWBz6VysWRo5dai9IUxgEhSiUYaenKM7ysHfr39wayMvNAxnvB
         qeCxX3UArnk41lP+s97+AMaakYpKh77X3Kreh+vxK6ERxBxFeNDO85NjxSZyq6VD38pJ
         ZgO3t8mbZYU0teUrQlC0jAudCtCPaJ5lSoWVsbJo9o3CJ1CnVTAG09eduQUuPhttB0MR
         IMZg==
X-Gm-Message-State: AOAM532EdhGWHL3Yd32M8L3/qWRvQ/LC+JYJMfs1ockD46pDz2pIHwPa
        r/hPvDA15f8ORUUmYeLZ4yPvxuTs7pO9EQ==
X-Google-Smtp-Source: ABdhPJy4cdMsUdye8XxXBYjHoLGEH5mCvBxGIiKd11rRielxvbFERC/d2A8pc2FdCoycvK7jkbKcNQ==
X-Received: by 2002:a19:4bc8:: with SMTP id y191mr10484963lfa.491.1600367418182;
        Thu, 17 Sep 2020 11:30:18 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id y11sm73703ljc.27.2020.09.17.11.30.16
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 11:30:17 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id b19so2868280lji.11
        for <linux-ext4@vger.kernel.org>; Thu, 17 Sep 2020 11:30:16 -0700 (PDT)
X-Received: by 2002:a05:651c:32e:: with SMTP id b14mr9863684ljp.314.1600367416426;
 Thu, 17 Sep 2020 11:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <0cbc959e-1b8d-8d7e-1dc6-672cf5b3899a@MichaelLarabel.com>
 <CAHk-=whP-7Uw9WgWgjRgF1mCg+NnkOPpWjVw+a9M3F9C52DrVg@mail.gmail.com>
 <CAHk-=wjfw3U5eTGWLaisPHg1+jXsCX=xLZgqPx4KJeHhEqRnEQ@mail.gmail.com>
 <a2369108-7103-278c-9f10-6309a0a9dc3b@MichaelLarabel.com> <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
 <0daf6ae6-422c-dd46-f85a-e83f6e1d1113@MichaelLarabel.com> <20200912143704.GB6583@casper.infradead.org>
 <658ae026-32d9-0a25-5a59-9c510d6898d5@MichaelLarabel.com> <CAHk-=wip0bCNnFK2Sxdn-YCTdKBF2JjF0kcM5mXbRuKKp3zojw@mail.gmail.com>
 <CAHk-=whc5CnTUWoeeCDj640Rng4nH8HdLsHgEdnz3NtPSRqqhQ@mail.gmail.com> <20200917182314.GU5449@casper.infradead.org>
In-Reply-To: <20200917182314.GU5449@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Sep 2020 11:30:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj6g2y2Z3cGzHBMoeLx-mfG0Md_2wMVwx=+g_e-xDNTbw@mail.gmail.com>
Message-ID: <CAHk-=wj6g2y2Z3cGzHBMoeLx-mfG0Md_2wMVwx=+g_e-xDNTbw@mail.gmail.com>
Subject: Re: Kernel Benchmarking
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Michael Larabel <Michael@michaellarabel.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Amir Goldstein <amir73il@gmail.com>,
        "Ted Ts'o" <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Sep 17, 2020 at 11:23 AM Matthew Wilcox <willy@infradead.org> wrote:
>
>             Something like taking
> the i_mmap_lock_read(file->f_mapping) in filemap_fault, then adding a
> new VM_FAULT_I_MMAP_LOCKED bit so that do_read_fault() and friends add:
>
>         if (ret & VM_FAULT_I_MMAP_LOCKED)
>                 i_mmap_unlock_read(vmf->vma->vm_file->f_mapping);
>         else
>                 unlock_page(page);
>
> ... want me to turn that into a real patch?

I can't guarantee it's the right model - it does worry me how many
places we might get that i_mmap_rwlock, and how long we migth hold it
for writing, and what deadlocks it might cause when we take it for
reading in the page fault path.

But I think it might be very interesting as a benchmark patch and a
trial balloon. Maybe it "just works".

I would _love_ for the page lock itself to be only (or at least
_mainly_) about the actual IO synchronization on the page.

That was the origin of it, the whole "protect all the complex state of
a page" behavior kind of grew over time, since it was the only
per-page lock we had.

              Linus
