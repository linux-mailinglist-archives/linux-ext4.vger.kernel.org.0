Return-Path: <linux-ext4+bounces-9309-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EA1B1FA28
	for <lists+linux-ext4@lfdr.de>; Sun, 10 Aug 2025 15:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6986C177455
	for <lists+linux-ext4@lfdr.de>; Sun, 10 Aug 2025 13:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48038260582;
	Sun, 10 Aug 2025 13:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CiwefkbK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B8B243951;
	Sun, 10 Aug 2025 13:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754833340; cv=none; b=k/iM4lF7ga/7oobH0k4hCvzQagNVh4Vb5oSuERg2B7igHk8mS5GcheyxDqPEXGAAxXI0VUmGFNVydbU2d83pc/936NsfbYQZ7I9GsQFtd6026mNFP4i5zsJ3/tAcEgUOmjAQKqXmU2JGfd3QEYerVrewKVvXqXTAY0GB466WvwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754833340; c=relaxed/simple;
	bh=lYfsbUws7d3sbPCB42F9HZxMcpJ3i7N9UNMxhnM35r0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=crlNlxznxAZ7D8vXuYBwsXrSZcaO4USVgb8Swko+szyYHXHp4VGY1YVRwSqe79aCl8e7meFDxKqgfR18+hF59Q9NCYQITkEo7q1c64vA74Dm9xJom9q4ZluxmfQiRtpp6g4tCil6DXwwELh3MPfXf9LyEmtEz9EDk5Qgc/aLyLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CiwefkbK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ABFbDa014546;
	Sun, 10 Aug 2025 13:42:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PYQZgvfNcc0kXpVhI
	ok6r8Bxs5AdIuo/c5/UZ0YX1lA=; b=CiwefkbKnaA5w8zi5D3e11MW9beSa2Dgk
	Y0j1kL/LhcyIs48FZNYMvhilCnCDLm5ySprm9pQtUkS5HDCITamnSqSAcSv6HjOP
	WiMzHkZ0izYnusr6EuuHITJzmlHfNni+3gx5k+oO2VHNrCSrpKG5BrA9b1+uTAE3
	aB93UBPCv1DiNAanj8dAUoGG7An1DAw37BB5QfYBRjvx8t4gFmZE/X2d1BbOhpqX
	1/AJs3nPT9wgnm9Gwy8svMCRIt1/JTQb+0HJzbLmXu9dBtXSYTBku+3eKB50FOn+
	lJ76IvZNAcUlxwnKZuW20dkXiC/dQFcb2AdYdwJ6R7lo/iMxI6Dhg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dx145b19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 13:42:12 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57ADgCva020423;
	Sun, 10 Aug 2025 13:42:12 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dx145b16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 13:42:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57ADJpNk028571;
	Sun, 10 Aug 2025 13:42:10 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48ej5msw94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 13:42:10 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57ADg8Z234013722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Aug 2025 13:42:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA4DD20043;
	Sun, 10 Aug 2025 13:42:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BB2220040;
	Sun, 10 Aug 2025 13:42:06 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.216.43])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 10 Aug 2025 13:42:06 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v4 01/11] common/rc: Add _min() and _max() helpers
Date: Sun, 10 Aug 2025 19:11:52 +0530
Message-ID: <43f45a0885f28fd1d1a88122a42830dd9eeb7e2c.1754833177.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1754833177.git.ojaswin@linux.ibm.com>
References: <cover.1754833177.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lSQiEu_RxbLos2B7hWujceCHXI9EXwDd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA5NyBTYWx0ZWRfXxeFTlH+R9UkW
 JiPg0lpnrtdgWo1uJVxfeVvFPRbIKPytRKCi3CXZ5Dy1Yg/lHZ2TpWLMmiC/Om9TJpabamPBSH7
 25QIB/YbM2utTwsYwDly28LwvpD4c0wyxxozQ3sxW0gC+7LBNqDCmrvBBlKacqPti9dkFWsgfEt
 lns1YGBKPNBmdaUzBRmWXznrKOxgmsuY1obOI4nZs1iFvb2wL3cTookRZs82iXTwv+XwEsX5SAi
 ja8GR96II/tQFtvVVtATQn02mQsMMbGTMatAjCay7zpNaK4YoaHVA6EuSUDqTQOOdgRc33AIxyW
 SAc/lxnpLHMmAolwFqvERtpWKw0Yw06DNpLslraztgvITbiUXO4h5ZWkFBUwN5igWboYc5ZoKrH
 2ct2UavOVM9mL3n9C/rqogY//vxR1e/QVXOE6z/vRhQRwEfmk0kbV5OqACwzIaXJFRuZPEfp
X-Proofpoint-GUID: EcMUEfIcDq_GYqRvgpS0OWAdp8Jaj-QY
X-Authority-Analysis: v=2.4 cv=fLg53Yae c=1 sm=1 tr=0 ts=6898a1b4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=wDx1mg2EYdB0JXDzLs4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-10_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxlogscore=967 malwarescore=0 bulkscore=0
 mlxscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508100097

Many programs open code these functionalities so add it as a generic helper
in common/rc

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 common/rc | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/common/rc b/common/rc
index 96578d15..3858ddce 100644
--- a/common/rc
+++ b/common/rc
@@ -5873,6 +5873,28 @@ _require_program() {
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


