Return-Path: <linux-ext4+bounces-6690-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA34A54DCC
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Mar 2025 15:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 153223B2332
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Mar 2025 14:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04DD17B500;
	Thu,  6 Mar 2025 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FTSSl90I"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0931F1624DC;
	Thu,  6 Mar 2025 14:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741271347; cv=none; b=pdlmLItn/xJmfNlShANBbOKfwqzlYCnQCR2Zd3mu++WglOOmNi/EjQ1+tgYn4Fm124aH9h8QUZDTFd1t/BGxrQZJz7lSQhWz0rRnBpI03ClAniN1DbvmIydciy30JOxsk69qxUcA7s3JShNGCpdaUjI3lDOJKI5IdCVuA4Y6eoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741271347; c=relaxed/simple;
	bh=IAWc07o0hy8Yj6IbKizZU9iMnybLs2RdnYBMOmPC14c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZV41axpgBl0xDwO/d1L7lsrf6zquRgXm9AIMLBQmb+O4HhZK5BWr6S69RCVc+0L71ybAW2kYB8B1GgcgwrWe4/RUD3Ks/l3ZLbBpjCroIcd1T50XOg8+CErTJsCoGLrIlEqatTIPZHyTfrObc+9aGGCkFIqvYv2RWiHOKGxk2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FTSSl90I; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5268LpYr000725;
	Thu, 6 Mar 2025 14:28:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZlXcIXcnmN4pmK6oK
	I6mE4wgeljt6AOBXxWFggX625I=; b=FTSSl90Imdiuwf/el3qjwRGcRYVvQZJYF
	RESaFOUhbdAiN1970tFCx0uhv0btM+nEi7zHeDuf/InzRyVbNz14IaisjAQC72gq
	rsSq5jOzBH60K1qz85C8IKAP8P6Oc/CmsH8cbOq5FCRb40IWD1LiC6FDlZWpkN89
	ORfu+YC+AhIgKsLXVmY8sotStrKp4rDZkDc3YMnT1hg7sxl4Z+xtB8AnFrzwP3re
	UPMCr0fuT7MUycppTpBV1dWqjwPRQLoAgaggBMHANuCx+MzoAMvIYkDA986npD1S
	XVwz3JK8/M/F/w15p7qFVj8JKUl+47KB81GfOXMHn7mpIChpFQbag==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 456wspmb6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 14:28:46 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 526ESkgP010434;
	Thu, 6 Mar 2025 14:28:46 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 456wspmb6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 14:28:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 526De8ph020794;
	Thu, 6 Mar 2025 14:28:45 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 454esk8uxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 14:28:45 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 526ESh5t35127948
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Mar 2025 14:28:44 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBBF72004B;
	Thu,  6 Mar 2025 14:28:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 164DD20040;
	Thu,  6 Mar 2025 14:28:42 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.in.ibm.com (unknown [9.109.219.249])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Mar 2025 14:28:41 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>,
        linux-kernel@vger.kernel.org,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v2 3/3] ext4: Make sb update interval tunable
Date: Thu,  6 Mar 2025 19:58:34 +0530
Message-ID: <4c89be10ad8c8937048148bce1fc9ca882d060c6.1741270780.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-GUID: cadswMRKw-2OP0LJ8DlJn9haS3EGBuiN
X-Proofpoint-ORIG-GUID: R9NeYpjWG8xcFFEAgZWBcAQ3_Y6fUikK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxlogscore=629 clxscore=1015 priorityscore=1501 phishscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503060110

Currently, outside error paths, we auto commit the super block after 1
hour has passed and 16MB worth of updates have been written since last
commit. This is a policy decision so make this tunable while keeping the
defaults same. This is useful if user wants to tweak the superblock
behavior or for debugging the codepath by allowing to trigger it more
frequently.

