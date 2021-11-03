Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4623F4443E4
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Nov 2021 15:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhKCOzI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Nov 2021 10:55:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56589 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230132AbhKCOzI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 Nov 2021 10:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635951151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kTzGd0AKmjFHRo7fXFpfjY5blmceuKFi00MsYOAPKc0=;
        b=GgQtuX520aqol8ve0QVlaQR9WizOO/cUMrkZt9hnFdLcp0P1nknDCCwM/ufKfuE6QNdu1n
        lIkTU9ZPPEikjdDjmfoS+STObjqXCpuGrxFm90WGrWQzV29T+n0jMWarV/Ik4Fm74RJbeu
        1cjVz0Gh8tU5UKMSgukc7sF1m7YNaPo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-s3WqVMe_Opi-PaffJS9v5Q-1; Wed, 03 Nov 2021 10:52:27 -0400
X-MC-Unique: s3WqVMe_Opi-PaffJS9v5Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75624A40E1;
        Wed,  3 Nov 2021 14:51:29 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.74])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2298C19741;
        Wed,  3 Nov 2021 14:51:27 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger@dilger.ca, Laurent GUERBY <laurent@guerby.net>
Subject: [PATCH v3 2/2] ext4: Allow to change s_last_trim_minblks via sysfs
Date:   Wed,  3 Nov 2021 15:51:22 +0100
Message-Id: <20211103145122.17338-2-lczerner@redhat.com>
In-Reply-To: <20211103145122.17338-1-lczerner@redhat.com>
References: <20211103145122.17338-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Ext4 has an optimization mechanism for batched disacrd (FITRIM) that
should help speed up subsequent calls of FITRIM ioctl by skipping the
groups that were previously trimmed. However because the FITRIM allows
to set the minimum size of an extent to trim, ext4 stores the last
minimum extent size and only avoids trimming the group if it was
previously trimmed with minimum extent size equal to, or smaller than
the current call.

There is currently no way to bypass the optimization without
umount/mount cycle. This becomes a problem when the file system is
live migrated to a different storage, because the optimization will
prevent possibly useful discard calls to the storage.

Fix it by exporting the s_last_trim_minblks via sysfs interface which
will allow us to set the minimum size to the number of blocks larger
than subsequent FITRIM call, effectively bypassing the optimization.

By setting the s_last_trim_minblks to ULONG_MAX the optimization will be
effectively cleared regardless of the previous state, or file system
configuration.

For example:
getconf ULONG_MAX > /sys/fs/ext4/dm-1/last_trim_minblks

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Reported-by: Laurent GUERBY <laurent@guerby.net>
---
v2: Remove unnecessary assignment
v3: s_last_trim_minblks is now unsinged long which simplifies this

 fs/ext4/sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 2314f7446592..95d8a996d2d8 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -245,6 +245,7 @@ EXT4_ATTR(last_error_time, 0444, last_error_time);
 EXT4_ATTR(journal_task, 0444, journal_task);
 EXT4_RW_ATTR_SBI_UI(mb_prefetch, s_mb_prefetch);
 EXT4_RW_ATTR_SBI_UI(mb_prefetch_limit, s_mb_prefetch_limit);
+EXT4_RW_ATTR_SBI_UL(last_trim_minblks, s_last_trim_minblks);
 
 static unsigned int old_bump_val = 128;
 EXT4_ATTR_PTR(max_writeback_mb_bump, 0444, pointer_ui, &old_bump_val);
@@ -295,6 +296,7 @@ static struct attribute *ext4_attrs[] = {
 #endif
 	ATTR_LIST(mb_prefetch),
 	ATTR_LIST(mb_prefetch_limit),
+	ATTR_LIST(last_trim_minblks),
 	NULL,
 };
 ATTRIBUTE_GROUPS(ext4);
-- 
2.31.1

