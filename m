Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735B43B0929
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Jun 2021 17:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbhFVPfM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 22 Jun 2021 11:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbhFVPfI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 22 Jun 2021 11:35:08 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B95C061756
        for <linux-ext4@vger.kernel.org>; Tue, 22 Jun 2021 08:32:52 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id r5so36694962lfr.5
        for <linux-ext4@vger.kernel.org>; Tue, 22 Jun 2021 08:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hmjRNaRTsIzZ03uK9rRt/2A93U0PY9kbbj4A/XRT2RE=;
        b=B6yWARmK6avEL61zEXxkktz5rMZ9fVIMLFKMWeX9LV0Sfcd5VNigl3pqQdvVOnT5fc
         wmXE3hK9zOlTCkZFZLMF/QUQ+0cmNYbS2oB34FCfw6eCV15UfYIvGJflzAjcMTMrjE3J
         gE/yWAYAxnnXGInGBg5PdjmBrZOcNgYDrgWts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hmjRNaRTsIzZ03uK9rRt/2A93U0PY9kbbj4A/XRT2RE=;
        b=ETN1VvyL67etwrKK4HeZT47IYxRhX/KV2ASHvnuVabiNKOacGIFO9wKIuqORaDkyAL
         +an98dDvO3F4Qx9AZlKGaKJX2MmYKD81VK6KTWmBOragcpoNJUyvwRZDp9E2MeJWpgyk
         fMKyKK2AWQuC5aABdUG390hBdoEdoBSb+MdrUdrxGI0Cx4/dqR8Xu6FnIsXiZeanyho2
         jA3qe9dmD0Li1b8KTDRH1dCV3MvKOmlk0yFG3tqsuJJxa9b4q1S8lq3y4EFwy8Rk5pV9
         m8HO7/fQPfdglu+F8FzABfoDDxZRrreKSYduu2KJcwAL9Oo8JgPePv4gxkBghN02R0BN
         jBLg==
X-Gm-Message-State: AOAM532fE8p+0h14CvcdPhAZNL8R/BF7Pfm722SJsWC9/bmQ0lRZnI4+
        NcXhl5+OqYExxoZBQADqEn89pD9+Ud2z+ixn8uI=
X-Google-Smtp-Source: ABdhPJwBruZXXSjCZKONaZdMBbyW6sZZ+48IhHiAa6h+mqQcCuCjeRBGz9SKtXLdmWFe+mQbe4d4hA==
X-Received: by 2002:a05:6512:169f:: with SMTP id bu31mr3344346lfb.486.1624375970847;
        Tue, 22 Jun 2021 08:32:50 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id k13sm534519lfu.189.2021.06.22.08.32.47
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 08:32:48 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id d25so2659915lji.7
        for <linux-ext4@vger.kernel.org>; Tue, 22 Jun 2021 08:32:47 -0700 (PDT)
X-Received: by 2002:a2e:7813:: with SMTP id t19mr3700308ljc.411.1624375967597;
 Tue, 22 Jun 2021 08:32:47 -0700 (PDT)
MIME-Version: 1.0
References: <3221175.1624375240@warthog.procyon.org.uk>
In-Reply-To: <3221175.1624375240@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 22 Jun 2021 08:32:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgM0ZMqY9fuYx0H6UninvbZjMyJeL=7Zz4=AmtO98QncA@mail.gmail.com>
Message-ID: <CAHk-=wgM0ZMqY9fuYx0H6UninvbZjMyJeL=7Zz4=AmtO98QncA@mail.gmail.com>
Subject: Re: Do we need to unrevert "fs: do not prefault sys_write() user
 buffer pages"?
To:     David Howells <dhowells@redhat.com>
Cc:     "Ted Ts'o" <tytso@mit.edu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux-MM <linux-mm@kvack.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Note this part:

On Tue, Jun 22, 2021 at 8:20 AM David Howells <dhowells@redhat.com> wrote:
>
>         copied = iov_iter_copy_from_user_atomic(page, i, offset, bytes);

The "atomic" is the key thing.

The fault_in_readable is just an optimistic "let's make things be mapped".

But yes, it could get unmapped again before the actual copy happens
with the lock held. But that's why the copy is using that atomic
version, so if that happens, we'll end up repeating.

Honestly, the first part comment above the
iov_iter_fault_in_readable() is a bit misleading (the deadlock would
be real _except_ for the atomic part), and it would logically make
sense to only do this for when the actual atomic copy_from_user_atomic
fails. But then you'd have to fault things twice if you do fault.

            Linus
