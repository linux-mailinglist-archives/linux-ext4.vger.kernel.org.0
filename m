Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB6781A2B7F
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 23:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgDHVzu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 17:55:50 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44642 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbgDHVzt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 17:55:49 -0400
Received: by mail-pl1-f196.google.com with SMTP id h11so3023144plr.11
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 14:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zp897UpkuL2UU+LkHaSYhEJOVKSoljAk865Ib3Ff/78=;
        b=RyJSosRSQBz0v9NfmaelwsBdj9d33WWyeZdmckVnh3x/7oo5n9l5Q3NZ7Y3ghKBGmP
         uf8JfPnvRf5K2qk+B8s1WDVBe01hSAklXaR2lJJ1zZ/MdaeqwinQzrWc8j3v3jal/WhC
         9MlRRfjXtjFEuRmm96/DRLtrTmckuib69MD7kWTI581nd3ITxhxzUIBAOowCi3PhomKb
         S9bXV6zQn/OuYB/p4XSzC9ONF10yVya8I7ouJi6Ibogmw8D9P4y8NCaOKBFH8B844dRT
         cgiMa/C+HOxT2xApnVp2T/9Wq/Ptgv0JyuhgzFYJS1vCTYJ7G0xI0E1TO49vbT7GGkXb
         +hQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zp897UpkuL2UU+LkHaSYhEJOVKSoljAk865Ib3Ff/78=;
        b=tPituKCEXT2EU7Isjgy4IFrBhxxlK48dfM56bo9VPW+j3m6HzuJdPuH39mH93X2gpb
         qaTXFRGkQHyLepGBMxXWwwMWfL97FFnVHJK80yfg62uYQKh/dPq9+cK05KoKNoAyZv+M
         A43dYxyGIVZ1gIE7L0eypRvz//6JojF3vhRIPS0lsBDWENZGMQsA3+eOIqd4Ee52Pq+Y
         +qR54/pDua1tqHia03O83LKEttYMmpgHIt/g9Nnoxz7zjmJstzowS+dxevJmPssSu7ga
         M4VsWDdwjcdyje5QiSzRjI78GoPtksQB78WKHxow9KSLySYGq5XBUcfXRlz3t908kLL9
         1cfA==
X-Gm-Message-State: AGi0PuZa760T08EnDpWROLVmPatFVj4BjDH4aqGoPn0N+vSRHfR0cCWD
        VRZXN34G+0gp5yN3e/aCjlv64yHO
X-Google-Smtp-Source: APiQypIJaqK7Su+a2rX86UUKYBeLLZUjtLpCd9wxnfFGzX1z7B4YomW1aOFwvQJYjjtVWIANzrSu2g==
X-Received: by 2002:a17:902:aa09:: with SMTP id be9mr7870207plb.341.1586382948457;
        Wed, 08 Apr 2020 14:55:48 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:6271:607:aca0:b6f7])
        by smtp.googlemail.com with ESMTPSA id z7sm450929pju.37.2020.04.08.14.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 14:55:47 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v6 05/20] jbd2: disable fast commits if journal is empty
Date:   Wed,  8 Apr 2020 14:55:15 -0700
Message-Id: <20200408215530.25649-5-harshads@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
In-Reply-To: <20200408215530.25649-1-harshads@google.com>
References: <20200408215530.25649-1-harshads@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

If journal is empty, clear the fast commit flag from the on disk
superblock. With this optimization, chances of running into backward
compatibility issues are reduced.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/jbd2/journal.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 79f015f7bf54..f8f55d0814ea 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1482,6 +1482,7 @@ int jbd2_journal_update_sb_log_tail(journal_t *journal, tid_t tail_tid,
 static void jbd2_mark_journal_empty(journal_t *journal, int write_op)
 {
 	journal_superblock_t *sb = journal->j_superblock;
+	bool had_fast_commit = false;
 
 	BUG_ON(!mutex_is_locked(&journal->j_checkpoint_mutex));
 	lock_buffer(journal->j_sb_buffer);
@@ -1495,9 +1496,20 @@ static void jbd2_mark_journal_empty(journal_t *journal, int write_op)
 
 	sb->s_sequence = cpu_to_be32(journal->j_tail_sequence);
 	sb->s_start    = cpu_to_be32(0);
+	if (jbd2_has_feature_fast_commit(journal)) {
+		/*
+		 * When journal is clean, no need to commit fast commit flag and
+		 * make file system incompatible with older kernels.
+		 */
+		jbd2_clear_feature_fast_commit(journal);
+		had_fast_commit = true;
+	}
 
 	jbd2_write_superblock(journal, write_op);
 
+	if (had_fast_commit)
+		jbd2_set_feature_fast_commit(journal);
+
 	/* Log is no longer empty */
 	write_lock(&journal->j_state_lock);
 	journal->j_flags |= JBD2_FLUSHED;
-- 
2.26.0.110.g2183baf09c-goog

