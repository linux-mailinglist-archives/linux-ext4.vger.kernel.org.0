Return-Path: <linux-ext4+bounces-6798-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C01F3A60A3A
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Mar 2025 08:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1774E3A2AA1
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Mar 2025 07:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAA31898ED;
	Fri, 14 Mar 2025 07:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HUVpZhLj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1075F1519B0;
	Fri, 14 Mar 2025 07:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741938278; cv=none; b=j4C2THAnFaFNcAyHhk3A5GkwjnYFw9NlJwa93mUD2KET+hAPKuSlQpRTBxD4NjsO8Lxl1X17Zewt4f3xiYZUYERwp6K3tcCHqlvXsVIYMMLzi2DdCHq6mKFPy/HTUbOB5rYA83Rhsu8DZ/ZVyoF/1MI0ojiMq5GQCJGOrVVQ7ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741938278; c=relaxed/simple;
	bh=6WbkmCGvrc6kAX4NXuaifadcZdcD9FoFIjvoPYwJ8nA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=trXj5ACq9TZdGAjLUPDMjP3/kIouOVXI0LhpafUJO6ZJdhbStR2dXmEaaNCa/4GcJYo4e9OUVLe+dExEBKrGrM+I1Sn3KTmEVr9DWbo+ElK1kbqA9C5I1yeK/FFTEG0IvoRNnHMXSJ4huE13BCiPNKVnLbo+nYkGjd+hBGSiZX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HUVpZhLj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DNOwwA018106;
	Fri, 14 Mar 2025 07:44:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=AM75vNikby5nBoUvo
	tgh7VAbZ5edQqh/5gUJk8S84lM=; b=HUVpZhLjRa7G5ejZ6ahjmKPkp5ZV2rPp6
	JxeIdWCXU6EHM1zEY0hx1oAqP/pW/6wrh74NVxj3J5GzySRY8Dr7/xC798jlRGeR
	kp3fEj2YQWQBw4sw10D0nXqC1PcBk/ujNYL9zqKdwX5DjllXimdsBHpBhRjKo3KN
	Gpin+qOxD125tu66MJ1ldHUlV6DOLO+YTxEfM1H/T1AK99JPKbwbRyOYLDjVqpkV
	GFEb74L6E2pw1Ff+y9W/BAUn1Y8deEuMVH3+TeYUGW/2Yx2XLlNwL2SuzvpUqbKP
	QvyW4M0sGpMSUM4mUeWv4upZ64ELTCrKM8Bo/7+5vht0Np7SUS9lQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c0srcd5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 07:44:24 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52E7a8M5021189;
	Fri, 14 Mar 2025 07:44:24 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c0srcd5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 07:44:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52E4xDh9007490;
	Fri, 14 Mar 2025 07:44:23 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45atsrdtk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 07:44:23 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52E7iLPG59703802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Mar 2025 07:44:21 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DCB02004F;
	Fri, 14 Mar 2025 07:44:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF01720043;
	Fri, 14 Mar 2025 07:44:17 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.24.194])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Mar 2025 07:44:17 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] ext4: define ext4_journal_destroy wrapper
Date: Fri, 14 Mar 2025 13:14:09 +0530
Message-ID: <c3ba78c5c419757e6d5f2d8ebb4a8ce9d21da86a.1741938027.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 86JhofC1LIXamunn2-D5xiFztrcQOoiT
X-Proofpoint-GUID: S9wgm-NnKADsNFRVQUrnUt94oheQLyCQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_03,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=743 mlxscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503140058

Define an ext4 wrapper over jbd2_journal_destroy to make sure we
have consistent behavior during journal destruction. This will also
come useful in the next patch where we add some ext4 specific logic
in the destroy path.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Baokun Li <libaokun1@huawei.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/ext4_jbd2.h | 14 ++++++++++++++
 fs/ext4/super.c     | 16 ++++++----------
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 3f2596c9e5f2..9b3c9df02a39 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -429,4 +429,18 @@ static inline int ext4_should_dioread_nolock(struct inode *inode)
 	return 1;
 }
 
+/*
+ * Pass journal explicitly as it may not be cached in the sbi->s_journal in some
+ * cases
+ */
+static inline int ext4_journal_destroy(struct ext4_sb_info *sbi, journal_t *journal)
+{
+	int err = 0;
+
+	err = jbd2_journal_destroy(journal);
+	sbi->s_journal = NULL;
+
+	return err;
+}
+
 #endif	/* _EXT4_JBD2_H */
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index a963ffda692a..8ad664d47806 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1297,8 +1297,7 @@ static void ext4_put_super(struct super_block *sb)
 
 	if (sbi->s_journal) {
 		aborted = is_journal_aborted(sbi->s_journal);
-		err = jbd2_journal_destroy(sbi->s_journal);
-		sbi->s_journal = NULL;
+		err = ext4_journal_destroy(sbi, sbi->s_journal);
 		if ((err < 0) && !aborted) {
 			ext4_abort(sb, -err, "Couldn't clean up the journal");
 		}
@@ -4960,8 +4959,7 @@ static int ext4_load_and_init_journal(struct super_block *sb,
 out:
 	/* flush s_sb_upd_work before destroying the journal. */
 	flush_work(&sbi->s_sb_upd_work);
-	jbd2_journal_destroy(sbi->s_journal);
-	sbi->s_journal = NULL;
+	ext4_journal_destroy(sbi, sbi->s_journal);
 	return -EINVAL;
 }
 
@@ -5652,8 +5650,7 @@ failed_mount8: __maybe_unused
 	if (sbi->s_journal) {
 		/* flush s_sb_upd_work before journal destroy. */
 		flush_work(&sbi->s_sb_upd_work);
-		jbd2_journal_destroy(sbi->s_journal);
-		sbi->s_journal = NULL;
+		ext4_journal_destroy(sbi, sbi->s_journal);
 	}
 failed_mount3a:
 	ext4_es_unregister_shrinker(sbi);
@@ -5958,7 +5955,7 @@ static journal_t *ext4_open_dev_journal(struct super_block *sb,
 	return journal;
 
 out_journal:
-	jbd2_journal_destroy(journal);
+	ext4_journal_destroy(EXT4_SB(sb), journal);
 out_bdev:
 	bdev_fput(bdev_file);
 	return ERR_PTR(errno);
@@ -6075,8 +6072,7 @@ static int ext4_load_journal(struct super_block *sb,
 	EXT4_SB(sb)->s_journal = journal;
 	err = ext4_clear_journal_err(sb, es);
 	if (err) {
-		EXT4_SB(sb)->s_journal = NULL;
-		jbd2_journal_destroy(journal);
+		ext4_journal_destroy(EXT4_SB(sb), journal);
 		return err;
 	}
 
@@ -6094,7 +6090,7 @@ static int ext4_load_journal(struct super_block *sb,
 	return 0;
 
 err_out:
-	jbd2_journal_destroy(journal);
+	ext4_journal_destroy(EXT4_SB(sb), journal);
 	return err;
 }
 
-- 
2.48.1


