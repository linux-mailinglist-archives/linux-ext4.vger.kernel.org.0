Return-Path: <linux-ext4+bounces-3788-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC2095822D
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Aug 2024 11:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D66CB1C2124E
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Aug 2024 09:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925FD18C004;
	Tue, 20 Aug 2024 09:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f7GPNB01"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6655A18B496;
	Tue, 20 Aug 2024 09:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724146050; cv=none; b=AR1w27KPykhV8H3GWwD0WoT7Z/SQ7B6o5t2aV6W03hp+HEI6zPn0GqdmRM3bEl4cobiOB2hhyfYOZZGUt/kLIjdH3uxDjXxR2yFwg5moi8mLI70gadnPtCyLDtYpwXd/CeeHvlbsTTYzVm6zrfg3J8l8XzQ9fcSfxvtrV6XBqfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724146050; c=relaxed/simple;
	bh=uyuHLa4E/0rICcL4LD+yki6xIF8s/9Fph2JEquPZDbk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vCfZpOWHTs2wZBzWOPLVq47qSiQzdFyQufU7J1YwSuWVyqDaSC3MY6xQu3qAcS5Kht5w6kLsnOIFuJBhZ7UjS7tLCVJ+Ne3ekSr7l9ytOK6KqIE/BHkeEAENz/7YLBFAQ/vUMsN4C9sLp4KeiPeRXxKWAc3+prR3A+L/BEYc8Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f7GPNB01; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47K1TQA2014557;
	Tue, 20 Aug 2024 09:27:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=Kd3HcJWgOPQRv5wiamNPLcU88D
	E0cWjveH6jN9IARIU=; b=f7GPNB01zoiF1QxRklKJsbHxtAIs5HJpQE19INArbs
	TnSz9e7TRt1s3C1nGXhmRBnw9eIBP8zowGzDuhGTErYOvpxfARlI8d8u0J3+lqwf
	B0ZdrC7x5e8eZptu5LxS8FhO7ZYiKUu5ZhzFqtEe12ML3v92YsA5QIW78CnDYaE/
	jD0hH7Xh/7eW+WGEQCYzcTVfr2wosYRxHzjzhizW5zh0PRKIvWGxJPlC1G8YGYEx
	gYsPle7fHVlg6HhpXR2a2igZEFZ2H8e8ule7qrbBp2eiBok93lif0PUqQOq6DIDu
	NBxdoqHV862axbhVedu6O+S5tk5z/h1n9UKk8N8L1qtA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mb5mxwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 09:27:20 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47K9RJDm005783;
	Tue, 20 Aug 2024 09:27:19 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mb5mxwn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 09:27:19 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47K5kGPN003097;
	Tue, 20 Aug 2024 09:27:18 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4136k0jbea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 09:27:18 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47K9REHR26083644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 09:27:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 180A920043;
	Tue, 20 Aug 2024 09:27:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DC4220040;
	Tue, 20 Aug 2024 09:27:12 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com.com (unknown [9.124.218.80])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 Aug 2024 09:27:11 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        syzbot+1ad8bac5af24d01e2cbd@syzkaller.appspotmail.com
Subject: [PATCH v2 1/2] ext4: Check stripe size compatibility on remount as well
Date: Tue, 20 Aug 2024 14:57:07 +0530
Message-ID: <f9042a87bfe883a3552c8fc561b2aa6f18de4f12.1724145714.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0fBOmfvPaHKEsGhcN6mbzmB7qnWZxeFY
X-Proofpoint-GUID: gwuZEippsdZ-eRwFWQTfx5KUsjPWju1D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408200066

We disable stripe size in __ext4_fill_super if it is not a multiple of
the cluster ratio however this check is missed when trying to remount.
This can leave us with cases where stripe < cluster_ratio after
remount:set making EXT4_B2C(sbi->s_stripe) become 0 that can cause some
unforeseen bugs like divide by 0.

Fix that by adding the check in remount path as well.

Reported-by: syzbot+1ad8bac5af24d01e2cbd@syzkaller.appspotmail.com
Tested-by: syzbot+1ad8bac5af24d01e2cbd@syzkaller.appspotmail.com
Reviewed-by: Kemeng Shi <shikemeng@huaweicloud.com>
Fixes: c3defd99d58c ("ext4: treat stripe in block unit")
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/super.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index e72145c4ae5a..9d495d78d262 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5165,6 +5165,18 @@ static int ext4_block_group_meta_init(struct super_block *sb, int silent)
 	return 0;
 }
 
+/*
+ * It's hard to get stripe aligned blocks if stripe is not aligned with
+ * cluster, just disable stripe and alert user to simpfy code and avoid
+ * stripe aligned allocation which will rarely successes.
+ */
+static bool ext4_is_stripe_incompatible(struct super_block *sb, unsigned long stripe)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	return (stripe > 0 && sbi->s_cluster_ratio > 1 &&
+		stripe % sbi->s_cluster_ratio != 0);
+}
+
 static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 {
 	struct ext4_super_block *es = NULL;
@@ -5272,13 +5284,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 		goto failed_mount3;
 
 	sbi->s_stripe = ext4_get_stripe_size(sbi);
-	/*
-	 * It's hard to get stripe aligned blocks if stripe is not aligned with
-	 * cluster, just disable stripe and alert user to simpfy code and avoid
-	 * stripe aligned allocation which will rarely successes.
-	 */
-	if (sbi->s_stripe > 0 && sbi->s_cluster_ratio > 1 &&
-	    sbi->s_stripe % sbi->s_cluster_ratio != 0) {
+	if (ext4_is_stripe_incompatible(sb, sbi->s_stripe)) {
 		ext4_msg(sb, KERN_WARNING,
 			 "stripe (%lu) is not aligned with cluster size (%u), "
 			 "stripe is disabled",
@@ -6441,6 +6447,15 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 
 	}
 
+	if ((ctx->spec & EXT4_SPEC_s_stripe) &&
+	    ext4_is_stripe_incompatible(sb, ctx->s_stripe)) {
+		ext4_msg(sb, KERN_WARNING,
+			 "stripe (%lu) is not aligned with cluster size (%u), "
+			 "stripe is disabled",
+			 ctx->s_stripe, sbi->s_cluster_ratio);
+		ctx->s_stripe = 0;
+	}
+
 	/*
 	 * Changing the DIOREAD_NOLOCK or DELALLOC mount options may cause
 	 * two calls to ext4_should_dioread_nolock() to return inconsistent
-- 
2.43.5


