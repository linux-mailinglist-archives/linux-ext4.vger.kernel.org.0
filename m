Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158D4458A12
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Nov 2021 08:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbhKVHuz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 22 Nov 2021 02:50:55 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57164 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbhKVHuu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 22 Nov 2021 02:50:50 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 928071FD58;
        Mon, 22 Nov 2021 07:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637567263;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3gUeHfZeYpJwk8vTvMN+6s+MYAIG0/bmYj9D7Qf+YZY=;
        b=hMuNjDdL49MgSGBD0toy/QtjCq22tq122JvrlrS/2rpRcvbM1RBwpjFVf2flPQAMLd4lOX
        h3o18m8TlOdQLkNjlOzvVn/4GDCbqSYs13XIi6YRpbdT3kGtF65FcaXbSj4axU1aRFBky9
        ZbVwWVwneOYfCTUZ3hRm3xhQ8BAj7GQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637567263;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3gUeHfZeYpJwk8vTvMN+6s+MYAIG0/bmYj9D7Qf+YZY=;
        b=OGpan03wXeu5Pkyx97/2Vt4LfDF0iOGcoMFHvTtd+qDr1z2tuRCUD39j2SDLsEAS3XErLn
        JFTvexderpK+HoBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4801113466;
        Mon, 22 Nov 2021 07:47:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QJUJEB9Lm2FCJAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Mon, 22 Nov 2021 07:47:43 +0000
Date:   Mon, 22 Nov 2021 08:47:41 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.com>,
        Matthew Bobrowski <repnop@google.com>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com,
        Khazhismel Kumykov <khazhy@google.com>,
        LTP List <ltp@lists.linux.it>
Subject: Re: [PATCH v4 0/9] Test the new fanotify FAN_FS_ERROR event
Message-ID: <YZtLDXW01Cz0BfPU@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20211118235744.802584-1-krisman@collabora.com>
 <CAOQ4uxhbDgdZZ0qphWg1vnW4ZoAkUxcQp631yZO8W49AE18W9g@mail.gmail.com>
 <8735nsuepi.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8735nsuepi.fsf@collabora.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi all,

<snip>
> Hi Amir,

> I have pushed v4 to :

> https://gitlab.collabora.com/krisman/ltp.git -b fan-fs-error_v4

FYI I've rebased it on my fix 3b2ea2e00 ("configure.ac: Add struct
fanotify_event_info_pidfd check")

https://github.com/linux-test-project/ltp.git -b gertazi/fanotify21.v4.fixes

diff to krisman/fan-fs-error_v4:

diff --git configure.ac configure.ac
index a9dc25249..d25183368 100644
--- configure.ac
+++ configure.ac
@@ -160,8 +160,8 @@ AC_CHECK_MEMBERS([struct utsname.domainname],,,[
 AC_CHECK_TYPES([enum kcmp_type],,,[#include <linux/kcmp.h>])
 AC_CHECK_TYPES([struct acct_v3],,,[#include <sys/acct.h>])
 AC_CHECK_TYPES([struct af_alg_iv, struct sockaddr_alg],,,[# include <linux/if_alg.h>])
-AC_CHECK_TYPES([struct fanotify_event_info_fid, struct fanotify_event_info_header,
-		struct fanotify_event_info_error],[],[],[#include <sys/fanotify.h>])
+AC_CHECK_TYPES([struct fanotify_event_info_fid, struct fanotify_event_info_error,
+		struct fanotify_event_info_header, struct fanotify_event_info_pidfd],,,[#include <sys/fanotify.h>])
 AC_CHECK_TYPES([struct file_dedupe_range],,,[#include <linux/fs.h>])
 
 AC_CHECK_TYPES([struct file_handle],,,[

Kind regards,
Petr
