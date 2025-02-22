Return-Path: <linux-ext4+bounces-6529-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CFEA4066C
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Feb 2025 09:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42EEA1711D9
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Feb 2025 08:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1075206F16;
	Sat, 22 Feb 2025 08:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cNLKbS02"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55B12066F3;
	Sat, 22 Feb 2025 08:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740213640; cv=none; b=BG9x2kLDgDOarrK/CdzGMaFOLE87hymRPw0h2wn0b7VTTz2eWu9kiNKR+eDQ8RckRRaC02s334g+MRfJEhl7q0AgMzCjw7VHzZyt9LMnCSdRDf+2j/zLHB6/ON1ZdiVPG79FzabwyykGBYtnMyrxzH3boXnDcbPruLZm+/FI6Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740213640; c=relaxed/simple;
	bh=i9n76LpRg5/9z7bYEElbmM6IhZF1UdG1UXnNhtQuF7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P75ipq0WTq/V5Z71t2T/9AVEF1+Qj+dXCa3mRdUYWTKqPHJdefJkmHqrCqLLT78c7p4gRz2SOLTOkxY0GbhFAx6RDbDqUlFhZcbdaT+14OCfvHzDmQk63v/B2kd7tELm1AZJPfA6hGa0zj1WAOLa+0G6AA1uhWnVz5guDaSIKHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cNLKbS02; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51M51oZI013209;
	Sat, 22 Feb 2025 08:40:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rtKRCEdc9H8O8YuVp
	i+iB66yeRyBU0+UDxOBXz2No44=; b=cNLKbS021hE+KG3vLtk+cWWxw5EL26Uyt
	3GKbxKQXp81wxGH0ReAP+L8dIJT2wN+l03GskEb9lc6LH3evmS0fIMVbSdSJx48I
	ddqouKu2QV2u2CpsSSdkKny6qqv/YoTKfZ+TqsIvGcc9NW8cGdNztnnOPvx182MW
	kefq1peMH0XNO8jz5doRhXzb1GB1B2hZ/8nNJDd816Wwh059MudR4oznwbYt9Hsg
	pbSDIWyqgu11dZdVWetYyHreDGFbw5b7yYkZgttD/gobJEYMTeyekTtyen5JCVFK
	TfV8cPruS/XM7u9nzceN5adc2n2pMx6+cHfkWbI1NqDc6qHPrKmSg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44y82xgj4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Feb 2025 08:40:34 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51M7NhaA029303;
	Sat, 22 Feb 2025 08:40:34 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44w024vhnn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Feb 2025 08:40:33 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51M8eWGQ52756808
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Feb 2025 08:40:32 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E998D20040;
	Sat, 22 Feb 2025 08:40:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2A1520043;
	Sat, 22 Feb 2025 08:40:30 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.30.104])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 22 Feb 2025 08:40:30 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ext4: Make sb update interval tunable
Date: Sat, 22 Feb 2025 14:10:23 +0530
Message-ID: <86b177b0b0a863362f11afa3fd835c5734e14ef7.1740212945.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740212945.git.ojaswin@linux.ibm.com>
References: <cover.1740212945.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: r5ls7A3knZq5_2kGWlhOLssorDaZy5qE
X-Proofpoint-GUID: r5ls7A3knZq5_2kGWlhOLssorDaZy5qE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-22_03,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 mlxlogscore=702 spamscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502220066

Currently, outside error paths, we auto commit the super block after 1
hour has passed and 16MB worth of updates have been written since last
commit. This is a policy decision so make this tunable while keeping the
defaults same. This is useful if user wants to tweak the superblock
update behavior or for debugging the codepath by allowing to trigger it
more frequently.

We can now tweak the super block update using sb_update_sec and
sb_update_kb files in /sys/fs/ext4/<dev>/

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/ext4.h  |  9 +++++++++
 fs/ext4/super.c | 15 ++++++++-------
 fs/ext4/sysfs.c |  4 ++++
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 2b7d781bfcad..306e5db7129c 100644
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
@@ -2279,6 +2281,13 @@ static inline int ext4_forced_shutdown(struct super_block *sb)
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
index b7341e9acf62..129d666f450b 100644
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


