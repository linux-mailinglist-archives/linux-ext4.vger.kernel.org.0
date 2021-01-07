Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586BC2EE795
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Jan 2021 22:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbhAGVVg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Jan 2021 16:21:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:33630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726507AbhAGVVg (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 7 Jan 2021 16:21:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E233235E4;
        Thu,  7 Jan 2021 21:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610054455;
        bh=JQnyou7N11nSe8TDE+2mKJurKi94dAj+iU3eUH7pczQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=O4EG1/PN8B9Wg7lpYA0oRBJPrPIzy5JYhq/uv8vAnK/qKAXzh2g2+xwzc52DYdWaT
         jW8bDDZtQpHc7BhcY8k0FNCZMdkctKEAry6+oh95f/0AS8/JFPrFGqEl2EbNbNsq6a
         IIIp4ugL2X2QUHgNNnzaAvIRVOZv0dDBw7gdh+n5y+G99h4ESxEr2KVTaTboDw+O5M
         3Ca8tSqhrhpRbUbmy0mLuCEkONwQXqf8KunHz9uagepLWDnNxDeGN2XCF9/c9jktGH
         RS8lqR36hI85x9mFiN/vAbd8fxlbBEJb1Hk8nmYQ+OrGh3OVBX7S8VvvHwEoqc/+89
         851m9rxIbZ+Xg==
Received: by mail-oi1-f172.google.com with SMTP id q25so8962191oij.10;
        Thu, 07 Jan 2021 13:20:55 -0800 (PST)
X-Gm-Message-State: AOAM530oBYz+WO4EK/funoWCJd5NqdItcrdUhWODCCB7wRg/CCKIW4bG
        6JIHU7mwTd9gyISdsrUKJAh7cl/rcpzR/fBNVj4=
X-Google-Smtp-Source: ABdhPJwlH1Ewtc7sSONuNWWPkcNOMjtoLMh6L28J0ziQAfl5nh6T+ZmmrR7FtjgXyEPFUnrDBSuyrAuRWDyklfja/ag=
X-Received: by 2002:aca:e103:: with SMTP id y3mr349498oig.11.1610054455043;
 Thu, 07 Jan 2021 13:20:55 -0800 (PST)
MIME-Version: 1.0
References: <20210105154726.GD1551@shell.armlinux.org.uk> <20210106115359.GB26994@C02TD0UTHF1T.local>
 <20210106135253.GJ1551@shell.armlinux.org.uk> <20210106172033.GA2165@willie-the-truck>
 <20210106223223.GM1551@shell.armlinux.org.uk> <20210107111841.GN1551@shell.armlinux.org.uk>
 <20210107124506.GO1551@shell.armlinux.org.uk> <CAK8P3a2TXPfFpgy+XjpDzOqt1qpDxufwiD-BLNbn4W_jpGp98g@mail.gmail.com>
 <20210107133747.GP1551@shell.armlinux.org.uk>
In-Reply-To: <20210107133747.GP1551@shell.armlinux.org.uk>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 7 Jan 2021 22:20:38 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2J8fLjPhyV0XUeuRBdSo6rz1gU4wrQRyfzKQvwhf22ag@mail.gmail.com>
Message-ID: <CAK8P3a2J8fLjPhyV0XUeuRBdSo6rz1gU4wrQRyfzKQvwhf22ag@mail.gmail.com>
Subject: Re: Aarch64 EXT4FS inode checksum failures - seems to be weak memory
 ordering issues
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Will Deacon <will@kernel.org>, linux-toolchains@vger.kernel.org,
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

On Thu, Jan 7, 2021 at 2:37 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
> On Thu, Jan 07, 2021 at 02:16:25PM +0100, Arnd Bergmann wrote:
> > On Thu, Jan 7, 2021 at 1:47 PM Russell King - ARM Linux admin
> > <linux@armlinux.org.uk> wrote:
>
> > The gcc bugzilla mentions backports into gcc-linaro, but I do not see
> > them in my git history.

Correction: I looked in the wrong branch, gcc-linaro does have it, as
does the Android gcc, which was recently still at 4.9 before they dropped it
in favor of clang.

> So, do we raise the minimum gcc version for the kernel as a whole to 5.1
> or just for aarch64?

I'd personally love to see gcc-5 as the global minimum version, as that
would let us finally use --std=gnu11 features instead of gnu89. [There are
a couple of useful features that are incompatible with gnu89, and
gnu99/gnu11 support in gcc didn't like the kernel sources]

If we make it arm64 specific, I'd propose only making it a build-time
warning instead of an error, as there are no other benefits to increasing
the minimum version if gcc-4.9 is still an option for other architectures,
and most gcc-4.9 users (Android, Red Hat and everyone using gcc-linaro)
have backported this bugfix already.

         Arnd
