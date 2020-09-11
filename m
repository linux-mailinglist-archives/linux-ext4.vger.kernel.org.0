Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB742656F0
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Sep 2020 04:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725468AbgIKCVM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Sep 2020 22:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgIKCVK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Sep 2020 22:21:10 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0119C061573
        for <linux-ext4@vger.kernel.org>; Thu, 10 Sep 2020 19:21:09 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a22so10707980ljp.13
        for <linux-ext4@vger.kernel.org>; Thu, 10 Sep 2020 19:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8HZHq5KXD3NR4oIo5lzSDg0AfWxu9PBq/LN7lDoX6XI=;
        b=bVnq/GUzf9VeflkqcPJph6dXhAdxvTl1J65/zEjkfKEZxvI2HWnMKevqy3JPFw5IWX
         VYElPb85B2Qx5dxHcfHgc3Pi8uT/rtFZ7TkEytD75tMUml4jf8sfUFhCztB9RTUtJGx8
         KUYOwl3UfjqO7tIeQUp8mPzxst2lgDMY1WdtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8HZHq5KXD3NR4oIo5lzSDg0AfWxu9PBq/LN7lDoX6XI=;
        b=pEtctPdS66DIp/kI934iMT9Ry6WRyQN+PePLx0PvhM250GmKwO41EmNt9d6/RMnLN+
         mYaYPmO5n9atVr2M0rsp7oSn995n1hclUfE0HKD+zSTULcMGdpaF231mC2cxKEhAiQzR
         dkWxE3VUsKfDYvA27/n6VXQiJ7SHPIuQaoeD61JpgwO/8oJ6wRfDWXJmqkusCRt7FoHj
         UunSHOjats8a5niOVzHcgIPj3nvApIhlXElQtwisHs5ZCzXe8vn01OdZB80sbzVF0k3E
         PQiELxxGqH5v4gQelm+3Ii2kmL6g+WepRaYocZyzUjcimo8v3docA6RGmYqc4zVxCc5V
         D6kA==
X-Gm-Message-State: AOAM530GaOicJGrnV0o3Y4VwL8hdDuzcXGKDN7uecABOMEdjZNiREbv3
        z3HIezENXrBXEu55DILI4w8l+2dlANNwZg==
X-Google-Smtp-Source: ABdhPJxG4exU02i8nsa2e4bCjACF2xi9Z199lBl/j+y+0/KzdKT7iceqzNoOm/0WsR/lOYUvMMqIig==
X-Received: by 2002:a2e:b178:: with SMTP id a24mr5406682ljm.276.1599790867725;
        Thu, 10 Sep 2020 19:21:07 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id x73sm147637lfa.94.2020.09.10.19.21.06
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 19:21:06 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id s205so10747267lja.7
        for <linux-ext4@vger.kernel.org>; Thu, 10 Sep 2020 19:21:06 -0700 (PDT)
X-Received: by 2002:a05:651c:104c:: with SMTP id x12mr6372323ljm.285.1599790865719;
 Thu, 10 Sep 2020 19:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiZnE409WkTOG6fbF_eV1LgrHBvMtyKkpTqM9zT5hpf9A@mail.gmail.com>
 <4ced9401-de3d-b7c9-9976-2739e837fafc@MichaelLarabel.com> <CAHk-=wj+Qj=wXByMrAx3T8jmw=soUetioRrbz6dQaECx+zjMtg@mail.gmail.com>
 <CAHk-=wgOPjbJsj-LeLc-JMx9Sz9DjGF66Q+jQFJROt9X9utdBg@mail.gmail.com>
 <CAHk-=wjjK7PTnDZNi039yBxSHtAqusFoRrZzgMNTiYkJYdNopw@mail.gmail.com>
 <aa90f272-1186-f9e1-8fdb-eefd332fdae8@MichaelLarabel.com> <CAHk-=wh_31_XBNHbdF7EUJceLpEpwRxVF+_1TONzyBUym6Pw4w@mail.gmail.com>
 <e24ef34d-7b1d-dd99-082d-28ca285a79ff@MichaelLarabel.com> <CAHk-=wgEE4GuNjcRaaAvaS97tW+239-+tjcPjTq2FGhEuM8HYg@mail.gmail.com>
 <6e1d8740-2594-c58b-ff02-a04df453d53c@MichaelLarabel.com> <CAHk-=wgJ3-cEkU-5zXFPvRCHKkCCuKxVauYWGphjePEhJJgtgQ@mail.gmail.com>
 <d2023f4c-ef14-b877-b5bb-e4f8af332abc@MichaelLarabel.com> <CAHk-=wiz=J=8mJ=zRG93nuJ9GtQAm5bSRAbWJbWZuN4Br38+EQ@mail.gmail.com>
 <CAHk-=wimM2kckaYj7spUJwehZkSYxK9RQqu3G392BE=73dyKtg@mail.gmail.com> <8bb582d2-2841-94eb-8862-91d1225d5ebc@MichaelLarabel.com>
In-Reply-To: <8bb582d2-2841-94eb-8862-91d1225d5ebc@MichaelLarabel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Sep 2020 19:20:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjqE_a6bpZyDQ4DCrvj_Dv2RwQoY7wN91kj8y-tZFRvEA@mail.gmail.com>
Message-ID: <CAHk-=wjqE_a6bpZyDQ4DCrvj_Dv2RwQoY7wN91kj8y-tZFRvEA@mail.gmail.com>
Subject: Re: Kernel Benchmarking
To:     Michael Larabel <Michael@michaellarabel.com>
Cc:     "Ted Ts'o" <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Sep 10, 2020 at 5:49 PM Michael Larabel
<Michael@michaellarabel.com> wrote:
>
> I should be able to fire up some benchmarks of the patch overnight to
> see what they show, but guessing something more might be at play. While
> it's plausible this might help the Apache and Nginx web server results
> as they do touch the disk, Hackbench for instance shouldn't really be
> interacting with the file-system. Was the Hackbench perf data useful at
> all or should I generate a longer run of that for more events?

The hackbench data actually does have some of the same patterns with
ext4_write_iter showing up there too, but the perf profile there is
fairly weak (it and nginx both have _much_ fewer profile data points
than the apache run had).

hackbench I also didn't feel was all that interesting, because the
performance impact seemed more mixed there.

NOTE! The whole fair locking issue does show up even without any
lock/unlock/lock patterns, because even if you don't have that
"immediately re-take the lock" thing going on as in the ext4 example,
it's a very easy pattern to trigger by simply having a microbenchmark
that does the same system call over and over again. So the
"lock-unlock-lock-unlock" pattern can be two separate system calls,
each of which just does a single lock-unlock, but they do so at a high
frequency. So the ext4 code I pointed at and that trial patch (maybe)
fixing is just the most egregious case of lock re-taking. It can
easily happen with an external loop too (although normally I'd expect
people to buffer writes enough that the next write certainly shouldn't
be to the same page).

I do kind of wonder why that apache benchmark would have multiple
processes locking the same page, which is what makes me wonder if
there's something else going on. The profile wasn't entirely trivial
to read (the page locking itself does not show up very high on the
profile at all, so ), so I might have missed some other clue.

There were other lock_page cases, ie jbd2_journal_get_write_access()
etc, so I think it's the writing side interacting with the flushing
side.

But the lock-unlock-lock pattern in the ext4 write code made me go
"yeah, that's _exactly_ the kind of thing that would potentialyl slow
down a lot".

Again, that's not saying that other similar patterns don't occur
elsewhere. It's only saying that that's the only really obvious one I
found.

            Linus
