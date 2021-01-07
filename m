Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7C92ED447
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Jan 2021 17:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbhAGQ2X (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Jan 2021 11:28:23 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34255 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728060AbhAGQ2W (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Jan 2021 11:28:22 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 107GRMMv023672
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Jan 2021 11:27:23 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3176915C356A; Thu,  7 Jan 2021 11:27:22 -0500 (EST)
Date:   Thu, 7 Jan 2021 11:27:22 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@kernel.org>, Will Deacon <will@kernel.org>,
        linux-toolchains@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: Aarch64 EXT4FS inode checksum failures - seems to be weak memory
 ordering issues
Message-ID: <X/c2aqSvYCaB9sR6@mit.edu>
References: <20210105154726.GD1551@shell.armlinux.org.uk>
 <20210106115359.GB26994@C02TD0UTHF1T.local>
 <20210106135253.GJ1551@shell.armlinux.org.uk>
 <20210106172033.GA2165@willie-the-truck>
 <20210106223223.GM1551@shell.armlinux.org.uk>
 <20210107111841.GN1551@shell.armlinux.org.uk>
 <20210107124506.GO1551@shell.armlinux.org.uk>
 <CAK8P3a2TXPfFpgy+XjpDzOqt1qpDxufwiD-BLNbn4W_jpGp98g@mail.gmail.com>
 <20210107133747.GP1551@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107133747.GP1551@shell.armlinux.org.uk>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jan 07, 2021 at 01:37:47PM +0000, Russell King - ARM Linux admin wrote:
> > The gcc bugzilla mentions backports into gcc-linaro, but I do not see
> > them in my git history.
> 
> So, do we raise the minimum gcc version for the kernel as a whole to 5.1
> or just for aarch64?

Russell, Arnd, thanks so much for tracking down the root cause of the
bug!

I will note that RHEL 7 uses gcc 4.8.  I personally don't have an
objections to requiring developers using RHEL 7 to have to install a
more modern gcc (since I use Debian Testing and gcc 10.2.1, myself,
and gcc 5.1 is so five years ago :-), but I could imagine that being
considered inconvenient for some.

						- Ted
