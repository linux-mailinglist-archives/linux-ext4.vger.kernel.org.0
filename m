Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428ED3A67CC
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jun 2021 15:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbhFNN3g (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 14 Jun 2021 09:29:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22901 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232917AbhFNN3g (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 14 Jun 2021 09:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623677253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0kZK6J8loNWaBSkeCyU38O0W++cR9DAB8ViyuZedSPk=;
        b=NjbLH+pyouepy3fXQ/X+KgeRAV9tDrsy4VySIKWAik7odqhGLWSufNj1IXbVQYOCPJ4HXo
        341BHzqbV4Ltc8HUd9vUG+ifnkTh4xugnQFbzRttJNhk9FFceWPIuyTAYj4dIEw+kVuEKY
        Uplal3zzTGc4WDZClTIAwX3lfuCsarE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-0TgldoiaO22oVptBuAwbLg-1; Mon, 14 Jun 2021 09:27:32 -0400
X-MC-Unique: 0TgldoiaO22oVptBuAwbLg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CB6E185061A
        for <linux-ext4@vger.kernel.org>; Mon, 14 Jun 2021 13:27:31 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.159])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 56F805D9CA;
        Mon, 14 Jun 2021 13:27:27 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     Dusty Mabe <dustymabe@redhat.com>
Subject: [PATCH] e2fsck: fix last mount/write time when e2fsck is forced
Date:   Mon, 14 Jun 2021 15:27:25 +0200
Message-Id: <20210614132725.10339-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

With commit c52d930f e2fsck is no longer able to fix bad last
mount/write time by default because it is conditioned on s_checkinterval
not being zero, which it is by default.

One place where it matters is when other e2fsprogs tools require to run
full file system check before a certain operation. If the last mount
time is for any reason in future, it will not allow it to run even if
full e2fsck is ran.

Fix it by checking the last mount/write time when the e2fsck is forced,
except for the case where we know the system clock is broken.

Fixes: c52d930f ("e2fsck: don't check for future superblock times if checkinterval == 0")
Reported-by: Dusty Mabe <dustymabe@redhat.com>
Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 e2fsck/super.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/e2fsck/super.c b/e2fsck/super.c
index e1c3f935..d8c1dcec 100644
--- a/e2fsck/super.c
+++ b/e2fsck/super.c
@@ -1038,9 +1038,10 @@ void check_super_block(e2fsck_t ctx)
 	 * Check to see if the superblock last mount time or last
 	 * write time is in the future.
 	 */
-	if (!broken_system_clock && fs->super->s_checkinterval &&
-	    !(ctx->flags & E2F_FLAG_TIME_INSANE) &&
-	    fs->super->s_mtime > (__u32) ctx->now) {
+	if ((!broken_system_clock && ctx->options & E2F_OPT_FORCE) ||
+	    (!broken_system_clock && fs->super->s_checkinterval &&
+	     !(ctx->flags & E2F_FLAG_TIME_INSANE) &&
+	     fs->super->s_mtime > (__u32) ctx->now)) {
 		pctx.num = fs->super->s_mtime;
 		problem = PR_0_FUTURE_SB_LAST_MOUNT;
 		if (fs->super->s_mtime <= (__u32) ctx->now + ctx->time_fudge)
@@ -1050,9 +1051,10 @@ void check_super_block(e2fsck_t ctx)
 			fs->flags |= EXT2_FLAG_DIRTY;
 		}
 	}
-	if (!broken_system_clock && fs->super->s_checkinterval &&
-	    !(ctx->flags & E2F_FLAG_TIME_INSANE) &&
-	    fs->super->s_wtime > (__u32) ctx->now) {
+	if ((!broken_system_clock && ctx->options & E2F_OPT_FORCE) ||
+	    (!broken_system_clock && fs->super->s_checkinterval &&
+	     !(ctx->flags & E2F_FLAG_TIME_INSANE) &&
+	     fs->super->s_wtime > (__u32) ctx->now)) {
 		pctx.num = fs->super->s_wtime;
 		problem = PR_0_FUTURE_SB_LAST_WRITE;
 		if (fs->super->s_wtime <= (__u32) ctx->now + ctx->time_fudge)
-- 
2.26.3

