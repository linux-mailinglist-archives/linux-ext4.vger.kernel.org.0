Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952617C8571
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Oct 2023 14:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbjJMMOF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 13 Oct 2023 08:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjJMMOF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 13 Oct 2023 08:14:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E1DA9;
        Fri, 13 Oct 2023 05:14:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A097721882;
        Fri, 13 Oct 2023 12:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697199240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=/Xf4C3l9Iso6xeaae7NubLlmFoMmCGa8pNWn490GaeE=;
        b=qdeL2FvTP+LgFGtLi01o5NGHBNpXBrTA0gIQNOhXoWdq9zc+ZPMs16mVkdH3Fl7DguHUs/
        dunMNV5ds/CVFwT5rEeynvt8fBLMeJlM1/F8qQH3067SNOwG1f5Wf1QalSmOQFJalRliNE
        K1N9fSPpGfJcuWZchYU1ftjdwA/bMgw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697199240;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=/Xf4C3l9Iso6xeaae7NubLlmFoMmCGa8pNWn490GaeE=;
        b=ZS6djrqnN+1bDhnoVd815NyA3Xv65LdWFWX70YwP/5iyBI5/mlvu/gndycJJmVrme7vqFN
        /AZut0O+dTwFDqCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8C6E11358F;
        Fri, 13 Oct 2023 12:14:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id I+tFIog0KWVfagAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 13 Oct 2023 12:14:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1D321A05C4; Fri, 13 Oct 2023 14:14:00 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        stable@vger.kernel.org
