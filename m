Return-Path: <linux-ext4+bounces-6689-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C89BA54DC9
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Mar 2025 15:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E110174FF4
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Mar 2025 14:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA9428F1;
	Thu,  6 Mar 2025 14:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T//WVzNB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C794516EB42;
	Thu,  6 Mar 2025 14:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741271335; cv=none; b=utNOz0hWZePhjQig7Mq3GufkC3OR7lJIa1ouXU6DO199Tew74xZmfv7NLKVR5uYNkB7A74t/AfdoNdp1+JhfB5y4hK+trnq/uhe25d3RbuT9rRt+fFf/dove346ynV6kJ7Q/y7/05QU1QZYAY9Z7x5yRHMjwWOMcKE101PfdZzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741271335; c=relaxed/simple;
	bh=zjb8z7ensd3sXRAJpgQCZaf6D0juc6pdmDMmtLBlumk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iPvQ9QiV0ZShPEI5oG19Y2yP/8fYo4Lv69XNuhzoOBlwAWOu8U0cMuCnZvd2wbMzA9wpgwhhhC2DXfuZR3OFHRCXmXfJOOc9cj6yuIb7DouWleqIrpNe0GmifkMNN15+eWXaShSkx0qZIEez7avTlenVUVljvClYpJwuB5oeEz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T//WVzNB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526D9fn4023822;
	Thu, 6 Mar 2025 14:28:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5nJ4BzVB7Xst8cj0y
	d+w4fnY+oJJyaYT+qfw/hCWsTU=; b=T//WVzNB6GY4LNzbFFjX/CyTTBb0aLQ3Z
	VeCzCre8Hcf043x1UiSgSoz6h7zsZ1mQbssT0zrBnX2u+f5ctpAbcRyyq77DfO7f
	8YsAf+NHE7nI9Nk27o1XOxz4Nh+JmF+aIeZtnqjwXTHB63pIek8W6IGXXTpnOPgk
	7p5HA+T34ESHkm203NEEPgTMbr/qX69feCFy2aXOpfGmdipiwTzKxxByfdJrVkEA
	Toyi2KHTy1BeF5eGmcPf4QNmWTivdbJmO8wbKhWUwovG/hLgd3RkJVPGl4rUhz0v
	FXzFonefhllcg3gNVFei3r28JDQi17qEZibs23WS57v6yEsa0NiSw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4574392ymk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 14:28:44 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 526EQtmb010712;
	Thu, 6 Mar 2025 14:28:44 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4574392ymf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 14:28:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 526EQOk8032243;
	Thu, 6 Mar 2025 14:28:43 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 454cjt9dhd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 14:28:43 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 526ESf8556033690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Mar 2025 14:28:41 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A756820049;
	Thu,  6 Mar 2025 14:28:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 01BF320040;
	Thu,  6 Mar 2025 14:28:40 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.in.ibm.com (unknown [9.109.219.249])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Mar 2025 14:28:39 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>,
        linux-kernel@vger.kernel.org, Mahesh Kumar <maheshkumar657g@gmail.com>
Subject: [PATCH v2 2/3] ext4: avoid journaling sb update on error if journal is destroying
Date: Thu,  6 Mar 2025 19:58:33 +0530
Message-ID: <1bf59095d87e5dfae8f019385ba3ce58973baaff.1741270780.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741270780.git.ojaswin@linux.ibm.com>
References: <cover.1741270780.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: leczszhq_tgtLnJclhiRYTQmmXbZ7OgA
X-Proofpoint-ORIG-GUID: JPSSjdcpck8VPKlW2RAL9Kv9YG9d8c_U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503060110

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

Hence, introduce a new sbi flag s_journal_destroying to indicate journal is
destroying only do a journaled (and deferred) update of sb if this flag is not
set. Otherwise, just fallback to an un-journaled commit.

We set sbi->s_journal_destroying = true only after all the FS updates are done
during ext4_put_super() (except a running transaction that will get commited
during jbd2_journal_destroy()). After this point, it is safe to commit the sb
outside the journal as it won't race with a journaled update (refer
2d01ddc86606).

Also, we don't need a similar check in ext4_grp_locked_error since it is only
called from mballoc and AFAICT it would be always valid to schedule work here.

Fixes: 2d01ddc86606 ("ext4: save error info to sb through journal if available")
Reported-by: Mahesh Kumar <maheshkumar657g@gmail.com>
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/ext4.h      | 2 ++
 fs/ext4/ext4_jbd2.h | 8 ++++++++
 fs/ext4/super.c     | 4 +++-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 2b7d781bfcad..d48e93bd5690 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1728,6 +1728,8 @@ struct ext4_sb_info {
 	 */
 	struct work_struct s_sb_upd_work;
 
+	bool s_journal_destorying;
+
 	/* Atomic write unit values in bytes */
 	unsigned int s_awu_min;
 	unsigned int s_awu_max;
diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 9b3c9df02a39..6bd3ca84410d 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -437,6 +437,14 @@ static inline int ext4_journal_destroy(struct ext4_sb_info *sbi, journal_t *jour
 {
 	int err = 0;
 
+	/*
+	 * At this point all pending FS updates should be done except a possible
+	 * running transaction (which will commit in jbd2_journal_destroy). It
+	 * is now safe for any new errors to directly commit superblock rather
+	 * than going via journal.
+	 */
+	sbi->s_journal_destorying = true;
+
 	err = jbd2_journal_destroy(journal);
 	sbi->s_journal = NULL;
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 8ad664d47806..31552cf0519a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -706,7 +706,7 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
 		 * constraints, it may not be safe to do it right here so we
 		 * defer superblock flushing to a workqueue.
 		 */
-		if (continue_fs && journal)
+		if (continue_fs && journal && !EXT4_SB(sb)->s_journal_destorying)
 			schedule_work(&EXT4_SB(sb)->s_sb_upd_work);
 		else
 			ext4_commit_super(sb);
@@ -5311,6 +5311,8 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	spin_lock_init(&sbi->s_error_lock);
 	INIT_WORK(&sbi->s_sb_upd_work, update_super_work);
 
+	sbi->s_journal_destorying = false;
+
 	err = ext4_group_desc_init(sb, es, logical_sb_block, &first_not_zeroed);
 	if (err)
 		goto failed_mount3;
-- 
2.48.1


