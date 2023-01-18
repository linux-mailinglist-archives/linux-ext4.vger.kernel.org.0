Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF889672897
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Jan 2023 20:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjARTkB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Jan 2023 14:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjARTj7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Jan 2023 14:39:59 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4265421D
        for <linux-ext4@vger.kernel.org>; Wed, 18 Jan 2023 11:39:57 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id fd15so20757069qtb.9
        for <linux-ext4@vger.kernel.org>; Wed, 18 Jan 2023 11:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=50IK4LVqoMmk7C/WdII2GzqA3m6oWHMIg74I9XrTXo0=;
        b=ScMxZ5jY0w04cygb16m/i2sdw9vtNE0BuTsMtZwFqhZOw/s1htXS2WLJio0GqPAK7a
         /ojrZG6eKl2Q0/OzyUo5CCnwJw7/hxsj235TUn2zPR0RAjmx2ibOP8fYlPHLAaFKKqU6
         CuM0ebzKEgqvDaJtOYshLWe0v9kve9UxaYWnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=50IK4LVqoMmk7C/WdII2GzqA3m6oWHMIg74I9XrTXo0=;
        b=rGcMmqzgAKcmOpb8ctkxaiMc2KNlADAAfcbogh7aw00rQ0w+D3yGS6unImMJS9GZud
         KgwbuA191WpdAVsjzkOOkpOxMPV0qx02koeCniStzdFR5M8GvKwTMZ4JUkR8pUfSPghX
         haJEzt9AhgiWGBreeClpRPTYh9wb8h8wz74yiG4Sj/m2Y1ALDBaP+RoSnM1GtfU1bXZl
         kBn4hDfkeAXjAMW3nSswBYtwvSB1pN/pQAzEYykiny9C6DA77CgZutYXs0ZSuX81cD+C
         qqgcVzaH1AdnlI1f+dPlat7Tldt8E5dUoZ1hr5uPod/t1saaER6pb7ixUT372c6ZHoY0
         qLKw==
X-Gm-Message-State: AFqh2kpPtItHlipCSEvqDPvGIafSlSTX9EQJLaDqX4gL6hPvf3bESdv6
        0ADzPumpnO7DDyMAipg7nWcfO/fxteucOG94
X-Google-Smtp-Source: AMrXdXvVg+YxLO2csspuzmUZU6KaaDXXVed6JS21WVi+JAudJisqdXmHKAJtpuiZW8d/eBiJIT6rHg==
X-Received: by 2002:ac8:72ce:0:b0:3a5:ff6e:d43e with SMTP id o14-20020ac872ce000000b003a5ff6ed43emr10566786qtp.2.1674070796551;
        Wed, 18 Jan 2023 11:39:56 -0800 (PST)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com. [209.85.219.45])
        by smtp.gmail.com with ESMTPSA id b24-20020ac86798000000b0039cc944ebdasm17869424qtp.54.2023.01.18.11.39.55
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 11:39:56 -0800 (PST)
Received: by mail-qv1-f45.google.com with SMTP id y8so24460999qvn.11
        for <linux-ext4@vger.kernel.org>; Wed, 18 Jan 2023 11:39:55 -0800 (PST)
X-Received: by 2002:a05:6214:5504:b0:535:2538:c972 with SMTP id
 mb4-20020a056214550400b005352538c972mr436923qvb.43.1674070795614; Wed, 18 Jan
 2023 11:39:55 -0800 (PST)
MIME-Version: 1.0
References: <Y8bpkm3jA3bDm3eL@debian-BULLSEYE-live-builder-AMD64>
 <7DE6598D-B60D-466F-8771-5FEC0FDEC57F@dilger.ca> <Y8dtze3ZLGaUi8pi@sol.localdomain>
 <CAHk-=whUNjwqZXa-MH9KMmc_CpQpoFKFjAB9ZKHuu=TbsouT4A@mail.gmail.com>
 <Y8eAJIKikCTJrlcr@sol.localdomain> <CAHk-=wg7SkJZeAJ-KMKxsA7m9cs7MJoSDpu0aYKVm=bAwhcqjA@mail.gmail.com>
 <Y8hE+uwHkilxThDT@sol.localdomain>
In-Reply-To: <Y8hE+uwHkilxThDT@sol.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Jan 2023 11:39:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgxcupvBROWUsrsyTKTWr8L93T+1xJaRvG6cOfREjpXMw@mail.gmail.com>
Message-ID: <CAHk-=wgxcupvBROWUsrsyTKTWr8L93T+1xJaRvG6cOfREjpXMw@mail.gmail.com>
Subject: Re: Detecting default signedness of char in ext4 (despite -funsigned-char)
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Eric Whitney <enwlinux@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 18, 2023 at 11:14 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> Now, we seem to have gotten the "let's break userspace, lol" version of Linus
> today, not the "SHUT THE FUCK UP, WE DO NOT BREAK USERSPACE" version of Linus

Heh.

Note that the reason I'm so laissez-faire about it is that "broken
test case" is something very different from "actually broken user
space".

I haven't actually seen anybody _report_ this as a problem, I've only
seen the generic/454 xfstest failures.

And "test failure" is simply not the same thing as "user failure".

Test failures are interesting in that they can most definitely
pinpoint the source of _potential_ user failures, but sometimes they
are just esoteric corner cases that don't happen in reality.

So the fact that we have had this bug since forever makes me suspect
absolutely nobody cares in real life. Yes, what's new is that it
happens on the same machine, but people have definitely moved ext4 USB
sticks around etc. I've most definitely done that myself, and it's not
been just between x86 machines.

Of course, it may also be that the filesystem patterns when you move a
USB stick around is very different from, say, the root filesystem
where you _don't_ necessarily tend to do it. So maybe the lack of
reports over the decades is not because people don't use xattrs with
the high bit set in the xattr names, but because it only happens in
situations that don't have that filesystem movement.

I dunno. On my system, at least, there is absolutely no sign of any
odd xattr names, according to something disgusting like

   find / -xdev -type f -print0 | xargs -0 getfattr

but who knows.

              Linus
