Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5829326C862
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Sep 2020 20:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgIPSr7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Sep 2020 14:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbgIPSro (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Sep 2020 14:47:44 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CB6C061756
        for <linux-ext4@vger.kernel.org>; Wed, 16 Sep 2020 11:47:43 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id k25so6862331ljk.0
        for <linux-ext4@vger.kernel.org>; Wed, 16 Sep 2020 11:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FvU3RmnxF4Fi3PPUl/NAHaQ6sckA0cZltUifXE0sQUY=;
        b=AiGhVJYFwlZ76nh2p80nDW5KlWkzhVstC+ekxJgSj3hh4Dl41ChGlQj+8UxI5F9Xc9
         pKW8C5G/1nb+f2eUFPyOHFNx3MYZgioEwfLY2TkTz0uC4umYfzyb0loAbP9D1r4fVoeg
         jK8KF5sV9qMp0+hOp7K8kAkTBJPF+XELbvJLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FvU3RmnxF4Fi3PPUl/NAHaQ6sckA0cZltUifXE0sQUY=;
        b=naqKWfv4NpAlZiorxVt7EdVbaiPZp2YIK9VjRrWX2W2Mm4qxOP0x6/ZUkd/UEc1yDq
         hiHatAxHsU43bsfWc7Vf/VJBtFKyt6nu4U578UshjMIyUyIO66lvi39f8zflREH4NzRc
         K+mUC0J9et/o1Nq+Jql3rNsIgGQVeryEG6nsHFPVKnCKxraAZt2UnOkC1P/9GVPpqNkT
         T+Q8cpImUf2jODf5QSO5O5hiIznIzds8hyLfFIs5FMScqbC6cKegBX2gC8sc3ZiztEy0
         +WKYJST/rczwKr+005rPpOm9AzEjiQQAwRx+CZ/xo1pSslPSl0umGeJV9rNs6F0g+IqX
         PAgg==
X-Gm-Message-State: AOAM530mASC0mC5rtAqYYo5g259rMq86KionbnqPOoVj3fK8AdhLujAT
        AzBSLq2c8DzKSsHfxYxVy3NGUvO4667bBQ==
X-Google-Smtp-Source: ABdhPJwtsXSP8sP27frWZ8phhi06JZnD/vtZDpMbjn5z4WSVsFOZaGHqJMLiqnYzFmnXJtJDdmQCDQ==
X-Received: by 2002:a05:651c:1064:: with SMTP id y4mr8199421ljm.107.1600282061172;
        Wed, 16 Sep 2020 11:47:41 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id b20sm5119927lfg.57.2020.09.16.11.47.38
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2020 11:47:39 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id w11so8128214lfn.2
        for <linux-ext4@vger.kernel.org>; Wed, 16 Sep 2020 11:47:38 -0700 (PDT)
X-Received: by 2002:a19:4186:: with SMTP id o128mr7813977lfa.148.1600282058590;
 Wed, 16 Sep 2020 11:47:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wip0bCNnFK2Sxdn-YCTdKBF2JjF0kcM5mXbRuKKp3zojw@mail.gmail.com>
 <c560a38d-8313-51fb-b1ec-e904bd8836bc@tessares.net> <CAHk-=wgZEUoiGoKh92stUh3sBA-7D24i6XqQN2UMm3u4=XkQkg@mail.gmail.com>
 <9550725a-2d3f-fa35-1410-cae912e128b9@tessares.net> <CAHk-=wimdSWe+GVBKwB0_=ZKX2ZN5JEqK5yA99toab4MAoYAsg@mail.gmail.com>
 <CAHk-=wimjnAsoDUjkanC2BQTntwK4qtzmPdBbtmgM=MMhR6B2w@mail.gmail.com>
 <a9faedf1-c528-38e9-2ac4-e8847ecda0f2@tessares.net> <CAHk-=wiHPE3Q-qARO+vqbN0FSHwQXCYSmKcrjgxqVLJun5DjhA@mail.gmail.com>
 <37989469-f88c-199b-d779-ed41bc65fe56@tessares.net> <CAHk-=wj8Bi5Kiufw8_1SEMmxc0GCO5Nh7TxEt+c1HdKaya=LaA@mail.gmail.com>
 <20200916103446.GB3607@quack2.suse.cz>
In-Reply-To: <20200916103446.GB3607@quack2.suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 16 Sep 2020 11:47:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiTwLL5O5afYJrJTsEm6XqYdGubh6zvKOt_1f8pqbfYgw@mail.gmail.com>
Message-ID: <CAHk-=wiTwLL5O5afYJrJTsEm6XqYdGubh6zvKOt_1f8pqbfYgw@mail.gmail.com>
Subject: Re: Kernel Benchmarking
To:     Jan Kara <jack@suse.cz>
Cc:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Michael Larabel <Michael@michaellarabel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        "Ted Ts'o" <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Sep 16, 2020 at 3:34 AM Jan Kara <jack@suse.cz> wrote:
>
> wait_on_page_bit_common() has:
>
>         spin_lock_irq(&q->lock);
>         SetPageWaiters(page);
>         if (!trylock_page_bit_common(page, bit_nr, wait))
>           - which expands to:
>           (
>                 if (wait->flags & WQ_FLAG_EXCLUSIVE) {
>                         if (test_and_set_bit(bit_nr, &page->flags))
>                                 return false;
>                 } else if (test_bit(bit_nr, &page->flags))
>                         return false;
>           )
>
>                 __add_wait_queue_entry_tail(q, wait);
>         spin_unlock_irq(&q->lock);
>
> Now the suspicious thing is the ordering here. What prevents the compiler
> (or the CPU for that matter) from reordering SetPageWaiters() call behind
> the __add_wait_queue_entry_tail() call? I know SetPageWaiters() and
> test_and_set_bit() operate on the same long but is it really guaranteed
> something doesn't reorder these?

I agree that we might want to make this much more specific, but no,
those things can't be re-ordered.

Part of it is very much that memory ordering is only about two
different locations - accessing the *same* location is always ordered,
even on weakly ordered CPU's.

And the compiler can't re-order them either, we very much make
test_and_set_bit() have the proper barriers. We'd be very screwed if a
"set_bit()" could pass a "test_and_set_bit".

That said, the PageWaiters bit is obviously very much by design in the
same word as the bit we're testing and setting - because the whole
point is that we can then at clear time check the PageWaiters bit
atomically with the bit we're clearing.

So this code optimally shouldn't use separate operations for those
bits at all. It would be better to just have one atomic sequence with
a cmpxchg that does both at the same time.

So I agree that sequence isn't wonderful. But no, I don't think this is the bug.

And as you mention, Matthieu sees it on UP, so memory ordering
wouldn't have been an issue anyway (and compiler re-ordering would
cause all kinds of other problems and break our bit operations
entirely).

Plus if it was some subtle bug like that, it wouldn't trigger as
consistently as it apparently does for Matthieu.

Of course, the reason that I don't see how it can trigger at all (I
still like my ABBA deadlock scenario, but I don't see anybody holding
any crossing locks in Matthieu's list of processes) means that I'm
clearly missing something

                  Linus
