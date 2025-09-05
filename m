Return-Path: <linux-ext4+bounces-9822-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31623B45112
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Sep 2025 10:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7F38485802
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Sep 2025 08:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D0F3043B4;
	Fri,  5 Sep 2025 08:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T8Q+Kfqy"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC593043D1;
	Fri,  5 Sep 2025 08:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757060119; cv=none; b=D4WQwnCp1UXDQ17yktkYjgbgbr24Oyl9VF2wBOb2xH64kZSgiEpdqiqLW4RPhW6Vi9jDmhR8iGYXe1O6WWjT7f5PGmcmCM4TKn+oLobpfReAqf8yH1gGTHXjtxMdDXljIaMKFth0nXwsYo5n81X+ZH7iRQ2RnHsHlcfksC8BQy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757060119; c=relaxed/simple;
	bh=dGl3HPk4ea6xcz1AY9xoYbL2hRSpczO81jV7mfFdqyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SChvX6nlD2J/A5Omt8Lgvg8dTChdOOnKe2VDGAZQOSAcqklGVI1i+j4cCfdZQVK1zs62mAAxOuOyOmL1aCeBLKZY8xFO0jIQ/8cfcakYhk65IuU6JhKTZDGlbJ84K6321jEzKAwZztYiZGvBS54H0CXkfTrLJZKmU+TVvlpzFRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T8Q+Kfqy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5857q0fN000693;
	Fri, 5 Sep 2025 08:14:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=tXHNtHbn1eNK0FlZE
	95i5qXhKjyxOQpxjAPzGwb8hhE=; b=T8Q+KfqyRgTbSXDzG5hx7oeHciyJ8ct/l
	tzN5SEp+WvaZWS9ynuURmbQKv+uEdB8fBrONKDLiSaDO9Y16ufFSWlpCMMAEJgBL
	pFncCOPE3eda7qhsyqYjboOPxNjV6kCldIFQd0yEDKZkFUsgNWSxAi1P0rE22KVH
	fq2AdXh1kOeHJlkLr4Ac2mc20YL8i8YQo8rR/sLoZUgTdSMXr/TrmXCSuMYd8WMA
	+qrMLPto955Tzr6MavbC7dkGFhv/fqRc08/IpSfYPq4iOSm9+Hgpw7yD8bMgy/VI
	CFQTroIkxlqBp7nZ8kDUe45bJfEWWZr86VrvVb/GvFZYMQQoGfFxw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48wshfajh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 08:14:58 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58587gUe000714;
	Fri, 5 Sep 2025 08:14:58 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48wshfajgx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 08:14:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5855YZQW019331;
	Fri, 5 Sep 2025 08:14:57 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48vd4n8edw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 08:14:57 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5858EteO18743792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Sep 2025 08:14:55 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B8B02004E;
	Fri,  5 Sep 2025 08:14:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C315C2004B;
	Fri,  5 Sep 2025 08:14:53 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.27.144])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Sep 2025 08:14:53 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        linux-kernel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH 2/2] fsmap: use blocksize units instead of cluster units
Date: Fri,  5 Sep 2025 13:44:47 +0530
Message-ID: <d332ed2f90a0c8533139741d25e7fc1935773e14.1757058211.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1757058211.git.ojaswin@linux.ibm.com>
References: <cover.1757058211.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QuBKTN1BuvLfJlVwgvUEdxckXIIn9pVo
X-Authority-Analysis: v=2.4 cv=do3bC0g4 c=1 sm=1 tr=0 ts=68ba9c02 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=dPYBfUDpcxx5Ehpc6mMA:9
X-Proofpoint-ORIG-GUID: RNbF0Ua0YLOdPSlSzHWyyMkt1q7j7HoA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAyMDA0MCBTYWx0ZWRfX49T+ikf78h6B
 eiRaF+GWoxrOYjnpwrtbCpNqc2CBv5dStP5lUfO1V6R7mOPVQ2GpEywknulH1FVIW9TDxpnlhR8
 VAoqxg3E4uZ66Y2M2tDtWecLvRPer4wuI8heRhcGw09PdflG9RXKvRtYjiGyetVxD5aZ+fIaZB6
 VgXhGaAZ0x2tcSMd7deHn9WUm1lGT2etsQghh3QGvlaBS0Dx5WwznukGultsxO5GRG099YZBNLY
 GOL2vmz/Jc0f48ITFqMxJbBXirQX4+uBWdAF7wuSBUizWQBlmEPkf4htcROpiwIS/TQXJN8wuVx
 Nih4YbE8mL698+lWGJ5gxt6Kk4nnkkQajtq5Kqzelg6lK1IiaIkMxs6Wc23A2fQUhj2vrLdt0Au
 ofzWMyjx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_02,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509020040

