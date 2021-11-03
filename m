Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB5544459E
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Nov 2021 17:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbhKCQQU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Nov 2021 12:16:20 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36120 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbhKCQQU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 Nov 2021 12:16:20 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 24470218D9;
        Wed,  3 Nov 2021 16:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635956023;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3bTowwt5/5FwY7SC7Z7E2G8TBByJ4VGdF4azpNrDENU=;
        b=T7A2QQNugZkq0mPriLjHnqcNU5MZ9XIBAoAlnlDPGoicll4r8McX8fnQLAS3gArwc6QHy/
        ybAI0KZkollWMNe2lp8qt4066uya90o/gqi2/8UZB0DcuKpvTdtgWeYIfX2P0REZMcvhXY
        4nqdeO1HUymOxec3eLx9NPrZq/TMhNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635956023;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3bTowwt5/5FwY7SC7Z7E2G8TBByJ4VGdF4azpNrDENU=;
        b=BIGJPluqIwlb2FEe0penCvEqc/62ILWuThez3GOXABfC79DWq9HQraa+6cu6GvLdK1TZaz
        GkB5kBg3TyHhpxBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C7F9513C91;
        Wed,  3 Nov 2021 16:13:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1NP2Lja1gmHKUAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Wed, 03 Nov 2021 16:13:42 +0000
Date:   Wed, 3 Nov 2021 17:13:41 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Matthew Bobrowski <repnop@google.com>, kernel@collabora.com,
        Khazhismel Kumykov <khazhy@google.com>,
        Jan Kara <jack@suse.com>, Ext4 <linux-ext4@vger.kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        LTP List <ltp@lists.linux.it>
Subject: Re: [LTP] [PATCH v3 1/9] syscalls: fanotify: Add macro to require
 specific mark types
Message-ID: <YYK1NQ+wPqzOsK9P@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20211029211732.386127-1-krisman@collabora.com>
 <20211029211732.386127-2-krisman@collabora.com>
 <YYEgqgFoo7oJheFr@google.com>
 <CAOQ4uxiZetvK=r-tedgqNXR4nT=+kWUG5eVRWu8wVUQY5PN0Ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiZetvK=r-tedgqNXR4nT=+kWUG5eVRWu8wVUQY5PN0Ew@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi all,

> On Tue, Nov 2, 2021 at 1:27 PM Matthew Bobrowski <repnop@google.com> wrote:

> > On Fri, Oct 29, 2021 at 06:17:24PM -0300, Gabriel Krisman Bertazi wrote:
> > > Like done for init flags and event types, and a macro to require a
> > > specific mark type.

> > > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> > > Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> > > ---
> > >  testcases/kernel/syscalls/fanotify/fanotify.h | 5 +++++
> > >  1 file changed, 5 insertions(+)

> > > diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
> > > index a2be183385e4..c67db3117e29 100644
> > > --- a/testcases/kernel/syscalls/fanotify/fanotify.h
> > > +++ b/testcases/kernel/syscalls/fanotify/fanotify.h
> > > @@ -373,4 +373,9 @@ static inline int fanotify_mark_supported_by_kernel(uint64_t flag)
> > >       return rval;
> > >  }

> > > +#define REQUIRE_MARK_TYPE_SUPPORTED_ON_KERNEL(mark_type) do { \
> > > +     fanotify_init_flags_err_msg(#mark_type, __FILE__, __LINE__, tst_brk_, \
> > > +                                 fanotify_mark_supported_by_kernel(mark_type)); \
> > > +} while (0)
> > > +
> > >  #endif /* __FANOTIFY_H__ */

> > A nit, but I'm of the opinion that s/_ON_/_BY_ within the macro name. Otherwise,
> > this looks OK to me.

> Agreed. You can change that while cherry-picking to your branch ;-)

+1. And yes, I'll change it while applying it into LTP (no need to repost).

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> Thanks,
> Amir.
