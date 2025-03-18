Return-Path: <linux-ext4+bounces-6897-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D754BA66CED
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Mar 2025 08:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80B4918870B4
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Mar 2025 07:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360821B81C1;
	Tue, 18 Mar 2025 07:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p+kc3K2I"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277CB17A309;
	Tue, 18 Mar 2025 07:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742284395; cv=none; b=by78oyHxR+w45G28GFeEhFUldrj5g8dlVz5QcHnMiiDg/AA+oxm5U4z3hRPcwRWIwD3nlGw+5mO+0E11eTr0U2/uoqUf4iGqEQaf6c6Uo3CBPnnJdBQs5r+yLWvoAkb4gN1QdOaunOmA90LSJeEeHTKXskUs9BnO0MeRs4QPaps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742284395; c=relaxed/simple;
	bh=x7BXdSVLCZ9prubKlcxU1630G6pWR58zvwh6ud9R79A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SU3EbYQJnyPB9reOQlogjWgy8cGkYun83t6Q1IPoNct7Al0jrrLBqA+wz9Y8Oim6saPRd+SNwwoN6atolhGwOHkfrOzezN9UkR2DATznMe9v/oON0iJm/HOjwaqu1A4Zb7V/gFk6umV2dQFEacF6p8y3FY1FgdwKqaRhS3SRS7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p+kc3K2I; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52HKcU1W032512;
	Tue, 18 Mar 2025 07:53:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=/gXFWGrY4KYSmgB2yt7zalQCkE7kMVIElamnYSN3B
	Zo=; b=p+kc3K2IZGi9mWqs/uNgnRN6LIbS1x2gIsUzMNqAKNhmwbCC/1q8K8D6R
	SakIO6lmLYSOYijR926cuIg1BaI9m+9KRIMTQKB6QTaPrzIHEyX394w6ubUrhtJk
	Wn+6BGSJ5hQZDRelmtdOpxwf/5u/+prFiD8C0U6kQePDCgZQAq8bHf8YOquTSKdz
	CzyvdndguTTIq7IfbX7dzDBVvWFyOH0QWwZ9FjSTC+fQ/DxSwFU5a82WblPvDJca
	wZpz455vF4uE35bicg28BAOEIiuc1mFS49eLn2/grLZDAGOFLO6LBchBqPw07C8W
	bkN/Xb0U3VlmQ/nkBf9W46EVRDbqg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45ety0j9yb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 07:53:06 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52I7qT7N027240;
	Tue, 18 Mar 2025 07:53:05 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45ety0j9y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 07:53:05 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52I50RQR005734;
	Tue, 18 Mar 2025 07:53:04 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dpk2a9q9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 07:53:04 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52I7r3kv59638128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 07:53:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32B7220043;
	Tue, 18 Mar 2025 07:53:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB4D920040;
	Tue, 18 Mar 2025 07:52:59 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.27.85])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Mar 2025 07:52:59 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] Fix a BUG_ON crashing the kernel in start_this_handle
Date: Tue, 18 Mar 2025 13:22:54 +0530
Message-ID: <cover.1742279837.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: s-JIfOmI8dFu8-rAjO410dx3SecD80ww
X-Proofpoint-ORIG-GUID: PnHapz77cvmGy5sfYCOUajPIk0xrkPpC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_03,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 suspectscore=0 mlxlogscore=953
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503180052

** Changes in v4 [4] **

  * some minor refactoring and typo fix

[4] https://lore.kernel.org/linux-ext4/cover.1741938027.git.ojaswin@linux.ibm.com/T/#m8b5191fef8b201246ab5b34f7dc11b79fe6afe99

** Changes in v3 [3] **

 * Picked RVBs from Jan and Baokun
 * In patch 2/3 we now do the following:
   set flag -> force commit -> flush wq
 * use sbi->s_mount_flags instead of an
   sbi field for journal destroy flag

[3] https://lore.kernel.org/linux-ext4/Z86b0c_qTURBBkOW@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com/T/#m3a6c2e9205381d86460267e7be37ae0db688b800

** Changes in v2 [1] **

 * Picked up RVBs from Jan and Ritesh
 * In patch 2/3, we now use a flag in sbi instead of SB_ACITVE
   to determine when to journal sb vs when to commit directly.
 * Added a prep patch 1/3

[1] https://lore.kernel.org/linux-ext4/cover.1740212945.git.ojaswin@linux.ibm.com/T/#m5e659425b8c8fe2ac01e7242b77fed315ff89db4

@Baokun, I didn't get a chance to look into the journal_inode
modifications we were discussing in [2]. I'll try to spend some time and
send that as a separate patch. Hope that's okay

[2] https://lore.kernel.org/linux-ext4/cover.1740212945.git.ojaswin@linux.ibm.com/T/#mad8feb44d9b6ddadf87830b92caa7b78d902dc05
 
** Original Cover **

When running LTP stress tests on ext4, after a multiday run we seemed to
have hit the following BUG_ON:

 [NIP  : start_this_handle+268]
 #3 [c000001067c27a40] start_this_handle at c008000004d40f74 [jbd2]  (unreliable)
 #4 [c000001067c27b60] jbd2__journal_start at c008000004d415cc [jbd2]
 #5 [c000001067c27be0] update_super_work at c0080000053f9758 [ext4]
 #6 [c000001067c27c70] process_one_work at c000000000188790
 #7 [c000001067c27d20] worker_thread at c00000000018973c
 #8 [c000001067c27dc0] kthread at c000000000196c84
 #9 [c000001067c27e10] ret_from_kernel_thread at c00000000000cd64

Which comes out to

  382   repeat:
  383           read_lock(&journal->j_state_lock);
* 384           BUG_ON(journal->j_flags & JBD2_UNMOUNT);
  385           if (is_journal_aborted(journal) ||
  386               (journal->j_errno != 0 && !(journal->j_flags & JBD2_ACK_ERR))) {
  387                   read_unlock(&journal->j_state_lock);


Initially this seemed like it should never happen but upon crash
analysis it seems like it could indeed be hit as described in patch 1/2.

I would like to add that through the logs we only knew that:

- ext4_journal_bmap -> ext4_map_blocks is failing with EFSCORRUPTED.
- update_super_work had hit the BUG_ON

I was not able to hit this bug again (without modifying the kernel to
inject errors) but the above backtrace seems to be one possible paths
where this BUG_ON can be hit. Rest of the analysis and fix is in patch
2/3. Patch 3 is just a small tweak that i found helpful while debugging.

That being said, journalling is something I'm not very familiar with and
there might be gaps in my understanding so thoughts and suggestions are
welcome.


Ojaswin Mujoo (3):
  ext4: define ext4_journal_destroy wrapper
  ext4: avoid journaling sb update on error if journal is destroying
  ext4: Make sb update interval tunable

 fs/ext4/ext4.h      | 12 +++++++++++-
 fs/ext4/ext4_jbd2.h | 29 ++++++++++++++++++++++++++++
 fs/ext4/super.c     | 47 +++++++++++++++++++++------------------------
 fs/ext4/sysfs.c     |  4 ++++
 4 files changed, 66 insertions(+), 26 deletions(-)

-- 
2.48.1


