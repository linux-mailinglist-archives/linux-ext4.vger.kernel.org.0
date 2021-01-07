Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C432EE7D9
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Jan 2021 22:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbhAGVtD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Jan 2021 16:49:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:37198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbhAGVtD (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 7 Jan 2021 16:49:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE3E923406;
        Thu,  7 Jan 2021 21:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610056103;
        bh=TQDWjh3f5pNnQ2t5MjxQ5TqLIEAU1dudzHdK0zBk+Ns=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iD+ZK/lfojmMkxhXnyH/1v8Tb0AwiXwyMFfxZhtAIZgz0HAke5gQ1BQxg7lVHp9TI
         gAdpITwTpkBqqsroyiceqy/xOW06ifTk4RCD4LdxhCin8jH5ninfACplB869eaWj56
         hQbubbiixp2WEM1jJcIFTIxzmxmotz+Xke8JTSV3jPycIBMLSjfEpuCozaSEv3HzqT
         WXwiw2vKOAwe2NN3ljw0hT5F4Qabo2Tnj8NBEzzeD5M6JuHuxYSDQcbwR3uBtpvQNK
         lpnVGmcDiM5jsCTzQvTuYSIiA9zg5G4dIY1dyOQifQm8BXopQbA4xcakFyzcS8PVXg
         05/ozQdCD06ug==
Received: by mail-ot1-f50.google.com with SMTP id i6so7806129otr.2;
        Thu, 07 Jan 2021 13:48:22 -0800 (PST)
X-Gm-Message-State: AOAM532JjXRaFQ1Y3e7ztIpKwAtdyXWYq3eg4k0OEMdRvlvLPjb4QKAm
        g3pR9+m5bzEO5YZ3m8y9/cKRS7st18LWfUVHApU=
X-Google-Smtp-Source: ABdhPJxnaJA141e20BKd4OL7t+qWGvU0o8rWnel2LS/2PmbZGYBn/q94i+4iN0Vo1bv8tzTS+O8U0EFHizJ+9FdNAio=
X-Received: by 2002:a9d:7a4b:: with SMTP id z11mr421259otm.305.1610056102295;
 Thu, 07 Jan 2021 13:48:22 -0800 (PST)
MIME-Version: 1.0
References: <20210105154726.GD1551@shell.armlinux.org.uk> <20210106115359.GB26994@C02TD0UTHF1T.local>
 <20210106135253.GJ1551@shell.armlinux.org.uk> <20210106172033.GA2165@willie-the-truck>
 <20210106223223.GM1551@shell.armlinux.org.uk> <20210107111841.GN1551@shell.armlinux.org.uk>
 <20210107124506.GO1551@shell.armlinux.org.uk> <CAK8P3a2TXPfFpgy+XjpDzOqt1qpDxufwiD-BLNbn4W_jpGp98g@mail.gmail.com>
 <20210107133747.GP1551@shell.armlinux.org.uk> <X/c2aqSvYCaB9sR6@mit.edu>
In-Reply-To: <X/c2aqSvYCaB9sR6@mit.edu>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 7 Jan 2021 22:48:05 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2svyz1KXSqSUMVeDqdag4f1VcERH9jpECSLsn-FWvZbw@mail.gmail.com>
Message-ID: <CAK8P3a2svyz1KXSqSUMVeDqdag4f1VcERH9jpECSLsn-FWvZbw@mail.gmail.com>
Subject: Re: Aarch64 EXT4FS inode checksum failures - seems to be weak memory
 ordering issues
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        linux-toolchains@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jan 7, 2021 at 5:27 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Thu, Jan 07, 2021 at 01:37:47PM +0000, Russell King - ARM Linux admin wrote:
> > > The gcc bugzilla mentions backports into gcc-linaro, but I do not see
> > > them in my git history.
> >
> > So, do we raise the minimum gcc version for the kernel as a whole to 5.1
> > or just for aarch64?
>
> Russell, Arnd, thanks so much for tracking down the root cause of the
> bug!

There is one more thing that I wondered about when looking through
the ext4 code: Should it just call the crc32c_le() function directly
instead of going through the crypto layer? It seems that with Ard's
rework from 2018, that can just call the underlying architecture specific
implementation anyway.

> I will note that RHEL 7 uses gcc 4.8.  I personally don't have an
> objections to requiring developers using RHEL 7 to have to install a
> more modern gcc (since I use Debian Testing and gcc 10.2.1, myself,
> and gcc 5.1 is so five years ago :-), but I could imagine that being
> considered inconvenient for some.

The main users of gcc-4.9 that I recall from previous discussions
were Android and Debian 8, but both of them are done now: Debian 8
has reached its end of life last summer, and Android uses clang
for building new kernels.

       Arnd