Currently, ext4's implementation of fsmap converts the ranges to cluster
units if bigalloc is enabled and then converts to block units whenever
needed. However, this back and forth conversion has known to cause
several edge case issues since even with bigalloc the metadata is still
in block size unit.

Hence, convert the code to use block size instead of cluster size.
Cluster size is only used when dealing with mballoc bitmap. This takes
care of the existing issues with the code, example, for a mapping as
follows:

xfs_io -c fsmap -d (bs=4096, clustersize=65536)

   0: 254:16 [0..7]: static fs metadata 8
   1: 254:16 [8..15]: special 102:1 8
   2: 254:16 [16..327]: special 102:2 312
   3: 254:16 [328..351]: special 102:3 24
   4: 254:16 [352..375]: special 102:4 24
   ...

xfs_io -c fsmap -d 6 16 (before this patch):

   0: 254:16 [0..7]: static fs metadata 8
   1: 254:16 [8..23]: unknown 16       <--- incorrect/ambiguous entry

xfs_io -c fsmap -d 6 16 (after this patch):

   0: 254:16 [0..7]: static fs metadata 8
   1: 254:16 [8..15]: special 102:1 8
   2: 254:16 [16..327]: special 102:2 312

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/fsmap.c   | 42 +++++++++++++++++++++++-------------------
 fs/ext4/mballoc.c | 25 +++++++++++++++++--------
 2 files changed, 40 insertions(+), 27 deletions(-)

diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
index 22fc333244ef..02e5d501dda8 100644
--- a/fs/ext4/fsmap.c
+++ b/fs/ext4/fsmap.c
@@ -193,13 +193,11 @@ static int ext4_getfsmap_meta_helper(struct super_block *sb,
 	struct ext4_getfsmap_info *info = priv;
 	struct ext4_fsmap *p;
 	struct ext4_fsmap *tmp;
-	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	ext4_fsblk_t fsb, fs_start, fs_end;
 	int error;
 
-	fs_start = fsb = (EXT4_C2B(sbi, start) +
-			  ext4_group_first_block_no(sb, agno));
-	fs_end = fs_start + EXT4_C2B(sbi, len);
+	fs_start = fsb =  start + ext4_group_first_block_no(sb, agno);
+	fs_end = fs_start + len;
 
 	/*
 	 * Return relevant extents from the meta_list. We emit all extents that
@@ -248,13 +246,12 @@ static int ext4_getfsmap_datadev_helper(struct super_block *sb,
 	struct ext4_getfsmap_info *info = priv;
 	struct ext4_fsmap *p;
 	struct ext4_fsmap *tmp;
-	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	ext4_fsblk_t fsb;
 	ext4_fsblk_t fslen;
 	int error;
 
-	fsb = (EXT4_C2B(sbi, start) + ext4_group_first_block_no(sb, agno));
-	fslen = EXT4_C2B(sbi, len);
+	fsb = start + ext4_group_first_block_no(sb, agno);
+	fslen = len;
 
 	/* If the retained free extent record is set... */
 	if (info->gfi_lastfree.fmr_owner) {
@@ -531,13 +528,13 @@ static int ext4_getfsmap_datadev(struct super_block *sb,
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	ext4_fsblk_t start_fsb;
-	ext4_fsblk_t end_fsb;
+	ext4_fsblk_t end_fsb, orig_end_fsb;
 	ext4_fsblk_t bofs;
 	ext4_fsblk_t eofs;
 	ext4_group_t start_ag;
 	ext4_group_t end_ag;
-	ext4_grpblk_t first_cluster;
-	ext4_grpblk_t last_cluster;
+	ext4_grpblk_t first_grpblk;
+	ext4_grpblk_t last_grpblk;
 	struct ext4_fsmap irec;
 	int error = 0;
 
@@ -553,10 +550,18 @@ static int ext4_getfsmap_datadev(struct super_block *sb,
 		return 0;
 	start_fsb = keys[0].fmr_physical;
 	end_fsb = keys[1].fmr_physical;
+	orig_end_fsb = end_fsb;
 
-	/* Determine first and last group to examine based on start and end */
-	ext4_get_group_no_and_offset(sb, start_fsb, &start_ag, &first_cluster);
-	ext4_get_group_no_and_offset(sb, end_fsb, &end_ag, &last_cluster);
+	/*
+	 * Determine first and last group to examine based on start and end.
+	 * NOTE: do_div() should take ext4_fsblk_t instead of ext4_group_t as
+	 * first argument else it will fail on 32bit archs.
+	 */
+	first_grpblk = do_div(start_fsb, EXT4_BLOCKS_PER_GROUP(sb));
+	last_grpblk = do_div(end_fsb, EXT4_BLOCKS_PER_GROUP(sb));
+
+	start_ag = start_fsb;
+	end_ag = end_fsb;
 
 	/*
 	 * Convert the fsmap low/high keys to bg based keys.  Initialize
@@ -564,7 +569,7 @@ static int ext4_getfsmap_datadev(struct super_block *sb,
 	 * of the bg.
 	 */
 	info->gfi_low = keys[0];
-	info->gfi_low.fmr_physical = EXT4_C2B(sbi, first_cluster);
+	info->gfi_low.fmr_physical = first_grpblk;
 	info->gfi_low.fmr_length = 0;
 
 	memset(&info->gfi_high, 0xFF, sizeof(info->gfi_high));
@@ -584,8 +589,7 @@ static int ext4_getfsmap_datadev(struct super_block *sb,
 		 */
 		if (info->gfi_agno == end_ag) {
 			info->gfi_high = keys[1];
-			info->gfi_high.fmr_physical = EXT4_C2B(sbi,
-					last_cluster);
+			info->gfi_high.fmr_physical = last_grpblk;
 			info->gfi_high.fmr_length = 0;
 		}
 
@@ -600,8 +604,8 @@ static int ext4_getfsmap_datadev(struct super_block *sb,
 				info->gfi_high.fmr_owner);
 
 		error = ext4_mballoc_query_range(sb, info->gfi_agno,
-				EXT4_B2C(sbi, info->gfi_low.fmr_physical),
-				EXT4_B2C(sbi, info->gfi_high.fmr_physical),
+				info->gfi_low.fmr_physical,
+				info->gfi_high.fmr_physical,
 				ext4_getfsmap_meta_helper,
 				ext4_getfsmap_datadev_helper, info);
 		if (error)
@@ -627,7 +631,7 @@ static int ext4_getfsmap_datadev(struct super_block *sb,
 	 * any allocated blocks at the end of the range.
 	 */
 	irec.fmr_device = 0;
-	irec.fmr_physical = end_fsb + 1;
+	irec.fmr_physical = orig_end_fsb + 1;
 	irec.fmr_length = 0;
 	irec.fmr_owner = EXT4_FMR_OWN_FREE;
 	irec.fmr_flags = 0;
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 5898d92ba19f..cf78776940dd 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -7117,6 +7117,8 @@ ext4_mballoc_query_range(
 	ext4_grpblk_t			start, next;
 	struct ext4_buddy		e4b;
 	int				error;
+	struct ext4_sb_info 		*sbi = EXT4_SB(sb);
+	ext4_grpblk_t 			start_c, end_c, next_c;
 
 	error = ext4_mb_load_buddy(sb, group, &e4b);
 	if (error)
@@ -7125,9 +7127,9 @@ ext4_mballoc_query_range(
 
 	ext4_lock_group(sb, group);
 
-	start = max(e4b.bd_info->bb_first_free, first);
-	if (end >= EXT4_CLUSTERS_PER_GROUP(sb))
-		end = EXT4_CLUSTERS_PER_GROUP(sb) - 1;
+	start = max(EXT4_C2B(sbi, e4b.bd_info->bb_first_free), first);
+	if (end >= EXT4_BLOCKS_PER_GROUP(sb))
+		end = EXT4_BLOCKS_PER_GROUP(sb) - 1;
 	if (meta_formatter && start != first) {
 		if (start > end)
 			start = end;
@@ -7138,19 +7140,26 @@ ext4_mballoc_query_range(
 			goto out_unload;
 		ext4_lock_group(sb, group);
 	}
-	while (start <= end) {
-		start = mb_find_next_zero_bit(bitmap, end + 1, start);
-		if (start > end)
+
+	start_c = EXT4_B2C(sbi, start);
+	end_c = EXT4_B2C(sbi, end);
+
+	while (start_c <= end_c) {
+		start_c = mb_find_next_zero_bit(bitmap, end_c + 1, start_c);
+		if (start_c > end_c)
 			break;
-		next = mb_find_next_bit(bitmap, end + 1, start);
+		next_c = mb_find_next_bit(bitmap, end_c + 1, start_c);
 
 		ext4_unlock_group(sb, group);
+
+		start = EXT4_C2B(sbi, start_c);
+		next = EXT4_C2B(sbi, next_c);
 		error = formatter(sb, group, start, next - start, priv);
 		if (error)
 			goto out_unload;
 		ext4_lock_group(sb, group);
 
-		start = next + 1;
+		start_c = next_c + 1;
 	}
 
 	ext4_unlock_group(sb, group);
-- 
2.49.0