Subject: [PATCH v3] ext4: Properly sync file size update after O_SYNC direct IO
Date:   Fri, 13 Oct 2023 14:13:50 +0200
Message-Id: <20231013121350.26872-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8425; i=jack@suse.cz; h=from:subject; bh=1pHrsh/BRc9dHNqdl5wJ1etY2TaDx6R1VHRBskLM2mo=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlKTR5BC9hdTZ9WwEqiR/cYxkQI6TgvMuCqBPFAcXZ CeqnwpGJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZSk0eQAKCRCcnaoHP2RA2cKFB/ 4wVcnqbkvgj8Q9SDedAMwGbSuYreIH6eCNdd/F/unwI+BbT5xgtaGR+MxlvAtVO8VRgWaV1oKpLWTd mvyXulge+Rf6iHteiK/WrYDaPVVsh57t6I0+PJxMQw3aHZAyXi3SLUHyjp4GdaIZAyLICVWLMOmJKk xTG1IP8ZSmL00zkOaXauAQpeu8iX7tiCBh9GH39HpQ9j3/23ubuT7W75RQvHC4H0HqMMtlf29jX7T+ zqW9Bo4PStzpAC7vCMsGiovaGGcWT5HLL1OElZMNe0RVtC1oOPtuAZvKxFmu5Xh09f5YWevDdm0IOw 6srWUsNpfu2wRGZrCMUQBYyjm3gJQN
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -0.60
X-Spamd-Result: default: False [-0.60 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[7];
         MID_CONTAINS_FROM(1.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[];
         FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,linux.alibaba.com,fromorbit.com,suse.cz]
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Gao Xiang has reported that on ext4 O_SYNC direct IO does not properly
sync file size update and thus if we crash at unfortunate moment, the
file can have smaller size although O_SYNC IO has reported successful
completion. The problem happens because update of on-disk inode size is
handled in ext4_dio_write_iter() *after* iomap_dio_rw() (and thus
dio_complete() in particular) has returned and generic_file_sync() gets
called by dio_complete(). Fix the problem by handling on-disk inode size
update directly in our ->end_io completion handler.

References: https://lore.kernel.org/all/02d18236-26ef-09b0-90ad-030c4fe3ee20@linux.alibaba.com
Reported-by: Gao Xiang <hsiangkao@linux.alibaba.com>
CC: stable@vger.kernel.org
Fixes: 378f32bab371 ("ext4: introduce direct I/O write using iomap infrastructure")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/file.c | 153 +++++++++++++++++++++----------------------------
 1 file changed, 65 insertions(+), 88 deletions(-)

Changes since v2:
* Added more comments explaining the code flow
* Added WARN_ON_ONCE to verify extending IO is handled synchronously

Changes since v1:
* Rebased on top of Linus' tree (instead of a tree with iomap cleanup)
* Made ext4_dio_write_end_io() always return number of written bytes on
  success for consistency
* Added Fixes tag

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 6830ea3a6c59..19d9db4799c4 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -306,80 +306,38 @@ static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
 }
 
 static ssize_t ext4_handle_inode_extension(struct inode *inode, loff_t offset,
-					   ssize_t written, size_t count)
+					   ssize_t count)
 {
 	handle_t *handle;
-	bool truncate = false;
-	u8 blkbits = inode->i_blkbits;
-	ext4_lblk_t written_blk, end_blk;
-	int ret;
-
-	/*
-	 * Note that EXT4_I(inode)->i_disksize can get extended up to
-	 * inode->i_size while the I/O was running due to writeback of delalloc
-	 * blocks. But, the code in ext4_iomap_alloc() is careful to use
-	 * zeroed/unwritten extents if this is possible; thus we won't leave
-	 * uninitialized blocks in a file even if we didn't succeed in writing
-	 * as much as we intended.
-	 */
-	WARN_ON_ONCE(i_size_read(inode) < EXT4_I(inode)->i_disksize);
-	if (offset + count <= EXT4_I(inode)->i_disksize) {
-		/*
-		 * We need to ensure that the inode is removed from the orphan
-		 * list if it has been added prematurely, due to writeback of
-		 * delalloc blocks.
-		 */
-		if (!list_empty(&EXT4_I(inode)->i_orphan) && inode->i_nlink) {
-			handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
-
-			if (IS_ERR(handle)) {
-				ext4_orphan_del(NULL, inode);
-				return PTR_ERR(handle);
-			}
-
-			ext4_orphan_del(handle, inode);
-			ext4_journal_stop(handle);
-		}
-
-		return written;
-	}
-
-	if (written < 0)
-		goto truncate;
 
+	lockdep_assert_held_write(&inode->i_rwsem);
 	handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
-	if (IS_ERR(handle)) {
-		written = PTR_ERR(handle);
-		goto truncate;
-	}
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
 
-	if (ext4_update_inode_size(inode, offset + written)) {
-		ret = ext4_mark_inode_dirty(handle, inode);
+	if (ext4_update_inode_size(inode, offset + count)) {
+		int ret = ext4_mark_inode_dirty(handle, inode);
 		if (unlikely(ret)) {
-			written = ret;
 			ext4_journal_stop(handle);
-			goto truncate;
+			return ret;
 		}
 	}
 
-	/*
-	 * We may need to truncate allocated but not written blocks beyond EOF.
-	 */
-	written_blk = ALIGN(offset + written, 1 << blkbits);
-	end_blk = ALIGN(offset + count, 1 << blkbits);
-	if (written_blk < end_blk && ext4_can_truncate(inode))
-		truncate = true;
-
-	/*
-	 * Remove the inode from the orphan list if it has been extended and
-	 * everything went OK.
-	 */
-	if (!truncate && inode->i_nlink)
+	if (inode->i_nlink)
 		ext4_orphan_del(handle, inode);
 	ext4_journal_stop(handle);
 
-	if (truncate) {
-truncate:
+	return count;
+}
+
+/*
+ * Clean up the inode after DIO or DAX extending write has completed and the
+ * inode size has been updated using ext4_handle_inode_extension().
+ */
+static void ext4_inode_extension_cleanup(struct inode *inode, ssize_t count)
+{
+	lockdep_assert_held_write(&inode->i_rwsem);
+	if (count < 0) {
 		ext4_truncate_failed_write(inode);
 		/*
 		 * If the truncate operation failed early, then the inode may
@@ -388,9 +346,28 @@ static ssize_t ext4_handle_inode_extension(struct inode *inode, loff_t offset,
 		 */
 		if (inode->i_nlink)
 			ext4_orphan_del(NULL, inode);
+		return;
 	}
+	/*
+	 * If i_disksize got extended due to writeback of delalloc blocks while
+	 * the DIO was running we could fail to cleanup the orphan list in
+	 * ext4_handle_inode_extension(). Do it now.
+	 */
+	if (!list_empty(&EXT4_I(inode)->i_orphan) && inode->i_nlink) {
+		handle_t *handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
 
-	return written;
+		if (IS_ERR(handle)) {
+			/*
+			 * The write has successfully completed. Not much to
+			 * do with the error here so just cleanup the orphan
+			 * list and hope for the best.
+			 */
+			ext4_orphan_del(NULL, inode);
+			return;
+		}
+		ext4_orphan_del(handle, inode);
+		ext4_journal_stop(handle);
+	}
 }
 
 static int ext4_dio_write_end_io(struct kiocb *iocb, ssize_t size,
@@ -399,31 +376,22 @@ static int ext4_dio_write_end_io(struct kiocb *iocb, ssize_t size,
 	loff_t pos = iocb->ki_pos;
 	struct inode *inode = file_inode(iocb->ki_filp);
 
+	if (!error && size && flags & IOMAP_DIO_UNWRITTEN)
+		error = ext4_convert_unwritten_extents(NULL, inode, pos, size);
 	if (error)
 		return error;
-
-	if (size && flags & IOMAP_DIO_UNWRITTEN) {
-		error = ext4_convert_unwritten_extents(NULL, inode, pos, size);
-		if (error < 0)
-			return error;
-	}
 	/*
-	 * If we are extending the file, we have to update i_size here before
-	 * page cache gets invalidated in iomap_dio_rw(). Otherwise racing
-	 * buffered reads could zero out too much from page cache pages. Update
-	 * of on-disk size will happen later in ext4_dio_write_iter() where
-	 * we have enough information to also perform orphan list handling etc.
-	 * Note that we perform all extending writes synchronously under
-	 * i_rwsem held exclusively so i_size update is safe here in that case.
-	 * If the write was not extending, we cannot see pos > i_size here
-	 * because operations reducing i_size like truncate wait for all
-	 * outstanding DIO before updating i_size.
+	 * Note that EXT4_I(inode)->i_disksize can get extended up to
+	 * inode->i_size while the I/O was running due to writeback of delalloc
+	 * blocks. But the code in ext4_iomap_alloc() is careful to use
+	 * zeroed/unwritten extents if this is possible; thus we won't leave
+	 * uninitialized blocks in a file even if we didn't succeed in writing
+	 * as much as we intended.
 	 */
-	pos += size;
-	if (pos > i_size_read(inode))
-		i_size_write(inode, pos);
-
-	return 0;
+	WARN_ON_ONCE(i_size_read(inode) < READ_ONCE(EXT4_I(inode)->i_disksize));
+	if (pos + size <= READ_ONCE(EXT4_I(inode)->i_disksize))
+		return size;
+	return ext4_handle_inode_extension(inode, pos, size);
 }
 
 static const struct iomap_dio_ops ext4_dio_write_ops = {
@@ -606,9 +574,16 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			   dio_flags, NULL, 0);
 	if (ret == -ENOTBLK)
 		ret = 0;
-
-	if (extend)
-		ret = ext4_handle_inode_extension(inode, offset, ret, count);
+	if (extend) {
+		/*
+		 * We always perform extending DIO write synchronously so by
+		 * now the IO is completed and ext4_handle_inode_extension()
+		 * was called. Cleanup the inode in case of error or race with
+		 * writeback of delalloc blocks.
+		 */
+		WARN_ON_ONCE(ret == -EIOCBQUEUED);
+		ext4_inode_extension_cleanup(inode, ret);
+	}
 
 out:
 	if (ilock_shared)
@@ -689,8 +664,10 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	ret = dax_iomap_rw(iocb, from, &ext4_iomap_ops);
 
-	if (extend)
-		ret = ext4_handle_inode_extension(inode, offset, ret, count);
+	if (extend) {
+		ret = ext4_handle_inode_extension(inode, offset, ret);
+		ext4_inode_extension_cleanup(inode, ret);
+	}
 out:
 	inode_unlock(inode);
 	if (ret > 0)
-- 
2.35.3

