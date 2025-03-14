Return-Path: <linux-ext4+bounces-6800-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D42C0A60A3E
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Mar 2025 08:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 988C61897D8B
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Mar 2025 07:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD8F1946AA;
	Fri, 14 Mar 2025 07:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IhHM/Fcl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BAC1519B0;
	Fri, 14 Mar 2025 07:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741938284; cv=none; b=efwIW/EmAwKBQNCn1RPsEevO0aaMLGhwKvuZtLXh2naUxGNXxKLKcTD4/kR2zwIWy+V0KauQM+NWcE9SVS19K3eKUIcjjMX8gbtTdMDQqlIOzW31QovuPEY131dt7DDVoCDuosN+/StzUIg10dZ3WwlGvbE2QNsX/kbg12wuVjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741938284; c=relaxed/simple;
	bh=3QOphe5mum8r5bZDrO0rG19IJY/HqckSMpWXM/yLvkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LMp/6Yk99QG7Pq9KgaaHkQj2SS73e+AZe2xxhOqpuXXml7jae0dgONCqQnIQxiMmCzOAJIkHDgWE+9AENLB4dj3l4DjUqD5OdK2gA0Usoh9GaVNsccHHu68wXKf0dtuoCJybKoejl1t6fWVFluyVgTYd1R0qYI9Ikp2+TtcbaUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IhHM/Fcl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DNQqYT009763;
	Fri, 14 Mar 2025 07:44:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2St2wmLGyzs2MwiPD
	LaevaKuDzpRdZ40vCxIseXnEhg=; b=IhHM/FclHfKO0esQJfnl6q00EOswk63qM
	E+eDq/DSMpWi7dv2nrR/YkXmmFL2aWJ0uIcK0c9U//lWmH1u2d/82VYzAtW4NKJr
	/rAMtF/MgyBA3xXlSq0zpvi6ayHsXygoSF/oZ7N0Oqr3OO48a6kAHkcpw6HmQjHc
	VwMdAIUxmOc+VfyRl1gHMba6DjfRrpDVf7aaz1+nTAor7H1mm/9UhQLzSt7CiQSv
	7pS/llueCeKPyuZdN4td2wgp6hYSL5hfexpVvx6+QGcY6ZrEYvV198RtxuHr93xq
	vLSLax5MtCK4xHcgmvmpDrcaE06hvQ7eF59ERfJxDWqTlIbfEr+dA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c6s5a7bb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 07:44:32 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52E7iVXN001962;
	Fri, 14 Mar 2025 07:44:31 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c6s5a7b8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 07:44:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52E4S83r003148;
	Fri, 14 Mar 2025 07:44:30 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45atstwurc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 07:44:30 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52E7iSp759441426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Mar 2025 07:44:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDFC22004E;
	Fri, 14 Mar 2025 07:44:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B24E720043;
	Fri, 14 Mar 2025 07:44:25 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.24.194])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Mar 2025 07:44:25 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] ext4: Make sb update interval tunable
Date: Fri, 14 Mar 2025 13:14:11 +0530
Message-ID: <6be9a2b7757b77e9a12394c69fee35fffd3a970b.1741938027.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-GUID: tkAh_Lnqum6OYHoDocdK-Coiaw4oGBm1
X-Proofpoint-ORIG-GUID: 8AH3-lFWCi-sPzVrcYMtM6qHgYrRius9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_03,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=611 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2503140058

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
Reviewed-by: Baokun Li <libaokun1@huawei.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/ext4.h  |  9 +++++++++
 fs/ext4/super.c | 15 ++++++++-------
 fs/ext4/sysfs.c |  4 ++++
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index ee54b8510791..23c3e3ced9e6 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1609,6 +1609,8 @@ struct ext4_sb_info {
 	unsigned int s_mb_prefetch;
 	unsigned int s_mb_prefetch_limit;
 	unsigned int s_mb_best_avail_max_trim_order;
+	unsigned int s_sb_update_sec;
+	unsigned int s_sb_update_kb;
 
 	/* stats for buddy allocator */
 	atomic_t s_bal_reqs;	/* number of reqs with len > 1 */
@@ -2280,6 +2282,13 @@ static inline int ext4_forced_shutdown(struct super_block *sb)
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
index 54ef0cc566a4..c97ca78bd48a 100644
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
 
@@ -5248,6 +5247,8 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
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


