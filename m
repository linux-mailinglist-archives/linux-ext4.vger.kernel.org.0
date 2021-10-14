Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A9D42E365
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Oct 2021 23:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbhJNVjg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Oct 2021 17:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbhJNVjf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Oct 2021 17:39:35 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80DAC061753;
        Thu, 14 Oct 2021 14:37:29 -0700 (PDT)
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1007])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 3B6611F44F72;
        Thu, 14 Oct 2021 22:37:27 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        repnop@google.com, Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Jan Kara <jack@suse.cz>
Subject: [PATCH v7 04/28] fsnotify: Don't insert unmergeable events in hashtable
Date:   Thu, 14 Oct 2021 18:36:22 -0300
Message-Id: <20211014213646.1139469-5-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211014213646.1139469-1-krisman@collabora.com>
References: <20211014213646.1139469-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Some events, like the overflow event, are not mergeable, so they are not
hashed.  But, when failing inside fsnotify_add_event for lack of space,
fsnotify_add_event() still calls the insert hook, which adds the
overflow event to the merge list.  Add a check to prevent any kind of
unmergeable event to be inserted in the hashtable.

Fixes: 94e00d28a680 ("fsnotify: use hash table for faster events merge")
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v2:
  - Do check for hashed events inside the insert hook (Amir)
---
 fs/notify/fanotify/fanotify.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 057abd2cf887..310246f8d3f1 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -702,6 +702,9 @@ static void fanotify_insert_event(struct fsnotify_group *group,
 
 	assert_spin_locked(&group->notification_lock);
 
+	if (!fanotify_is_hashed_event(event->mask))
+		return;
+
 	pr_debug("%s: group=%p event=%p bucket=%u\n", __func__,
 		 group, event, bucket);
 
@@ -779,8 +782,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 
 	fsn_event = &event->fse;
 	ret = fsnotify_add_event(group, fsn_event, fanotify_merge,
-				 fanotify_is_hashed_event(mask) ?
-				 fanotify_insert_event : NULL);
+				 fanotify_insert_event);
 	if (ret) {
 		/* Permission events shouldn't be merged */
 		BUG_ON(ret == 1 && mask & FANOTIFY_PERM_EVENTS);
-- 
2.33.0

