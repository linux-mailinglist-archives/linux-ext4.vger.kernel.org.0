Return-Path: <linux-ext4+bounces-456-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1699F8146BA
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Dec 2023 12:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD186B238C7
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Dec 2023 11:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBA624B43;
	Fri, 15 Dec 2023 11:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cD+btg7f"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB7924B23;
	Fri, 15 Dec 2023 11:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFBHVaY011177;
	Fri, 15 Dec 2023 11:20:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=zIiV4BzwnifgXIlH+qgu+iNoGQS8N1PMOdoE1UYeSew=;
 b=cD+btg7fP12CqvNrp7916DCX1My6dj/Vmy64b6Ew4vE3G8UdmVOvvJZIIopHMlHpVe9z
 ha2OiiJOfcgl/GKxCPh5OG3hbNvnsHy17MW70KAgoG+0JAJ/3g9MJlx1Uxw8OVZ2jlVb
 UKaGECjH/rvt89CC7lQ2suw2xEQmiys+bWjescGDLAo/Ioqz6y2l20XuECuu9trk7rSW
 0mkfcxLeD67ltTJcZ0kSWpH5pr2AffQkBiLnngC6e6NOl17keIeVslRqQjtKogRl/ZVY
 WkU0RS9DnSyme8Kgv0EGcH11fCCpLs2E2TFhP2iOkBCb2g5STre4zOj0zCUjDmCc5ACJ pA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v0nstr2b2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 11:20:39 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BFBI5cF013198;
	Fri, 15 Dec 2023 11:20:38 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v0nstr2ac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 11:20:38 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFAdbII028201;
	Fri, 15 Dec 2023 11:20:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uw2y07q3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 11:20:37 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BFBKZtQ21693010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 11:20:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6709620049;
	Fri, 15 Dec 2023 11:20:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49F3C20040;
	Fri, 15 Dec 2023 11:20:24 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com.com (unknown [9.43.77.136])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 Dec 2023 11:20:20 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, glandvador@yahoo.com, bugzilla@eyal.emu.id.au
Subject: [PATCH 1/1] ext4: fallback to complex scan if aligned scan doesn't work
Date: Fri, 15 Dec 2023 16:49:50 +0530
Message-Id: <ee033f6dfa0a7f2934437008a909c3788233950f.1702455010.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1702455010.git.ojaswin@linux.ibm.com>
References: <cover.1702455010.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hgJo6u-o_zxmBj87-5KC5-obBzWSlJwh
X-Proofpoint-GUID: I4CQQhNYIZI_Ne1ZQFvI_xdifZ4RGOCW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_06,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312150073

Currently in case the goal length is a multiple of stripe size we use
ext4_mb_scan_aligned() to find the stripe size aligned physical blocks.
In case we are not able to find any, we again go back to calling
ext4_mb_choose_next_group() to search for a different suitable block
group. However, since the linear search always begins from the start,
most of the times we end up with the same BG and the cycle continues.

With large fliesystems, the CPU can be stuck in this loop for hours
which can slow down the whole system. Hence, until we figure out a
better way to continue the search (rather than starting from beginning)
in ext4_mb_choose_next_group(), lets just fallback to
ext4_mb_complex_scan_group() in case aligned scan fails, as it is much
more likely to find the needed blocks.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/mballoc.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index d72b5e3c92ec..63f12ec02485 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2895,14 +2895,19 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 			ac->ac_groups_scanned++;
 			if (cr == CR_POWER2_ALIGNED)
 				ext4_mb_simple_scan_group(ac, &e4b);
-			else if ((cr == CR_GOAL_LEN_FAST ||
-				 cr == CR_BEST_AVAIL_LEN) &&
-				 sbi->s_stripe &&
-				 !(ac->ac_g_ex.fe_len %
-				 EXT4_B2C(sbi, sbi->s_stripe)))
-				ext4_mb_scan_aligned(ac, &e4b);
-			else
-				ext4_mb_complex_scan_group(ac, &e4b);
+			else {
+				bool is_stripe_aligned = sbi->s_stripe &&
+					!(ac->ac_g_ex.fe_len %
+					  EXT4_B2C(sbi, sbi->s_stripe));
+
+				if ((cr == CR_GOAL_LEN_FAST ||
+				     cr == CR_BEST_AVAIL_LEN) &&
+				    is_stripe_aligned)
+					ext4_mb_scan_aligned(ac, &e4b);
+
+				if (ac->ac_status == AC_STATUS_CONTINUE)
+					ext4_mb_complex_scan_group(ac, &e4b);
+			}
 
 			ext4_unlock_group(sb, group);
 			ext4_mb_unload_buddy(&e4b);
-- 
2.39.3


