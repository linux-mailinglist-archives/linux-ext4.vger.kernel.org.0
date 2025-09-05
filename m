Return-Path: <linux-ext4+bounces-9821-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4849DB4510C
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Sep 2025 10:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1C7B7AB537
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Sep 2025 08:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF212FFDE0;
	Fri,  5 Sep 2025 08:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FWyEfsS3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255703019B7;
	Fri,  5 Sep 2025 08:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757060115; cv=none; b=hfgeBAbTnuMAQjktiatkn4KQCrXpBwAGu/ao4QngSQDnzO84eOv37OSmGEyeBgqzoS6oNYm7L37p7ryXqRkvoy8H5hIqpMwzLtkyR8IoiOHAmEnfdW/DLOp2iZkY5ZiYLntBO5pZTLoH57MzmBSDcaZiZ8uAp6xgsbdyLyHPFN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757060115; c=relaxed/simple;
	bh=sm/TzjrAehkEUJaQufVHn5YoM2USZj2WUOJf4X0XQQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzNam1+AWI3B9h9HVmzwqKbvj/xveKVQueiGLMxhCk+b/kSM3mdULtnSuTTVm5bewbfrDx+nmcgtFW8JbIthYYZTvRDXv6n//ZQ6KPMZKUbqVgYuPX+S3n3Mu7SsRS4q3eTE7qsK7dXAdwYRh06o10d0b5ahN3qr792gPlDagsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FWyEfsS3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5856pQ2M011377;
	Fri, 5 Sep 2025 08:14:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WJGB95gX2Zofxj8Ia
	+KLEl69WUYf3/kubsB1SAz4ElY=; b=FWyEfsS3WzAFn/aqc9M35/HaScmjxEEvm
	SBagatKo6VvkLvyqMnprWa4r5vWY/LpQL7sBVFenChcA5wO4Hz6/V/TlmWp1lqpR
	RqiyXDJWZBoJ5GxB5b2Odss3kbWsmqcWB3hHSJ3MyU5C6qsZpu1x8r7Bns1Cwac+
	cgZUOYqmxgZyL15hbr+v13X5eGgVeHURnK4fREWcCbCFCS0oVme4H++6qKO9PEBc
	8pGiek9cWsKfojGGNAzYrPxAkQsvYrwuN/b5DhE4eYzTVBz2lWNhBXAUJ8gzDnwD
	FrQpxlgLTBFB0umHpmkQVBgA9wWXeIfQDlu1/hhUhsTcWa4Uuf1IA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usuaearf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 08:14:56 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5858EuOe004747;
	Fri, 5 Sep 2025 08:14:56 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usuaearb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 08:14:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58558Kaq019404;
	Fri, 5 Sep 2025 08:14:55 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48vd4n8edn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 08:14:55 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5858ErmL48628062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Sep 2025 08:14:53 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FD9D2004E;
	Fri,  5 Sep 2025 08:14:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFCC72004B;
	Fri,  5 Sep 2025 08:14:51 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.27.144])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Sep 2025 08:14:51 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        linux-kernel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH 1/2] ext4: Correctly handle queries for metadata mappings
Date: Fri,  5 Sep 2025 13:44:46 +0530
Message-ID: <023f37e35ee280cd9baac0296cbadcbe10995cab.1757058211.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-GUID: 7W_8CZXIMvu61FOfgH7_tqLM-Z7g2N1b
X-Authority-Analysis: v=2.4 cv=U6uSDfru c=1 sm=1 tr=0 ts=68ba9c00 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=yJojWOMRYYMA:10 a=GcyzOjIWAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=aYyh5IJWwJZTkH4q8vMA:9 a=P-ljAEOyBtQA:10 a=hQL3dl6oAZ8NdCsdz28n:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX9bVTc2nbTmUn
 VncM9sJc7VuD45kDhzOZPxJhTzgPGWgAHoBB3h4LPJH7lyFbIBMfmJ0R7uhTCHHDzBCYqBKfZ7y
 Km9eVZ2mC19efrwjKXaqJYcXbd2jjmeZaVpVl1SaA2/KIeW3/344tui/y/LlWOXIQkFdYyVpPPx
 kPXXSbEtlkzLwBWX4MYCB73bmZslvB7hslH9KIo46EY+RKgzkWqWztyqtw2/mt1tKThfHE32GTp
 agd/+iTK4ddNMezF0yhL6qjQTUULCI/jyQdeZKuuUvimeF8d5gPwMKLmZdKmYz7FzsP8yawZE7O
 6OQRr1BbzERmI1yjQZ4MndH8mArwKWftDWlvohnjCerirl/6EVd3cXHUVwb2EjjyjTfQ04Manjq
 +g76qZkD
