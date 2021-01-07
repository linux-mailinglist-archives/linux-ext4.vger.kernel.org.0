Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A99732EE830
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Jan 2021 23:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbhAGWPk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Jan 2021 17:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbhAGWPk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Jan 2021 17:15:40 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33291C0612F4;
        Thu,  7 Jan 2021 14:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hp/hzbK32x3dtwPGRRysL2rjHsQS0TM3qH9C23QvpIA=; b=j7hHcXeFfYP57LBpWFdXW7V+U
        +Z6qUX2TtBeaa6rYBqBgNCiVvJT4ilYColt4Yvs0NBPxitPL4ichfEXLoev4YFuUPvGgowKub2LDd
        AAe9iJDQpPwA9J4yx/uwzlLuBEP5TSDhawMa2Zes3IguK0D+su1mc6Q+31oJCXPCTeCZ8fQOQeVHw
        1XfnbhMZ8VT+apBUPs/9Wg1nlVOdzrqwdYyMWxw7L/0r7tWp3puyrb2PFeDZOLFEXbHQ8itkvAZ9i
        TSShIJO/Ke1uITaWdzD/ytM/4PaG/zGLJdt5pAIV2oHT0lUed972s4YgQG2P8V+vgWeV3IV3k50+u
        tMHKXRq0w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45240)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kxdYR-0003GN-2H; Thu, 07 Jan 2021 22:14:51 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kxdYM-0001W8-SH; Thu, 07 Jan 2021 22:14:46 +0000
Date:   Thu, 7 Jan 2021 22:14:46 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, Will Deacon <will@kernel.org>,
        linux-toolchains@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: Aarch64 EXT4FS inode checksum failures - seems to be weak memory
 ordering issues
Message-ID: <20210107221446.GS1551@shell.armlinux.org.uk>
References: <20210106115359.GB26994@C02TD0UTHF1T.local>
 <20210106135253.GJ1551@shell.armlinux.org.uk>
 <20210106172033.GA2165@willie-the-truck>
 <20210106223223.GM1551@shell.armlinux.org.uk>
 <20210107111841.GN1551@shell.armlinux.org.uk>
 <20210107124506.GO1551@shell.armlinux.org.uk>
 <CAK8P3a2TXPfFpgy+XjpDzOqt1qpDxufwiD-BLNbn4W_jpGp98g@mail.gmail.com>
 <20210107133747.GP1551@shell.armlinux.org.uk>
 <X/c2aqSvYCaB9sR6@mit.edu>
 <CAK8P3a2svyz1KXSqSUMVeDqdag4f1VcERH9jpECSLsn-FWvZbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2svyz1KXSqSUMVeDqdag4f1VcERH9jpECSLsn-FWvZbw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jan 07, 2021 at 10:48:05PM +0100, Arnd Bergmann wrote:
> On Thu, Jan 7, 2021 at 5:27 PM Theodore Ts'o <tytso@mit.edu> wrote:
> >
> > On Thu, Jan 07, 2021 at 01:37:47PM +0000, Russell King - ARM Linux admin wrote:
> > > > The gcc bugzilla mentions backports into gcc-linaro, but I do not see
> > > > them in my git history.
> > >
> > > So, do we raise the minimum gcc version for the kernel as a whole to 5.1
> > > or just for aarch64?
> >
> > Russell, Arnd, thanks so much for tracking down the root cause of the
> > bug!
> 
> There is one more thing that I wondered about when looking through
> the ext4 code: Should it just call the crc32c_le() function directly
> instead of going through the crypto layer? It seems that with Ard's
> rework from 2018, that can just call the underlying architecture specific
> implementation anyway.

Yes, I've been wondering about that too. To me, it looks like the
ext4 code performs a layering violation by going "under the covers"
- there are accessor functions to set the CRC and retrieve it. ext4
instead just makes the assumption that the CRC value is stored after
struct shash_desc. Especially as the crypto/crc32c code references
the value using:

	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);

Not even crypto drivers are allowed to assume that desc+1 is where
the CRC is stored.

However, struct shash_desc is already 128 bytes in size on aarch64,
and the proper way of doing it via SHASH_DESC_ON_STACK() is overkill,
being strangely 2 * sizeof(struct shash_desc) + 360 (which looks like
another bug to me!)

#define HASH_MAX_DESCSIZE       (sizeof(struct shash_desc) + 360)
                                 ^^^^^^^^^^^^^^^^^^^^^^^^^
#define SHASH_DESC_ON_STACK(shash, ctx)                           \
        char __##shash##_desc[sizeof(struct shash_desc) +         \
                              ^^^^^^^^^^^^^^^^^^^^^^^^^
                HASH_MAX_DESCSIZE] CRYPTO_MINALIGN_ATTR; \
        struct shash_desc *shash = (struct shash_desc *)__##shash##_desc

So, I agree with you wrt crc32c_le(), especially as it would be more
efficient, and as the use of crc32c is already hard coded in the ext4
code - not only with crypto_alloc_shash("crc32c", 0, 0) but also with
the fixed-size structure in ext4_chksum().

However, it's ultimately up to the ext4 maintainers to decide.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
