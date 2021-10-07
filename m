Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890DC425720
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Oct 2021 17:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241930AbhJGPzg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Oct 2021 11:55:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52210 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbhJGPzg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Oct 2021 11:55:36 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 803FC2249F;
        Thu,  7 Oct 2021 15:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633622021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4f8iGXQD3UElFSizPSM1pppXnKHaF2scCLBVU2+oMKY=;
        b=0BohPLUlO8fIwJmeXeF9+JYFR/karIz+PtmVlFihml5CPMCxrJkC5D/9dMWLra2HFBJlkB
        KWt4olkLps39vlraDmklObDi/0MVogagreIl1s0OPEFprzYD7gwVMat1/IXcdI0XmDq3LP
        N3DkDV3I31P1lflloKzCGqSnJbCXjho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633622021;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4f8iGXQD3UElFSizPSM1pppXnKHaF2scCLBVU2+oMKY=;
        b=8XX/TE8SjMzUdsZ0qQr+hzrFViGGBBnIYj7GqmneI+Uy+rwDi6daDtM2SkJy1u1GxNoGgy
        j9lYEKWyOLWPHmCw==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 7244FA3B85;
        Thu,  7 Oct 2021 15:53:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3797D1E0BEA; Thu,  7 Oct 2021 17:53:38 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-ext4@vger.kernel.org>
Cc:     Ted Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Subject: [PATCH 1/2] ext4: Make sure quota gets properly shutdown on error
Date:   Thu,  7 Oct 2021 17:53:35 +0200
Message-Id: <20211007155336.12493-2-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211007155336.12493-1-jack@suse.cz>
References: <20211007155336.12493-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1381; h=from:subject; bh=iiNOtZRRyo82xhszHxxc9CcMCIbyhJnjntXalTolCPI=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhXxd4mLrEBhJke+Nn8ZJxK7d2ZrrnscuXDLDzt7sV x9nhcDWJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYV8XeAAKCRCcnaoHP2RA2fsXB/ 9nYRM1kes+OkWh37dFRKSsawqeLF1iJfoR/O9oeFrATXMshXmkz5O0S3XBE7FP6ksgAgMFOAma5Z2k ihuY6S9V2KcDKVLAoHcu5/1bLgu4ID0E3qWEk9cBuCXhzTuroErMkUpAi4A452dhrOWLTP2vpC8BT+ VJctWWXz09WTH0CWPdEBcYK1WtDxbcbxIez34l/1HjY63KI8n491paFxTAGXzk9Kg3Cp+3x9jSCeLK Yz05V3X10KGbg78iouLBHLy+ByJN0kdEZWbat3BGNxIJ5mdEyiHZPKhXeF2ZeQPRaXHhTUjFE0VBUS DBvfQyY2oRY4+pg+KBIXSYtcq6fik4
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When we hit an error when enabling quotas and setting inode flags, we do
not properly shutdown quota subsystem despite returning error from
Q_QUOTAON quotactl. This can lead to some odd situations like kernel
using quota file while it is still writeable for userspace. Make sure we
properly cleanup the quota subsystem in case of error.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/super.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 88d5d274a868..fbe9cae63786 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6267,10 +6267,7 @@ static int ext4_quota_on(struct super_block *sb, int type, int format_id,
 
 	lockdep_set_quota_inode(path->dentry->d_inode, I_DATA_SEM_QUOTA);
 	err = dquot_quota_on(sb, type, format_id, path);
-	if (err) {
-		lockdep_set_quota_inode(path->dentry->d_inode,
-					     I_DATA_SEM_NORMAL);
-	} else {
+	if (!err) {
 		struct inode *inode = d_inode(path->dentry);
 		handle_t *handle;
 
@@ -6290,7 +6287,12 @@ static int ext4_quota_on(struct super_block *sb, int type, int format_id,
 		ext4_journal_stop(handle);
 	unlock_inode:
 		inode_unlock(inode);
+		if (err)
+			dquot_quota_off(sb, type);
 	}
+	if (err)
+		lockdep_set_quota_inode(path->dentry->d_inode,
+					     I_DATA_SEM_NORMAL);
 	return err;
 }
 
-- 
2.26.2

