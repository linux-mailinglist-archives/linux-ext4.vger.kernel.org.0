Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8825224B86
	for <lists+linux-ext4@lfdr.de>; Sat, 18 Jul 2020 15:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgGRN2z (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 18 Jul 2020 09:28:55 -0400
Received: from m15111.mail.126.com ([220.181.15.111]:52017 "EHLO
        m15111.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgGRN2y (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 18 Jul 2020 09:28:54 -0400
X-Greylist: delayed 1852 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Jul 2020 09:28:53 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=Nrs0U0+MFKKRAAU9Nt
        Id3jHpjc4smynpnfde3x7aSUk=; b=BgxXTonA7plPDAUC85Kp910v4oOh1gXwiG
        nrfars58K54KDSPLGQahbSaxqr27wAbgYbLPAJ/OcN2VKT9NM1Pw6DZLtS/88COm
        UhBiflNDqTDlplijWcwzdQEvSg1M3KTyZ2VUaG6Z9xVe7VwAj/C0I7LcGx1MIVxG
        UBNthTK2g=
Received: from 192.168.137.249 (unknown [112.10.74.162])
        by smtp1 (Coremail) with SMTP id C8mowAAnFFrD8RJfJrTAHg--.49366S3;
        Sat, 18 Jul 2020 20:57:41 +0800 (CST)
From:   Xianting Tian <xianting_tian@126.com>
To:     tytso@mit.edu, jack@suse.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] jbd2: fix incorrect code style
Date:   Sat, 18 Jul 2020 08:57:37 -0400
Message-Id: <1595077057-8048-1-git-send-email-xianting_tian@126.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: C8mowAAnFFrD8RJfJrTAHg--.49366S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF4fXw1UJw45AFyktF4ktFb_yoW5XrWfpw
        1Utry8urW0vryUAa4vqF48GFWYgrWSyFW7KrsrC3WktanxGFnIvryIyF4DA3yqqFZ5W3W7
        AFy8t397Cw4vkwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jiVyxUUUUU=
X-Originating-IP: [112.10.74.162]
X-CM-SenderInfo: h0ld03plqjs3xldqqiyswou0bp/1tbi9AVlpFpD+9igGwAAsx
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Remove unnecessary blank.

Signed-off-by: Xianting Tian <xianting_tian@126.com>
---
 fs/jbd2/journal.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index e494443..5eccf8c 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1285,7 +1285,7 @@ journal_t *jbd2_journal_init_inode(struct inode *inode)
  * superblock as being NULL to prevent the journal destroy from writing
  * back a bogus superblock.
  */
-static void journal_fail_superblock (journal_t *journal)
+static void journal_fail_superblock(journal_t *journal)
 {
 	struct buffer_head *bh = journal->j_sb_buffer;
 	brelse(bh);
@@ -1815,7 +1815,7 @@ int jbd2_journal_destroy(journal_t *journal)
 
 
 /**
- *int jbd2_journal_check_used_features () - Check if features specified are used.
+ *int jbd2_journal_check_used_features() - Check if features specified are used.
  * @journal: Journal to check.
  * @compat: bitmask of compatible features
  * @ro: bitmask of features that force read-only mount
@@ -1825,7 +1825,7 @@ int jbd2_journal_destroy(journal_t *journal)
  * features.  Return true (non-zero) if it does.
  **/
 
-int jbd2_journal_check_used_features (journal_t *journal, unsigned long compat,
+int jbd2_journal_check_used_features(journal_t *journal, unsigned long compat,
 				 unsigned long ro, unsigned long incompat)
 {
 	journal_superblock_t *sb;
@@ -1860,7 +1860,7 @@ int jbd2_journal_check_used_features (journal_t *journal, unsigned long compat,
  * all of a given set of features on this journal.  Return true
  * (non-zero) if it can. */
 
-int jbd2_journal_check_available_features (journal_t *journal, unsigned long compat,
+int jbd2_journal_check_available_features(journal_t *journal, unsigned long compat,
 				      unsigned long ro, unsigned long incompat)
 {
 	if (!compat && !ro && !incompat)
@@ -1882,7 +1882,7 @@ int jbd2_journal_check_available_features (journal_t *journal, unsigned long com
 }
 
 /**
- * int jbd2_journal_set_features () - Mark a given journal feature in the superblock
+ * int jbd2_journal_set_features() - Mark a given journal feature in the superblock
  * @journal: Journal to act on.
  * @compat: bitmask of compatible features
  * @ro: bitmask of features that force read-only mount
@@ -1893,7 +1893,7 @@ int jbd2_journal_check_available_features (journal_t *journal, unsigned long com
  *
  */
 
-int jbd2_journal_set_features (journal_t *journal, unsigned long compat,
+int jbd2_journal_set_features(journal_t *journal, unsigned long compat,
 			  unsigned long ro, unsigned long incompat)
 {
 #define INCOMPAT_FEATURE_ON(f) \
-- 
1.8.3.1

