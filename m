Return-Path: <linux-ext4+bounces-10254-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 680E3B8808E
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 08:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B29D26281DD
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 06:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFE22C1596;
	Fri, 19 Sep 2025 06:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IAEDYpRk"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FFA2BF000;
	Fri, 19 Sep 2025 06:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758264509; cv=none; b=G0taVOJva//iZjZKq4yjooUjklOlYLquPRCr0HQB7AEzS1BXh6jjLT7Mbg7Enq9Bs7fcDQmRegdjjFFknP6Otank0oPEtY7q1O043zWWUretlx6tePx8sY1R/aMHlaKoxjquvPPXVzGa2JTbyD8TYRsAkmlcxCFAY9sWcb+yXJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758264509; c=relaxed/simple;
	bh=IdUEutyZ93amHarGXgGsMBB4Qfcd7ks1oarQIAtu0Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Auek4dldL+5ZWyOXQPqxfFf71T1xP6uV1n/HshLIq+jpPB/4ba2ef/Q0zR4py1Fso2FYgObMQdH+nFSf3LhXoY03Yoft6+8rkpiNFhqYGeVKgWV3UE3Bo5xpF9X3anT9EqdyvdEtm6mWqTM43jCtJYcBPPWeIzEEyuaw1baOhdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IAEDYpRk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58INsFh1023812;
	Fri, 19 Sep 2025 06:48:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=q9h9zW9aKtQcC8/jU
	8xJ+MdlBeFU8vQJmkg5Cw9+FY0=; b=IAEDYpRkeL0U3+/VBZB5oZ9H16H9vkV14
	dbSb5czyLfijIeuwRIPCuEGeQTXiK9xNS3A/cfF9kkakbmDLR0I+cxtdTILogZXz
	X9XGHj50IdTpZFPijVsWm8AiBDGuWOWcMjbXN2XYkoScGVEWKWWIkIXoBQRbTTHZ
	lwiQ4FgeKnYmiCKr32PYdKnCeSJ2qC25Dlqb7zHIu/JZHJLH03vmzr4rQmlptYNx
	TDkoFeUB/YkjpkE1B6Z8NOC2078EIl1H52pvcwSWNtUeRDclGN4Akrf6roos0bgM
	h2cSfWxhO/XR8dNTxMz2WQ+LFbYQ/KbAfPMULFCer3IprXm2vclkA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4qxar1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 06:48:18 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58J6UDv5022899;
	Fri, 19 Sep 2025 06:48:18 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4qxaqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 06:48:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58J4lk1h029498;
	Fri, 19 Sep 2025 06:48:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495kb1atnw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 06:48:17 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58J6mF6X28705182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 06:48:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F2A82004E;
	Fri, 19 Sep 2025 06:48:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2A1A20040;
	Fri, 19 Sep 2025 06:48:11 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.215.51])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Sep 2025 06:48:11 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        John Garry <john.g.gary@oracle.com>
Subject: [PATCH v7 01/12] common/rc: Add _min() and _max() helpers
Date: Fri, 19 Sep 2025 12:17:54 +0530
Message-ID: <97ed192e3cfe41810aa8c599b32f5ba439402bcf.1758264169.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1758264169.git.ojaswin@linux.ibm.com>
References: <cover.1758264169.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -LeqR-nHFhZ0fCOmw3qvHkf79uF2n_ww
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX/CFrXAzbok/m
 ZELppsHV0pX/CuQwkeig64h292voZ1+xvRfx3BMCDn5+cA2p0PP2YHMGBF5SpOqray2OwoWST+b
 Oe+MeGNwdr5uah096SwjFGs/s6Jeh47OIbA1tbMAIJtU5iqv9EdvzfEGuNz5luL+cXPfIr0Jno2
 z25oE1nVSOPLq79GIwxKEr/W6f1qVkG1diebe1JNVctAvD6vyDBHYP0aWFvC4MDyRh47IR9I4Tm
 qYf7d6WfxzxlDmreJ5pVx32ahJpDrlqJl5QanrZFs9YWoIr10x0jndHtF1CpclvJak9S6yM8xea
 jwqnuEGOsRwlucgDOKcPBp0Tclsnay7eWV8+9XF9NqyvCSO++eCcvpzWD1Hu4Pz1LFlHNs+MJzv
 sFpSOjh5
X-Authority-Analysis: v=2.4 cv=R8oDGcRX c=1 sm=1 tr=0 ts=68ccfcb2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=VnNF1IyMAAAA:8
 a=wDx1mg2EYdB0JXDzLs4A:9
X-Proofpoint-GUID: 8DcyIrDMwvGvu5JOIJ9K12NvO6K96mwD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204

Many programs open code these functionalities so add it as a generic helper
in common/rc

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: John Garry <john.g.gary@oracle.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 common/rc | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/common/rc b/common/rc
index 81587dad..28fbbcbb 100644
--- a/common/rc
+++ b/common/rc
@@ -5978,6 +5978,28 @@ _require_inplace_writes()
 	fi
 }
 
+_min() {
+	local ret
+
+	for arg in "$@"; do
+		if [ -z "$ret" ] || (( $arg < $ret )); then
+			ret="$arg"
+		fi
+	done
+	echo $ret
+}
+
+_max() {
+	local ret
+
+	for arg in "$@"; do
+		if [ -z "$ret" ] || (( $arg > $ret )); then
+			ret="$arg"
+		fi
+	done
+	echo $ret
+}
+
 ################################################################################
 # make sure this script returns success
 /bin/true
-- 
2.49.0


