Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C156535D029
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Apr 2021 20:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244729AbhDLSVS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Apr 2021 14:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhDLSVP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Apr 2021 14:21:15 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C707C061574
        for <linux-ext4@vger.kernel.org>; Mon, 12 Apr 2021 11:20:57 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id b136-20020a1c1b8e0000b029012c69da2040so46158wmb.1
        for <linux-ext4@vger.kernel.org>; Mon, 12 Apr 2021 11:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0z3XzP3OkACR5NstqNEyPn1NJX+7W0uBkbKJqycox7I=;
        b=Owyxnfwck/7sZd6w11qbFpCmlRdKFNwzk5IfNE+bly++OpJqLDhS3Ou96PczHVjbFs
         2eDsyArloENl7T4b78cQWsXFqDnbwIEA5LIfHuPhxLzBxBrxayeGAduKvud7HIin7NZr
         xol0FaNN9BORkFR4imlcVzVXO5YvFND0u1BQjBoTDGLs3qoZyMTm7kcN644LL2kJVi+4
         1YlCNP4wf40/qcwOWrMHpSZaFrqwnv6WYg1BagOHMbgTM0+yNXDDkIJ4o+2JO4GZS79d
         TySdWlbffFhToD7nZuHLas/1l9yJQ01THVMesGrCUbBY6702SEmu1r2bYGj/4e6027hV
         0wcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0z3XzP3OkACR5NstqNEyPn1NJX+7W0uBkbKJqycox7I=;
        b=NQZfZxjreP8U39cF6e2Ng+t4LRqJ0vy51SFBvqd5kuGKdsqP9b/TNc1ylCtwxAj3rZ
         6jn2JCAgjR3C2FAKrFhCQkPvVOJXNyRLMkh3pB/G66G8rjVJPHAbranr+mfCYlj5+/xP
         DNp9w0v8Y4RqqzcrgsQIvZB4C3p8Juheh7aWxyj4PRSOdTjirfw12v1mYfhQVZI86/i6
         Ue4ZkSk2udynJ5Am38Ce8d+nS+FztBgoIsmp1ncFW0Vlt8dXcmsB8y+4SRML9WUJzt9e
         92q3tkJkxkWInd7HKdfchqQ3ip7uErz/oYMtFopPZan3k6v9oXe/R4QH/POQFBRIyWQ5
         EQrA==
X-Gm-Message-State: AOAM530boBavBQ2e2pKSTEABy8YoEP5TP9xg/SUXkVYBF+gH3aJhEq9V
        5pL94L+KUEjDHKZcLr1aV2KADzlxwB2U5g==
X-Google-Smtp-Source: ABdhPJz71K7/57uPCiR89xSOHHgTjPmpmi1JlsdyaAHF49nrC0vBeITcntzH+c2vNK3NyDOJ4hb0Zg==
X-Received: by 2002:a05:600c:189e:: with SMTP id x30mr415323wmp.44.1618251655804;
        Mon, 12 Apr 2021 11:20:55 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:197c:ad7a:49b7:8f5c])
        by smtp.gmail.com with ESMTPSA id g16sm18643195wrs.76.2021.04.12.11.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 11:20:55 -0700 (PDT)
Date:   Mon, 12 Apr 2021 20:20:46 +0200
From:   Marco Elver <elver@google.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, Hao Sun <sunhao.th@gmail.com>,
        jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        paulmck@kernel.org, dvyukov@google.com
Subject: Re: KCSAN: data-race in __jbd2_journal_file_buffer /
 jbd2_journal_dirty_metadata
Message-ID: <YHSPfiJ/h/f3ky5n@elver.google.com>
References: <CACkBjsZW5Sp4jB51+C5mrMssgq73x8iEko_EV6CTXVvtVa7KPQ@mail.gmail.com>
 <20210406123232.GD19407@quack2.suse.cz>
 <YGx308zQXxOjmwNZ@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGx308zQXxOjmwNZ@mit.edu>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Apr 06, 2021 at 11:01AM -0400, Theodore Ts'o wrote:
> On Tue, Apr 06, 2021 at 02:32:33PM +0200, Jan Kara wrote:
> > And the comment explains, why we do this unreliable check. Again, if we
> > wanted to silence KCSAN, we could use data_race() macro but AFAIU Ted isn't
> > very fond of that annotation.
> 
> I'm not fond of the data_race macro, but I like bogus KCSAN reports
> even less.  My main complaint is if we're going to have to put the
> data_race() macro in place, we're going to need to annotate each
> location with an explanation of why it's there (suppress a KCSAN false
> positive), and why's it's safe.  If it's only one or two places, it'll
> probably be fine.  If it's dozens, then I would say that KCSAN is
> becoming a net negative in terms of making the Linux kernel code
> maintainable.

I've just seen the latest reports on these data races [1], but it seems
the more relevant context is here.
[1] https://lore.kernel.org/linux-ext4/20210412113158.GA4679@quack2.suse.cz/

Let me try to put things in perspective.

No, we do not want maintainability to suffer. Whether or not documenting
the concurrency design via data_race() and a few comments is a negative
or positive is up to you. To me, it'd be a positive because I don't have
to guess what the code is trying to do because concurrent code rarely is
obvious. (In fairness, if you don't like to add comments, just a
data_race() without comment tells a reader more than now; perhaps they'd
then rummage in the git logs.)

Yes, there are currently lots of data-racy accesses in the kernel that
are mostly benign. Yet, they are data races in the memory model's eyes,
and every optimizing compiler is free to screw them up! For example a
lot of those plain read-modify-write bitops ("...  |= ...").

Unfortunately tooling cannot determine without hints (like data_race())
whether or not those are safe, since the programmer's intent is unclear.
Crucially, the programmer's intent is also unclear to the compiler!
Which means the compiler _is_ free to screw up those operations.

If we could somehow precisely determine which plain accesses can race,
we'd solve a decades-old problem: optimizing compilers and concurrent
code do not get along. Therefore, C needed a memory model to sort out
this mess, which we have since C11. The Linux kernel, however, doesn't
play by those rules. The Linux Kernel Memory Model (LKMM) tries to
specify the rules the kernel can safely play by.

But since we have KCSAN, which initially tried to follow the LKMM
strictly, various feedback has resulted in taming KCSAN to a subset of
the LKMM. A lot of the data races that are left, yet appear benign,
simply have no obvious rules or patterns (otherwise we wouldn't have the
problem we have with optimizing compilers). I couldn't, in good
conscience, tame KCSAN based on poorly thought-out rules. Because we
know they're data races, and the compiler _is_ free to subject them to
concurrency-unsafe optimizations.

Because we knew that different codes will want different KCSAN exposure
until there is a de-facto LKMM that is to be followed everywhere (one
can dream), KCSAN has lots of knobs. They are described in detail here:
https://lwn.net/Articles/816854/

> I'm not fond of the data_race macro, but I like bogus KCSAN reports
> even less.

While the data_race() macro was meant to be exactly for this case, to
tell tooling "this data race is fine, even if the compiler messes it
up", if there are too many data races for you right now feel free to add
'KCSAN_SANITIZE_file.o := n' to the files you don't want checked. Or
even 'KCSAN_SANITIZE := n' to ignore all files in a directory. It would
avoid the robots sending you reports. Not ideal, but it'd give some time
to see how things evolve elsewhere if you'd rather avoid all this for
now.

Thanks,
-- Marco
