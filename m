Return-Path: <linux-ext4+bounces-11106-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C30C1344E
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Oct 2025 08:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D2E94EDCA6
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Oct 2025 07:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B9D1E0E08;
	Tue, 28 Oct 2025 07:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AgxpBU2Q"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA1A19F48D;
	Tue, 28 Oct 2025 07:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761635935; cv=none; b=aY+jp98++9pIqO9v1YfrvpaIf6YiFSMMYvt2I6NsvX4d70+FoJhXN12Ia/HPq6bQg2X3o134m0iVGlA5GSFoPYy8lqTCJer+cKrRXv4TuR8mQZMd+LWGsn9QftLMkYSQxILWyPyEj3IhgirTNWWeOhafCwNjlZGsK2IF1ua68DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761635935; c=relaxed/simple;
	bh=BXFBq7Er5A9bRGBHiLTG5uqk2zxYrix6RZxVlQfuScg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jnXKAYjndynWpSUL9bx5JPjJ7MP6ocu8DFH3vQwqv7EG9mntLuoMp8sUALo3JYqmpQs965F+dwueKpOuOJdfK58wHjTTC2Z591SgVEs7y3wDWq/USKAUwjI+ZT3Rw6eJ2VckCNCoN83G+/3vL9dVCEur17eR/4Y/eC7Ucw1kilA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AgxpBU2Q; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59RN7OCx031798;
	Tue, 28 Oct 2025 07:18:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=P7Py8NhbCX0BEipZgHSAOlAVJoSfFXFjwG/L7gFbT
	3g=; b=AgxpBU2QHGTCkQzDPVzKH5M3XNS44ox35npgDzoFNScVYpHFNfgwEODk4
	B7hDdy1NRY9cBHO0GGytqPoxIVWz/UAhqTffpnEy/5n7ZPD02TYyg2Wcx0NdWrt8
	hSMWD2Al0DRMGjZIjID3ZZnsrC6fKh74FDWfMIUXk6aYzw/N2XZ88YgjAGndG8sQ
	XkFHv5+rxoW7SnCrPliU2CXk7PJKEFmiuIq9ubNz3mBILis1ZKbpHbd403aDxfw3
	l0IqB2qtoa1gRLPPU6TIXpPaG0lBjI8Nlc6cc0qQvaWHLFrvjQ/RTgKwtcLU7n81
	mMlQ1unuK8nsMuYW435RaBzVxS+4Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0mys2g0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 07:18:49 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59S7C4bT024613;
	Tue, 28 Oct 2025 07:18:48 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0mys2g0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 07:18:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59S6qehT021584;
	Tue, 28 Oct 2025 07:18:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a18vs1nsk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 07:18:47 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59S7IkJ833620334
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 07:18:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4909920067;
	Tue, 28 Oct 2025 07:18:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2E3F20063;
	Tue, 28 Oct 2025 07:17:44 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.in.ibm.com (unknown [9.109.219.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Oct 2025 07:17:44 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Leah Rumancik <lrumancik@google.com>, linux-ext4@vger.kernel.org
Subject: [PATCH] ext4/048: Fix hangup due to no free inodes
Date: Tue, 28 Oct 2025 12:47:43 +0530
Message-ID: <20251028071743.1507168-1-ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QWRnHhBYZLjB1cG1dE65taQswsqjdDpK
X-Authority-Analysis: v=2.4 cv=ct2WUl4i c=1 sm=1 tr=0 ts=69006e59 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=MHt_SkkdIr3fsFmjLxcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAxMCBTYWx0ZWRfXwBjKxXaNfITq
 /zSlAd2CkApjLQooNersleCu89gkhAwwb/TEbBfSQJ1P00S/MMzMYTYBGXCPy2NOJvS+EmyNtEk
 WziVZdWuOjKLQXYA30nxjSAmIhCm4VccAV4cDnIWSAPwfVqpCzaXKmrhXfpmlINjMUOAJvNk5dq
 imSsfXyqCcY7gw0ec0djCXjs03dpkZvAiRmK0YViIGpyOIn38a0TRuuyw7fTEA9sGtNCt7TAWhT
 A4oTF1DryDXhaIO3Bj/2uUlCtMshoafUiCfAC0B8px10ZfS7SUJ8F7Cp3qKmwmmUfKm336HqHET
 iZ7i5DaNZ+01jPeKH3/yDV2nRyPhvH3GmfQbd1F9Ye90JHHix3/8n6OixnECvo3kRtYu4i1pQu5
 pTYtbD1SuEDL0EjHylIyw1Zenk8EHQ==
X-Proofpoint-GUID: vkAL9tWgAf1lrlGm97IBpGeC70tWCRV7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250010

We currently mkfs a 128MB filesystem, which gives use ~2048 free inodes
on 64k blocksize. The test then keeps adding new files to a directory to
trigger an htree split. For 64k this takes more than the total free
inodes, which causes touch to return -ENOSPC. This leads to the while
loop in induce_node_split() to never finish.

To fix this:
1. Format a 1G FS which gives us atleast 16K inodes to work with.
2. _fail if there's any error while trying to induce node split, so we
   dont get stuck in loop

Fixes: 466ddbfd1151 ("ext4: add test for ext4_dir_entry2 wipe")
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/ext4/048 | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/ext4/048 b/tests/ext4/048
index 2031c8c8..6343ff3a 100755
--- a/tests/ext4/048
+++ b/tests/ext4/048
@@ -69,6 +69,11 @@ induce_node_split() {
 	while [[ "$(stat --printf="%s" $testdir)" == "$dir_size" ]]; do
 		file_num=$(($file_num + 1))
 		touch $testdir/test"$(printf "%04d" $file_num)"
+		local ret=$?
+		if [[ $ret -ne 0 ]]
+		then
+			_fail "ERROR induce_node_split(): $ret"
+		fi
 	done
 	_scratch_unmount >> $seqres.full 2>&1
 }
@@ -81,7 +86,7 @@ test_file1="test0001"
 test_file2="test0002"
 test_file3="test0003"
 
-_scratch_mkfs_sized $((128 * 1024 * 1024)) >> $seqres.full 2>&1
+_scratch_mkfs_sized $((1 * 1024 * 1024 * 1024)) >> $seqres.full 2>&1
 
 # create scratch dir for testing
 # create some files with no name a substr of another name so we can grep later
-- 
2.51.0


