Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 002C53B0D4D
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Jun 2021 20:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbhFVS7x (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 22 Jun 2021 14:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbhFVS7w (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 22 Jun 2021 14:59:52 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62026C061574
        for <linux-ext4@vger.kernel.org>; Tue, 22 Jun 2021 11:57:36 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id d25so3511601lji.7
        for <linux-ext4@vger.kernel.org>; Tue, 22 Jun 2021 11:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xPk7T/ftbiBmPf+o6AYQ5V0HnU5NGPQBeJe2s6miHI8=;
        b=VhTAedbTxJDC60DaO13KHKxcUeyU8ENl3RSl3vIntzzeRYtWM0BVNQZJ7sDNpmRFQO
         Ucorn0ijH5dvTGTuXlecFzoOE2aDg/bX3NnRpMk0K++RjVnfO6xG9mcKG8RMdHCWoqbH
         9yUMAp0MAks+wmHiCn2j+g4RTxHlsJd0MRqpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xPk7T/ftbiBmPf+o6AYQ5V0HnU5NGPQBeJe2s6miHI8=;
        b=NbpXYU+KFuSGfLhkOHbT47hrqjgo/IbbCO1Dt3ktXxVxz1nxpUx/0TBupUeyeuh3Yl
         rqrkBmu3golwrjJKTEFr+aWCR9txAmQJ8qyiRz3igyxu7s1udWtzublx4n232Bd/XpSg
         q3+DKZL1kghaNuXoxQMMdhi33aZHF4Yz8W9LlEELRcTHGRIccdnOFB/rN7G1h3nbIKii
         ZF+99ZRi7FtJ6k6UEAdvp+Wf+moJY3kvOR6L/eckTPOK78JaS4pPW2HXpWg92LT64C2j
         yeTkJyeimPUccY7H07bXQzU749GQi8ueJx9J0QMB93ubgGuwD6yZKSscDaX4z0ncxZA4
         b3UQ==
X-Gm-Message-State: AOAM530LWoj6oXevJZwyf0EFRcy3Z2t4ddqigXqHjAiQovODD8XEtIc2
        XQ5unAjaPL9JIBAz/+hA5ner7p26CNxl77NKfNY=
X-Google-Smtp-Source: ABdhPJwLBghMUAhYh03kx7FFXnCRp5qg+q/q6a4WFJ9VAs+Prjn8mWqhqD5gaad5nUruDF8+ko1adg==
X-Received: by 2002:a2e:9a41:: with SMTP id k1mr4502028ljj.248.1624388254546;
        Tue, 22 Jun 2021 11:57:34 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id e13sm683431lfc.111.2021.06.22.11.57.33
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 11:57:34 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id c16so757ljh.0
        for <linux-ext4@vger.kernel.org>; Tue, 22 Jun 2021 11:57:33 -0700 (PDT)
X-Received: by 2002:a2e:22c4:: with SMTP id i187mr4487018lji.251.1624388246482;
 Tue, 22 Jun 2021 11:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wh=YxjEtTpYyhgypKmPJQ8eVLJ4qowmwbnG1bOU06_4Bg@mail.gmail.com>
 <3221175.1624375240@warthog.procyon.org.uk> <YNIBb5WPrk8nnKKn@zeniv-ca.linux.org.uk>
 <YNIDdgn0m8d2a0P3@zeniv-ca.linux.org.uk> <YNIdJaKrNj5GoT7w@casper.infradead.org>
 <3231150.1624384533@warthog.procyon.org.uk> <YNImEkqizzuStW72@casper.infradead.org>
 <CAHk-=wicC9ZTNNH1E-oHebcT3+r4Q4Wf1tXBindXrCdotj20Gg@mail.gmail.com>
 <YNIqjhsvEms6+vk9@casper.infradead.org> <CAHk-=wiRumzeOn1Fk-m-FiGf+sA0dSS3YPu--KAkT8-5W5yEHA@mail.gmail.com>
 <YNItqqZA9Y1wOnZY@casper.infradead.org> <F78E1A78-DB7E-4F3A-8C7C-842AA757E4FE@gmail.com>
In-Reply-To: <F78E1A78-DB7E-4F3A-8C7C-842AA757E4FE@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 22 Jun 2021 11:57:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=whDyrOMJMZBxtTUaMeuSd_dafiR_DFCwsLSbJuLwEuYsw@mail.gmail.com>
Message-ID: <CAHk-=whDyrOMJMZBxtTUaMeuSd_dafiR_DFCwsLSbJuLwEuYsw@mail.gmail.com>
Subject: Re: Do we need to unrevert "fs: do not prefault sys_write() user
 buffer pages"?
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
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

On Tue, Jun 22, 2021 at 11:51 AM Nadav Amit <nadav.amit@gmail.com> wrote:
> Just reminding the alternative (in the RFC that I mentioned before):
> a vDSO exception table entry for a memory accessing function in the
> vDSO. It then behaves as a sort of MADV_WILLNEED for the faulting
> page if an exception is triggered. Unlike MADV_WILLNEED it maps the
> page if no IO is needed. It can return through a register whether
> the page was present or not.

Yeah, that looks like a user-space equivalent.

And thanks to the vdso, it doesn't need to support all architectures.
Unlike a kernel model would (but yes, a kernel model could then have a
fallback for the non-prefetching synchronous case instead, so I guess
we could just do one architecture at a time).

               Linus
