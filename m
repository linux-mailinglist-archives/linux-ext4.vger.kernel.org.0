Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD554DC9B
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Jun 2019 23:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfFTVck (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Jun 2019 17:32:40 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55242 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726192AbfFTVcj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Jun 2019 17:32:39 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x5KLWZwI009174
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jun 2019 17:32:36 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5F209420484; Thu, 20 Jun 2019 17:32:30 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] jbd2: drop declaration of journal_sync_buffer()
Date:   Thu, 20 Jun 2019 17:32:28 -0400
Message-Id: <20190620213228.8191-1-tytso@mit.edu>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The journal_sync_buffer() function was never carried over from jbd to
jbd2.  So get rid of the vestigal declaration of this (non-existent)
function.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/jbd2/journal.c    | 3 ---
 include/linux/jbd2.h | 1 -
 2 files changed, 4 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 17f679aeba7c..953990eb70a9 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -66,9 +66,6 @@ EXPORT_SYMBOL(jbd2_journal_get_undo_access);
 EXPORT_SYMBOL(jbd2_journal_set_triggers);
 EXPORT_SYMBOL(jbd2_journal_dirty_metadata);
 EXPORT_SYMBOL(jbd2_journal_forget);
-#if 0
-EXPORT_SYMBOL(journal_sync_buffer);
-#endif
 EXPORT_SYMBOL(jbd2_journal_flush);
 EXPORT_SYMBOL(jbd2_journal_revoke);
 
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 0e0393e7f41a..df03825ad1a1 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1373,7 +1373,6 @@ void		 jbd2_journal_set_triggers(struct buffer_head *,
 					   struct jbd2_buffer_trigger_type *type);
 extern int	 jbd2_journal_dirty_metadata (handle_t *, struct buffer_head *);
 extern int	 jbd2_journal_forget (handle_t *, struct buffer_head *);
-extern void	 journal_sync_buffer (struct buffer_head *);
 extern int	 jbd2_journal_invalidatepage(journal_t *,
 				struct page *, unsigned int, unsigned int);
 extern int	 jbd2_journal_try_to_free_buffers(journal_t *, struct page *, gfp_t);
-- 
2.22.0

