Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA562EEF95
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Jan 2021 10:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbhAHJ1n (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 8 Jan 2021 04:27:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:51240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727416AbhAHJ1m (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 8 Jan 2021 04:27:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D459623383;
        Fri,  8 Jan 2021 09:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610098021;
        bh=OK/mYSs9iM/Xc5hxkZH354NtxXCpKfdWVjsPjgRbISk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C5qyhiKjMN7La52qc6rSqYAOnndCr76SYaP4nS6fmGU4KOHTk7A9TbGUuWuP47r2i
         7K81EAa64FipzxuKipWJx2HAi9c41nOqvh7XWK2F8/Q8ioih0CkDJOIuNr97Sd059s
         fwQz1R6BcTeHg/wuO4Y006iJdGIR9VLJNCjXxsrvkIlZ/FQpsMFVauV8FA73sDUNVY
         owqzKKU4zPGpaEZZqrqik0Uve0hmVAZ2i4Lvc5KIseuYQ5i/QsYOPOfIPwS7IimOkL
         ejnpVJIy37QEIEs6YiasyhF33mldMpxfo0qTWnYiE9gM6mwpbsPJcZtqD9S7R2zSQu
         vpjjsMgaI6yvQ==
Date:   Fri, 8 Jan 2021 09:26:56 +0000
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
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
Message-ID: <20210108092655.GA4031@willie-the-truck>
References: <20210106115359.GB26994@C02TD0UTHF1T.local>
 <20210106135253.GJ1551@shell.armlinux.org.uk>
 <20210106172033.GA2165@willie-the-truck>
 <20210106223223.GM1551@shell.armlinux.org.uk>
 <20210107111841.GN1551@shell.armlinux.org.uk>
 <20210107124506.GO1551@shell.armlinux.org.uk>
 <CAK8P3a2TXPfFpgy+XjpDzOqt1qpDxufwiD-BLNbn4W_jpGp98g@mail.gmail.com>
 <20210107133747.GP1551@shell.armlinux.org.uk>
 <CAK8P3a2J8fLjPhyV0XUeuRBdSo6rz1gU4wrQRyfzKQvwhf22ag@mail.gmail.com>
 <X/gkMmObbkI4+ip/@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/gkMmObbkI4+ip/@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jan 08, 2021 at 10:21:54AM +0100, Peter Zijlstra wrote:
> On Thu, Jan 07, 2021 at 10:20:38PM +0100, Arnd Bergmann wrote:
> > On Thu, Jan 7, 2021 at 2:37 PM Russell King - ARM Linux admin
> 
> > > So, do we raise the minimum gcc version for the kernel as a whole to 5.1
> > > or just for aarch64?
> > 
> > I'd personally love to see gcc-5 as the global minimum version, as that
> > would let us finally use --std=gnu11 features instead of gnu89. [There are
> > a couple of useful features that are incompatible with gnu89, and
> > gnu99/gnu11 support in gcc didn't like the kernel sources]
> 
> +1 for raising the tree-wide minimum (again!). We actually have a bunch
> of work-arounds for 4.9 bugs we can get rid of as well.

We even just added another one for arm64 KVM! [1]

So yes, I'm in favour of leaving gcc 4.9 to rot as well, especially after
this ext4 debugging experience.

Will

[1] https://git.kernel.org/linus/9fd339a45be5
