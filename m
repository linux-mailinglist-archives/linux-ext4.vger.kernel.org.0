Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A83A26ADA8
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Sep 2020 21:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgIOTd1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Sep 2020 15:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbgIOTdG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Sep 2020 15:33:06 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289FFC06178A
        for <linux-ext4@vger.kernel.org>; Tue, 15 Sep 2020 12:33:05 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id x69so4375462lff.3
        for <linux-ext4@vger.kernel.org>; Tue, 15 Sep 2020 12:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R4adhV9rWK5fVJfVLfsA1RpAgGhE1SKba3wPMEBwlHQ=;
        b=RMErlYgJlXkb0Vz5F+GbJlAflS7CDOBEDAnHgQ6XVorvnlASnwLA1/u0rSrYkXuFQM
         mNgrBeUfGtILyZVOTcMIj+g0bkAfmvZpba3gU5I2q4S9ORj5JefAeBSRKnVWXI5NSMTF
         vNpL7v5vEzpKJDwkYko3HD1FM2oHMq+fF9Jz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R4adhV9rWK5fVJfVLfsA1RpAgGhE1SKba3wPMEBwlHQ=;
        b=YoL8QDKFqHduTE4cK5dcMwjfY9wfkJbVqI4QOKmwR128G1/UpU5lLjQmi3hqYeWNzJ
         IF2raH7L8me+M4lef53LZ1Z8WNK6hEsRskkCHgue0BDzXaR0jHsYkk0BNzk8kvh8LSZ/
         fRpxuTX4KVbYa5NGObtWx6UCLLEVA+BNZfRKoZgPcWY8jdHBGLgpfyHvanv5du15ixhY
         5Ormgs/3v/9ReXTtSwfltHDxv2ILYO1eSkvl0clKDe94EJatmGvJmZ4nbiVLvBve5ddA
         d9iATI5ZozL4U6bZALd7E4gPgm2LjFuWFwTh6jVwL0PA+c8QobvfyFoEr8HHZrBuq5P3
         FKRw==
X-Gm-Message-State: AOAM5313LWRM3+RQ2lJaPfud8dy9hRBDB+jDo1HPvvpWStxgMOPdHjzS
        1cHnt1weyTTannASiNP2f6gOW/uvv1BIgg==
X-Google-Smtp-Source: ABdhPJyfoIbSd6fCJEG31YPyUIPBGspi11iVTqI+vLQ18j3aR9Z16KI146x0S0I99cA5FTvp+pj6jg==
X-Received: by 2002:a19:814d:: with SMTP id c74mr6288393lfd.302.1600198383138;
        Tue, 15 Sep 2020 12:33:03 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id f207sm4533069lfd.47.2020.09.15.12.33.01
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 12:33:01 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id b19so3826537lji.11
        for <linux-ext4@vger.kernel.org>; Tue, 15 Sep 2020 12:33:01 -0700 (PDT)
X-Received: by 2002:a2e:7819:: with SMTP id t25mr6952577ljc.371.1600198380912;
 Tue, 15 Sep 2020 12:33:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiz=J=8mJ=zRG93nuJ9GtQAm5bSRAbWJbWZuN4Br38+EQ@mail.gmail.com>
 <0cbc959e-1b8d-8d7e-1dc6-672cf5b3899a@MichaelLarabel.com> <CAHk-=whP-7Uw9WgWgjRgF1mCg+NnkOPpWjVw+a9M3F9C52DrVg@mail.gmail.com>
 <CAHk-=wjfw3U5eTGWLaisPHg1+jXsCX=xLZgqPx4KJeHhEqRnEQ@mail.gmail.com>
 <a2369108-7103-278c-9f10-6309a0a9dc3b@MichaelLarabel.com> <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
 <0daf6ae6-422c-dd46-f85a-e83f6e1d1113@MichaelLarabel.com> <20200912143704.GB6583@casper.infradead.org>
 <658ae026-32d9-0a25-5a59-9c510d6898d5@MichaelLarabel.com> <CAHk-=wip0bCNnFK2Sxdn-YCTdKBF2JjF0kcM5mXbRuKKp3zojw@mail.gmail.com>
 <c560a38d-8313-51fb-b1ec-e904bd8836bc@tessares.net> <CAHk-=wgZEUoiGoKh92stUh3sBA-7D24i6XqQN2UMm3u4=XkQkg@mail.gmail.com>
 <9550725a-2d3f-fa35-1410-cae912e128b9@tessares.net> <CAHk-=wimdSWe+GVBKwB0_=ZKX2ZN5JEqK5yA99toab4MAoYAsg@mail.gmail.com>
 <CAHk-=wimjnAsoDUjkanC2BQTntwK4qtzmPdBbtmgM=MMhR6B2w@mail.gmail.com> <a9faedf1-c528-38e9-2ac4-e8847ecda0f2@tessares.net>
In-Reply-To: <a9faedf1-c528-38e9-2ac4-e8847ecda0f2@tessares.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Sep 2020 12:32:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiHPE3Q-qARO+vqbN0FSHwQXCYSmKcrjgxqVLJun5DjhA@mail.gmail.com>
Message-ID: <CAHk-=wiHPE3Q-qARO+vqbN0FSHwQXCYSmKcrjgxqVLJun5DjhA@mail.gmail.com>
Subject: Re: Kernel Benchmarking
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     Michael Larabel <Michael@michaellarabel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        "Ted Ts'o" <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Sep 15, 2020 at 12:26 PM Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> I don't know if this info is useful but I just checked and I can
> reproduce the issue with a single CPU.

Good thinking.

> And the trace is very similar to the previous one:

.. and yes, now there are no messy traces, they all have that
__lock_page_killable() unambiguously in them (and the only '?' entries
are just from stale stuff on the stack which is due to stack frames
that aren't fully initialized and old stack frame data shining
through).

So it does seem like the previous trace uncertainty was likely just a
cross-CPU issue.

Was that an actual UP kernel? It might be good to try that too, just
to see if it could be an SMP race in the page locking code.

After all, one such theoretical race was one reason I started the rewrite.

                       Linus
