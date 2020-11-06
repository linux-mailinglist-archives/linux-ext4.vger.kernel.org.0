Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4495B2A8DDB
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Nov 2020 04:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgKFD7f (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Nov 2020 22:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgKFD7f (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Nov 2020 22:59:35 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29039C0613CF
        for <linux-ext4@vger.kernel.org>; Thu,  5 Nov 2020 19:59:35 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id x13so89497pfa.9
        for <linux-ext4@vger.kernel.org>; Thu, 05 Nov 2020 19:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9gY7yrHwgSn7s6B+JgYra0UOR9/ZkGrAmkJazp1U9gg=;
        b=k5x56AOhADh/KZSv2VxVuqWBRO/p3M9rb+C/7jXwm4bBok91LzWffMT9cqfsONys9X
         GkjHgPFv1IpS+eMIgFonC4lO0ia2VihQgj4EVc4dpBdjqVCgBelOOmfAn/bCknzn90gk
         MUpqxUoLXzbpGENn3KY4znm9BkMfirzk8gTBy2SBnTkCCYgGiGermw/qvok7kJBKKrJh
         9N+3RKIsG8kg98wZFzxlF5mEHBx6vsWEKDXkUeyEP5f1p25su7TxuIDuB0uuo0ZSwuVd
         1KncDkoWJ4cKtXLn4JhA+fNMpxheV3D6YStd1oJZ+BV5ktjh384Ho9qooHF/5ufLUelR
         FIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9gY7yrHwgSn7s6B+JgYra0UOR9/ZkGrAmkJazp1U9gg=;
        b=js79El480lYyYaIah892MlXnPBAW0mdRCYgqKPNPsYU8qpx5j2uwnoP1z8ga6WbPXm
         u4G3zc19/ltPEGIY4foaXVjyJrNPEYzAnsvsDXMm7ClJqJk9VdZR8faMY3odkb0HGEPE
         4Hhfdf/Nh+bsE57Mmf+sdkyyAcDz73hLG7cbJHOcyJsIu5LoHHex1pXX5EpSkcqdyWlj
         BuaB1ZUlkOkx/52KBkEBXylvCQs4l6jXMgMgdoiGX+LHS+HLQcfWvPHfSSAeWdJwq7Fi
         O1RXHMfYVVRboFsYjVQPCl2TIOegcg/+ZSZZf44JdFCE2WY5enp+9gznSEB9AWFErZM9
         cI0w==
X-Gm-Message-State: AOAM533e9YM+eW2TBQfEMx3pmeWpo/J6zzARouf8JgKxS2d5z+m1/oIN
        6KQORCuFY+ZFP4orXHULlhp9MG7BEME=
X-Google-Smtp-Source: ABdhPJypd2b7uhMaB2kdf/BHeUb4dQruAqXiBvucre91Yq1DqI2Ho7qBlwsgInxwwNL9JulfRgQpIQ==
X-Received: by 2002:a17:90a:182:: with SMTP id 2mr253898pjc.21.1604635174237;
        Thu, 05 Nov 2020 19:59:34 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id z13sm3869429pgc.44.2020.11.05.19.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 19:59:33 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v2 09/22] jbd2: don't pass tid to jbd2_fc_end_commit_fallback()
Date:   Thu,  5 Nov 2020 19:58:58 -0800
Message-Id: <20201106035911.1942128-10-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201106035911.1942128-1-harshadshirwadkar@gmail.com>
References: <20201106035911.1942128-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In jbd2_fc_end_commit_fallback(), we know which tid to commit. There's
no need for caller to pass it.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/fast_commit.c |  2 +-
 fs/jbd2/journal.c     | 12 +++++++++---
 include/linux/jbd2.h  |  2 +-
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index bab60c5d5095..e69c580fa91e 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1143,7 +1143,7 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
 		"Fast commit ended with blks = %d, reason = %d, subtid - %d",
 		nblks, reason, subtid);
 	if (reason == EXT4_FC_REASON_FC_FAILED)
-		return jbd2_fc_end_commit_fallback(journal, commit_tid);
+		return jbd2_fc_end_commit_fallback(journal);
 	if (reason == EXT4_FC_REASON_FC_START_FAILED ||
 		reason == EXT4_FC_REASON_INELIGIBLE)
 		return jbd2_complete_transaction(journal, commit_tid);
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 778ea50fc8d1..59166e299cde 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -777,13 +777,19 @@ static int __jbd2_fc_end_commit(journal_t *journal, tid_t tid, bool fallback)
 
 int jbd2_fc_end_commit(journal_t *journal)
 {
-	return __jbd2_fc_end_commit(journal, 0, 0);
+	return __jbd2_fc_end_commit(journal, 0, false);
 }
 EXPORT_SYMBOL(jbd2_fc_end_commit);
 
-int jbd2_fc_end_commit_fallback(journal_t *journal, tid_t tid)
+int jbd2_fc_end_commit_fallback(journal_t *journal)
 {
-	return __jbd2_fc_end_commit(journal, tid, 1);
+	tid_t tid;
+
+	read_lock(&journal->j_state_lock);
+	tid = journal->j_running_transaction ?
+		journal->j_running_transaction->t_tid : 0;
+	read_unlock(&journal->j_state_lock);
+	return __jbd2_fc_end_commit(journal, tid, true);
 }
 EXPORT_SYMBOL(jbd2_fc_end_commit_fallback);
 
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 5f0ef6380b0c..1c49fd62ff2e 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1619,7 +1619,7 @@ extern int jbd2_cleanup_journal_tail(journal_t *);
 /* Fast commit related APIs */
 int jbd2_fc_begin_commit(journal_t *journal, tid_t tid);
 int jbd2_fc_end_commit(journal_t *journal);
-int jbd2_fc_end_commit_fallback(journal_t *journal, tid_t tid);
+int jbd2_fc_end_commit_fallback(journal_t *journal);
 int jbd2_fc_get_buf(journal_t *journal, struct buffer_head **bh_out);
 int jbd2_submit_inode_data(struct jbd2_inode *jinode);
 int jbd2_wait_inode_data(journal_t *journal, struct jbd2_inode *jinode);
-- 
2.29.1.341.ge80a0c044ae-goog

