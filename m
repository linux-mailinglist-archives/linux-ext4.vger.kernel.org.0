Return-Path: <linux-ext4+bounces-6965-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22784A6D535
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Mar 2025 08:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5FBD1893458
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Mar 2025 07:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77312586E0;
	Mon, 24 Mar 2025 07:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cUGE5Ok0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D92259C83;
	Mon, 24 Mar 2025 07:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742801862; cv=none; b=Y7deNIWubPIX9EU9uQGQLqKtXkpmYDg73tsjwFLej5AFbT/9IX/jWCdEfBO4yPd1C91gpkV1vv3JPD1obwcw1QllFOZAUtIJWTQFohtGbcvAYDJ2gotdHEQa8+c+3UUoaL25PJyjEItOLmufP840S5AWzz/CIs2xOyGczaQIGaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742801862; c=relaxed/simple;
	bh=2BWHvwgYN1arVXgjKr7yqDlAI18r0MdfXrmwWeNBmbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9DRRG84yTVbfbhwwdpxTpr/eAene7ft0vRwPHG9rlJ0W7jGQodH+TV22baWh44FeRMN1VreRytFmB4cdLSFKEj8kfdUTaCo0iOH8zHH5ICMkMaVu6XaVO7pEURYhZRjJPPfoLueiYk6i1IYjlUf517rgP2104CZRhRKAvExVWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cUGE5Ok0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52NMIJfO024381;
	Mon, 24 Mar 2025 07:37:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=li3Z9XtwlzFVJsnd4
	9gv2urb/nH6TiB2FmItOK7AxGg=; b=cUGE5Ok0ZaW1o+HsizW3+zjTEOLSDpeei
	jnMK8Pmw4YN96ijT3O9FTPzK7+U/fN3jO5hdW7z/nboYtEaVdKhDl1W3QnMeuYCJ
	COgT36erGu5GiFA0AcC5oBDWgpgOaxJy4jdiMpxU+9hmCeBdxQcW8xzKosspNMGu
	lWPMZHHuDm4Ncm4RjKm0anRFLqtXHiqeZExyJnKQgv95p2Yf1tCnDpBfY3QlIqtv
	4V5I2haFDIT/YYoVbZAvkBgiVp+uXPPYoG03MQw4c34akLm1sgRMtstVFrnrB/dq
	qtECmXRe1U0fJ4xl1SuKtFSQc58l+qY23sYvLF3SOJ7WyvuR1mWQg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45jsh021fc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 07:37:33 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52O7bXZl005044;
	Mon, 24 Mar 2025 07:37:33 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45jsh021fa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 07:37:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52O75PSB030321;
	Mon, 24 Mar 2025 07:37:32 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j7ht5c50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 07:37:32 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52O7bUTm53412216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Mar 2025 07:37:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95BC12004B;
	Mon, 24 Mar 2025 07:37:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA57820040;
	Mon, 24 Mar 2025 07:37:28 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.29.200])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Mar 2025 07:37:28 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: John Garry <john.g.garry@oracle.com>, dchinner@redhat.com,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org
Subject: [RFC v3 08/11] ext4: add forcealign support of mballoc
Date: Mon, 24 Mar 2025 13:07:06 +0530
Message-ID: <18c0e6352a9d20bea37447e6500ecec4cae73614.1742800203.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1742800203.git.ojaswin@linux.ibm.com>
References: <cover.1742800203.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: M0hxVpSh9V6jyR9SjVOq-EEBlvxLKA-u
X-Proofpoint-GUID: srMiE8Wj2XeWYtxDmq1lgc_LejjvdSTT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_03,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=768 suspectscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503240053

Introduce an EXT4_MB_FORCE_ALIGN flag that essentially enforces the same
behavior as EXT4_MB_HINT_ALIGNED however the alignment requirements are no
longer a hint but must be respected. If the allocator can't return aligned
blocks, then ENOSPC will be thrown.

This will be eventually used to guarantee aligned blocks to perform H/W
accelerated atomic writes.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/ext4.h              |  2 ++
 fs/ext4/mballoc.c           | 31 +++++++++++++++++++++++--------
 include/trace/events/ext4.h |  1 +
 3 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index ab4f10f9031a..9b9d7a354736 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -224,6 +224,8 @@ enum criteria {
 #define EXT4_MB_CR_BEST_AVAIL_LEN_OPTIMIZED		0x00020000
 /* mballoc will try to align physical start to length (aka natural alignment) */
 #define EXT4_MB_HINT_ALIGNED	      	0x40000
+/* Same as HINT_ALIGNED but fail allocation if alginment can't be guaranteed */
+#define EXT4_MB_FORCE_ALIGN		0x80000
 
 struct ext4_allocation_request {
 	/* target inode for block we're allocating */
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index db7c593873a9..412aa80bc6e7 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2872,12 +2872,21 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 		ac->ac_criteria = cr;
 
 		if (ac->ac_criteria > CR_POWER2_ALIGNED &&
-		    ac->ac_flags & EXT4_MB_HINT_ALIGNED &&
 		    ac->ac_g_ex.fe_len > 1) {
-			ext4_warning_inode(
-				ac->ac_inode,
-				"Aligned allocation not possible, using unaligned allocation");
-			ac->ac_flags &= ~EXT4_MB_HINT_ALIGNED;
+			if (ac->ac_flags & EXT4_MB_FORCE_ALIGN) {
+				ext4_warning_inode(
+					ac->ac_inode,
+					"Aligned allocation not possible, failing allocation");
+				ac->ac_status = AC_STATUS_BREAK;
+				goto exit;
+			}
+
+			if (ac->ac_flags & EXT4_MB_HINT_ALIGNED) {
+				ext4_warning_inode(
+					ac->ac_inode,
+					"Aligned allocation not possible, using unaligned allocation");
+				ac->ac_flags &= ~EXT4_MB_HINT_ALIGNED;
+			}
 		}
 
 		/*
@@ -3023,9 +3032,15 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 			goto exit;
 		}
 
-		WARN_ON_ONCE(!is_power_of_2(len));
-		WARN_ON_ONCE(start % len);
-		WARN_ON_ONCE(ac->ac_b_ex.fe_len < ac->ac_o_ex.fe_len);
+		if (WARN_ON_ONCE(!is_power_of_2(len)) ||
+		    WARN_ON_ONCE(start % len) ||
+		    WARN_ON_ONCE(ac->ac_b_ex.fe_len < ac->ac_o_ex.fe_len)) {
+			/* FORCE_ALIGN should error out if aligned blocks can't be found */
+			if (ac->ac_flags & EXT4_MB_FORCE_ALIGN) {
+				ac->ac_status = AC_STATUS_BREAK;
+				goto exit;
+			}
+		}
 	}
 
  exit:
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index d9464ee764af..ebc1fb5ad57b 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -37,6 +37,7 @@ struct partial_cluster;
 	{ EXT4_MB_USE_ROOT_BLOCKS,	"USE_ROOT_BLKS" },	\
 	{ EXT4_MB_USE_RESERVED,		"USE_RESV" },		\
 	{ EXT4_MB_HINT_ALIGNED,		"HINT_ALIGNED" }, \
+	{ EXT4_MB_FORCE_ALIGN,		"FORCE_ALIGN" }, \
 	{ EXT4_MB_STRICT_CHECK,		"STRICT_CHECK" })
 
 #define show_map_flags(flags) __print_flags(flags, "|",			\
-- 
2.48.1


