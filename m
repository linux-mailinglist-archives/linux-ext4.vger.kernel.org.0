Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1724578DC
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Nov 2021 23:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbhKSWm2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 19 Nov 2021 17:42:28 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:41640 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbhKSWm2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 19 Nov 2021 17:42:28 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 621911FD32;
        Fri, 19 Nov 2021 22:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637361565;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sZKQiLW0GBjSd5I99TiU3zoGy+TT/jaUvTzYZQ36Cw0=;
        b=mHsWkGZ1blMAYAzr0AzNzDCxSKrVYiOGxeSARhxFyYU8DWbq0OS3639YnqzSZnKwwf1q9z
        dWdIbI85865VrQ1SWCa03SQa8HPIRRleCPwqPmSulTTfN6C+BA7/Ls8E7zSzgDoFj3K7kz
        aOIXUiEMo/iX8kqhg5VNYIweF0dJi8w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637361565;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sZKQiLW0GBjSd5I99TiU3zoGy+TT/jaUvTzYZQ36Cw0=;
        b=wzfxIhBBHMqSSOvbwtLpzfUCidSxA4rLF3R9oc1WzzSz+skTxdJB/q4vN+hdw9Tp28D2fx
        rVGU1e11Gdg16LAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 27E7213B53;
        Fri, 19 Nov 2021 22:39:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lxPxB50nmGFONQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 19 Nov 2021 22:39:25 +0000
Date:   Fri, 19 Nov 2021 23:39:23 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Matthew Bobrowski <repnop@google.com>,
        Jan Kara <jack@suse.com>, Ext4 <linux-ext4@vger.kernel.org>,
        kernel@collabora.com, Khazhismel Kumykov <khazhy@google.com>,
        LTP List <ltp@lists.linux.it>
Subject: Re: [PATCH v4 4/9] syscalls/fanotify22: Validate the generic error
 info
Message-ID: <YZgnm3XX6wGZA80L@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20211118235744.802584-1-krisman@collabora.com>
 <20211118235744.802584-5-krisman@collabora.com>
 <CAOQ4uxjk8J48ASw2yJhd-OR2LVN6kirg7p6xQbX=xEofGYUghw@mail.gmail.com>
 <YZf6/YdyOUY8puWq@pevik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZf6/YdyOUY8puWq@pevik>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Amir,

> ...
> > > -AC_CHECK_TYPES([struct fanotify_event_info_fid, struct fanotify_event_info_header],,,[#include <sys/fanotify.h>])
> > > +AC_CHECK_TYPES([struct fanotify_event_info_fid, struct fanotify_event_info_header,
> > > +               struct fanotify_event_info_error],[],[],[#include <sys/fanotify.h>])

> > Doh! it seems like fanotify_event_info_pidfd was dropped between v2 ->
> > v3 in Matthew's patches.

> > Petr,

> > Can you please fix this.

> Hi Amir,

> thanks for info, sure I'll fix it on Monday.
Fixed now. Thanks!

Kind regards,
Petr

> Kind regards,
> Petr

> > Thanks,
> > Amir.