We can now tweak the super block update using sb_update_sec and
sb_update_kb files in /sys/fs/ext4/<dev>/

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/ext4.h  |  9 +++++++++
 fs/ext4/super.c | 15 ++++++++-------
 fs/ext4/sysfs.c |  4 ++++
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index d48e93bd5690..82c902ed86f3 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1608,6 +1608,8 @@ struct ext4_sb_info {
 	unsigned int s_mb_prefetch;
 	unsigned int s_mb_prefetch_limit;
 	unsigned int s_mb_best_avail_max_trim_order;
+	unsigned int s_sb_update_sec;
+	unsigned int s_sb_update_kb;
 
 	/* stats for buddy allocator */
 	atomic_t s_bal_reqs;	/* number of reqs with len > 1 */
@@ -2281,6 +2283,13 @@ static inline int ext4_forced_shutdown(struct super_block *sb)
 #define EXT4_DEF_MIN_BATCH_TIME	0
 #define EXT4_DEF_MAX_BATCH_TIME	15000 /* 15ms */
 
+/*
+ * Default values for superblock update
+ */
+#define EXT4_DEF_SB_UPDATE_INTERVAL_SEC (3600) /* seconds (1 hour) */
+#define EXT4_DEF_SB_UPDATE_INTERVAL_KB (16384) /* kilobytes (16MB) */
+
+
 /*
  * Minimum number of groups in a flexgroup before we separate out
  * directories into the first block group of a flexgroup
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 31552cf0519a..1b47b111c583 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -447,9 +447,6 @@ static time64_t __ext4_get_tstamp(__le32 *lo, __u8 *hi)
 #define ext4_get_tstamp(es, tstamp) \
 	__ext4_get_tstamp(&(es)->tstamp, &(es)->tstamp ## _hi)
 
-#define EXT4_SB_REFRESH_INTERVAL_SEC (3600) /* seconds (1 hour) */
-#define EXT4_SB_REFRESH_INTERVAL_KB (16384) /* kilobytes (16MB) */
-
 /*
  * The ext4_maybe_update_superblock() function checks and updates the
  * superblock if needed.
@@ -457,8 +454,10 @@ static time64_t __ext4_get_tstamp(__le32 *lo, __u8 *hi)
  * This function is designed to update the on-disk superblock only under
  * certain conditions to prevent excessive disk writes and unnecessary
  * waking of the disk from sleep. The superblock will be updated if:
- * 1. More than an hour has passed since the last superblock update, and
- * 2. More than 16MB have been written since the last superblock update.
+ * 1. More than sbi->s_sb_update_sec (def: 1 hour) has passed since the last
+ *    superblock update
+ * 2. More than sbi->s_sb_update_kb (def: 16MB) kbs have been written since the
+ *    last superblock update.
  *
  * @sb: The superblock
  */
@@ -479,7 +478,7 @@ static void ext4_maybe_update_superblock(struct super_block *sb)
 	now = ktime_get_real_seconds();
 	last_update = ext4_get_tstamp(es, s_wtime);
 
-	if (likely(now - last_update < EXT4_SB_REFRESH_INTERVAL_SEC))
+	if (likely(now - last_update < sbi->s_sb_update_sec))
 		return;
 
 	lifetime_write_kbytes = sbi->s_kbytes_written +
@@ -494,7 +493,7 @@ static void ext4_maybe_update_superblock(struct super_block *sb)
 	 */
 	diff_size = lifetime_write_kbytes - le64_to_cpu(es->s_kbytes_written);
 
-	if (diff_size > EXT4_SB_REFRESH_INTERVAL_KB)
+	if (diff_size > sbi->s_sb_update_kb)
 		schedule_work(&EXT4_SB(sb)->s_sb_upd_work);
 }
 
@@ -5246,6 +5245,8 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	sbi->s_commit_interval = JBD2_DEFAULT_MAX_COMMIT_AGE * HZ;
 	sbi->s_min_batch_time = EXT4_DEF_MIN_BATCH_TIME;
 	sbi->s_max_batch_time = EXT4_DEF_MAX_BATCH_TIME;
+	sbi->s_sb_update_kb = EXT4_DEF_SB_UPDATE_INTERVAL_KB;
+	sbi->s_sb_update_sec = EXT4_DEF_SB_UPDATE_INTERVAL_SEC;
 
 	/*
 	 * set default s_li_wait_mult for lazyinit, for the case there is
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index ddb54608ca2e..987bd00f916a 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -254,6 +254,8 @@ EXT4_ATTR(journal_task, 0444, journal_task);
 EXT4_RW_ATTR_SBI_UI(mb_prefetch, s_mb_prefetch);
 EXT4_RW_ATTR_SBI_UI(mb_prefetch_limit, s_mb_prefetch_limit);
 EXT4_RW_ATTR_SBI_UL(last_trim_minblks, s_last_trim_minblks);
+EXT4_RW_ATTR_SBI_UI(sb_update_sec, s_sb_update_sec);
+EXT4_RW_ATTR_SBI_UI(sb_update_kb, s_sb_update_kb);
 
 static unsigned int old_bump_val = 128;
 EXT4_ATTR_PTR(max_writeback_mb_bump, 0444, pointer_ui, &old_bump_val);
@@ -305,6 +307,8 @@ static struct attribute *ext4_attrs[] = {
 	ATTR_LIST(mb_prefetch),
 	ATTR_LIST(mb_prefetch_limit),
 	ATTR_LIST(last_trim_minblks),
+	ATTR_LIST(sb_update_sec),
+	ATTR_LIST(sb_update_kb),
 	NULL,
 };
 ATTRIBUTE_GROUPS(ext4);
-- 
2.48.1


