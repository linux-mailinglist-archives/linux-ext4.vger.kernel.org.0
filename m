Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8EAF43A406
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Oct 2021 22:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237471AbhJYUMD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 25 Oct 2021 16:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbhJYULr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 25 Oct 2021 16:11:47 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CECC04A413;
        Mon, 25 Oct 2021 12:30:12 -0700 (PDT)
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1002])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 43BF91F433E3;
        Mon, 25 Oct 2021 20:30:02 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com, jack@suse.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Jan Kara <jack@suse.cz>
Subject: [PATCH v9 19/31] fanotify: Pre-allocate pool of error events
Date:   Mon, 25 Oct 2021 16:27:34 -0300
Message-Id: <20211025192746.66445-20-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211025192746.66445-1-krisman@collabora.com>
References: <20211025192746.66445-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Pre-allocate slots for file system errors to have greater chances of
succeeding, since error events can happen in GFP_NOFS context.  This
patch introduces a group-wide mempool of error events, shared by all
FAN_FS_ERROR marks in this group.

For now, just allocate 128 positions.  A future patch allows this
array to be dynamically resized when a new mark is added.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v8:
  - FANOTIFY_DEFAULT_MAX_FEE_POOL -> FANOTIFY_DEFAULT_FEE_POOL_SIZE
  - Reduce limit to 32. (Jan)
Changes since v7:
  - Expand limit to 128. (Amir)
---
 fs/notify/fanotify/fanotify.c      |  3 +++
 fs/notify/fanotify/fanotify.h      | 11 +++++++++++
 fs/notify/fanotify/fanotify_user.c | 26 +++++++++++++++++++++++++-
 include/linux/fsnotify_backend.h   |  2 ++
 4 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 8f152445d75c..01d68dfc74aa 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -819,6 +819,9 @@ static void fanotify_free_group_priv(struct fsnotify_group *group)
 	if (group->fanotify_data.ucounts)
 		dec_ucount(group->fanotify_data.ucounts,
 			   UCOUNT_FANOTIFY_GROUPS);
+
+	if (mempool_initialized(&group->fanotify_data.error_events_pool))
+		mempool_exit(&group->fanotify_data.error_events_pool);
 }
 
 static void fanotify_free_path_event(struct fanotify_event *event)
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index c42cf8fd7d79..a577e87fac2b 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -141,6 +141,7 @@ enum fanotify_event_type {
 	FANOTIFY_EVENT_TYPE_PATH,
 	FANOTIFY_EVENT_TYPE_PATH_PERM,
 	FANOTIFY_EVENT_TYPE_OVERFLOW, /* struct fanotify_event */
+	FANOTIFY_EVENT_TYPE_FS_ERROR, /* struct fanotify_error_event */
 	__FANOTIFY_EVENT_TYPE_NUM
 };
 
@@ -196,6 +197,16 @@ FANOTIFY_NE(struct fanotify_event *event)
 	return container_of(event, struct fanotify_name_event, fae);
 }
 
+struct fanotify_error_event {
+	struct fanotify_event fae;
+};
+
+static inline struct fanotify_error_event *
+FANOTIFY_EE(struct fanotify_event *event)
+{
+	return container_of(event, struct fanotify_error_event, fae);
+}
+
 static inline __kernel_fsid_t *fanotify_event_fsid(struct fanotify_event *event)
 {
 	if (event->type == FANOTIFY_EVENT_TYPE_FID)
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 66ee3c2805c7..2f4182b754b2 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -30,6 +30,7 @@
 #define FANOTIFY_DEFAULT_MAX_EVENTS	16384
 #define FANOTIFY_OLD_DEFAULT_MAX_MARKS	8192
 #define FANOTIFY_DEFAULT_MAX_GROUPS	128
+#define FANOTIFY_DEFAULT_FEE_POOL_SIZE	32
 
 /*
  * Legacy fanotify marks limits (8192) is per group and we introduced a tunable
@@ -1054,6 +1055,15 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
 	return ERR_PTR(ret);
 }
 
+static int fanotify_group_init_error_pool(struct fsnotify_group *group)
+{
+	if (mempool_initialized(&group->fanotify_data.error_events_pool))
+		return 0;
+
+	return mempool_init_kmalloc_pool(&group->fanotify_data.error_events_pool,
+					 FANOTIFY_DEFAULT_FEE_POOL_SIZE,
+					 sizeof(struct fanotify_error_event));
+}
 
 static int fanotify_add_mark(struct fsnotify_group *group,
 			     fsnotify_connp_t *connp, unsigned int type,
@@ -1062,6 +1072,7 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 {
 	struct fsnotify_mark *fsn_mark;
 	__u32 added;
+	int ret = 0;
 
 	mutex_lock(&group->mark_mutex);
 	fsn_mark = fsnotify_find_mark(connp, group);
@@ -1072,13 +1083,26 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 			return PTR_ERR(fsn_mark);
 		}
 	}
+
+	/*
+	 * Error events are pre-allocated per group, only if strictly
+	 * needed (i.e. FAN_FS_ERROR was requested).
+	 */
+	if (!(flags & FAN_MARK_IGNORED_MASK) && (mask & FAN_FS_ERROR)) {
+		ret = fanotify_group_init_error_pool(group);
+		if (ret)
+			goto out;
+	}
+
 	added = fanotify_mark_add_to_mask(fsn_mark, mask, flags);
 	if (added & ~fsnotify_conn_mask(fsn_mark->connector))
 		fsnotify_recalc_mask(fsn_mark->connector);
+
+out:
 	mutex_unlock(&group->mark_mutex);
 
 	fsnotify_put_mark(fsn_mark);
-	return 0;
+	return ret;
 }
 
 static int fanotify_add_vfsmount_mark(struct fsnotify_group *group,
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 00dbaafbcf95..51ef2b079bfa 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -19,6 +19,7 @@
 #include <linux/atomic.h>
 #include <linux/user_namespace.h>
 #include <linux/refcount.h>
+#include <linux/mempool.h>
 
 /*
  * IN_* from inotfy.h lines up EXACTLY with FS_*, this is so we can easily
@@ -246,6 +247,7 @@ struct fsnotify_group {
 			int flags;           /* flags from fanotify_init() */
 			int f_flags; /* event_f_flags from fanotify_init() */
 			struct ucounts *ucounts;
+			mempool_t error_events_pool;
 		} fanotify_data;
 #endif /* CONFIG_FANOTIFY */
 	};
-- 
2.33.0

