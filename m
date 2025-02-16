Return-Path: <linux-ext4+bounces-6464-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB48A37673
	for <lists+linux-ext4@lfdr.de>; Sun, 16 Feb 2025 19:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EBDD165954
	for <lists+linux-ext4@lfdr.de>; Sun, 16 Feb 2025 18:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E990119CC34;
	Sun, 16 Feb 2025 18:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JYhvvmWZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1982525771;
	Sun, 16 Feb 2025 18:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739728978; cv=none; b=YCRKSWNW+4wsa18lbHt1r/KsIqwZqp+a5UFe13GB3nXir3gbKYlsK/mZFeJERoxqddP/tSjS+bzfUHyLP3wRZ6gVKqJiTaR2BgH/2HTp5G0VjdiF34HWP11Kq0+yGy96NPHVEN5737vHbUpj78Ou0vWKeWNhqjft4N3UBEN+GDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739728978; c=relaxed/simple;
	bh=t+WEa/YV84UHDrghWTAOC96OzfAFkWsWBd2b101LDa8=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=cWgw9KrHLKCQ4Pi5ik8aQhlkN0uYPLqBLbFoRzaVU86vjBlEKghVF1uxJnqVU09c1X/SzFpMCqUiXRX99Pz1vkX+YnATc6QJHlaWcuBXNMkPJwuLThGfX9Uajv1++9q9zcIJUsMcpYmZ5BaL6yOUcs8dwbkSrfF2R3Phgrbe2Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JYhvvmWZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51GFFC6d004824;
	Sun, 16 Feb 2025 18:02:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=t+WEa/YV84UHDrghWTAOC96OzfAF
	kWsWBd2b101LDa8=; b=JYhvvmWZDFFsQnZKMzDtfI7NFM3GwsOqdZXlGTEB9Fpw
	kBX4hzvw1uAlIU8vwI1W07phxjJ5tydgZPxEC3JZIaOIHePglXpwURBxJC0sXhfE
	cl1AB9N0HnznsVnJl+ACctlGpmynjOqku5FK/Wn4SHZd538zHOui95kPsfYHH11a
	H/DRJX0IC8e74cl3XztMdNyeZma11VU82a1bQ8T+FYJ1lzwGm0kBjieEbyFH5OCL
	G2qWjCIkMyl84MYCHKxEA44NFbFqb+zK2tiwca9utZY1n40/XkDqlere1ysQ2OV3
	r/paTv6seKAL9Rt0goSgUkUom1qHW6Sk78WJyFNM7Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44u9u7t3vg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 16 Feb 2025 18:02:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51GHaRgb003891;
	Sun, 16 Feb 2025 18:02:41 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44u68njp2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 16 Feb 2025 18:02:41 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51GI2eeO29295120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 16 Feb 2025 18:02:40 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D5F15803F;
	Sun, 16 Feb 2025 18:02:40 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D1E558060;
	Sun, 16 Feb 2025 18:02:37 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.242.32])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 16 Feb 2025 18:02:36 +0000 (GMT)
From: Venkat <venkat88@linux.ibm.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [next-20250212] FStests generic/451 on EXT4 FS resulting in
 kernel OOPs
Message-Id: <7F085D3B-4AE5-4DDC-94BB-59EF8A67A592@linux.ibm.com>
Date: Sun, 16 Feb 2025 23:32:24 +0530
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
To: tytso@mit.edu, robh@kernel.org, angelogioacchino.delregno@collabora.com,
        chunfeng.yun@mediatek.com, vkoul@kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
X-Mailer: Apple Mail (2.3774.600.62)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: A4tV1X1Njir-qAVKGwGrVvZlbr3Tu9-B
X-Proofpoint-ORIG-GUID: A4tV1X1Njir-qAVKGwGrVvZlbr3Tu9-B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-16_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=695
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 phishscore=0 spamscore=0 clxscore=1011 impostorscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502160159

I did attempt git bisect, and the first bad commit is =
d49e636ed7014be354d1ee279b8f4957e8def389.

Git bisect log:

 #git bisect log
#git bisect start
# status: waiting for both good and bad commits
# good: [a64dcfb451e254085a7daee5fe51bf22959d52d3] Linux 6.14-rc2
git bisect good a64dcfb451e254085a7daee5fe51bf22959d52d3
# status: waiting for bad commit, 1 good commit known
# bad: [c674aa7c289e51659e40dda0f954886ef7f80042] Add linux-next =
specific files for 20250212
git bisect bad c674aa7c289e51659e40dda0f954886ef7f80042
# good: [0a354ebcff3e3564281f2ee70b7094f5d16b762e] Merge branch =
'for-next' of =
git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git
git bisect good 0a354ebcff3e3564281f2ee70b7094f5d16b762e
# good: [21abbfe377b86bac23e3d167f002a492391555c7] Merge branch =
'for-next' of =
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
git bisect good 21abbfe377b86bac23e3d167f002a492391555c7
# good: [fcd8e79b9c555ea05cca4ab4593e3fa02722158f] Merge branch =
'usb-next' of =
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
git bisect good fcd8e79b9c555ea05cca4ab4593e3fa02722158f
# bad: [8b5e9ed3e14f98a0dfa9a2e15654c0f4d94ac64c] Merge branch =
'pwm/for-next' of =
git://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git
git bisect bad 8b5e9ed3e14f98a0dfa9a2e15654c0f4d94ac64c
# bad: [4e91a64bcf478f6f7cf7aab043d80ca671367348] Merge branch =
'staging-next' of =
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
git bisect bad 4e91a64bcf478f6f7cf7aab043d80ca671367348
# good: [7b465a0d58c19a45ddf81c90bc8ba04693de038b] iio: light: adux1020: =
Drop unneeded assignment for cache_type
git bisect good 7b465a0d58c19a45ddf81c90bc8ba04693de038b
# good: [66b800119cc5ced59aa45d523e8ef9af54211abd] Merge branch 'togreg' =
of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
git bisect good 66b800119cc5ced59aa45d523e8ef9af54211abd
# bad: [1fad5171135d31d3d9258715c7d3fefa378797e0] Merge branch =
'for-next' of =
git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-w1.git
git bisect bad 1fad5171135d31d3d9258715c7d3fefa378797e0
# good: [0d8db251dd15d2e284f5a6a53bc2b869f3eca711] phy: qcom: qmp-pcie: =
Add X1P42100 Gen4x4 PHY
git bisect good 0d8db251dd15d2e284f5a6a53bc2b869f3eca711
# bad: [d49e636ed7014be354d1ee279b8f4957e8def389] Merge branch 'next' of =
git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git
git bisect bad d49e636ed7014be354d1ee279b8f4957e8def389
# good: [88c0053baed659acd85b87dd52cbd75f3d8806be] phy: Use =
(of|device)_property_present() for non-boolean properties
git bisect good 88c0053baed659acd85b87dd52cbd75f3d8806be
# first bad commit: [d49e636ed7014be354d1ee279b8f4957e8def389] Merge =
branch 'next' of =
git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git
#

Regards,
Venkat.=09=

