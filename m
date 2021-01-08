Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 983CD2EEF44
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Jan 2021 10:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbhAHJOU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 8 Jan 2021 04:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbhAHJOT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 8 Jan 2021 04:14:19 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F40C0612F4;
        Fri,  8 Jan 2021 01:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JstFwViTfznovKsvrCMjV4s0lyrsGpLOyj403etiWzw=; b=Pqrtrh67hmHbrp2S7fw29gpnGh
        ydq2LtcOiP+q//2A3OdaQj7PNhCBPo/OZg5R/R03o7eDsRwKhKGBBi4vlCYSXQjwWpCR7WdUheHd+
        Bh6u9jqXxdyUpUOxNMGxdYdVZ0SxWOqWpDIvKuILdvdctphGjVcTF9qSVbPgD/7mma+BtK/xeyTIz
        Z40r/WkGtYNhyEAaoSt3W9JR/HslBg9KAYUqSL5AMahjK2Wr59NY6j3Dxy4u7GdU8gVkQqgA+YDuR
        Ho1rVHR1uPeSRpawzplLHQL7WRa8ia+pX8vTLbkbfWNHJOyyfMyAL8+pDffd6l2tHoZuEWbtfOfk/
        LUhcYFCA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kxnpo-0000s1-VE; Fri, 08 Jan 2021 09:13:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 287AE301E02;
        Fri,  8 Jan 2021 10:13:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 102A52C2B465F; Fri,  8 Jan 2021 10:13:23 +0100 (CET)
Date:   Fri, 8 Jan 2021 10:13:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@kernel.org>, Will Deacon <will@kernel.org>,
        linux-toolchains@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: Aarch64 EXT4FS inode checksum failures - seems to be weak memory
 ordering issues
Message-ID: <X/giM+tM3FGVj0Np@hirez.programming.kicks-ass.net>
References: <20210105154726.GD1551@shell.armlinux.org.uk>
 <20210106115359.GB26994@C02TD0UTHF1T.local>
 <20210106135253.GJ1551@shell.armlinux.org.uk>
 <20210106172033.GA2165@willie-the-truck>
 <20210106223223.GM1551@shell.armlinux.org.uk>
 <20210107111841.GN1551@shell.armlinux.org.uk>
 <20210107124506.GO1551@shell.armlinux.org.uk>
 <CAK8P3a2TXPfFpgy+XjpDzOqt1qpDxufwiD-BLNbn4W_jpGp98g@mail.gmail.com>
 <20210107133747.GP1551@shell.armlinux.org.uk>
 <X/c2aqSvYCaB9sR6@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/c2aqSvYCaB9sR6@mit.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jan 07, 2021 at 11:27:22AM -0500, Theodore Ts'o wrote:
> I will note that RHEL 7 uses gcc 4.8.  I personally don't have an
> objections to requiring developers using RHEL 7 to have to install a
> more modern gcc (since I use Debian Testing and gcc 10.2.1, myself,
> and gcc 5.1 is so five years ago :-), but I could imagine that being
> considered inconvenient for some.

The kernel minimum (4.9) is already past that, so RHEL7 people are
already out in the cold.
