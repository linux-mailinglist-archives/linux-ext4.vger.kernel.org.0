Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 746722F3719
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Jan 2021 18:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391747AbhALR3e (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Jan 2021 12:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbhALR3d (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 12 Jan 2021 12:29:33 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBE6C061794
        for <linux-ext4@vger.kernel.org>; Tue, 12 Jan 2021 09:28:53 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id f11so3718361ljm.8
        for <linux-ext4@vger.kernel.org>; Tue, 12 Jan 2021 09:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OqpF9m8Ie7h14NS62Or0oMAWtodm7MvHcM9nCVl5hwY=;
        b=GoLT4gtWkFQzxysE0FG1990pw92x+A+KYUUxNjKBXuEcavd4IzBOYB2y1Ih6O3FQQA
         u4qohDIAC5MRsuNuXKSw6NqhtOI03AoPDeIsiuvh8ZPfrLyWugFTKK7Q6Iqr3CtdG7N6
         RF2iI2e3VCJkSIBRtrw2oE8igcSnQqwxsmmk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OqpF9m8Ie7h14NS62Or0oMAWtodm7MvHcM9nCVl5hwY=;
        b=La9+tCPHBw5Ru6qsmX+ipbJDISIbf670EYfBQtuT1PTiq6PK9OuqvS+a4by5Yy8esB
         kg1TD6k6kNiJlA+K/eGPlgh7Vfz/rphy7y0UK1IoJJyAEH9bSrMIe/D7M1f/i7KT22zY
         dIYEmG9GWLG349Dmc0ynoIb5Wnm/IInUiBHeMqOIQ8vBCtkHyyxfH/fynEHiMn29I+ne
         wxswgKOAruQCSZBwASZI9pJ+jGGyXzUK6y/WxhPPud7DoHiY2cy2tFB5g+oHdf4B6ipG
         l8TFA+5F2ibOAvtMx6ogxz/0xQuFLrgCbbaoSURKI9epvJLZNic4nP1L1Dxk+0to4W00
         ePeQ==
X-Gm-Message-State: AOAM530Wn0XU4ncxRIVc1X5igBDbJiwLUHx3yvre59IjCgXuhW4uGIDE
        tkgp3uDHyumXmYhyvEEnY3rUBnBoX4jlhQ==
X-Google-Smtp-Source: ABdhPJxPsiWYm9uxclKpOnKmBWMlrED5xOOm6CXjGiUlljirSSgi1DmpO5DhjfCRUbq1qRbOklG6vg==
X-Received: by 2002:a2e:7307:: with SMTP id o7mr132622ljc.452.1610472530802;
        Tue, 12 Jan 2021 09:28:50 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id z2sm469626lfd.142.2021.01.12.09.28.48
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 09:28:48 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id n11so3742209lji.5
        for <linux-ext4@vger.kernel.org>; Tue, 12 Jan 2021 09:28:48 -0800 (PST)
X-Received: by 2002:a2e:9d89:: with SMTP id c9mr149709ljj.220.1610472527992;
 Tue, 12 Jan 2021 09:28:47 -0800 (PST)
MIME-Version: 1.0
References: <20210106172033.GA2165@willie-the-truck> <20210106223223.GM1551@shell.armlinux.org.uk>
 <20210107111841.GN1551@shell.armlinux.org.uk> <20210107124506.GO1551@shell.armlinux.org.uk>
 <CAK8P3a2TXPfFpgy+XjpDzOqt1qpDxufwiD-BLNbn4W_jpGp98g@mail.gmail.com>
 <20210107133747.GP1551@shell.armlinux.org.uk> <CAK8P3a2J8fLjPhyV0XUeuRBdSo6rz1gU4wrQRyfzKQvwhf22ag@mail.gmail.com>
 <X/gkMmObbkI4+ip/@hirez.programming.kicks-ass.net> <20210108092655.GA4031@willie-the-truck>
 <CAHk-=whnKkj5CSbj-uG_MVVUsPZ6ppd_MFhZf_kpXDkh2MAVRA@mail.gmail.com> <20210112132049.GA26096@wunner.de>
In-Reply-To: <20210112132049.GA26096@wunner.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Jan 2021 09:28:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiHaVWUKQ9wvHe5D=JrV3MDehfRi_FL7KXGbi6=S7=jUA@mail.gmail.com>
Message-ID: <CAHk-=wiHaVWUKQ9wvHe5D=JrV3MDehfRi_FL7KXGbi6=S7=jUA@mail.gmail.com>
Subject: Re: Aarch64 EXT4FS inode checksum failures - seems to be weak memory
 ordering issues
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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

On Tue, Jan 12, 2021 at 5:20 AM Lukas Wunner <lukas@wunner.de> wrote:
>
> > Variable declarations in for-loops is the only one I can think of. I
> > think that would clean up some code (and some macros), but might not
> > be compelling on its own.
>
> Anonymous structs/unions.  I used to have a use case for that in
> struct efi_dev_path in include/linux/efi.h, but Ard Biesheuvel
> refactored it in a gnu89-compatible way for v5.7 with db8952e7094f.

We use anonymous structs/unions extensively and all over the place already.

We've had a couple of special cases where some versions of gcc didn't
do things right iirc (it was something like "nested anonymous struct"
or similar), but those weren't actually about the feature itself.

Was it perhaps the nested case you were thinking of? If so, I think
that's not really a --std=gun11 thing, it's more of a "certain
versions of gcc didn't do it at all".

               Linus
