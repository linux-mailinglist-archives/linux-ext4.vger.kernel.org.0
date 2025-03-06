Return-Path: <linux-ext4+bounces-6688-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA35A54DC7
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Mar 2025 15:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 320DE3B281C
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Mar 2025 14:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB3A16C687;
	Thu,  6 Mar 2025 14:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GdVMkld5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B7F17BEBF;
	Thu,  6 Mar 2025 14:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741271332; cv=none; b=GsfNxBzjQLZB+wf/GDYA5Y4A2POZdM9b8LvWwlsXgosR8/HWz8z7ueSwQw0RFVRJ6bY0Z3/wmnBdV8OUflMxS2xdhRvf6mMycYYruABzpQPQPDtt9jDWcUp2GizREigffRniaUM2Wd4Twx+qjsi0CiNSocg2gxSMifRXC+YfLH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741271332; c=relaxed/simple;
	bh=VsEHTryIvSCPfyyGMRqkYROKP7sRwl209LDHew4UU1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ioXPQP+0DDz22a1W6VNIh3IJv4Yw09zjrBJS+g4wNBNw7NFwlcsSuqX1b+8DB+FiEbxoBVaavslIRjRxCfl2Hfo3Y05ZmPzb2TOdQmBnF0jCnNvWI7Zokrv1EWALFOFkk+kkAwBx2P17JMUC0poGmXAfGBSYoDKoZtFllO/ephw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GdVMkld5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5269UdMX028465;
	Thu, 6 Mar 2025 14:28:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=0Ex4FGZjL2uJXW0TEhQ5OqQtiGEib/q9COn03voWG
	ks=; b=GdVMkld5S0kcWWLpM8chCx3RwE4idV+jeZUUoyKw8u0OVMWBOAR+kynXH
	/GXpqGHBymzyaAcAsMJ/EpJyJuG133tzIaX78P91kPbxQUTTu4ESncPWrVEt0ji1
	yB08svji32Uegb9rr3tNL/PEHE02unLBVYFDscs7rxI6Qg10iGJrybLNt2uc9nOy
	sXDh0qQN/jG1TilM2Fy0ynxNUzQXTPMOC2L/O8XV5Ao9sbhaYKosG3u0fWbRzlvD
	SmIrqgWL+91fELV2rWmBbhnk6sFZ3sPmIRwKsWOTGHznNwhIyeCDt3xPIe3REhUo
	TGJHOdv3rIQ+eI47/yPRHh9vtg+qw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 456wu04b7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 14:28:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 526DhYTj020800;
	Thu, 6 Mar 2025 14:28:39 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 454esk8uxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 14:28:39 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 526ESbEi46399834
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Mar 2025 14:28:37 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A928B20049;
	Thu,  6 Mar 2025 14:28:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5320E20040;
	Thu,  6 Mar 2025 14:28:36 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.in.ibm.com (unknown [9.109.219.249])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Mar 2025 14:28:36 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Fix a BUG_ON crashing the kernel in start_this_handle
Date: Thu,  6 Mar 2025 19:58:31 +0530
Message-ID: <cover.1741270780.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vWuTaPUW8JQ_YP2kaWVI8lzSS7tM3Gg4
X-Proofpoint-ORIG-GUID: vWuTaPUW8JQ_YP2kaWVI8lzSS7tM3Gg4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0
 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=892 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503060110

** Changes since v1 [1] **

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

 fs/ext4/ext4.h      | 11 +++++++++++
 fs/ext4/ext4_jbd2.h | 22 ++++++++++++++++++++++
 fs/ext4/super.c     | 35 +++++++++++++++++------------------
 fs/ext4/sysfs.c     |  4 ++++
 4 files changed, 54 insertions(+), 18 deletions(-)

-- 
2.48.1


