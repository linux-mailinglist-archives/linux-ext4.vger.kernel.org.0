Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058334DA4BD
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Mar 2022 22:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbiCOVpF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Mar 2022 17:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235470AbiCOVpE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Mar 2022 17:45:04 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597E613D40
        for <linux-ext4@vger.kernel.org>; Tue, 15 Mar 2022 14:43:51 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 22FLhhYd018945
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Mar 2022 17:43:43 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3CC9515C3E98; Tue, 15 Mar 2022 17:43:43 -0400 (EDT)
Date:   Tue, 15 Mar 2022 17:43:43 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: [PATCHv3 05/10] ext4: Return early for non-eligible fast_commit
 track events
Message-ID: <YjEIj/elOQ4f9qq2@mit.edu>
References: <cover.1647057583.git.riteshh@linux.ibm.com>
 <3cd025d9c490218a92e6d8fb30b6123e693373e3.1647057583.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cd025d9c490218a92e6d8fb30b6123e693373e3.1647057583.git.riteshh@linux.ibm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Mar 12, 2022 at 11:09:50AM +0530, Ritesh Harjani wrote:
> Currently ext4_fc_track_template() checks, whether the trace event
> path belongs to replay or does sb has ineligible set, if yes it simply
> returns. This patch pulls those checks before calling
> ext4_fc_track_template() in the callers of ext4_fc_track_template().
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

I had to add the following patch to this commit in order to prevent a
BUG when using ext4 to mount a file system without a journal.  This is
because ext4_rename() calls the __ext4_fc_track_* functions directly,
and moving the checks from __ext4_fc_track_* to ext4_fc_track_* would
result in a NULL pointer dereference.

						- Ted

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 39e223f7bf64..e37da8d5cd0c 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3891,12 +3891,19 @@ static int ext4_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 		ext4_fc_mark_ineligible(old.inode->i_sb,
 			EXT4_FC_REASON_RENAME_DIR, handle);
 	} else {
+		struct super_block *sb = old.inode->i_sb;
+
 		if (new.inode)
 			ext4_fc_track_unlink(handle, new.dentry);
-		__ext4_fc_track_link(handle, old.inode, new.dentry);
-		__ext4_fc_track_unlink(handle, old.inode, old.dentry);
-		if (whiteout)
-			__ext4_fc_track_create(handle, whiteout, old.dentry);
+		if (test_opt2(sb, JOURNAL_FAST_COMMIT) &&
+		    !(EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY) &&
+		    !(ext4_test_mount_flag(sb, EXT4_MF_FC_INELIGIBLE))) {
+			__ext4_fc_track_link(handle, old.inode, new.dentry);
+			__ext4_fc_track_unlink(handle, old.inode, old.dentry);
+			if (whiteout)
+				__ext4_fc_track_create(handle, whiteout,
+						       old.dentry);
+		}
 	}
 
 	if (new.inode) {

