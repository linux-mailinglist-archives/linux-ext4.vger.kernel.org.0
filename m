Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2A72ED4EF
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Jan 2021 18:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbhAGRB6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Jan 2021 12:01:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31799 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728713AbhAGRB6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Jan 2021 12:01:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610038831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uHtLQ82irY0zw9G0AL7ymoS/HHVkiUCAdKjz4xIDFCA=;
        b=abMzKT73Rz1McXwoBOdB3KGtT/Ki/AihZZnI8Mp4XIbslzJz2d07NEMo9CydEB0rIvt6vr
        qzwJlCm61xwPTDGpSfRwg6OqTN+tuw+HaT9noz9y0W5sD6uw3xgCArepjCzhHgl9qEscZO
        29cmjUATM4kUC4KLci+4dLEU3u2iEVE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-tA9k7NiUM0q06iIHy0qyAg-1; Thu, 07 Jan 2021 12:00:27 -0500
X-MC-Unique: tA9k7NiUM0q06iIHy0qyAg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9084107ACE3;
        Thu,  7 Jan 2021 17:00:25 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-114-198.ams2.redhat.com [10.36.114.198])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 57E6C19C81;
        Thu,  7 Jan 2021 17:00:23 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@kernel.org>, Will Deacon <will@kernel.org>,
        linux-toolchains@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: Aarch64 EXT4FS inode checksum failures - seems to be weak
 memory ordering issues
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
Date:   Thu, 07 Jan 2021 18:00:21 +0100
In-Reply-To: <X/c2aqSvYCaB9sR6@mit.edu> (Theodore Ts'o's message of "Thu, 7
        Jan 2021 11:27:22 -0500")
Message-ID: <87r1mwy95m.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

* Theodore Ts'o:

> On Thu, Jan 07, 2021 at 01:37:47PM +0000, Russell King - ARM Linux admin wrote:
>> > The gcc bugzilla mentions backports into gcc-linaro, but I do not see
>> > them in my git history.
>> 
>> So, do we raise the minimum gcc version for the kernel as a whole to 5.1
>> or just for aarch64?
>
> Russell, Arnd, thanks so much for tracking down the root cause of the
> bug!
>
> I will note that RHEL 7 uses gcc 4.8.  I personally don't have an
> objections to requiring developers using RHEL 7 to have to install a
> more modern gcc (since I use Debian Testing and gcc 10.2.1, myself,
> and gcc 5.1 is so five years ago :-), but I could imagine that being
> considered inconvenient for some.

Actually, RHEL 7 should have the fix (internal bug #1362635, curiously
we encountered it in the *XFS* CRC calculation code back then).

My understanding is that RHEL 7 aarch64 support ceased completely about
a month ago, so that shouldn't be an argument against bumping the
minimum version requirement to 5.1.

Thanks,
Florian
-- 
Red Hat GmbH, https://de.redhat.com/ , Registered seat: Grasbrunn,
Commercial register: Amtsgericht Muenchen, HRB 153243,
Managing Directors: Charles Cachera, Brian Klemm, Laurie Krebs, Michael O'Neill

