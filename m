Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B442EF935
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Jan 2021 21:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbhAHUad (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 8 Jan 2021 15:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbhAHUac (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 8 Jan 2021 15:30:32 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441BCC061380;
        Fri,  8 Jan 2021 12:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3NuKcP/o2asx0FFI9whdbE8cG4acAU/bjOidJQiHRu4=; b=SxjT6qlizraAdzfoC5DuKEWS9
        05kTbDGljDKQCF7Y89n5rm1G8jVt15Cij9mGOb26YoYjV1lBEXJKfxWl1zXT4yzUabdV13w3ANw42
        suUwIcfafPitFROZMPDmmxsW7RiHGlPix2V6aRHu8SZS6kIqAGbycJknu6c1bVmOuARHT2Sj4uwLZ
        IOv3ymo6c8n5rRXIS3ZpmSQ3fPiUiNy6gGkEqVMfUKwkJ5uqvNog6CZghXRpPM+8MFv3ioz5h1oCM
        kJOlq8RfZ27wyWNEnqrMVxxZM/hjVo+0WvI5VxJa86Tm8lMIeENA/ourZ7x0IfSHmqTvVK/q7QTdE
        LtN05F7gQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45446)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kxyNx-0004SJ-2y; Fri, 08 Jan 2021 20:29:25 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kxyNw-0002SW-4O; Fri, 08 Jan 2021 20:29:24 +0000
Date:   Fri, 8 Jan 2021 20:29:24 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@kernel.org>,
        linux-toolchains@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Theodore Ts'o <tytso@mit.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: Aarch64 EXT4FS inode checksum failures - seems to be weak memory
 ordering issues
Message-ID: <20210108202924.GY1551@shell.armlinux.org.uk>
References: <20210106172033.GA2165@willie-the-truck>
 <20210106223223.GM1551@shell.armlinux.org.uk>
 <20210107111841.GN1551@shell.armlinux.org.uk>
 <20210107124506.GO1551@shell.armlinux.org.uk>
 <CAK8P3a2TXPfFpgy+XjpDzOqt1qpDxufwiD-BLNbn4W_jpGp98g@mail.gmail.com>
 <20210107133747.GP1551@shell.armlinux.org.uk>
 <CAK8P3a2J8fLjPhyV0XUeuRBdSo6rz1gU4wrQRyfzKQvwhf22ag@mail.gmail.com>
 <X/gkMmObbkI4+ip/@hirez.programming.kicks-ass.net>
 <20210108092655.GA4031@willie-the-truck>
 <CAHk-=whnKkj5CSbj-uG_MVVUsPZ6ppd_MFhZf_kpXDkh2MAVRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whnKkj5CSbj-uG_MVVUsPZ6ppd_MFhZf_kpXDkh2MAVRA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jan 08, 2021 at 12:02:53PM -0800, Linus Torvalds wrote:
> Well, honestly, I'm always in favor of having people not use ancient
> compilers, but both of the issues at hand do seem to be specific to
> arm64.
> 
> The "gcc before 5.1 generates incorrect stack pointer writes on arm64"
> sounds pretty much deadly, and I think means that yes, for arm64 we
> simply need to require 5.1 or newer.
> 
> I also suspect there is much less reason to use old gcc's on arm64. I
> can't imagine that people really run very old setups, Is some old RHEL
> version even relevant for arm64?

For me, six years old for a compiler is really not "very old" - and,
when I first encountered this problem, it was over 12 months ago.
Apart from the kernel, I am not in the habbit of upgrading stuff for
the sake of upgrading - I tend to stick with what I have and what
works. Not everyone on this planet has a desire to have the latest
and greatest all the time.

Since then, I've _not_ wanted to change the compiler in case the
problem vanishes without explanation - it had the feeling of being
way more serious than a compiler bug, potentially a memory ordering
bug.

It took about a year just to start being able to work out what was
going on - it would take up to about three months to show for me,
and when it did, it spat out an ext4 inode checksum error and made
the rootfs read-only.

To "hide" that by upgrading the compiler, and then to be in the
situation where you do not trust any aarch64 machine with your data
is no real solution. That's exactly where I was until this had been
found. The aarch64 architecture had completely lost my trust as a
viable computing platform - and I was at the point of considering
disposing of all my aarch64 hardware and replacing it with x86.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
