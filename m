Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188C033788C
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Mar 2021 16:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbhCKPzI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Mar 2021 10:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234383AbhCKPy5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 11 Mar 2021 10:54:57 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73C3C061760
        for <linux-ext4@vger.kernel.org>; Thu, 11 Mar 2021 07:54:56 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id f8so1883227otp.8
        for <linux-ext4@vger.kernel.org>; Thu, 11 Mar 2021 07:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yALvACLbG4vrfUUx3qZqeyzSfVcl9s+hAiG4U+bMuHc=;
        b=swKJ+cXtjqjUiqBziIbCvK1W0Jqtxsmb0JtDejFHsmeoRUzMlbqcwAtEhWCA1WLZsZ
         RH60dBjjXVu4l8heRsjnmMDBjVX7KwWd73gdXeI+E9lbeYSp1mXN+DZ4BaslqifvVqZR
         w6nemR8fVkgXXZCOKjQhlcE9GrZ/vDcRzDoCQI8h9GZKjcUgLTQSODn9Gd8+bVdJs3F4
         b0kGBA9E4OBgzpT+84Cdm1hSQPvG70L6Mj4R8kka8qPEXqwEV2+P10wQf4TimR+WDVvE
         UpbaJ4tyuuxVXSmhtK0mpHTxJQAUydEl4PcdWheT6xpmjJK8WnDias+aZNUktH/L1RPV
         Z94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yALvACLbG4vrfUUx3qZqeyzSfVcl9s+hAiG4U+bMuHc=;
        b=diIHc3HDthRmiB5Gnn6QUcgpDnphTLUUcZMOnFKpE5m1IR7o8EsN670nu64zidlxch
         gpF+SDJY/764y9xAF6Leey+muVOiyxRX571/gT7FNVJdpXTrweHSIlNZigXUGEXx31jv
         3qTQJi3reDdw4SgnGZQUycaclRWCdA0CyUXLwHZWfgdqaiK12p5LTqrtoGZdGkqBeOAb
         depnIMlPCMvjStNAx94mrE66xOelFuedGVX9I3D46Se7Gq+iAVLi9mw33KoYqA+1j8LJ
         4MeT3qXdkVkHgbZeBdzzhYbTaFb9Gv/UQU7LXxYvXfcdEAbdAH/CwG/2thVnJ+6SE9qL
         CI9A==
X-Gm-Message-State: AOAM531S1aN239+DoQInxV2KvJsNDaaB2yxAzNfnfZwHgLr2055a9Xxi
        hpj9VDcAmQ0cybvsCB0ZWV5nfzgOshSWR45Xa9z1kQ==
X-Google-Smtp-Source: ABdhPJxvoq+npQntQQMIFeeZH42ft8CkQkhq67+pg4zE4YOm2vvzUdK+/8BO/kgi062xNyX9aYsqJNf1y/VOlmT/nzc=
X-Received: by 2002:a9d:644a:: with SMTP id m10mr7632608otl.233.1615478096124;
 Thu, 11 Mar 2021 07:54:56 -0800 (PST)
MIME-Version: 1.0
References: <0000000000008de88005bd40ac36@google.com> <20210311142503.GA31816@quack2.suse.cz>
 <CACT4Y+ZtBwv1aXUumTXnWzAi7LEpJ6CZemGyVR2FC6_YO2E4EQ@mail.gmail.com>
 <YEoybjJpCQzNx15r@elver.google.com> <YEo3gYOU/VnmHCeV@mit.edu>
In-Reply-To: <YEo3gYOU/VnmHCeV@mit.edu>
From:   Marco Elver <elver@google.com>
Date:   Thu, 11 Mar 2021 16:54:43 +0100
Message-ID: <CANpmjNNwvDDcDnfDtwCKKpGVnHEuwhn5tP+eK0CH7R_FgQgCtA@mail.gmail.com>
Subject: Re: [syzbot] KCSAN: data-race in start_this_handle / start_this_handle
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Dmitry Vyukov <dvyukov@google.com>, Jan Kara <jack@suse.cz>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+30774a6acf6a2cf6d535@syzkaller.appspotmail.com>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

+Cc Paul

On Thu, 11 Mar 2021 at 16:30, Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Thu, Mar 11, 2021 at 04:08:30PM +0100, Marco Elver wrote:
> > If the outcome of the check does not affect correctness and the code is
> > entirely fault tolerant to the precise value being read, then a
> > data_race(!journal->j_running_transaction) marking here would be fine.
>
> So a very common coding pattern is to check a value w/o the lock, and
> if it looks like we might need to check *with* a lock, we'll grab the
> lock and recheck.  Does KCSAN understand that this sort of thing is
> safe automatically?

It doesn't -- these are concurrency patterns that go way beyond the
scope of a data race detector. The main problem, as always with such
patterns, is that in one case it seems fine, yet in the next it isn't.

> In thie particular case, it's a bit more complicated than that; we're
> checking a value, and then allocating memory, grabbing the spin lock,
> and then re-checking the value, so we don't have to drop the spinlock,
> allocate the memory, grab the lock again, and then rechecking the
> value.  So even if KCSAN catches the simpler case as described above,
> we still might need to explicitly mark the data_race explicitly.

This seems like a variation of double-checked locking.

> But the more we could have the compiler automatically figure out
> things without needing an explicit tag, it would seem to me that this
> would be better, since manual tagging is going to be more error-prone.

What you're alluding to here would go much further than a data race
detector ("data race" is still just defined by the memory model). The
wish that there was a static analysis tool that would automatically
understand the "concurrency semantics as intended by the developer" is
something that'd be nice to have, but just doesn't seem realistic.
Because how can a tool tell what the developer intended, without input
from that developer?

If there's worry marking accesses is error-prone, then that might be a
signal that the concurrency design is too complex (or the developer
hasn't considered all cases).

For that reason, we need to mark accesses to tell the compiler and
tooling where to expect concurrency, so that 1) the compiler generates
correct code, and 2) tooling such as KCSAN can double-check what the
developer intended is actually what's happening.

Thanks,
-- Marco
