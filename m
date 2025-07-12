Return-Path: <linux-ext4+bounces-8947-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5913AB02B34
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Jul 2025 16:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B78131730BE
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Jul 2025 14:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCEB27C163;
	Sat, 12 Jul 2025 14:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JoNUnKp1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D776F27B4E0;
	Sat, 12 Jul 2025 14:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752329599; cv=none; b=qOI9DaYQTSyCuTxwkU/amHaYGA+l/+8SV+faxD4N6GKOQVwjQd3Mig3mPsdeuHfSwr2gj6GUsAWE9LFtquWnvoypdquYJvbkotq1xEsfEtirhXYlfGGVY3LzESHAVYFEwWDEAh7aYq1NAajeQMYCep95irLbnrFMaADb1NN3a9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752329599; c=relaxed/simple;
	bh=KGnhA3OEPNi5mPEFOwuBdga0KZcoROXpHFOdoqRmo3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZOkP4AN1rBHfluyJfFv1Rm/k+MowSE/XoNOIVFO+aLvYIe5HI9Ajnw5c54lX/jBoL6BsqsWEwxotXNVotRD7FPsP6U3ek4Cr4/B6PYgV8XT20NIyAzwjhZicXEUT16zHzsT+CxeD8QaqxqUH/tlnh3ZhzGRzU8bgmbMsJtklDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JoNUnKp1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56C1ufbo022923;
	Sat, 12 Jul 2025 14:13:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=GeM76khIzlsvA662v
	qoGYtRNLFzJUS8exvmZZPtUZg0=; b=JoNUnKp1SQu0r0WGgAF1G+O2QdPNomQ6c
	WD66QnALnSJYnM6hI56d/+vKfvaMJtD/RlGo5HUqO97JYSWkWHr1E84VK44Th4Kz
	Hvhtt6pOtSe7U9KIh1dRmlpWN8o3HO+LUsri2mrXr1aPhDKcuuFOwFiaIE3Fedv+
	RAwCkgEV9yNUd63+5V7oiwwTLbPbrV76dqbRiCBO7Qecwoik2DKyn5NXCBrKpLPa
	nZLSzY81OC9rwa4DG9kkLbKL2nJUbuebtrJsjaNrKH6gUXzqirXzhO2TobJ3W5r5
	5f0dz++3hBGcG2rNSREBwGRCLq60ESuuuY43acdqNLTjwfgQzGDjQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ud4st2yb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Jul 2025 14:13:04 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56CED46X004280;
	Sat, 12 Jul 2025 14:13:04 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ud4st2y9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Jul 2025 14:13:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56CA6C91025586;
	Sat, 12 Jul 2025 14:13:03 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qfcpqe4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Jul 2025 14:13:03 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56CED1GR51708224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 12 Jul 2025 14:13:01 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 689842004E;
	Sat, 12 Jul 2025 14:13:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A93220040;
	Sat, 12 Jul 2025 14:12:59 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.215.252])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 12 Jul 2025 14:12:58 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v3 01/13] common/rc: Add _min() and _max() helpers
Date: Sat, 12 Jul 2025 19:42:43 +0530
Message-ID: <f61636e664cf22024ee68b2f0ca3d3583eec7ec4.1752329098.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1752329098.git.ojaswin@linux.ibm.com>
References: <cover.1752329098.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEyMDEwNCBTYWx0ZWRfX2L/Go5CZivrC 6xm/Qmv8NZaqLc0VhIzmm6ubODY0xUjKgjwqLXp2iIf7xqlDmhtXy6BdMEfkl8UhOBqt3e+3bXM ORRrB8rYbsRP/QoY2cyBIimKmIvMaVnMMyAo74HXYacRf8GFE9qPONGHtSwAotPmyoSFA9q4VKn
 +pMho93AtsXEfBLy4VQPXIzC8bYOdY1kVjfRCE6qZg5byYAk6I6LAoEamq4oA5VWB4eMEanIbJ9 HN8D0nFMw8VcRRv8M9k7GGltIwXY3tbNxLLcoTBfGeQKBu/b574rPZa6MrHxiDjWWSN3afmTjjv SsA5DiObHVe+x6N4X/L3vmsulHYdsQhR/TuKnTKYYB0sAuIzkpdfNF+kBPy9OHuJ5dt+haEFBJW
 vcD11BktbQun2bUZftMLWoRrR0BIrX1vnrVzXcR26tazaELjLVsUGpPJv1NC7gKxIB/a35UX
X-Proofpoint-GUID: zwQC4WZBwAVM2snA3fKW-PRE5P4BrNfV
X-Proofpoint-ORIG-GUID: MtMJvNoX0Jo_DgfCM5YqKVAMf0QdS2Ru
X-Authority-Analysis: v=2.4 cv=KezSsRYD c=1 sm=1 tr=0 ts=68726d70 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=wDx1mg2EYdB0JXDzLs4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-12_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 clxscore=1015 suspectscore=0 phishscore=0 mlxlogscore=912 mlxscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507120104

Many programs open code these functionalities so add it as a generic helper
in common/rc

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 common/rc | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/common/rc b/common/rc
index f71cc8f0..9a9d3cc8 100644
--- a/common/rc
+++ b/common/rc
@@ -5817,6 +5817,28 @@ _require_program() {
 	_have_program "$1" || _notrun "$tag required"
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


