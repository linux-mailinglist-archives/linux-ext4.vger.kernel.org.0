Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9164F2F3176
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Jan 2021 14:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732730AbhALNVc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Jan 2021 08:21:32 -0500
Received: from bmailout2.hostsharing.net ([83.223.78.240]:49391 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732265AbhALNVc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 12 Jan 2021 08:21:32 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id E08F82800B3D8;
        Tue, 12 Jan 2021 14:20:49 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id D48D850D7E; Tue, 12 Jan 2021 14:20:49 +0100 (CET)
Date:   Tue, 12 Jan 2021 14:20:49 +0100
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
Message-ID: <20210112132049.GA26096@wunner.de>
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
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jan 08, 2021 at 12:02:53PM -0800, Linus Torvalds wrote:
> I appreciate Arnd pointing out "--std=gnu11", though. What are the
> actual relevant language improvements?
> 
> Variable declarations in for-loops is the only one I can think of. I
> think that would clean up some code (and some macros), but might not
> be compelling on its own.

Anonymous structs/unions.  I used to have a use case for that in
struct efi_dev_path in include/linux/efi.h, but Ard Biesheuvel
refactored it in a gnu89-compatible way for v5.7 with db8952e7094f.

[The above was copy-pasted from last time this discussion came up
in July 2020.  Back then, Kirill Shutemov likewise mentioned the
local variables in loops feature:
https://lore.kernel.org/lkml/20200710111724.m4jaci73pykalxys@wunner.de/
]

Thanks,

Lukas
