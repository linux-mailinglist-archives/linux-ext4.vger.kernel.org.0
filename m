Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE39457705
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Nov 2021 20:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235970AbhKSTcH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 19 Nov 2021 14:32:07 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:36388 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235931AbhKSTcG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 19 Nov 2021 14:32:06 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 507BC1FD3D;
        Fri, 19 Nov 2021 19:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637350143;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vYCqqCmr0eXa8bYDyXX1w6z/yqJGXuqP/p7h+u+GVyc=;
        b=baG/dou2SqzYlj3+hEayGDfiDTRFQFlib70V6H8Nhy9xNv0GIUYal8iObIvoDGtbnzDv21
        1onbkqWhenbuihKGiuX+ntKNoohOrVstlQSdPIt5Ss+lP2pbY+xEYXGCyiPFLcidSGzA9b
        uH1q3Zl9eH4Qaok2OfZcb6CstAb1Aiw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637350143;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vYCqqCmr0eXa8bYDyXX1w6z/yqJGXuqP/p7h+u+GVyc=;
        b=4V7ZMxVAhigkLFV+Zu9QZKjqjQesmTmNu2B+4eg66NFdTQgHkvbKIEja+RUI7Kgte+l578
        rBOzU4IjFW4HWMDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0A595139F0;
        Fri, 19 Nov 2021 19:29:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /hBNAf/6l2GCeQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 19 Nov 2021 19:29:03 +0000
Date:   Fri, 19 Nov 2021 20:29:01 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>, Petr Vorel <pvorel@suse.cz>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Matthew Bobrowski <repnop@google.com>,
        Jan Kara <jack@suse.com>, Ext4 <linux-ext4@vger.kernel.org>,
        kernel@collabora.com, Khazhismel Kumykov <khazhy@google.com>,
        LTP List <ltp@lists.linux.it>
Subject: Re: [PATCH v4 4/9] syscalls/fanotify22: Validate the generic error
 info
Message-ID: <YZf6/YdyOUY8puWq@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20211118235744.802584-1-krisman@collabora.com>
 <20211118235744.802584-5-krisman@collabora.com>
 <CAOQ4uxjk8J48ASw2yJhd-OR2LVN6kirg7p6xQbX=xEofGYUghw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjk8J48ASw2yJhd-OR2LVN6kirg7p6xQbX=xEofGYUghw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

...
> > -AC_CHECK_TYPES([struct fanotify_event_info_fid, struct fanotify_event_info_header],,,[#include <sys/fanotify.h>])
> > +AC_CHECK_TYPES([struct fanotify_event_info_fid, struct fanotify_event_info_header,
> > +               struct fanotify_event_info_error],[],[],[#include <sys/fanotify.h>])

> Doh! it seems like fanotify_event_info_pidfd was dropped between v2 ->
> v3 in Matthew's patches.

> Petr,

> Can you please fix this.

Hi Amir,

thanks for info, sure I'll fix it on Monday.

Kind regards,
Petr

> Thanks,
> Amir.
