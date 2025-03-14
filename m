Return-Path: <linux-ext4+bounces-6799-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C97A60A3B
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Mar 2025 08:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E46517AB96
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Mar 2025 07:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3661218FDA5;
	Fri, 14 Mar 2025 07:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ax/01A6c"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3041715350B;
	Fri, 14 Mar 2025 07:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741938278; cv=none; b=sxFRjlo+hoGFlmqOhVXSYrUN3u9Xm1m+pbTm49UI8Ifx5slDvArQ6zN2JCw4z02XVcry70gNi7qQudnmO0usdcXqWpoRnzRE4osUMySX82zw5EPO+z7CUz77rM41GrpEEo742W3r0GTUOXd5qFCnS35TlvPOAuC2YZJ5NyBsC/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741938278; c=relaxed/simple;
	bh=XPhEZgZVhi3XbjMujJuvrYrqXR4THiKCRiorg6BtSJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JPbonaj4Hjqh1YhmaCuzf7EHeDYKbd43V3cX/L7G8mTqxfnln8YLzBi2XXpBoZn7x9bzdI6vAyzcD5PaiqS4T8OpRlHCysth8lWkWIQv3ksKkwGPmmVq80r2cv4IjlSz1V1UyfUO1eA+EZuxP5oKzUBSuG3Sd+q5qB3KQn5ilLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ax/01A6c; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DNPANW032481;
	Fri, 14 Mar 2025 07:44:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KMW5jMY7RmYyG8F2N
	1NffrMddU+AWRHw8CPczXyW4iQ=; b=ax/01A6cCMv43HoAKS8JPuap2hh2mSdAh
	VNjNtDsrmX+H/InPiIBiU0dRMLF4F1LtPhfGmJ+fi6wbCWJP24vlqexNuMdWmO9Z
	SngZvJVJtfFAhpb+A4zWnY3cAXwz30h7N9Uuv6tGP/KFdK9vIQsno48VD+nY9ObN
	7ZGDwbVxw5u0wFDQ9bOeLEFALW7SLPjdMWZjqT45kH26Opa4jPEnhD85mSTz3xxG
	8GbpSzvK81pdhYCIPmGqOHOwC3CRB0OQvrnmmI9QpBuDF9XyUpl28tS2UypwvCWw
	hhCxH4N8378HaqCk4g4q2pVdkaN5EN5Nmm7+D/UQCHLnu071HwKtg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c6hptbgn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 07:44:28 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52E7fLh0009928;
	Fri, 14 Mar 2025 07:44:27 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c6hptbgk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 07:44:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52E48Fe2012311;
	Fri, 14 Mar 2025 07:44:27 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45atsrnuat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 07:44:26 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52E7iPvt45810106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Mar 2025 07:44:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0453B20043;
	Fri, 14 Mar 2025 07:44:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA99E2004B;
	Fri, 14 Mar 2025 07:44:21 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.24.194])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Mar 2025 07:44:21 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        Mahesh Kumar <maheshkumar657g@gmail.com>
Subject: [PATCH v3 2/3] ext4: avoid journaling sb update on error if journal is destroying
Date: Fri, 14 Mar 2025 13:14:10 +0530
Message-ID: <b8e529f340a9c25c270a77733c79ffc590a9935c.1741938027.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741938027.git.ojaswin@linux.ibm.com>
References: <cover.1741938027.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DUS-CeE-yyLaUWcnezMoMshJf2_twk2H
X-Proofpoint-ORIG-GUID: OSynhhKYz7sTrI0z0Gt_oGVuN9Hu0yAB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_03,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 clxscore=1015 spamscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503140058

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
 fs/ext4/ext4.h      |  1 +
 fs/ext4/ext4_jbd2.h | 15 +++++++++++++++
 fs/ext4/super.c     | 12 ++++++------
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 2b7d781bfcad..ee54b8510791 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1179,6 +1179,7 @@ struct ext4_inode_info {
 #define	EXT4_ERROR_FS			0x0002	/* Errors detected */
 #define	EXT4_ORPHAN_FS			0x0004	/* Orphans being recovered */
 #define EXT4_FC_REPLAY			0x0020	/* Fast commit replay ongoing */
+#define EXT4_JOURNAL_DESTORY		0x0040	/* Journal is in process of destroying */
 
 /*
  * Misc. filesystem flags
diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 9b3c9df02a39..f054db9fa9e1 100644
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
+	ext4_set_mount_flag(sbi->s_sb, EXT4_JOURNAL_DESTORY);
+
+	ext4_force_commit(sbi->s_sb);
+	flush_work(&sbi->s_sb_upd_work);
+
 	err = jbd2_journal_destroy(journal);
 	sbi->s_journal = NULL;
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 8ad664d47806..54ef0cc566a4 100644
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
+		    !ext4_test_mount_flag(sb, EXT4_JOURNAL_DESTORY))
 			schedule_work(&EXT4_SB(sb)->s_sb_upd_work);
 		else
 			ext4_commit_super(sb);
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


