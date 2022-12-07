Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35676458FC
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Dec 2022 12:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiLGL1t (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Dec 2022 06:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiLGL12 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Dec 2022 06:27:28 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F226FAF3
        for <linux-ext4@vger.kernel.org>; Wed,  7 Dec 2022 03:27:27 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D1C8621CA5;
        Wed,  7 Dec 2022 11:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670412443; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Nhtqr8UdriMk3AjDYwCLDj+xnYpZDjboz9Lzk4A8nk=;
        b=XN93s56DV+clF4NhM+KJ1Oqfapyoj3vc03FhQ4/4QG84ySeL3VZQ9BpNAv/UJwKpxsVGQG
        9Kj5v9fE7l/h3h5a4ElRHRy+U1ooKA2gOvULxcc8xmjG6zvDeWrdqZybrhBYxDTTH2MYxo
        WXSKLALS/OfSzekAKF4uo9XR+/QvTTA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670412443;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Nhtqr8UdriMk3AjDYwCLDj+xnYpZDjboz9Lzk4A8nk=;
        b=FFVreM/Acw3wftHUfnEcNgDNeXeU0FIivENUOCfBayIpMulfTR1EKCwg91zKg5a5fNAvCZ
        SxH1j3ztwz08LvCA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id C5B6913732;
        Wed,  7 Dec 2022 11:27:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id f61EMJt4kGNJLAAAGKfGzw
        (envelope-from <jack@suse.cz>); Wed, 07 Dec 2022 11:27:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 09F79A0735; Wed,  7 Dec 2022 12:27:23 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v4 09/13] jbd2: Switch jbd2_submit_inode_data() to use fs-provided hook for data writeout
Date:   Wed,  7 Dec 2022 12:27:12 +0100
Message-Id: <20221207112722.22220-9-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221207112259.8143-1-jack@suse.cz>
References: <20221207112259.8143-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2428; i=jack@suse.cz; h=from:subject; bh=BwhuXcDi8ihTJ1g4K2G+XR7kilsjYpigi3eooLgj1Wg=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjkHiQKJLB5Af/xkDBCmsVQDb+UPi+dX+R4/U3QGNB teu4GI+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY5B4kAAKCRCcnaoHP2RA2aSsCA CqoYFlDdLWfghtWtfm7eXyis6wIQNXh6BpWqtiPN7cBB71EDP56X5jyM+Zrown4X8cvC7bU0KVroOj 9WCqLiMwxZpTLko/6Bn/Yv4NG0kEJKeJZdB28mscFhHOlxh+0eCfGqbiIyFe05F0ENfWnqtMkTsvMG 6Qvu/myhTi3YSdZFJLnKRfwsITmhaKaY1pyVUl/AX5VEtuSAjSGJWbVXbWx3XjnnUK4gGEjAx+uTSM 6Y1n5nur8MCsElZOE0Ael0F4bNNOXoqi39oT7FKc4kCnsmcrQGM1niqeZzvV5OmDLk2YKYHuR6dt3U zOjZjw4L3K0Em8GvU83+f+WgzMfrjn
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

jbd2_submit_inode_data() hardcoded use of
jbd2_journal_submit_inode_data_buffers() for submission of data pages.
Make it use j_submit_inode_data_buffers hook instead. This effectively
switches ext4 fastcommits to use ext4_writepages() for data writeout
instead of generic_writepages().

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/fast_commit.c | 2 +-
 fs/jbd2/commit.c      | 5 ++---
 include/linux/jbd2.h  | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 0f6d0a80467d..7c6694593497 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -986,7 +986,7 @@ static int ext4_fc_submit_inode_data_all(journal_t *journal)
 			finish_wait(&ei->i_fc_wait, &wait);
 		}
 		spin_unlock(&sbi->s_fc_lock);
-		ret = jbd2_submit_inode_data(ei->jinode);
+		ret = jbd2_submit_inode_data(journal, ei->jinode);
 		if (ret)
 			return ret;
 		spin_lock(&sbi->s_fc_lock);
diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 885a7a6cc53e..4810438b7856 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -207,14 +207,13 @@ int jbd2_journal_submit_inode_data_buffers(struct jbd2_inode *jinode)
 }
 
 /* Send all the data buffers related to an inode */
-int jbd2_submit_inode_data(struct jbd2_inode *jinode)
+int jbd2_submit_inode_data(journal_t *journal, struct jbd2_inode *jinode)
 {
-
 	if (!jinode || !(jinode->i_flags & JI_WRITE_DATA))
 		return 0;
 
 	trace_jbd2_submit_inode_data(jinode->i_vfs_inode);
-	return jbd2_journal_submit_inode_data_buffers(jinode);
+	return journal->j_submit_inode_data_buffers(jinode);
 
 }
 EXPORT_SYMBOL(jbd2_submit_inode_data);
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 0b7242370b56..2170e0cc279d 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1662,7 +1662,7 @@ int jbd2_fc_begin_commit(journal_t *journal, tid_t tid);
 int jbd2_fc_end_commit(journal_t *journal);
 int jbd2_fc_end_commit_fallback(journal_t *journal);
 int jbd2_fc_get_buf(journal_t *journal, struct buffer_head **bh_out);
-int jbd2_submit_inode_data(struct jbd2_inode *jinode);
+int jbd2_submit_inode_data(journal_t *journal, struct jbd2_inode *jinode);
 int jbd2_wait_inode_data(journal_t *journal, struct jbd2_inode *jinode);
 int jbd2_fc_wait_bufs(journal_t *journal, int num_blks);
 int jbd2_fc_release_bufs(journal_t *journal);
-- 
2.35.3

