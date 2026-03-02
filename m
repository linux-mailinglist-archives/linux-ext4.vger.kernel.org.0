Return-Path: <linux-ext4+bounces-14323-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIBdBsqgpWmuCAAAu9opvQ
	(envelope-from <linux-ext4+bounces-14323-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 15:38:02 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 961481DAFDB
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 15:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9BC8130087D9
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Mar 2026 14:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE3F3FFAD6;
	Mon,  2 Mar 2026 14:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="STmqJKXX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD18C3FFAC6
	for <linux-ext4@vger.kernel.org>; Mon,  2 Mar 2026 14:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772462257; cv=none; b=X/y6Lx1hvLMfa/EjXb0fNlAq7ZaDs761fJO8k4MQSTohUjmVqHF+CwNmiZTLZNGs8WvGr032PQbRqQmH0CguZ9n1CaacAsGh36CdCKYm48248A+RlW+wQ59NxIVeCtRIYJRPZpAqcgC5r4D2svmOk9IMz5eRJasn1zGLT1P6sjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772462257; c=relaxed/simple;
	bh=Um25oj7nki0zFSgy1PTq+dKr8xv6jDz8qrGIRulaGmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nWK9GVeANq20kowRxoZOiHIpg4LTe0/IuTeAupBN6HfzAAAyIKwjNm+e/CO2MSyZXspoq//9F8H5KHyGyfq8NSWF2mH14d7pJRZ3guFiZE4Wioc2ezpTNbvE9R5qsD3D3g4orybl5sIb3ssWNuVFGnWHDfUbGBHhdI5iOSt90cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=STmqJKXX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622DmhDL2187914;
	Mon, 2 Mar 2026 14:37:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=fa6VW2JSjZ6g9mioA+BrUQS/iWRKnsv+qhjUiaqia
	xE=; b=STmqJKXXpUTm/kAbw1kG95Gq7KDGQT8PV/gE+Wjb9EfSZyNuKBHf1+kn+
	FppK1eXcxoWlXBT4GDU8cHF2czKcrcApvVeuDBD+kR544QThL4spfJlC8enGPVwg
	WtF2uWL6JyI7JY/gjA9dgXAjPjt9K1gENTTrTNBhUPlml7aiJUB96/TXLoSpmP5b
	reIfVLwkAE5KNRORUS8RX67PdIsgQBJwnca+D410fdzRSPfOpiOUaHypaJALIDfH
	xFUvOr8pfktUzb7bVGSZB/cxn/b1yvXU4EOwuRvIQK1xkITvdIJBHNEJlrc/zOL6
	7ju2HSDIpBqzBulTlvUP6CSqxwNpA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksk3pv2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 14:37:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 622D9Fvr016802;
	Mon, 2 Mar 2026 14:37:31 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmbpmxh8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 14:37:30 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 622EbQ2o61538782
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Mar 2026 14:37:26 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8E9720043;
	Mon,  2 Mar 2026 14:37:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8069C20040;
	Mon,  2 Mar 2026 14:37:25 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.211.209])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Mar 2026 14:37:25 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Disha Goel <disgoel@linux.ibm.com>
Subject: [PATCH v2] generic/108: fix test hand upon failure to create LV
Date: Mon,  2 Mar 2026 20:07:24 +0530
Message-ID: <98f8ef5ff92632a0be336a563ebda36cfe898348.1767782181.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mtK1uoPXT_XysNcYCZ0toq2pZYlAtOZw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDExOSBTYWx0ZWRfX2IwLtUrDpQxY
 dsPWXVG9RzeblVK2OiLza0ZOpOsQJLXs+d8D1NnUflq+k9XgIlzOQSgoBsBiuVfF8c853vPoLxY
 eSCAo6BhToiqLxiNNb36WcW3MzUMlSv7weRQDxjtOGK6PTA6GaLddRn/z9hzPQssWNwpfEeerPY
 +WcW9id09EVnZRccQ5X9TO4Iba74JiNqTdMD/n+yTTtAkXE/TVjDH/2nWqM9aOeIHlmNDKPBNjy
 yv4St2O8ffU/lZQ/JfKH+IpR2O/110qTpH3B41tJpXnxhnJOJQTZXshqm6uw0MZAaiaZdVOj1ix
 BYXDG2h6CHJoFXW0XeyhjAA+IJu4hk+9UEt3sGsUn+uyInV2FlIpGiOJgOUDN7cdt5F8mAK3/zl
 jR3XQT2L1dslxfrWYFJ0shVAMN2MCN8x0GDvU+TRPGMcpPs1W7QSX6R03zzx6NMLuUqzht3+BWh
 rKQfFEHZK0v2U93wtHw==
X-Authority-Analysis: v=2.4 cv=csCWUl4i c=1 sm=1 tr=0 ts=69a5a0ab cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=0fFrJNyYT6Ehky_TIyQA:9
X-Proofpoint-GUID: mtK1uoPXT_XysNcYCZ0toq2pZYlAtOZw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020119
X-Rspamd-Queue-Id: 961481DAFDB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14323-lists,linux-ext4=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojaswin@linux.ibm.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

In case the lvcreate operation fails, we don't catch the error and
proceed as usual. The test then tries to wait for the LV to come up
but it never does, causing a hang.

To fix this:
1. Add a check to ensure SCSI_DEBUG dev is of required size
2. Additionally, fail if there are errors while creating the LV.

Context for completeness:

This was noticed when we accidentally used CONFIG_SCSI_DEBUG=y instead
of =m, causing it to create an 8MB SCSI debug device. This led to the
lvcreate operation to fail with:

  Insufficient suitable allocatable extents for logical volume lv_108: 68 more required

However the test never caught this resulting in a hang.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reported-by: Disha Goel <disgoel@linux.ibm.com>
---
 tests/generic/108 | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/generic/108 b/tests/generic/108
index 4f86ec94..05d743a9 100755
--- a/tests/generic/108
+++ b/tests/generic/108
@@ -50,6 +50,11 @@ SCSI_DEBUG_DEV=`_get_scsi_debug_dev ${physical:-512} ${logical:-512} 0 $size`
 test -b "$SCSI_DEBUG_DEV" || _notrun "Failed to initialize scsi debug device"
 echo "SCSI debug device $SCSI_DEBUG_DEV" >>$seqres.full
 
+got_size_kb=$(_get_device_size $SCSI_DEBUG_DEV)
+
+[[ $got_size_kb -lt $((size * 1024)) ]] &&
+	_notrun "Need SCSI debug device of size $(( size * 1024 )) KB. Got $got_size_kb KB"
+
 # create striped volume with 4MB stripe size
 #
 # lvm has a hardcoded list of valid devices and fails with
@@ -60,7 +65,7 @@ $LVM_PROG vgcreate -f $vgname $SCSI_DEBUG_DEV $SCRATCH_DEV >>$seqres.full 2>&1
 # We use yes pipe instead of 'lvcreate --yes' because old version of lvm
 # (like 2.02.95 in RHEL6) don't support --yes option
 yes | $LVM_PROG lvcreate -i 2 -I 4m -L ${lvsize}m -n $lvname $vgname \
-	>>$seqres.full 2>&1
+	>>$seqres.full 2>&1 || _fail "Failed to create LVM lv"
 _udev_wait /dev/mapper/$vgname-$lvname
 
 # _mkfs_dev exits the test on failure, this makes sure test lv is created by
-- 
2.51.0


