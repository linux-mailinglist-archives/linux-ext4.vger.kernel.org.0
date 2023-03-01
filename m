Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE166A6E06
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Mar 2023 15:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjCAOKV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Mar 2023 09:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjCAOKV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Mar 2023 09:10:21 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3006C2BEC6
        for <linux-ext4@vger.kernel.org>; Wed,  1 Mar 2023 06:10:08 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6746F1FE12;
        Wed,  1 Mar 2023 14:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677679807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=aIMjfmhq7nYPusiyg85tcqZI3FYTZk4EnEbX5heVlwg=;
        b=jGYnYx68//ElqAEoAlfm+yNFQhlPLz7q6v8ekWTLx6pf2EQfHDl2zqy3TW661W31lphtkh
        jgB89IwrajH5aFOswJYRjfVpQFse3952bIF1+CyWGN/hHJ2G/rJH9IduMq5fd9bUIxQB39
        /5lVsUDD/iOlFHOfVkRrL1M9tzKQSVM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677679807;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=aIMjfmhq7nYPusiyg85tcqZI3FYTZk4EnEbX5heVlwg=;
        b=p1lTqYdFlLTIrnkpPheDl2apJAPtj435PFQE30QiuKihvhGQNZp66X47VxXr74YEVjjprF
        JCkkjA+F5k89pCBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4B77613A3E;
        Wed,  1 Mar 2023 14:10:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xo1ZEr9c/2M9LwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 01 Mar 2023 14:10:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9CAA2A06E5; Wed,  1 Mar 2023 15:10:05 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        syzbot+9d16c39efb5fade84574@syzkaller.appspotmail.com
Subject: [PATCH] ext4: Fix deadlock during directory rename
Date:   Wed,  1 Mar 2023 15:10:04 +0100
Message-Id: <20230301141004.15087-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2362; i=jack@suse.cz; h=from:subject; bh=xXiOhYfpd9MzzRp/FRGaJPxPJNi6jTgGAMdC7OTpfv4=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBj/1yt14qH9d7SFMXRn3J1j2q1mz+qvNiiSe4qNjng P+BFbUCJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY/9crQAKCRCcnaoHP2RA2XadB/ 93eGiNNRtZ63fjeOIpfhXVJGi+51oKI5XVsCk0xpu9MkwI7RDDRYNUwnNMbLha6+u3R+yjIHpb6Go7 RpxkepvYemHtcdk2Wg+soJi/Kv6wFcrGYIo02hwletXYUViANHmfMEmFuZ8t+eFQyIt01ijM1q5UdH 2Q1KvDU8cxURRnsOdTfdtnoASGzzrRrmD64HrxBRugsFi6iCT4bmFJAkVEyYsc6CWRmQFQKciOd/dq fsGyzpCA1Mn2NhokaoNQ8TfQ6sCvpWAFo2gxmGYBRvEwS829BdFAaxxfAVCa0SHajdu8fprohGkt8C j9QfZh4ze2uNFrALl/UnyUPEPDNMc6
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

As lockdep properly warns, we should not be locking i_rwsem while having
transactions started as the proper lock ordering used by all directory
handling operations is i_rwsem -> transaction start. Fix the lock
ordering by moving the locking of the directory earlier in
ext4_rename().

Reported-by: syzbot+9d16c39efb5fade84574@syzkaller.appspotmail.com
Fixes: 0813299c586b ("ext4: Fix possible corruption when moving a directory")
Link: https://syzkaller.appspot.com/bug?extid=9d16c39efb5fade84574
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/namei.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 94608b7df7e8..426013b27816 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3813,9 +3813,19 @@ static int ext4_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			return retval;
 	}
 
+	/*
+	 * We need to protect against old.inode directory getting converted
+	 * from inline directory format into a normal one.
+	 */
+	if (S_ISDIR(old.inode->i_mode))
+		inode_lock_nested(old.inode, I_MUTEX_NONDIR2);
+
 	old.bh = ext4_find_entry(old.dir, &old.dentry->d_name, &old.de, NULL);
-	if (IS_ERR(old.bh))
-		return PTR_ERR(old.bh);
+	if (IS_ERR(old.bh)) {
+		retval = PTR_ERR(old.bh);
+		goto unlock_moved_dir;
+	}
+
 	/*
 	 *  Check for inode number is _not_ due to possible IO errors.
 	 *  We might rmdir the source, keep it as pwd of some process
@@ -3872,11 +3882,6 @@ static int ext4_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			if (new.dir != old.dir && EXT4_DIR_LINK_MAX(new.dir))
 				goto end_rename;
 		}
-		/*
-		 * We need to protect against old.inode directory getting
-		 * converted from inline directory format into a normal one.
-		 */
-		inode_lock_nested(old.inode, I_MUTEX_NONDIR2);
 		retval = ext4_rename_dir_prepare(handle, &old);
 		if (retval) {
 			inode_unlock(old.inode);
@@ -4013,12 +4018,15 @@ static int ext4_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	} else {
 		ext4_journal_stop(handle);
 	}
-	if (old.dir_bh)
-		inode_unlock(old.inode);
 release_bh:
 	brelse(old.dir_bh);
 	brelse(old.bh);
 	brelse(new.bh);
+
+unlock_moved_dir:
+	if (S_ISDIR(old.inode->i_mode))
+		inode_unlock(old.inode);
+
 	return retval;
 }
 
-- 
2.35.3

