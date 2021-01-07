Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8390C2EE8A6
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Jan 2021 23:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbhAGW2e (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Jan 2021 17:28:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:42140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728762AbhAGW2d (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 7 Jan 2021 17:28:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF989233A0;
        Thu,  7 Jan 2021 22:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610058473;
        bh=1PbX9hu0NL7rmJtULi9rAa4tgyH75fs0nUv2OGbIUHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FoIP2zgOJueDtSXbOah/fQoWqVsSbNzBTZDwPTw26V9mwRZb7c+QYRqPx+4CODHmH
         cOvPHjtPm6NPEjhZeaNq/WL1xTjOkDHOzsZmY3V90aGEmw2UID5ekd/TcsY0xQhCqI
         fgjQQK7zvUm0vk95l+gY1Go5avKOAKPzVXqoSJoUNdz18noxVHPAl4SYCXkbB+0jAQ
         bSjQahiAzBdeOJKV75hu3aRv284wUzUekHUIASdCImUaZYOjuBYKV11kxlIPdoizuJ
         TZdIVnH0j1SU3fo2G+yDeCDbOr+6QXfzsJOJLhbGV9lDDIbcxWnJ+1DAfl7QBTYbL6
         sTYt433/xpo/Q==
Date:   Thu, 7 Jan 2021 14:27:51 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        linux-toolchains@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: Aarch64 EXT4FS inode checksum failures - seems to be weak memory
 ordering issues
Message-ID: <X/eK5xIMK5yZ2/tl@gmail.com>
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
> 

It looks like that would work, although note that crc32c_le() uses the shash API
too, so it isn't any more "direct" than what ext4 does now.

Also, a potential issue is that the implementation of crc32c that crc32c_le()
uses might be chosen too early if the architecture-specific implementation of
crc32c is compiled as a module (e.g. crc32c-intel.ko).  There are two ways this
could be fixed -- either by making it a proper library API like blake2s() that
can call the architecture-specific code directly, or by reconfiguring things
when a new crypto module is loaded (like what lib/crc-t10dif.c does).

Until one of those is done, switching to crc32c_le() might cause performance
regressions.

- Eric
