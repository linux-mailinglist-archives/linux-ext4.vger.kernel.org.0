Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595153B0CDF
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Jun 2021 20:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbhFVSbH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 22 Jun 2021 14:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbhFVSbG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 22 Jun 2021 14:31:06 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF9DC061574
        for <linux-ext4@vger.kernel.org>; Tue, 22 Jun 2021 11:28:49 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id a11so24465559lfg.11
        for <linux-ext4@vger.kernel.org>; Tue, 22 Jun 2021 11:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ZpVUR22GV2FhIPfitStL6sJNaCS4zKOgFuhT+Jblpo=;
        b=Z693fDgItvtwcb4kTOVryT20g278Zz6hUQqITd0+HePvWOEJ/q4X2/GBHNiKYE5aNZ
         xF4pSUq8WFx8OrMLW1r42O24+mcof+0hdJXuwaV68w1SsOSyBEhfQWKBUBZM0GfgOc5N
         g49GS2nhPH9aIUXjg2ss34vZ75Z/DfiJKbz0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ZpVUR22GV2FhIPfitStL6sJNaCS4zKOgFuhT+Jblpo=;
        b=ZpxgFzjJcWx4LUyRXF6nmihYFuMJnUryuRG6bDp7SguTvhZlW467eXKow/YDHwuZRN
         lTuev/R2+Xa1DxFVOSqX3sKK2XAKu03ry6Vh3hNXnl8n9OXxnsRKTKaQ7Hp2qvlnUQI9
         R24yc4iYX5fz/ZcVL97bpEyUzkLC8djV24UTGF+PsstfRH4u6UqPB7D7JpN0lTqMbbxG
         SV2gDGDGb+N+zS5+xgMLsBWlwV877ilM5qhSJMZyUjMKS88qTrxPbXRm2CPUPQzWET2o
         WhmhFXBpldkimd9IX5f976iVb/AmUaamC5CoXhT0/24DB7N2SgMFYZjZiP08Ioz6dLLd
         9E0g==
X-Gm-Message-State: AOAM532exdOH3/9A6S6AGdCJYVBKaK95gWH1ohRwjEXV9PvERwDIKKxS
        BQQ0yvT+kA3JsAd32u9EP52OeWRHT57BFTw0gIo=
X-Google-Smtp-Source: ABdhPJzA0QghnRaudzSESeJ2zpyw3gpBTbBy22SyvqMVdWkyE+Y0aFkSawgc2HFMgKcuLK7sDUSZsw==
X-Received: by 2002:a05:6512:169b:: with SMTP id bu27mr3970648lfb.327.1624386527642;
        Tue, 22 Jun 2021 11:28:47 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id p5sm14341ljn.109.2021.06.22.11.28.47
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 11:28:47 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id k8so31297470lja.4
        for <linux-ext4@vger.kernel.org>; Tue, 22 Jun 2021 11:28:47 -0700 (PDT)
X-Received: by 2002:a2e:b618:: with SMTP id r24mr4383026ljn.48.1624386526776;
 Tue, 22 Jun 2021 11:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wh=YxjEtTpYyhgypKmPJQ8eVLJ4qowmwbnG1bOU06_4Bg@mail.gmail.com>
 <3221175.1624375240@warthog.procyon.org.uk> <YNIBb5WPrk8nnKKn@zeniv-ca.linux.org.uk>
 <YNIDdgn0m8d2a0P3@zeniv-ca.linux.org.uk> <YNIdJaKrNj5GoT7w@casper.infradead.org>
 <3231150.1624384533@warthog.procyon.org.uk> <YNImEkqizzuStW72@casper.infradead.org>
 <CAHk-=wicC9ZTNNH1E-oHebcT3+r4Q4Wf1tXBindXrCdotj20Gg@mail.gmail.com> <YNIqjhsvEms6+vk9@casper.infradead.org>
In-Reply-To: <YNIqjhsvEms6+vk9@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 22 Jun 2021 11:28:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiRumzeOn1Fk-m-FiGf+sA0dSS3YPu--KAkT8-5W5yEHA@mail.gmail.com>
Message-ID: <CAHk-=wiRumzeOn1Fk-m-FiGf+sA0dSS3YPu--KAkT8-5W5yEHA@mail.gmail.com>
Subject: Re: Do we need to unrevert "fs: do not prefault sys_write() user
 buffer pages"?
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, "Ted Ts'o" <tytso@mit.edu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jun 22, 2021 at 11:23 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> It wouldn't be _that_ bad necessarily.  filemap_fault:

It's not actually the mm code that is the biggest problem. We
obviously already have readahead support.

It's the *fault* side.

In particular, since the fault would return without actually filling
in the page table entry (because the page isn't ready yet, and you
cannot expose it to other threads!), you also have to jump over the
instruction that caused this all.

Doable? Oh, absolutely. But you basically need a new inline asm thing
for each architecture, so that the architecture knows how to skip the
instruction that caused the page fault, and the new exception table
entry type to say 'this is that magic VM prefetch instruction".

So filemap_fault() is the least of the problems.

Honestly, it doesn't look _complicated_, but it does look like a fair
number of small details..

               Linus
