Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E772F61E1
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Jan 2021 14:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbhANNXi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Jan 2021 08:23:38 -0500
Received: from bmailout3.hostsharing.net ([176.9.242.62]:56461 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbhANNXi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Jan 2021 08:23:38 -0500
X-Greylist: delayed 548 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Jan 2021 08:23:37 EST
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 41E2910195B69;
        Thu, 14 Jan 2021 14:13:48 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 1078331C7F; Thu, 14 Jan 2021 14:13:48 +0100 (CET)
Date:   Thu, 14 Jan 2021 14:13:48 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        linux-toolchains@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Theodore Ts'o <tytso@mit.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: Aarch64 EXT4FS inode checksum failures - seems to be weak memory
 ordering issues
Message-ID: <20210114131348.GA1343@wunner.de>
References: <20210107111841.GN1551@shell.armlinux.org.uk>
 <20210107124506.GO1551@shell.armlinux.org.uk>
 <CAK8P3a2TXPfFpgy+XjpDzOqt1qpDxufwiD-BLNbn4W_jpGp98g@mail.gmail.com>
 <20210107133747.GP1551@shell.armlinux.org.uk>
 <CAK8P3a2J8fLjPhyV0XUeuRBdSo6rz1gU4wrQRyfzKQvwhf22ag@mail.gmail.com>
 <X/gkMmObbkI4+ip/@hirez.programming.kicks-ass.net>
 <20210108092655.GA4031@willie-the-truck>
 <CAHk-=whnKkj5CSbj-uG_MVVUsPZ6ppd_MFhZf_kpXDkh2MAVRA@mail.gmail.com>
 <20210112132049.GA26096@wunner.de>
 <CAHk-=wiHaVWUKQ9wvHe5D=JrV3MDehfRi_FL7KXGbi6=S7=jUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiHaVWUKQ9wvHe5D=JrV3MDehfRi_FL7KXGbi6=S7=jUA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jan 12, 2021 at 09:28:32AM -0800, Linus Torvalds wrote:
> On Tue, Jan 12, 2021 at 5:20 AM Lukas Wunner <lukas@wunner.de> wrote:
> > > Variable declarations in for-loops is the only one I can think of. I
> > > think that would clean up some code (and some macros), but might not
> > > be compelling on its own.
> >
> > Anonymous structs/unions.  I used to have a use case for that in
> > struct efi_dev_path in include/linux/efi.h, but Ard Biesheuvel
> > refactored it in a gnu89-compatible way for v5.7 with db8952e7094f.
> 
> We use anonymous structs/unions extensively and all over the place already.

Yes, my apologies, I mixed things up.

Back in 2016 when I authored 46cd4b75cd0e, what I wanted to do was
include an unnamed "struct efi_generic_dev_path;" in struct efi_dev_path:

struct efi_dev_path {
	struct efi_generic_dev_path;
	union {
		struct {
			u32 hid;
			u32 uid;
		} acpi;
		struct {
			u8 fn;
			u8 dev;
		} pci;
	};
} __attribute ((packed));

The alternative is to copy-paste the elements of struct efi_dev_path
or to give it a name such as "header" (which is what db8952e7094f
subsequently did).  Both options seemed inelegant to me.

However it turns out this feature requires -fms-extensions.
It's not part of -std=gnu11.

So coming back to topic, yes there doesn't seem to be too much to
be gained from moving to -std=gnu11 aside from variable declarations
in for-loops.

(And it really has to be -std=gnu11 because -std=c11 fails to compile.)

Thanks,

Lukas
