Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0D970EC18
	for <lists+linux-ext4@lfdr.de>; Wed, 24 May 2023 05:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239273AbjEXDuU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 23 May 2023 23:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239286AbjEXDuO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 23 May 2023 23:50:14 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77614C1
        for <linux-ext4@vger.kernel.org>; Tue, 23 May 2023 20:50:13 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 34O3nvNv023549
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 23:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1684900199; bh=lFGVLvSBFhHx7Kn44mkMmiq4RuBsQzsThLSCaoaBq9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=FRpokWMI9oD/fR3AFWMNXT7QAotlaD7zhdFARp8EeTk2anmEjXEgfHyk3f0t0IOkE
         Ev83UAKxuuqc0kg4kK0Y/TGZVN12l/B/mLXeyCpMqkMMvlan6O+XCtGOqrrfs5BBsV
         31Q3zfu/1CYOECOPMkoXmEfzFRIDGtSdQYbfcj/JInLjZU1qMDfBipE6WY4TwYDqCh
         rClmwSXcWQazp+jJ0FAmxS6YOfpPZ/QWnxq7jDTaq5LVTkxzmPXB6cOfI6x11SawFt
         iargcyzpV6OmoonMOr7+jXgf5bU3rsPX/ahiZhHE0mxYCb76LHVKc/QUGFrc0W4znK
         5ofonYrRQlsow==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8DCC215C052F; Tue, 23 May 2023 23:49:57 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, stable@kernel.org,
        syzbot+298c5d8fb4a128bc27b0@syzkaller.appspotmail.com
Subject: [PATCH 4/4] ext4: add lockdep annotations for i_data_sem for ea_inode's
Date:   Tue, 23 May 2023 23:49:51 -0400
Message-Id: <20230524034951.779531-5-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230524034951.779531-1-tytso@mit.edu>
References: <20230524034951.779531-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Treat i_data_sem for ea_inodes as being in their own lockdep class to
avoid lockdep complaints about ext4_setattr's use of inode_lock() on
normal inodes potentially causing lock ordering with i_data_sem on
ea_inodes in ext4_xattr_inode_write().  However, ea_inodes will be
operated on by ext4_setattr(), so this isn't a problem.

Cc: stable@kernel.org
Link: https://syzkaller.appspot.com/bug?extid=298c5d8fb4a128bc27b0
Reported-by: syzbot+298c5d8fb4a128bc27b0@syzkaller.appspotmail.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/ext4.h  | 2 ++
 fs/ext4/xattr.c | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 9525c52b78dc..8104a21b001a 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -918,11 +918,13 @@ do {									       \
  *			  where the second inode has larger inode number
  *			  than the first
  *  I_DATA_SEM_QUOTA  - Used for quota inodes only
+ *  I_DATA_SEM_EA     - Used for ea_inodes only
  */
 enum {
 	I_DATA_SEM_NORMAL = 0,
 	I_DATA_SEM_OTHER,
 	I_DATA_SEM_QUOTA,
+	I_DATA_SEM_EA
 };
 
 
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index ff7ab63c5b4f..13d7f17a9c8c 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -121,7 +121,11 @@ ext4_expand_inode_array(struct ext4_xattr_inode_array **ea_inode_array,
 #ifdef CONFIG_LOCKDEP
 void ext4_xattr_inode_set_class(struct inode *ea_inode)
 {
+	struct ext4_inode_info *ei = EXT4_I(ea_inode);
+
 	lockdep_set_subclass(&ea_inode->i_rwsem, 1);
+	(void) ei;	/* shut up clang warning if !CONFIG_LOCKDEP */
+	lockdep_set_subclass(&ei->i_data_sem, I_DATA_SEM_EA);
 }
 #endif
 
-- 
2.31.0

