Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6278344302E
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Nov 2021 15:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhKBOVq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 Nov 2021 10:21:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53241 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229530AbhKBOVq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 2 Nov 2021 10:21:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635862751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jGbWDq0JeuevevnIwbjTj5Ma5PpZ7MLVoWYZxYZzFb4=;
        b=Kz1xCp9x3ElisduR42T6VYLGzNZBx2JqR4IQ4H/tb2p+Y8bpoEEBSUIHcX1rD1P6VRJbUA
        N40QhkN+Vimp1+w51743elZAZNaKquyyrpvg6UrZWVhrPSuFLMPZNmyvQh1U+XbqmbrZiP
        Tg+EaAsugsUL/V+e20utH78CF2tEzQs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-HcXdjykmPduDlpVE6wcQGA-1; Tue, 02 Nov 2021 10:19:07 -0400
X-MC-Unique: HcXdjykmPduDlpVE6wcQGA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9F51100C609;
        Tue,  2 Nov 2021 14:19:06 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9CD9D67841;
        Tue,  2 Nov 2021 14:19:05 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     Laurent GUERBY <laurent@guerby.net>
Subject: [PATCH v2] ext4: Allow to change s_last_trim_minblks via sysfs
Date:   Tue,  2 Nov 2021 15:19:02 +0100
Message-Id: <20211102141902.9808-1-lczerner@redhat.com>
In-Reply-To: <20211102133115.9600-1-lczerner@redhat.com>
References: <20211102133115.9600-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

By setting the s_last_trim_minblks to INT_MAX the optimization will be
effectively cleared regardless of the previous state, or file system
configuration.

For example:
echo 2147483647 > /sys/fs/ext4/dm-1/last_trim_minblks

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Reported-by: Laurent GUERBY <laurent@guerby.net>
---
v2: Remove unnecessary assignment

 fs/ext4/sysfs.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 2314f7446592..94c86eb8d3cc 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -187,6 +187,9 @@ static struct ext4_attr ext4_attr_##_name = {			\
 #define EXT4_RO_ATTR_SBI_ATOMIC(_name,_elname)	\
 	EXT4_ATTR_OFFSET(_name, 0444, pointer_atomic, ext4_sb_info, _elname)
 
+#define EXT4_RW_ATTR_SBI_ATOMIC(_name,_elname)	\
+	EXT4_ATTR_OFFSET(_name, 0644, pointer_atomic, ext4_sb_info, _elname)
+
 #define EXT4_ATTR_PTR(_name,_mode,_id,_ptr) \
 static struct ext4_attr ext4_attr_##_name = {			\
 	.attr = {.name = __stringify(_name), .mode = _mode },	\
@@ -245,6 +248,7 @@ EXT4_ATTR(last_error_time, 0444, last_error_time);
 EXT4_ATTR(journal_task, 0444, journal_task);
 EXT4_RW_ATTR_SBI_UI(mb_prefetch, s_mb_prefetch);
 EXT4_RW_ATTR_SBI_UI(mb_prefetch_limit, s_mb_prefetch_limit);
+EXT4_RW_ATTR_SBI_ATOMIC(last_trim_minblks, s_last_trim_minblks);
 
 static unsigned int old_bump_val = 128;
 EXT4_ATTR_PTR(max_writeback_mb_bump, 0444, pointer_ui, &old_bump_val);
@@ -295,6 +299,7 @@ static struct attribute *ext4_attrs[] = {
 #endif
 	ATTR_LIST(mb_prefetch),
 	ATTR_LIST(mb_prefetch_limit),
+	ATTR_LIST(last_trim_minblks),
 	NULL,
 };
 ATTRIBUTE_GROUPS(ext4);
@@ -474,6 +479,14 @@ static ssize_t ext4_attr_store(struct kobject *kobj,
 			return ret;
 		*((unsigned long *) ptr) = t;
 		return len;
+	case attr_pointer_atomic:
+		if (!ptr)
+			return 0;
+		ret = kstrtoint(skip_spaces(buf), 0, (int *)&t);
+		if (ret)
+			return ret;
+		atomic_set((atomic_t *) ptr, t);
+		return len;
 	case attr_inode_readahead:
 		return inode_readahead_blks_store(sbi, buf, len);
 	case attr_trigger_test_error:
-- 
2.31.1

