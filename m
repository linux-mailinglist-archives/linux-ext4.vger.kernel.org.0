Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279A23B0CF0
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Jun 2021 20:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbhFVSej (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 22 Jun 2021 14:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbhFVSeg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 22 Jun 2021 14:34:36 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E92FC06175F
        for <linux-ext4@vger.kernel.org>; Tue, 22 Jun 2021 11:32:19 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id c11so31491540ljd.6
        for <linux-ext4@vger.kernel.org>; Tue, 22 Jun 2021 11:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f0pmw5StORP1KUcP15TdiklSXjxFImoIRcmx4+WJzKc=;
        b=NP4S1TsIF9h2rPtpSgvjlnlXPEzV1Eg6DWYa5iK2q6AtxYQkNIkoYmNrE9B5XO/S4e
         HF1VEmrSrJFoleJ4FjX+FsvMVqxeW7ygtwWfM8q4P8/YZWbLfBROiuS/kumnsSNRhqqv
         IWq+2Kwg/HRFdIwqvLmKhyArAFRW+GJQTx+1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f0pmw5StORP1KUcP15TdiklSXjxFImoIRcmx4+WJzKc=;
        b=EXOExlEW3B1zWXKKjmboQXKPWhoeMt0N/eYl0ZSJaC/jUIa4vHjFlmhcG2MtvnoJJh
         euHmMGMoGrkSU/bMp0nzHi1+A9C2Za2QXp6yqhha7x+pS18ZgSWUv+PgwPgG/mCX/2/n
         epLoUO1dB5zTloHG5rVSBLPL0aM3TLnrRJE5sCf1onQksv+D+Wm/a/Gso7ptKjYLLpC1
         FTPzkLwf8LX05oPrtK5zdzwjSWehjb2hxihs3Op12M79lJGCJ9JlAvCvxAtLWy5S0e69
         mPCv3jpfRpBAE1Dbm3EYAgpjU821XXp85BP8Pc3vRoyBlbmc1mRVa1uHKOVBRfIwn7+j
         FAQw==
X-Gm-Message-State: AOAM530c0ZT6+DI/qVbgR8+mE+lmaI7nstz/gQDjEzrAF7rPLW4dy4ru
        E8/UL7PFhA7X3/Mnn2fKMrMDWL4iC7BOg+iduzs=
X-Google-Smtp-Source: ABdhPJzMRdpcb/8YnrqAPWDxS1gtWmb5Hz5RgLGvHwtW4uFV+OXKzCmWP8JIi3kfEuPnsRlsDNl/MQ==
X-Received: by 2002:a05:651c:1695:: with SMTP id bd21mr3575588ljb.316.1624386737877;
        Tue, 22 Jun 2021 11:32:17 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id j17sm16167ljo.74.2021.06.22.11.32.16
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 11:32:16 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id r5so37573698lfr.5
        for <linux-ext4@vger.kernel.org>; Tue, 22 Jun 2021 11:32:16 -0700 (PDT)
X-Received: by 2002:a19:7d04:: with SMTP id y4mr3809268lfc.201.1624386736181;
 Tue, 22 Jun 2021 11:32:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wh=YxjEtTpYyhgypKmPJQ8eVLJ4qowmwbnG1bOU06_4Bg@mail.gmail.com>
 <3221175.1624375240@warthog.procyon.org.uk> <YNIBb5WPrk8nnKKn@zeniv-ca.linux.org.uk>
 <YNIDdgn0m8d2a0P3@zeniv-ca.linux.org.uk> <YNIdJaKrNj5GoT7w@casper.infradead.org>
 <3231150.1624384533@warthog.procyon.org.uk> <YNImEkqizzuStW72@casper.infradead.org>
 <CAHk-=wicC9ZTNNH1E-oHebcT3+r4Q4Wf1tXBindXrCdotj20Gg@mail.gmail.com> <3233312.1624386204@warthog.procyon.org.uk>
In-Reply-To: <3233312.1624386204@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 22 Jun 2021 11:32:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgA4_TkMqOw9GwW7aNe3jBU_yBKZkNWTicz=BKap_=siw@mail.gmail.com>
Message-ID: <CAHk-=wgA4_TkMqOw9GwW7aNe3jBU_yBKZkNWTicz=BKap_=siw@mail.gmail.com>
Subject: Re: Do we need to unrevert "fs: do not prefault sys_write() user
 buffer pages"?
To:     David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
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

On Tue, Jun 22, 2021 at 11:23 AM David Howells <dhowells@redhat.com> wrote:
>
> Probably the most obvious way would be to set a flag in task_struct saying
> what you're doing and have the point that would otherwise wait for the page to
> become unlocked skip to the fault fixup code if the page is locked after
> ->readahead() has been invoked and the flag is set, then use get_user() in
> iov_iter_fault_in_readable().

Yeah, the existing user access exception handling code _almost_
handles it, except for one thing: you'd need to have some way to
distinguish between "prefetch successful" and "fault failed".

And yeah, I guess it could be a flag in task_struct, but at that point
my gag reflex starts acting up.

               Linus
