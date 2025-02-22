Return-Path: <linux-ext4+bounces-6527-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A98CBA40669
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Feb 2025 09:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DBF517553C
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Feb 2025 08:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647E12063FC;
	Sat, 22 Feb 2025 08:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sP5VCz8u"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF4C2063EC;
	Sat, 22 Feb 2025 08:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740213637; cv=none; b=eOucupY1P2BXHFbDj7LTS7Br8jwrATmyNXPR0rw4pn8Sx3TRJ4AzCK1VYH05DCTTP1IevEtgt3RaBUBHRP9ayPccYfoospcE6HfCt1UUD8APQDgDjET2gAKJXd8okw7napkcM3dfuZRIag6vVcuYYF2RE0bXcfRUhL7uhFlYlJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740213637; c=relaxed/simple;
	bh=xskrD9bsgdpye8LZrQM8m3Ee8yRvK5UTd25K7iV5sP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lylw0ZF74zuL/T6pdf+zOu73Ly57uuzHpnzQ7airaNZcrAB3CutAh7DHecPOp9VeMpym80lTPu78qEaeZzpkIxhmNoLqjXSQT/ShKG8zPmjA1kBNhrlIpTaTRVqqcyNqBjJKsY25YaQIZR/3cDqxg+jzSAHlbgXLckn9v/+cNp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sP5VCz8u; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51M5rKFT014657;
	Sat, 22 Feb 2025 08:40:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Zedv4r0eGEKxCWCarbK1QbD6GSvkUPReZID9O0ucZ
	NE=; b=sP5VCz8uDgK55xO1XU5l6qWWG+RkR+ALe2j95JdIxu5O6WYLZyOvg2Xkz
	C3I9EOoo/T+/FmrmUL7shoaUMCGCtEfx+ZmGQdptl7uqI6Qbfh2Uj+KOOwQNNVjF
	ble6s8qgeMm3By7Cl+CqNzk4whFpgm0P49F4d9p/OmnIk0UrlfKkTrCwtP2Faj+D
	1qvyHabfvQJu+o5nbFQWt9LeoJK+cZ29CqUL0gyY8IA7ZR187OlpfXHorMjEA70A
	cevnZ0qGY4enFhT9VWEN6Mubd3/niejNyfnZQf1T3Lf41rCg43+DC3TmviieK00k
	iXDNzc5Ws0BcCroJ+FiOLvPv7/QMg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44y83a8jv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Feb 2025 08:40:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51M6sToN009691;
	Sat, 22 Feb 2025 08:40:29 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w03ymgwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Feb 2025 08:40:29 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51M8eRKx42598762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Feb 2025 08:40:28 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEB9920040;
	Sat, 22 Feb 2025 08:40:27 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D106820043;
	Sat, 22 Feb 2025 08:40:26 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.30.104])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 22 Feb 2025 08:40:26 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Fix a BUG_ON crashing the kernel in start_this_handle
Date: Sat, 22 Feb 2025 14:10:21 +0530
Message-ID: <cover.1740212945.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eePE92_QHZ37nS4Xu-_SbfafiLWzPZku
X-Proofpoint-GUID: eePE92_QHZ37nS4Xu-_SbfafiLWzPZku
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-22_03,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 phishscore=0 mlxscore=0 malwarescore=0 spamscore=0 mlxlogscore=766
 priorityscore=1501 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502220066

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
1/2. Patch 2 is just a small tweak that i found helpful while debugging.

That being said, journalling is something I'm not very familiar with and
there might be gaps in my understanding so thoughts and suggestions are
welcome.

Ojaswin Mujoo (2):
  ext4: only defer sb update on error if SB_ACTIVE
  ext4: Make sb update interval tunable

 fs/ext4/ext4.h  |  9 +++++++++
 fs/ext4/super.c | 17 +++++++++--------
 fs/ext4/sysfs.c |  4 ++++
 3 files changed, 22 insertions(+), 8 deletions(-)

-- 
2.48.1


