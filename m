Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2572F31D3
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Jan 2021 14:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbhALNdW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Jan 2021 08:33:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40500 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725843AbhALNdW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 12 Jan 2021 08:33:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610458316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zKKsToTCsHKK+pVPuk9zw5RNKK0D4uDQCytCR/8mFAA=;
        b=VHytFgskteiEUCdP6W35LZt72g+ISRLNTrhuOso+hV1G/8IQIBwExqu8xhG6HZtahcslyh
        oc9KmUbjf7WS+lNkyc5JMsayzeWjLEYR20jhmo8kvS3E94L7M7P5/cquuMT2Ya6Tc0wyNV
        F3RXlVWvRrHD5S+LSn+I48N22CaZhok=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-za5grBJhMtGTUsXh0knBLw-1; Tue, 12 Jan 2021 08:31:52 -0500
X-MC-Unique: za5grBJhMtGTUsXh0knBLw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A1BE107ACF7;
        Tue, 12 Jan 2021 13:31:50 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-114-67.ams2.redhat.com [10.36.114.67])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 55DF35D9D2;
        Tue, 12 Jan 2021 13:31:47 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
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
Subject: Re: Aarch64 EXT4FS inode checksum failures - seems to be weak
 memory ordering issues
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
        <20210112132049.GA26096@wunner.de>
Date:   Tue, 12 Jan 2021 14:31:45 +0100
In-Reply-To: <20210112132049.GA26096@wunner.de> (Lukas Wunner's message of
        "Tue, 12 Jan 2021 14:20:49 +0100")
Message-ID: <877doii8n2.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

* Lukas Wunner:

> On Fri, Jan 08, 2021 at 12:02:53PM -0800, Linus Torvalds wrote:
>> I appreciate Arnd pointing out "--std=gnu11", though. What are the
>> actual relevant language improvements?
>> 
>> Variable declarations in for-loops is the only one I can think of. I
>> think that would clean up some code (and some macros), but might not
>> be compelling on its own.
>
> Anonymous structs/unions.  I used to have a use case for that in
> struct efi_dev_path in include/linux/efi.h, but Ard Biesheuvel
> refactored it in a gnu89-compatible way for v5.7 with db8952e7094f.

Aren't those a GNU extension supported since GCC 3.0?

Thanks,
Florian
-- 
Red Hat GmbH, https://de.redhat.com/ , Registered seat: Grasbrunn,
Commercial register: Amtsgericht Muenchen, HRB 153243,
Managing Directors: Charles Cachera, Brian Klemm, Laurie Krebs, Michael O'Neill

