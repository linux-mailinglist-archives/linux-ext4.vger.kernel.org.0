Return-Path: <linux-ext4+bounces-9553-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E143BB3111D
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Aug 2025 10:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1F8D1C23B5A
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Aug 2025 08:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14792EAD15;
	Fri, 22 Aug 2025 08:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bExb2aTR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FB72E7166;
	Fri, 22 Aug 2025 08:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755849751; cv=none; b=oiMgBi410u8CBSBBouO9m48saGkQzww0s8nFdiIW6eSXFtuh+pfNOXpmzqxkH7vpMFHc0dtm2ndJFUEAHhuLNYUpIM7DZU1CnJiznRPBBi0pSxNzokvW+BmQjkxLGe+AGnqKn0HibTXyFzUAgJh5Jyuda4NoNiifsZvPxsFMsK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755849751; c=relaxed/simple;
	bh=rwemJAsET1QAd67z1zthbFOTnKYTlW3d35XQz3vetPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qlf1eolW5aTz7l3I3vNJpGXzszn31zTPZvPzoCiwbxXdS/dH/dg4nsyZsftxglQH9lqFGMoB/ibyhZZrSkh+Ga/vBAWsq72wd+Y8qP8dpySSTMGCIeXKR9q2SL1i7noK69He7huwZ4pv8FjEQFP9Rx4YehOJucfFK/1Oepl8HpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bExb2aTR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M5onvN011916;
	Fri, 22 Aug 2025 08:02:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=MfELG6FC8BYGZ51xy
	ZXxPCf5stkdh9Ke37+72AOOym4=; b=bExb2aTRXf1+niWIIWVBJF0cTg9TTBRnf
	o6IFFFkbxkfktidr36IjN5kSV92raZiieoXG9rDarY29ERjeSdCDr2CeuAMFAnJo
	m8f8r5Ykt6F9aMwJSJH7DHHb3BfIOzRz4VqOvG0LZGgiX+VMxOuhMa7l9gEO5jvL
	wEM3ZpJl1BoFAVFkqqLi4Q/56QHSyUbll0YXZXUe+MatME7BfN1M024+dRIWveHN
	ihm2LftHd+9MacDJymxVqpdte1IqW7L7r8CwEi49FoFcWYQpFK9OFBd+/ndJWMeb
	EBCMUxJZhWztyIUVi93q1zOgz1TEJ9N5aKV+qaS9oFbsatGRkyfYg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vw4cp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 08:02:20 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57M82K19024216;
	Fri, 22 Aug 2025 08:02:20 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vw4cj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 08:02:20 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57M3tj9C031881;
	Fri, 22 Aug 2025 08:02:19 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48my5ycafy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 08:02:19 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57M82HjS51708290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 08:02:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7457620043;
	Fri, 22 Aug 2025 08:02:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3573C20040;
	Fri, 22 Aug 2025 08:02:15 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.210.10])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 Aug 2025 08:02:14 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v5 01/12] common/rc: Add _min() and _max() helpers
Date: Fri, 22 Aug 2025 13:32:00 +0530
Message-ID: <b8f62c7ab108b74a61db6ded976292e8a4b46ad8.1755849134.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755849134.git.ojaswin@linux.ibm.com>
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfXzzObLmZRTntO
 /ieerJqJZ1VLoXwBinbPqRuW9vfC4qzkfFaUJPEx+ZWB6nupwvCIyDpoBKfYBGh+5Wx9VJ08h83
 UZ9ytc416XG1uG2JVBoVnHFOvOlxEXt+ax8PBfu1ExTQ8zF/A++zjD4heSsGtJkW0o450tLNn2Y
 xNRyOi95kKUFNbhR+8W4pAnRJkuBDnA/BIjq932cNcZQ/iZikXSPswBZJuHg0Fe7s2jepJut1RH
 eKk52bfjAVgaOOrmaKTA5fh3w950czJypgKkKNiNkvwAQFre5Agk49JLp0DyuCyac/21B0Z4pt9
 4dHks6lD5jO7tFRmWG7CMKryjfieTqFIuxVa77Y3w2GD7d2vCFL6itCFEmw484TlXy5iE+TsXG+
 Uq6OnMaKCrGRgNlwtN9zDSCMxBkvZw==
X-Proofpoint-ORIG-GUID: 4tTTkPKftnEx5t4ixF_8MEZQ-95yuz0q
X-Authority-Analysis: v=2.4 cv=T9nVj/KQ c=1 sm=1 tr=0 ts=68a8240c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=wDx1mg2EYdB0JXDzLs4A:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: yBheFqQRLRTkq6ReGE_gElyfI4wBjMBn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508190222

Many programs open code these functionalities so add it as a generic helper
in common/rc

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 common/rc | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/common/rc b/common/rc
index ff5df203..35a1c835 100644
--- a/common/rc
+++ b/common/rc
@@ -5975,6 +5975,28 @@ _require_inplace_writes()
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


