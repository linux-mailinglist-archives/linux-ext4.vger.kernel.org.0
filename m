Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3FA2EEF71
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Jan 2021 10:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbhAHJWt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 8 Jan 2021 04:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbhAHJWs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 8 Jan 2021 04:22:48 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B2FC0612F5;
        Fri,  8 Jan 2021 01:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hzsPaWcvnTcN6zjmKvoePQm62laeQH1oHkAlW/Wfqj8=; b=iiY8GRpezMWdVt6/QNtReqbCHO
        dzUSJq1qr5AIlUa6NQeZNRww61pnEP9vhFjfv0k43vwv6jLfM8H6/c5zVnNcz5YiNM/MIlnrchYtB
        hO/MkC7lmQXd6sdMOGAz0Zm74pQOJtHP6VZ4d386yduo3w7ng+NroqiGFREKzZfh9Riye3J13sR44
        7QnmPfl3gGQRk3iSVrb1L1AEE/X0NSNY2S3RdBhxpicqs3F5JeSwnvgUfmVH+IWpEM/1Dy8ZWJcfZ
        mMxhYI5/eeOHmilpdfAKvjm4S1xTQEgnIe9f8BxzIk2B/t/mbED7W5GK/S5icRTFFAmQGdIzoVTkL
        GlhzwQ3Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kxny1-00024h-ES; Fri, 08 Jan 2021 09:21:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 653B33003D8;
        Fri,  8 Jan 2021 10:21:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 308832B877B8A; Fri,  8 Jan 2021 10:21:54 +0100 (CET)
Date:   Fri, 8 Jan 2021 10:21:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        linux-toolchains@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Theodore Ts'o <tytso@mit.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Aarch64 EXT4FS inode checksum failures - seems to be weak memory
 ordering issues
Message-ID: <X/gkMmObbkI4+ip/@hirez.programming.kicks-ass.net>
References: <20210105154726.GD1551@shell.armlinux.org.uk>
 <20210106115359.GB26994@C02TD0UTHF1T.local>
 <20210106135253.GJ1551@shell.armlinux.org.uk>
 <20210106172033.GA2165@willie-the-truck>
 <20210106223223.GM1551@shell.armlinux.org.uk>
 <20210107111841.GN1551@shell.armlinux.org.uk>
 <20210107124506.GO1551@shell.armlinux.org.uk>
 <CAK8P3a2TXPfFpgy+XjpDzOqt1qpDxufwiD-BLNbn4W_jpGp98g@mail.gmail.com>
 <20210107133747.GP1551@shell.armlinux.org.uk>
 <CAK8P3a2J8fLjPhyV0XUeuRBdSo6rz1gU4wrQRyfzKQvwhf22ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2J8fLjPhyV0XUeuRBdSo6rz1gU4wrQRyfzKQvwhf22ag@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jan 07, 2021 at 10:20:38PM +0100, Arnd Bergmann wrote:
> On Thu, Jan 7, 2021 at 2:37 PM Russell King - ARM Linux admin

> > So, do we raise the minimum gcc version for the kernel as a whole to 5.1
> > or just for aarch64?
> 
> I'd personally love to see gcc-5 as the global minimum version, as that
> would let us finally use --std=gnu11 features instead of gnu89. [There are
> a couple of useful features that are incompatible with gnu89, and
> gnu99/gnu11 support in gcc didn't like the kernel sources]

+1 for raising the tree-wide minimum (again!). We actually have a bunch
of work-arounds for 4.9 bugs we can get rid of as well.
