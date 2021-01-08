Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54892EF883
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Jan 2021 21:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbhAHUEj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 8 Jan 2021 15:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729110AbhAHUEi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 8 Jan 2021 15:04:38 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C31DC0612AC
        for <linux-ext4@vger.kernel.org>; Fri,  8 Jan 2021 12:03:13 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id a12so25793733lfl.6
        for <linux-ext4@vger.kernel.org>; Fri, 08 Jan 2021 12:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PmspDcv/ocVoLjM7eZCys1d3yrpEciEb1QwZ9ZHCG10=;
        b=BK/5L/vmNIcg4m+RxJlM6MSBoYFNRgclyJ3q7dL4Xn+udGNWmcjBD/magHIwpo/iOs
         W4/GoBbDVvgnMvBl4GEuZQbo3jGtrL4vsK3dKcclqKMZygPwOVPxGbmLu8GWxVw6SjtZ
         MAsSFa5bDGCIwjrhbwDLN8kkunnSOyISqo78A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PmspDcv/ocVoLjM7eZCys1d3yrpEciEb1QwZ9ZHCG10=;
        b=jVphr2dO8qBWG2xFF0pyVaNHTzEIsjoMe+y9Ls4WHBJU3A3H+sn0uVnTtqJY3vCdjg
         DRii3iUSERMKkX2lwWjTLTUVfLwqnYEJW9RL0uUMi+1P89GQ+EOPUb8iTmjRBcLz5vfK
         50WY4ggF7D9zbS0MSgy3v2zRDRIdp7ioOAJUWXGEwY8XT3u3wTpHbUSJKAcCU/LtaxWX
         z0V/VuvTHP6OaqXWbNub6/CPboab0TZJP1OvNlGUWIxVqd4E9P+iLiB3t038Lxsq0raA
         Db1qzzRzophuNDg43GIEhZgJhGusaW9nXlDXE+vHBoRjYvvErgbV2YFbZIUGvNZLqttY
         3UVg==
X-Gm-Message-State: AOAM532mC9r0ruAemwXXMUVxL65DZm2jAJI5wZvq+0Yeuvv3uhunPGAZ
        EeXc5hocW8Tr7jh5wzFcI7ScbHu56KsiJQ==
X-Google-Smtp-Source: ABdhPJxnTJUxA2eMwqSGz9FCkd0VfZu+HdpVfS3Im7EnBtToaRIb/8hqmum9fvckviaY1moAuB1Lbw==
X-Received: by 2002:a2e:7015:: with SMTP id l21mr2338710ljc.201.1610136191485;
        Fri, 08 Jan 2021 12:03:11 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id a8sm2149185lfo.206.2021.01.08.12.03.10
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jan 2021 12:03:10 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id b26so25764743lff.9
        for <linux-ext4@vger.kernel.org>; Fri, 08 Jan 2021 12:03:10 -0800 (PST)
X-Received: by 2002:ac2:41d9:: with SMTP id d25mr2021963lfi.377.1610136189681;
 Fri, 08 Jan 2021 12:03:09 -0800 (PST)
MIME-Version: 1.0
References: <20210106115359.GB26994@C02TD0UTHF1T.local> <20210106135253.GJ1551@shell.armlinux.org.uk>
 <20210106172033.GA2165@willie-the-truck> <20210106223223.GM1551@shell.armlinux.org.uk>
 <20210107111841.GN1551@shell.armlinux.org.uk> <20210107124506.GO1551@shell.armlinux.org.uk>
 <CAK8P3a2TXPfFpgy+XjpDzOqt1qpDxufwiD-BLNbn4W_jpGp98g@mail.gmail.com>
 <20210107133747.GP1551@shell.armlinux.org.uk> <CAK8P3a2J8fLjPhyV0XUeuRBdSo6rz1gU4wrQRyfzKQvwhf22ag@mail.gmail.com>
 <X/gkMmObbkI4+ip/@hirez.programming.kicks-ass.net> <20210108092655.GA4031@willie-the-truck>
In-Reply-To: <20210108092655.GA4031@willie-the-truck>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Jan 2021 12:02:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=whnKkj5CSbj-uG_MVVUsPZ6ppd_MFhZf_kpXDkh2MAVRA@mail.gmail.com>
Message-ID: <CAHk-=whnKkj5CSbj-uG_MVVUsPZ6ppd_MFhZf_kpXDkh2MAVRA@mail.gmail.com>
Subject: Re: Aarch64 EXT4FS inode checksum failures - seems to be weak memory
 ordering issues
To:     Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        linux-toolchains@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jan 8, 2021 at 1:27 AM Will Deacon <will@kernel.org> wrote:
>
> On Fri, Jan 08, 2021 at 10:21:54AM +0100, Peter Zijlstra wrote:
> > On Thu, Jan 07, 2021 at 10:20:38PM +0100, Arnd Bergmann wrote:
> > > On Thu, Jan 7, 2021 at 2:37 PM Russell King - ARM Linux admin
> >
> > > > So, do we raise the minimum gcc version for the kernel as a whole to 5.1
> > > > or just for aarch64?
> > >
> > > I'd personally love to see gcc-5 as the global minimum version, as that
> > > would let us finally use --std=gnu11 features instead of gnu89. [There are
> > > a couple of useful features that are incompatible with gnu89, and
> > > gnu99/gnu11 support in gcc didn't like the kernel sources]
> >
> > +1 for raising the tree-wide minimum (again!). We actually have a bunch
> > of work-arounds for 4.9 bugs we can get rid of as well.
>
> We even just added another one for arm64 KVM! [1]
>
> So yes, I'm in favour of leaving gcc 4.9 to rot as well, especially after
> this ext4 debugging experience.

Well, honestly, I'm always in favor of having people not use ancient
compilers, but both of the issues at hand do seem to be specific to
arm64.

The "gcc before 5.1 generates incorrect stack pointer writes on arm64"
sounds pretty much deadly, and I think means that yes, for arm64 we
simply need to require 5.1 or newer.

I also suspect there is much less reason to use old gcc's on arm64. I
can't imagine that people really run very old setups, Is some old RHEL
version even relevant for arm64?

So while I'd love to just say "everybody needs to make sure they have
an up-to-date compiler", my git feel is that at least with the current
crop of issues, there is little to really push us globally.

I appreciate Arnd pointing out "--std=gnu11", though. What are the
actual relevant language improvements?

Variable declarations in for-loops is the only one I can think of. I
think that would clean up some code (and some macros), but might not
be compelling on its own.

               Linus
