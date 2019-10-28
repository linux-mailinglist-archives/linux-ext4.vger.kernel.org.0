Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D032EE7000
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Oct 2019 11:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388377AbfJ1KyA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Oct 2019 06:54:00 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33236 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728554AbfJ1Kx7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Oct 2019 06:53:59 -0400
Received: by mail-pf1-f194.google.com with SMTP id c184so6673706pfb.0
        for <linux-ext4@vger.kernel.org>; Mon, 28 Oct 2019 03:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hzUA/3MWmz4zE5gI8tQIld6lm5+sdsFzA4VSheS6JfQ=;
        b=Angb3Tj3jgXlr520cPCtCWxo5mOy2rZV91q12F7goKGs2ZCJtV141AqbuLKEmpjftL
         gcMn2T2IK/RnVdDnLSa5s5FXW0OLUEppbQ3Qd/atgnoP7uSXpOp0Lzi5NhQ82CH7D8mK
         s/zwnbQ9/y0TYmQGLZdtSH8iVTIaeY2dmv1PhlOhrqXN2cUof1Xy/96ZL+S/5pFLNOtB
         Om17hpjg8PAyXG0/y6WeuVXW3kHiLPMpc921OCKIDSpD/kMATV4nLyRGuAKe3VPE/1lD
         RtYVZNdIsjCvm7Ev4EiDsfOeOhhFp4KBkseXLXeBMfGjBZACWr2yFa0eqL9ksomB3oG9
         f0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hzUA/3MWmz4zE5gI8tQIld6lm5+sdsFzA4VSheS6JfQ=;
        b=CFGmnhoWobUwOICaDBYHdirb2HxNrg3yU9fdIHZa710nj8bQL3Pq0t4RFN/CrXrmOT
         GSoujiRtrDWpASueR1NZ3ktSoJFcFQqPHGv9ewzTguAry7wd+iMmg4/HACbUbtSOv9Qq
         JPbSW1gMPyDYCK9jcEv3l6Ni2oL0sqhbM2qhM7fRZB5RcxzNcJw99bwR0pExa4AwlDFw
         yhRkSGB+sK4ynzD96PAqZhltigIOu/5SYmzEtff2C9SdL4aM8W+CPG1XIrpA7HMuYrMh
         hvYVwFTjvutUlQXYtUWl+yjYwV5PecBJ35g5bmZlu+tIHC1xVhJskTdDmRi8oRIBK7jC
         ls5A==
X-Gm-Message-State: APjAAAXPXgsoBnDscuYsrXxF/MZVZ5f55SWvrcEOuQK1ptg9MiCYG3q0
        CWnYvP6s4eBmtX3Bkgso7Kv8
X-Google-Smtp-Source: APXvYqwhhhnLLvV6plWnhv+DzE/nx0VoWa4YIiEht4CJyGSLT+8Y2GmQKsJVAjM0Yl9LpgfuSsvEsw==
X-Received: by 2002:a65:64da:: with SMTP id t26mr19834283pgv.180.1572260038670;
        Mon, 28 Oct 2019 03:53:58 -0700 (PDT)
Received: from poseidon.bobrowski.net (d114-78-127-22.bla803.nsw.optusnet.com.au. [114.78.127.22])
        by smtp.gmail.com with ESMTPSA id v1sm11626385pjd.22.2019.10.28.03.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 03:53:58 -0700 (PDT)
Date:   Mon, 28 Oct 2019 21:53:52 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: [PATCH v6 10/11] ext4: update ext4_sync_file() to not use
 __generic_file_fsync()
Message-ID: <b58782fcf631b6248174fb69f3314fd60b760404.1572255426.git.mbobrowski@mbobrowski.org>
References: <cover.1572255424.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1572255424.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When the filesystem is created without a journal, we eventually call
into __generic_file_fsync() in order to write out all the modified
in-core data to the permanent storage device. This function happens to
try and obtain an inode_lock() while synchronizing the files buffer
and it's associated metadata.

Generally, this is fine, however it becomes a problem when there is
higher level code that has already obtained an inode_lock() as this
leads to a recursive lock situation. This case is especially true when
porting across direct I/O to iomap infrastructure as we obtain an
inode_lock() early on in the I/O within ext4_dio_write_iter() and hold
it until the I/O has been completed. Consequently, to not run into
this specific issue, we move away from calling into
__generic_file_fsync() and perform the necessary synchronization tasks
within ext4_sync_file().

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
---

Thanks Jan and Christoph for the suggestion on this one, highly
appreciated.

 fs/ext4/fsync.c | 72 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 47 insertions(+), 25 deletions(-)

