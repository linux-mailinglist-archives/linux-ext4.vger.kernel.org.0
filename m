Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C60F2ED0ED
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Jan 2021 14:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbhAGNib (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Jan 2021 08:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728026AbhAGNib (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Jan 2021 08:38:31 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13945C0612F4;
        Thu,  7 Jan 2021 05:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3VXG1gjVht0cxl9ViTm3PDVS6dPgMzDNMoqL8tdmikk=; b=k64FnmbV4KB12EIuVh77t+bl1
        J1Rcz2wbaBMBbYJXF+n3xQC676/dz0YE1rB2ymmNi3E8YvzTOKw8W2t4D36ZM6/YCUs5mYzo3pfAX
        +5nN1SsuRbhqSKjuVPS0aWTGGkbyivSp+erTSrUTXjoQvIuoxjTHotYq/CGFhCknE+jtWDjOpRiFf
        n0ksS53oJEuP5Odzn9Xar9/F/ODZBNLYdLGF6Oa5vL7eTFUMT25mPLTj35TOA60D42t5xfP+R+tW/
        KuxQV0bBi1ixf4erXhXp8DdBtbiVVhOXf9iQz7AMFwbhvCUqMkFNXmwknRgx7FvUPVpzrER+ITOsR
        hl9NLNZxA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45222)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kxVU4-0002sQ-BI; Thu, 07 Jan 2021 13:37:48 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kxVU3-0001DA-Bm; Thu, 07 Jan 2021 13:37:47 +0000
Date:   Thu, 7 Jan 2021 13:37:47 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Will Deacon <will@kernel.org>, linux-toolchains@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Theodore Ts'o <tytso@mit.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: Aarch64 EXT4FS inode checksum failures - seems to be weak memory
 ordering issues
Message-ID: <20210107133747.GP1551@shell.armlinux.org.uk>
References: <20210105154726.GD1551@shell.armlinux.org.uk>
 <20210106115359.GB26994@C02TD0UTHF1T.local>
 <20210106135253.GJ1551@shell.armlinux.org.uk>
 <20210106172033.GA2165@willie-the-truck>
 <20210106223223.GM1551@shell.armlinux.org.uk>
 <20210107111841.GN1551@shell.armlinux.org.uk>
 <20210107124506.GO1551@shell.armlinux.org.uk>
 <CAK8P3a2TXPfFpgy+XjpDzOqt1qpDxufwiD-BLNbn4W_jpGp98g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2TXPfFpgy+XjpDzOqt1qpDxufwiD-BLNbn4W_jpGp98g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jan 07, 2021 at 02:16:25PM +0100, Arnd Bergmann wrote:
> On Thu, Jan 7, 2021 at 1:47 PM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> 
> > Arnd has found via bisecting gcc:
> >
> > 7e8c2bd54af ("[AArch64] fix unsafe access to deallocated stack")
> >
> > which seems to be https://gcc.gnu.org/bugzilla/show_bug.cgi?id=63293
> >
> > That seems to suggest that gcc-5.0.0 is also affected.
> >
> > Looking at the changelog in Debian's gcc-8.3 packages, this doesn't
> > feature, so it's not easy just to look at the changelogs to work out
> > which versions are affected.
> 
> I checked the history to confirm that all gcc-5 releases (5.0.x is pre-release)
> and later have the fix.
> 
> The gcc bugzilla mentions backports into gcc-linaro, but I do not see
> them in my git history.

So, do we raise the minimum gcc version for the kernel as a whole to 5.1
or just for aarch64?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
