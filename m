Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 733AE89364
	for <lists+linux-ext4@lfdr.de>; Sun, 11 Aug 2019 21:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfHKTv2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 11 Aug 2019 15:51:28 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40204 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726053AbfHKTv2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 11 Aug 2019 15:51:28 -0400
Received: from callcc.thunk.org (199-127-56.static.fiberhub.net [199.127.56.122] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7BJpKMm008061
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 11 Aug 2019 15:51:24 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 2A5B84218EE; Sun, 11 Aug 2019 15:51:14 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH v2 2/3] ext4: add a new ioctl EXT4_IOC_GETSTATE
Date:   Sun, 11 Aug 2019 15:51:07 -0400
Message-Id: <20190811195108.24308-2-tytso@mit.edu>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190811195108.24308-1-tytso@mit.edu>
References: <20190811195108.24308-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The new ioctl EXT4_IOC_GETSTATE returns some of the dynamic state of
an ext4 inode for debugging purposes.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/ext4.h  | 11 +++++++++++
 fs/ext4/ioctl.c | 17 +++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index b22f24f1d365..ee296797bcd2 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -651,6 +651,7 @@ enum {
 #define EXT4_IOC_GET_ENCRYPTION_POLICY	FS_IOC_GET_ENCRYPTION_POLICY
 /* ioctl codes 19--39 are reserved for fscrypt */
 #define EXT4_IOC_CLEAR_ES_CACHE		_IO('f', 40)
+#define EXT4_IOC_GETSTATE		_IOW('f', 41, __u32)
 
 #define EXT4_IOC_FSGETXATTR		FS_IOC_FSGETXATTR
 #define EXT4_IOC_FSSETXATTR		FS_IOC_FSSETXATTR
@@ -664,6 +665,16 @@ enum {
 #define EXT4_GOING_FLAGS_LOGFLUSH		0x1	/* flush log but not data */
 #define EXT4_GOING_FLAGS_NOLOGFLUSH		0x2	/* don't flush log nor data */
 
+/*
+ * Flags returned by EXT4_IOC_GETSTATE
+ *
+ * We only expose to userspace a subset of the state flags in
+ * i_state_flags
+ */
+#define EXT4_STATE_FLAG_EXT_PRECACHED	0x00000001
+#define EXT4_STATE_FLAG_NEW		0x00000002
+#define EXT4_STATE_FLAG_NEWENTRY	0x00000004
+#define EXT4_STATE_FLAG_DA_ALLOC_CLOSE	0x00000008
 
 #if defined(__KERNEL__) && defined(CONFIG_COMPAT)
 /*
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 15b1047878ab..ffb7bde4900d 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -1123,6 +1123,22 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return 0;
 	}
 
+	case EXT4_IOC_GETSTATE:
+	{
+		__u32	state = 0;
+
+		if (ext4_test_inode_state(inode, EXT4_STATE_EXT_PRECACHED))
+			state |= EXT4_STATE_FLAG_EXT_PRECACHED;
+		if (ext4_test_inode_state(inode, EXT4_STATE_NEW))
+			state |= EXT4_STATE_FLAG_NEW;
+		if (ext4_test_inode_state(inode, EXT4_STATE_NEWENTRY))
+			state |= EXT4_STATE_FLAG_NEWENTRY;
+		if (ext4_test_inode_state(inode, EXT4_STATE_DA_ALLOC_CLOSE))
+			state |= EXT4_STATE_FLAG_DA_ALLOC_CLOSE;
+
+		return put_user(state, (__u32 __user *) arg);
+	}
+
 	case EXT4_IOC_FSGETXATTR:
 	{
 		struct fsxattr fa;
@@ -1242,6 +1258,7 @@ long ext4_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case EXT4_IOC_SHUTDOWN:
 	case FS_IOC_GETFSMAP:
 	case EXT4_IOC_CLEAR_ES_CACHE:
+	case EXT4_IOC_GETSTATE:
 		break;
 	default:
 		return -ENOIOCTLCMD;
-- 
2.22.0

