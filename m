Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C2C45B87F
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Nov 2021 11:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237614AbhKXKnM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 24 Nov 2021 05:43:12 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:36728 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233492AbhKXKnM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 24 Nov 2021 05:43:12 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 04D8721958;
        Wed, 24 Nov 2021 10:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637750402;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/HHLWuOx/5jB+RRapOoNMKfyTXRaJjW9pkkg8fquSaE=;
        b=gZnKYa+4rcP6Oq4Fs/5nFNZXbQLlrTpoHuEY1/gan6hJA0vY7N8T0owd5Ns5CsId2t6M+D
        1doAaZTDWtbZxOlZI195WnLjMVGf3oXAJtqrrGDitgykI9Ke2SoC5UZEG90eVhhmLBR9Bd
        +DXsdtV4Q0qKT92DHh/2debsNcmYeQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637750402;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/HHLWuOx/5jB+RRapOoNMKfyTXRaJjW9pkkg8fquSaE=;
        b=WYm6kzBgfH2Z+TMpbCcH4igUmF9lca0lksVJMfwOL8Zbk4OvTatOCc1u+wQS36gSlb+MBd
        LTgeLqKCRHbJAMBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7C43313F05;
        Wed, 24 Nov 2021 10:40:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id u+qZHIEWnmHvagAAMHmgww
        (envelope-from <pvorel@suse.cz>); Wed, 24 Nov 2021 10:40:01 +0000
Date:   Wed, 24 Nov 2021 11:39:59 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Khazhismel Kumykov <khazhy@google.com>,
        Matthew Bobrowski <repnop@google.com>,
        Jan Kara <jack@suse.com>, Ext4 <linux-ext4@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>
Subject: Re: [LTP] [PATCH v4 0/9] Test the new fanotify FAN_FS_ERROR event
Message-ID: <YZ4Wf3d+J36NPMfS@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20211118235744.802584-1-krisman@collabora.com>
 <CAOQ4uxhbDgdZZ0qphWg1vnW4ZoAkUxcQp631yZO8W49AE18W9g@mail.gmail.com>
 <8735nsuepi.fsf@collabora.com>
 <YZtLDXW01Cz0BfPU@pevik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZtLDXW01Cz0BfPU@pevik>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi all,

<snip>
> > Hi Amir,

> > I have pushed v4 to :

> > https://gitlab.collabora.com/krisman/ltp.git -b fan-fs-error_v4

> FYI I've rebased it on my fix 3b2ea2e00 ("configure.ac: Add struct
> fanotify_event_info_pidfd check")

> https://github.com/linux-test-project/ltp.git -b gertazi/fanotify21.v4.fixes

FYI I removed branch from official LTP repository and put it to my fork
https://github.com/pevik/ltp.git -b fan-fs-error_v4.fixes

Kind regards,
Petr

> diff to krisman/fan-fs-error_v4:

> diff --git configure.ac configure.ac
> index a9dc25249..d25183368 100644
> --- configure.ac
> +++ configure.ac
> @@ -160,8 +160,8 @@ AC_CHECK_MEMBERS([struct utsname.domainname],,,[
>  AC_CHECK_TYPES([enum kcmp_type],,,[#include <linux/kcmp.h>])
>  AC_CHECK_TYPES([struct acct_v3],,,[#include <sys/acct.h>])
>  AC_CHECK_TYPES([struct af_alg_iv, struct sockaddr_alg],,,[# include <linux/if_alg.h>])
> -AC_CHECK_TYPES([struct fanotify_event_info_fid, struct fanotify_event_info_header,
> -		struct fanotify_event_info_error],[],[],[#include <sys/fanotify.h>])
> +AC_CHECK_TYPES([struct fanotify_event_info_fid, struct fanotify_event_info_error,
> +		struct fanotify_event_info_header, struct fanotify_event_info_pidfd],,,[#include <sys/fanotify.h>])
>  AC_CHECK_TYPES([struct file_dedupe_range],,,[#include <linux/fs.h>])

>  AC_CHECK_TYPES([struct file_handle],,,[

> Kind regards,
> Petr