diff --git a/fs/ext4/fsync.c b/fs/ext4/fsync.c
index 5508baa11bb6..e10206e7f4bb 100644
--- a/fs/ext4/fsync.c
+++ b/fs/ext4/fsync.c
@@ -80,6 +80,43 @@ static int ext4_sync_parent(struct inode *inode)
 	return ret;
 }
 
+static int ext4_fsync_nojournal(struct inode *inode, bool datasync,
+				bool *needs_barrier)
+{
+	int ret, err;
+
+	ret = sync_mapping_buffers(inode->i_mapping);
+	if (!(inode->i_state & I_DIRTY_ALL))
+		return ret;
+	if (datasync && !(inode->i_state & I_DIRTY_DATASYNC))
+		return ret;
+
+	err = sync_inode_metadata(inode, 1);
+	if (!ret)
+		ret = err;
+
+	if (!ret)
+		ret = ext4_sync_parent(inode);
+	if (test_opt(inode->i_sb, BARRIER))
+		*needs_barrier = true;
+
+	return ret;
+}
+
+static int ext4_fsync_journal(struct inode *inode, bool datasync,
+			     bool *needs_barrier)
+{
+	struct ext4_inode_info *ei = EXT4_I(inode);
+	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
+	tid_t commit_tid = datasync ? ei->i_datasync_tid : ei->i_sync_tid;
+
+	if (journal->j_flags & JBD2_BARRIER &&
+	    !jbd2_trans_will_send_data_barrier(journal, commit_tid))
+		*needs_barrier = true;
+
+	return jbd2_complete_transaction(journal, commit_tid);
+}
+
 /*
  * akpm: A new design for ext4_sync_file().
  *
@@ -91,17 +128,14 @@ static int ext4_sync_parent(struct inode *inode)
  * What we do is just kick off a commit and wait on it.  This will snapshot the
  * inode to disk.
  */
-
 int ext4_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 {
-	struct inode *inode = file->f_mapping->host;
-	struct ext4_inode_info *ei = EXT4_I(inode);
-	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
 	int ret = 0, err;
-	tid_t commit_tid;
 	bool needs_barrier = false;
+	struct inode *inode = file->f_mapping->host;
+	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
+	if (unlikely(ext4_forced_shutdown(sbi)))
 		return -EIO;
 
 	J_ASSERT(ext4_journal_current_handle() == NULL);
@@ -111,23 +145,15 @@ int ext4_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	if (sb_rdonly(inode->i_sb)) {
 		/* Make sure that we read updated s_mount_flags value */
 		smp_rmb();
-		if (EXT4_SB(inode->i_sb)->s_mount_flags & EXT4_MF_FS_ABORTED)
+		if (sbi->s_mount_flags & EXT4_MF_FS_ABORTED)
 			ret = -EROFS;
 		goto out;
 	}
 
-	if (!journal) {
-		ret = __generic_file_fsync(file, start, end, datasync);
-		if (!ret)
-			ret = ext4_sync_parent(inode);
-		if (test_opt(inode->i_sb, BARRIER))
-			goto issue_flush;
-		goto out;
-	}
-
 	ret = file_write_and_wait_range(file, start, end);
 	if (ret)
 		return ret;
+
 	/*
 	 * data=writeback,ordered:
 	 *  The caller's filemap_fdatawrite()/wait will sync the data.
@@ -142,18 +168,14 @@ int ext4_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 *  (they were dirtied by commit).  But that's OK - the blocks are
 	 *  safe in-journal, which is all fsync() needs to ensure.
 	 */
-	if (ext4_should_journal_data(inode)) {
+	if (!sbi->s_journal)
+		ret = ext4_fsync_nojournal(inode, datasync, &needs_barrier);
+	else if (ext4_should_journal_data(inode))
 		ret = ext4_force_commit(inode->i_sb);
-		goto out;
-	}
+	else
+		ret = ext4_fsync_journal(inode, datasync, &needs_barrier);
 
-	commit_tid = datasync ? ei->i_datasync_tid : ei->i_sync_tid;
-	if (journal->j_flags & JBD2_BARRIER &&
-	    !jbd2_trans_will_send_data_barrier(journal, commit_tid))
-		needs_barrier = true;
-	ret = jbd2_complete_transaction(journal, commit_tid);
 	if (needs_barrier) {
-	issue_flush:
 		err = blkdev_issue_flush(inode->i_sb->s_bdev, GFP_KERNEL, NULL);
 		if (!ret)
 			ret = err;
-- 
2.20.1

