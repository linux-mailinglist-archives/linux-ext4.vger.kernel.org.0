Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F50826AC79
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Sep 2020 20:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgIOSsi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Sep 2020 14:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbgIOSsH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Sep 2020 14:48:07 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D400C061788
        for <linux-ext4@vger.kernel.org>; Tue, 15 Sep 2020 11:48:06 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id m5so4215643lfp.7
        for <linux-ext4@vger.kernel.org>; Tue, 15 Sep 2020 11:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LTbv9ixmlr6M2NlSNW04eJaKIOgB6gnfk9QuC76NwqI=;
        b=R4A8aWwfONyraW34Non6+9EyYqEYt7xpEWbb7V1/g8CDpQEehM4YsRVSs9rkSq5/k+
         8cAhrioTweZR1mdOLigDRMWe0zhOr/TcctCtaMxX/xgmGCxQyVCMZC7uLe9GlAAYw/x2
         qAVHx/OcNyf5AHEb+ph+MgC6rOnBVDBaoZMOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LTbv9ixmlr6M2NlSNW04eJaKIOgB6gnfk9QuC76NwqI=;
        b=R/fv6I038U81Kg435psAjUZQKhbdWIZsGVnwYWfWWWj0UQdII3k6y57KUzgz9xnIun
         dK6kXOMJPp7linuwa/+MG4da37MJvsoWu2YRuN6SpTJ46zzDlBuaKV02QChV+ttlaGfN
         JecRyXiEyRRH1b9Gx17dOJXS3doMHEk1seDD1IIORg6PmsRoJuEj6PFh6J5vMg5cPEWK
         VRmFQeN0rHMtsriHDQrHw4pGv6nluSIcfFUKJ4TghXkwOFVl0ovemrjt8vjpHDh8NKJO
         d6oChffZ2L5/u/5k1jw40Y0USMLLwB4T0WZuQbaKRdfKUIljljLbXYuDSi+RGG83deEn
         VNtw==
X-Gm-Message-State: AOAM530A55Mh7KGZzGZWl/7QIJ2C5xOpXI6ZDi+xT9uVWY6nSvlUPO/V
        D028WJPTpLeBrl+zszeG6bC0UfZ4BJJ1+A==
X-Google-Smtp-Source: ABdhPJwv4GIs8ZqkyVsQ+eX+P46UMJZj0Lfy8IbCvJGEpTWX1x4BA7id67ELmNSLLALO+NFvYDo+zg==
X-Received: by 2002:a19:6b17:: with SMTP id d23mr6894401lfa.322.1600195684352;
        Tue, 15 Sep 2020 11:48:04 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 5sm4154249lfr.289.2020.09.15.11.48.02
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 11:48:02 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id z17so4186978lfi.12
        for <linux-ext4@vger.kernel.org>; Tue, 15 Sep 2020 11:48:02 -0700 (PDT)
X-Received: by 2002:a19:521a:: with SMTP id m26mr7261771lfb.133.1600195681832;
 Tue, 15 Sep 2020 11:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiz=J=8mJ=zRG93nuJ9GtQAm5bSRAbWJbWZuN4Br38+EQ@mail.gmail.com>
 <CAHk-=wimM2kckaYj7spUJwehZkSYxK9RQqu3G392BE=73dyKtg@mail.gmail.com>
 <8bb582d2-2841-94eb-8862-91d1225d5ebc@MichaelLarabel.com> <CAHk-=wjqE_a6bpZyDQ4DCrvj_Dv2RwQoY7wN91kj8y-tZFRvEA@mail.gmail.com>
 <0cbc959e-1b8d-8d7e-1dc6-672cf5b3899a@MichaelLarabel.com> <CAHk-=whP-7Uw9WgWgjRgF1mCg+NnkOPpWjVw+a9M3F9C52DrVg@mail.gmail.com>
 <CAHk-=wjfw3U5eTGWLaisPHg1+jXsCX=xLZgqPx4KJeHhEqRnEQ@mail.gmail.com>
 <a2369108-7103-278c-9f10-6309a0a9dc3b@MichaelLarabel.com> <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
 <0daf6ae6-422c-dd46-f85a-e83f6e1d1113@MichaelLarabel.com> <20200912143704.GB6583@casper.infradead.org>
 <658ae026-32d9-0a25-5a59-9c510d6898d5@MichaelLarabel.com> <CAHk-=wip0bCNnFK2Sxdn-YCTdKBF2JjF0kcM5mXbRuKKp3zojw@mail.gmail.com>
 <c560a38d-8313-51fb-b1ec-e904bd8836bc@tessares.net> <CAHk-=wgZEUoiGoKh92stUh3sBA-7D24i6XqQN2UMm3u4=XkQkg@mail.gmail.com>
 <9550725a-2d3f-fa35-1410-cae912e128b9@tessares.net> <CAHk-=wimdSWe+GVBKwB0_=ZKX2ZN5JEqK5yA99toab4MAoYAsg@mail.gmail.com>
In-Reply-To: <CAHk-=wimdSWe+GVBKwB0_=ZKX2ZN5JEqK5yA99toab4MAoYAsg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Sep 2020 11:47:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wimjnAsoDUjkanC2BQTntwK4qtzmPdBbtmgM=MMhR6B2w@mail.gmail.com>
Message-ID: <CAHk-=wimjnAsoDUjkanC2BQTntwK4qtzmPdBbtmgM=MMhR6B2w@mail.gmail.com>
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

On Tue, Sep 15, 2020 at 11:27 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Every one of them is in the "io_schedule()" in the filemap_fault()
> path, although two of them seem to be in file_fdatawait_range() rather
> than in the lock_page() code itself (so they are also waiting on a
> page bit, but they are waiting for the writeback bit to clear).

No, that seems to be just stale entries on the stack from a previous
system call, rather than a real trace. There's no way to reach
file_fdatawait_range() from mlockall() that I can see.

So I'm not entirely sure why the stack trace for two of the processes
looks a bit different, but they all look like they should be in
__lock_page_killable().

It's possible those two were woken up (by another CPU) and their stack
is in flux. They also have "wake_up_page_bit()" as a stale entry on
their stack, so that's not entirely unlikely.

So that sysrq-W state shows that yes, people are stuck waiting for a
page, but that wasn't exactly unexpected.

                 Linus
