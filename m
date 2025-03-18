Return-Path: <linux-ext4+bounces-6898-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4C8A66CCD
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Mar 2025 08:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A0B3B0BEE
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Mar 2025 07:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC1C1F099B;
	Tue, 18 Mar 2025 07:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pGrQ77Bx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D71C1EF364;
	Tue, 18 Mar 2025 07:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742284399; cv=none; b=L9sOx/aTfmKG4+OSIa7WzAiWVOERJkbaHK2PKAM+4pxBowe9bmmGmkbHPxRbm2l+Jpfl7QyUt5He0zndKtmqA+SyQernLnh1fQlxFC4ewGHb62vS8nC0Y4cF0S8mZ1mIAfEDH1SYeVQ+yLN741TGu8kNgswlFnKWRpTP65Fgy/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742284399; c=relaxed/simple;
	bh=MWVJnHV5Pf8i5TQixb0q/aekZTCIFymMpGEtB1mVjWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aBuxsbxUnDwGFyJaOV+Q0yxu1YuBmUE188eAft4UnOtWUonV/22zJZmcmlt04o5KJ3/4LDwPEae13c/Qku7qhbgXg9xyD/NnpSbRtPJyvgVJc2kil/cGTnEu+jMIPrQUwDoCAgl+6i9AD2cNo0IdxxysoZNBmH9WU6BivZEI4Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pGrQ77Bx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52HKqTgY012179;
	Tue, 18 Mar 2025 07:53:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=E+cmUdSTSMh8Di7xc
	in945MPCv4UupI+TetQCtjDwtU=; b=pGrQ77BxXvHL2rp4elUZ/QBLBEi+arHGL
	dRmGJ9p1X5El0xPQvoWWmCOR2SigjJu33cMl9VK8qWbU3PT2r+4BsL/6AjDsMG5P
	GNCZ3hOBVtsRCawwoHnAGAu1C3GsH7JhYOrZVyT98o2hOZX27fQyuIf9wJfRGHLN
	waOIo/bYsW5CKn5PvG356ge6Fua5zhedvZvt6h2FNpBwbXcvZe2qcOf9dUVZURK5
	7VDZms9LBvHD4uiWDar7fptBZb0bWTlmPzsBFYOpjAwA9FB3GqLWjIxRlaTScHUB
	3r5OrM+vYvrUFOo3h5OE5cRC//2rUJEl7O7y1geal8+ho+CdSGArw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45eu55t8ax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 07:53:10 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52I7rAws003545;
	Tue, 18 Mar 2025 07:53:10 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45eu55t8av-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 07:53:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52I4Bji0001076;
	Tue, 18 Mar 2025 07:53:09 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dp3kjegy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 07:53:09 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52I7r79j50332074
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 07:53:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A709020040;
	Tue, 18 Mar 2025 07:53:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE3B220043;
	Tue, 18 Mar 2025 07:53:05 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.27.85])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Mar 2025 07:53:05 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        Mahesh Kumar <maheshkumar657g@gmail.com>
Subject: [PATCH v4 2/3] ext4: avoid journaling sb update on error if journal is destroying
Date: Tue, 18 Mar 2025 13:22:56 +0530
Message-ID: <9613c465d6ff00cd315602f99283d5f24018c3f7.1742279837.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1742279837.git.ojaswin@linux.ibm.com>
References: <cover.1742279837.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eyISuN_Gjy7nB416ZjLR8azaD-kWGOlz
X-Proofpoint-GUID: PjGfiTZ7RDnmkI_YfDUUYk528kI7Yu-u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_03,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503180052

Presently we always BUG_ON if trying to start a transaction on a journal marked
with JBD2_UNMOUNT, since this should never happen. However, while ltp running
stress tests, it was observed that in case of some error handling paths, it is
possible for update_super_work to start a transaction after the journal is
destroyed eg:

(umount)
ext4_kill_sb
  kill_block_super
    generic_shutdown_super
      sync_filesystem /* commits all txns */
      evict_inodes
        /* might start a new txn */
      ext4_put_super
	flush_work(&sbi->s_sb_upd_work) /* flush the workqueue */
        jbd2_journal_destroy
          journal_kill_thread
            journal->j_flags |= JBD2_UNMOUNT;
          jbd2_journal_commit_transaction
            jbd2_journal_get_descriptor_buffer
              jbd2_journal_bmap
                ext4_journal_bmap
                  ext4_map_blocks
                    ...
                    ext4_inode_error
                      ext4_handle_error
                        schedule_work(&sbi->s_sb_upd_work)

                                               /* work queue kicks in */
                                               update_super_work
                                                 jbd2_journal_start
                                                   start_this_handle
                                                     BUG_ON(journal->j_flags &
                                                            JBD2_UNMOUNT)

Hence, introduce a new mount flag to indicate journal is destroying and only do
a journaled (and deferred) update of sb if this flag is not set. Otherwise, just
fallback to an un-journaled commit.