X-Proofpoint-ORIG-GUID: c_pbiMSC9Gi3bcn5NSIR1XSKOVJH6ZBR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_02,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300034

Currently, our handling of metadata is _ambiguous_ in some scenarios,
that is, we end up returning unknown if the range only covers the
mapping partially.

For example, in the following case:

$ xfs_io -c fsmap -d

  0: 254:16 [0..7]: static fs metadata 8
  1: 254:16 [8..15]: special 102:1 8
  2: 254:16 [16..5127]: special 102:2 5112
  3: 254:16 [5128..5255]: special 102:3 128
  4: 254:16 [5256..5383]: special 102:4 128
  5: 254:16 [5384..70919]: inodes 65536
  6: 254:16 [70920..70967]: unknown 48
  ...

$ xfs_io -c fsmap -d 24 33

  0: 254:16 [24..39]: unknown 16  <--- incomplete reporting

$ xfs_io -c fsmap -d 24 33  (With patch)

    0: 254:16 [16..5127]: special 102:2 5112

This is because earlier in ext4_getfsmap_meta_helper, we end up ignoring
any extent that starts before our queried range, but overlaps it. While
the man page [1] is a bit ambiguous on this, this fix makes the output
make more sense since we are anyways returning an "unknown" extent. This
is also consistent to how XFS does it:

$ xfs_io -c fsmap -d

  ...
  6: 254:16 [104..127]: free space 24
  7: 254:16 [128..191]: inodes 64
  ...

$ xfs_io -c fsmap -d 137 150

  0: 254:16 [128..191]: inodes 64   <-- full extent returned

 [1] https://man7.org/linux/man-pages/man2/ioctl_getfsmap.2.html

Reported-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/fsmap.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
index 91185c40f755..22fc333244ef 100644
--- a/fs/ext4/fsmap.c
+++ b/fs/ext4/fsmap.c
@@ -74,7 +74,8 @@ static int ext4_getfsmap_dev_compare(const void *p1, const void *p2)
 static bool ext4_getfsmap_rec_before_low_key(struct ext4_getfsmap_info *info,
 					     struct ext4_fsmap *rec)
 {
-	return rec->fmr_physical < info->gfi_low.fmr_physical;
+	return rec->fmr_physical + rec->fmr_length <=
+	       info->gfi_low.fmr_physical;
 }
 
 /*
@@ -200,15 +201,18 @@ static int ext4_getfsmap_meta_helper(struct super_block *sb,
 			  ext4_group_first_block_no(sb, agno));
 	fs_end = fs_start + EXT4_C2B(sbi, len);
 
-	/* Return relevant extents from the meta_list */
+	/*
+	 * Return relevant extents from the meta_list. We emit all extents that
+	 * partially/fully overlap with the query range
+	 */
 	list_for_each_entry_safe(p, tmp, &info->gfi_meta_list, fmr_list) {
-		if (p->fmr_physical < info->gfi_next_fsblk) {
+		if (p->fmr_physical + p->fmr_length <= info->gfi_next_fsblk) {
 			list_del(&p->fmr_list);
 			kfree(p);
 			continue;
 		}
-		if (p->fmr_physical <= fs_start ||
-		    p->fmr_physical + p->fmr_length <= fs_end) {
+		if (p->fmr_physical <= fs_end &&
+		    p->fmr_physical + p->fmr_length > fs_start) {
 			/* Emit the retained free extent record if present */
 			if (info->gfi_lastfree.fmr_owner) {
 				error = ext4_getfsmap_helper(sb, info,
-- 
2.49.0


