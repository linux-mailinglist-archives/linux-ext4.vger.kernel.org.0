Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9114516B7
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Nov 2021 22:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344149AbhKOVlA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 15 Nov 2021 16:41:00 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:49918 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349852AbhKOV3Y (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 15 Nov 2021 16:29:24 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 81A092170C;
        Mon, 15 Nov 2021 21:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637011587;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RIpISZM3Q4aQS4wDIT1b4W1D2mBknEGSZlwMt5K2VH8=;
        b=lm9ZldTT0ytxBO7IQDFr85VOMZIxpXAEe711lkdHzGO4AZxb54dbWrZFJCovp81OqNJER/
        uzMgSLNStiA5SIwBN/2qyE7WRzHegEgDg0aOmQfUL7Yhl0WQgyzK/dy5x9n+e4k3chiUgD
        4XZOhAewulQ8dFyEhk3Gc2dIZ+eho/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637011587;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RIpISZM3Q4aQS4wDIT1b4W1D2mBknEGSZlwMt5K2VH8=;
        b=EUQMg2d5mgAKL/Mlws3D6trb7w+7EvH+yOi5xl7rkutw7YRMzPzQ60dgLOAREOG2/8QGrS
        7Ao7sgIwIlsxl2Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CED8D13AE9;
        Mon, 15 Nov 2021 21:26:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iaD4KILQkmE0IwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Mon, 15 Nov 2021 21:26:26 +0000
Date:   Mon, 15 Nov 2021 22:26:24 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     jack@suse.com, amir73il@gmail.com, repnop@google.com,
        linux-ext4@vger.kernel.org, kernel@collabora.com,
        khazhy@google.com, ltp@lists.linux.it
Subject: Re: [LTP] [PATCH v3 0/9] Test the new fanotify FAN_FS_ERROR event
Message-ID: <YZLQgDMTKBBlY8fN@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20211029211732.386127-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211029211732.386127-1-krisman@collabora.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Gabriel, all,

I merged Matthew's v3 FAN_REPORT_PIDFD, which is for 5.15 kernel.

Could you please rebase your changes on the top of current master?
Unfortunately that means to rename fanotify21.c in all commits.

Also please: s/REQUIRE_MARK_TYPE_SUPPORTED_ON_KERNEL/REQUIRE_MARK_TYPE_SUPPORTED_BY_KERNEL/

and other changes:

diff --git testcases/kernel/syscalls/fanotify/fanotify21.c testcases/kernel/syscalls/fanotify/fanotify21.c
index 7f0154da5..44882097b 100644
--- testcases/kernel/syscalls/fanotify/fanotify21.c
+++ testcases/kernel/syscalls/fanotify/fanotify21.c
@@ -131,7 +131,7 @@ int check_error_event_info_fid(struct fanotify_event_info_fid *fid,
 	if (memcmp(&fid->fsid, &ex->fid->fsid, sizeof(fid->fsid))) {
 		tst_res(TFAIL, "%s: Received bad FSID type (%x...!=%x...)",
 			ex->name, FSID_VAL_MEMBER(fid->fsid, 0),
-			FSID_VAL_MEMBER(ex->fid->fsid, 0));
+			ex->fid->fsid.val[0]);
 
 		return 1;
 	}
@@ -298,7 +298,6 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.mount_device = 1,
 	.mntpoint = MOUNT_PATH,
-	.all_filesystems = 0,
 	.needs_root = 1,
 	.dev_fs_type = "ext4",
 	.needs_cmds = (const char *[]) {

Thanks!

Petr