Further, in the journal destroy path, we have the following sequence:

  1. Set mount flag indicating journal is destroying
  2. force a commit and wait for it
  3. flush pending sb updates

This sequence is important as it ensures that, after this point, there is no sb
update that might be journaled so it is safe to update the sb outside the
journal. (To avoid race discussed in 2d01ddc86606)

Also, we don't need a similar check in ext4_grp_locked_error since it is only
called from mballoc and AFAICT it would be always valid to schedule work here.

Fixes: 2d01ddc86606 ("ext4: save error info to sb through journal if available")
Reported-by: Mahesh Kumar <maheshkumar657g@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/ext4.h      |  3 ++-
 fs/ext4/ext4_jbd2.h | 15 +++++++++++++++
 fs/ext4/super.c     | 16 ++++++++--------
 3 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 2b7d781bfcad..0685bb68e64a 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1823,7 +1823,8 @@ static inline int ext4_valid_inum(struct super_block *sb, unsigned long ino)
  */
 enum {
 	EXT4_MF_MNTDIR_SAMPLED,
-	EXT4_MF_FC_INELIGIBLE	/* Fast commit ineligible */
+	EXT4_MF_FC_INELIGIBLE,	/* Fast commit ineligible */
+	EXT4_MF_JOURNAL_DESTROY	/* Journal is in process of destroying */
 };
 
 static inline void ext4_set_mount_flag(struct super_block *sb, int bit)
diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 9b3c9df02a39..3221714d9901 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -437,6 +437,21 @@ static inline int ext4_journal_destroy(struct ext4_sb_info *sbi, journal_t *jour
 {
 	int err = 0;
 
+	/*
+	 * At this point only two things can be operating on the journal.
+	 * JBD2 thread performing transaction commit and s_sb_upd_work
+	 * issuing sb update through the journal. Once we set
+	 * EXT4_JOURNAL_DESTROY, new ext4_handle_error() calls will not
+	 * queue s_sb_upd_work and ext4_force_commit() makes sure any
+	 * ext4_handle_error() calls from the running transaction commit are
+	 * finished. Hence no new s_sb_upd_work can be queued after we
+	 * flush it here.
+	 */
+	ext4_set_mount_flag(sbi->s_sb, EXT4_MF_JOURNAL_DESTROY);
+
+	ext4_force_commit(sbi->s_sb);
+	flush_work(&sbi->s_sb_upd_work);
+
 	err = jbd2_journal_destroy(journal);
 	sbi->s_journal = NULL;
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 8ad664d47806..46f7c9922cda 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -704,9 +704,13 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
 		 * In case the fs should keep running, we need to writeout
 		 * superblock through the journal. Due to lock ordering
 		 * constraints, it may not be safe to do it right here so we
-		 * defer superblock flushing to a workqueue.
+		 * defer superblock flushing to a workqueue. We just need to be
+		 * careful when the journal is already shutting down. If we get
+		 * here in that case, just update the sb directly as the last
+		 * transaction won't commit anyway.
 		 */
-		if (continue_fs && journal)
+		if (continue_fs && journal &&
+		    !ext4_test_mount_flag(sb, EXT4_MF_JOURNAL_DESTROY))
 			schedule_work(&EXT4_SB(sb)->s_sb_upd_work);
 		else
 			ext4_commit_super(sb);
@@ -1291,7 +1295,6 @@ static void ext4_put_super(struct super_block *sb)
 	ext4_unregister_li_request(sb);
 	ext4_quotas_off(sb, EXT4_MAXQUOTAS);
 
-	flush_work(&sbi->s_sb_upd_work);
 	destroy_workqueue(sbi->rsv_conversion_wq);
 	ext4_release_orphan_info(sb);
 
@@ -1301,7 +1304,8 @@ static void ext4_put_super(struct super_block *sb)
 		if ((err < 0) && !aborted) {
 			ext4_abort(sb, -err, "Couldn't clean up the journal");
 		}
-	}
+	} else
+		flush_work(&sbi->s_sb_upd_work);
 
 	ext4_es_unregister_shrinker(sbi);
 	timer_shutdown_sync(&sbi->s_err_report);
@@ -4957,8 +4961,6 @@ static int ext4_load_and_init_journal(struct super_block *sb,
 	return 0;
 
 out:
-	/* flush s_sb_upd_work before destroying the journal. */
-	flush_work(&sbi->s_sb_upd_work);
 	ext4_journal_destroy(sbi, sbi->s_journal);
 	return -EINVAL;
 }
@@ -5648,8 +5650,6 @@ failed_mount8: __maybe_unused
 	sbi->s_ea_block_cache = NULL;
 
 	if (sbi->s_journal) {
-		/* flush s_sb_upd_work before journal destroy. */
-		flush_work(&sbi->s_sb_upd_work);
 		ext4_journal_destroy(sbi, sbi->s_journal);
 	}
 failed_mount3a:
-- 
2.48.1


