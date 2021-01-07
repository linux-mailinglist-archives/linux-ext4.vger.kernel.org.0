Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48BD12ECE94
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Jan 2021 12:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbhAGLT1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Jan 2021 06:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbhAGLT0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Jan 2021 06:19:26 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90680C0612F8;
        Thu,  7 Jan 2021 03:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=S08DtyL008m+qnmwxqQkLEttBGjQAK8QhaFe4DkFXlY=; b=g7hUqBv0KP36V5o2e4V0VXuwh
        GYxuYuEEDjJiUOWsbZf2qTzRMMJ6746wJIOMgvsFFIZ0qEIqHd2CLPHXWqPMMpYjtNcob6P8pvag8
        20NffPtpQYS76cFkWaIyt2NIj6e7Bj4sgmwqQrhuiuOWR8wOhCwpZULtHZQO0YboRViMOp1y0ur0i
        DhyazszPl70r1hwYoCkAxqWpn/ushYNjYUBLHzKf+TENcDZBt2QkKyeRxc/abcWDps78LjG4wCBxP
        cdEegoueuWqkEgtmuQvhqlow73QkpyiG9xx1VE6TWtGsWy3Kh+1NNID8xTvUP1c7hCVRkYH/4Atoh
        DGwSB6BGg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45214)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kxTJT-0002hu-ID; Thu, 07 Jan 2021 11:18:43 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kxTJR-00018e-95; Thu, 07 Jan 2021 11:18:41 +0000
Date:   Thu, 7 Jan 2021 11:18:41 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Will Deacon <will@kernel.org>, linux-toolchains@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>, Theodore Ts'o <tytso@mit.edu>,
        linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: Aarch64 EXT4FS inode checksum failures - seems to be weak memory
 ordering issues
Message-ID: <20210107111841.GN1551@shell.armlinux.org.uk>
References: <20210105154726.GD1551@shell.armlinux.org.uk>
 <20210106115359.GB26994@C02TD0UTHF1T.local>
 <20210106135253.GJ1551@shell.armlinux.org.uk>
 <20210106172033.GA2165@willie-the-truck>
 <20210106223223.GM1551@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106223223.GM1551@shell.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 06, 2021 at 10:32:23PM +0000, Russell King - ARM Linux admin wrote:
> On Wed, Jan 06, 2021 at 05:20:34PM +0000, Will Deacon wrote:
> > With that, I see the following after ten seconds or so:
> > 
> >   EXT4-fs error (device sda2): ext4_lookup:1707: inode #674497: comm md5sum: iget: checksum invalid
> > 
> > Russell, Mark -- does this recipe explode reliably for you too?
> 
> I've been working this evening on tracking down what change in the
> Kconfig file between your working 5.10 kernel binary you supplied me,
> and my failing 5.9 kernel.
> 
> I've found that _enabling_ CONFIG_STACKPROTECTOR appears to mask the
> inode checksum failure problem, at least from a short test.) I'm going
> to re-enable CONFIG_STACKPROTECTOR and leave it running for longer.
> 
> That is:
> 
> CONFIG_STACKPROTECTOR=y
> CONFIG_STACKPROTECTOR_STRONG=y
> 
> appears to mask the problem
> 
> # CONFIG_STACKPROTECTOR is not set
> 
> appears to unmask the problem.

We have finally got to the bottom of this - the "bug" is in the ext4
code:

static inline u32 ext4_chksum(struct ext4_sb_info *sbi, u32 crc,
                              const void *address, unsigned int length)
{
        struct {
                struct shash_desc shash;
                char ctx[4];
        } desc;

        BUG_ON(crypto_shash_descsize(sbi->s_chksum_driver)!=sizeof(desc.ctx));

        desc.shash.tfm = sbi->s_chksum_driver;
        *(u32 *)desc.ctx = crc;

        BUG_ON(crypto_shash_update(&desc.shash, address, length));

        return *(u32 *)desc.ctx;
}

This isn't always inlined, despite the "inline" keyword. With GCC
4.9.4, this is compiled to the following code when the stack protector
is disabled:

0000000000000004 <ext4_chksum.isra.14.constprop.19>:
   4:   a9be7bfd        stp     x29, x30, [sp, #-32]!		<------
   8:   2a0103e3        mov     w3, w1
   c:   aa0203e1        mov     x1, x2
  10:   910003fd        mov     x29, sp				<------
  14:   f9000bf3        str     x19, [sp, #16]
  18:   d10603ff        sub     sp, sp, #0x180			<------
  1c:   9101fff3        add     x19, sp, #0x7f
  20:   b9400002        ldr     w2, [x0]
  24:   9279e273        and     x19, x19, #0xffffffffffffff80	<------
  28:   7100105f        cmp     w2, #0x4
  2c:   540001a1        b.ne    60 <ext4_chksum.isra.14.constprop.19+0x5c>  // b.any
  30:   2a0303e4        mov     w4, w3
  34:   aa0003e3        mov     x3, x0
  38:   b9008264        str     w4, [x19, #128]
  3c:   aa1303e0        mov     x0, x19
  40:   f9000263        str     x3, [x19]			<------
  44:   94000000        bl      0 <crypto_shash_update>
                        44: R_AARCH64_CALL26    crypto_shash_update
  48:   350000e0        cbnz    w0, 64 <ext4_chksum.isra.14.constprop.19+0x60>
  4c:   910003bf        mov     sp, x29				<======
  50:   b9408260        ldr     w0, [x19, #128]			<======
  54:   f9400bf3        ldr     x19, [sp, #16]
  58:   a8c27bfd        ldp     x29, x30, [sp], #32
  5c:   d65f03c0        ret
  60:   d4210000        brk     #0x800
  64:   97ffffe7        bl      0 <ext4_chksum.isra.14.part.15>

Of the instructions that are highlighted with "<------" and "<======",
x29 is located at the bottom of the function's stack frame, excluding
local variables.  x19 is "desc", which is calculated to be safely below
x29 and aligned to a 128 byte boundary.

The bug is pointed to by the two "<======" markers - the instruction
at 4c restores the stack pointer _above_ "desc" before then loading
desc.ctx.

If an interrupt occurs right between these two instructions, then
desc.ctx will be corrupted, leading to the checksum failing.

Comments on irc are long the lines of this being "an impressive
compiler bug".

We now need to find which gcc versions are affected, so we know what
minimum version to require for aarch64.

Arnd has been unable to find anything in gcc bugzilla to explain this;
he's tested gcc-5.5.0, which appears to produce correct code, and is
trying to bisect between 4.9.4 and 5.1.0 to locate where this was
fixed.

Peter Zijlstra suggested adding linux-toolchains@ and asking compiler
folks for feedback on this bug. I guess a pointer to whether this is
a known bug, and which bug may be useful.

I am very relieved to have found a positive reason for this bug, rather
than just moving forward on the compiler and have the bug vanish
without explanation, never knowing if it would rear its head in future
and corrupt my filesystems, e.g. never knowing if it became a
temporarily masked memory ordering bug.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
