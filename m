Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21A75C090B
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Sep 2019 17:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfI0P7R (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 27 Sep 2019 11:59:17 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43242 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbfI0P7R (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 27 Sep 2019 11:59:17 -0400
Received: by mail-lj1-f195.google.com with SMTP id n14so2981630ljj.10
        for <linux-ext4@vger.kernel.org>; Fri, 27 Sep 2019 08:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WUAOKj8TZSrA0yEWe2HFVFAP8tkdAoUvA0qRc/X2cQw=;
        b=gmZVemT3kiPxJ+8cpxAZPOWUM+OCNclOcXI3vW7HbQXKL0sh5OTlcNAkP0CWnCKa5a
         zT+iiF8vVo3r2RkNGaqPNZVYv2LYMJwzYsEqIEB9TZQQ94W4xVcmnk0DtC8URs/ZpX/O
         1DnVrVlH+y95Mqvpe3nzWUmYoU64c/+Qyc6lA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WUAOKj8TZSrA0yEWe2HFVFAP8tkdAoUvA0qRc/X2cQw=;
        b=bToMjQmQev9rmXni7xg8+VhSVk4IVQclHCvoUq644qtYjME0QFdxFv4ezrB4ruLxQc
         JZW5YM9imDC7wZluGgsyO3vSs13DwT3rQSQeby+IjGwHS1inqRLbNJe343SnMuwWl4qJ
         SIktKxSUrVl3xq3jtxrcFM9dl6BTiASBhzSTyPbQq6JXGCoUaPHECrISqZ6DqdM4SyZf
         V1FCbTcbFbk7kW0uv/q26T9fjTq8rHYR/hygB3RptAIDbuXBDlo+R73qmY5fBN5HkD3I
         mO0PkJrHLwMs9tDJImA6YoRQ3Hu8jphzVXKeZkAVPtpMOE091fp5GMMHQ5GYxDSJakG0
         h/cA==
X-Gm-Message-State: APjAAAU050Fj3BElzrW+C8WbVaRLKbLIUSadPJiim85Hj40MjgukFd4U
        EKZc7lSGlPvzUGv+p8O6eFonA4ZMtW4=
X-Google-Smtp-Source: APXvYqzMOpERKTSeAlkZQJi9YQnfKnDymWjCOFSy8LAiSHxbD+pmFZA0cvyULSSX9AtkGfuSOwSSAw==
X-Received: by 2002:a2e:9584:: with SMTP id w4mr3508710ljh.145.1569599954347;
        Fri, 27 Sep 2019 08:59:14 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id r6sm540594lfn.29.2019.09.27.08.59.12
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2019 08:59:13 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id y3so3010168ljj.6
        for <linux-ext4@vger.kernel.org>; Fri, 27 Sep 2019 08:59:12 -0700 (PDT)
X-Received: by 2002:a2e:3e07:: with SMTP id l7mr3440165lja.180.1569599952421;
 Fri, 27 Sep 2019 08:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190917052438.GA26923@1wt.eu> <2508489.jOnZlRuxVn@merkaba>
 <20190917121156.GC6762@mit.edu> <20190917123015.sirlkvy335crozmj@debian-stretch-darwi.lab.linutronix.de>
 <20190917160844.GC31567@gardel-login> <CAHk-=wgsWTCZ=LPHi7BXzFCoWbyp3Ey-zZbaKzWixO91Ryr9=A@mail.gmail.com>
 <20190917174219.GD31798@gardel-login> <87zhj15qgf.fsf@x220.int.ebiederm.org>
 <84824f79-2d12-0fd5-5b32-b0360eb075ac@gmail.com> <CAHk-=whYhC-qXHdEypy6iC7SzPA+KvWphLXSGF+mvGCGHGjNZw@mail.gmail.com>
 <20190927135708.GD11791@gardel-login>
In-Reply-To: <20190927135708.GD11791@gardel-login>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 27 Sep 2019 08:58:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=widBVsz+JZYnkV8xvCt+XMzkO6Gz3KZQ_gULXpMpUZfMA@mail.gmail.com>
Message-ID: <CAHk-=widBVsz+JZYnkV8xvCt+XMzkO6Gz3KZQ_gULXpMpUZfMA@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     Lennart Poettering <mzxreary@0pointer.de>
Cc:     "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Sep 27, 2019 at 6:57 AM Lennart Poettering <mzxreary@0pointer.de> wrote:
>
> Doing the random seed in the boot loader is nice for two reasons:
>
> 1. It runs very very early, so that the OS can come up with fully
>    initialized entropy right from the beginning.

Oh, that part I love.

But I don't believe in your second case:

> 2. The boot loader generally has found some disk to read the kernel from,
>    i.e. has a place where stuff can be stored and which can be updated
>    (most modern boot loaders can write to disk these days, and so can
>    EFI). Thus, it can derive a new random seed from a stored seed on disk
>    and pass it to the OS *AND* update it right away on disk ensuring that
>    it is never reused again.

No. This is absolutely no different at all from user space doing it
early with a file.

All the same "golden image" issues exist, and in general the less the
boot loader writes to disk, the better.

Plus it doesn't actually work anyway in the one situation where people
_really_ want it - embedded devices, where the kernel image is quite
possibly in read-only flash that needs major setup for updates.

PLUS.

Your "it can update it right away on disk" is just crazy talk. With
WHAT? It has no randomness to play with, and it doesn't have time to
do jitter entropy stuff.

So all it can do is a really bad job at taking the previous random
seed, doing some transformation on it, and add a little bit of
whatever system randomness it can find. None of which is any better
than what the kernel can do.

End result: you'd need to have the kernel update whatever bootloader
data later on, and I'm not seeing that happening. Afaik the current
bootloader interface has no way to specify how to update it when you
actually have better randomness.

> NVRAM backing EFI vars sucks. Nothing you want to update on every
> cycle. It's OK to update during OS installation, but during every
> single boot? I'd rather not.

I do agree that EFI nvram isn't wonderful, but hopefully nonvolatile
storage is improving, and it's conceptually the right thing.

                  Linus
