Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F8929F59C
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Oct 2020 20:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgJ2TxX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Oct 2020 15:53:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9018 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725980AbgJ2TxW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 29 Oct 2020 15:53:22 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09TJYOm9127339;
        Thu, 29 Oct 2020 15:53:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=wqX6CLeoDapKERTcG3S0RVEmkQlKUlM+bdp1Fmhqzzo=;
 b=CFPhX2LiDdF4tCEGJoku8Y3x1Kdt0DosIumVMqHTO0VQxXguSbnrGLY3XGdnB5GsK6QK
 sB09s/uU2VNRsvegvTE025MKS/D8mkyob5tJnn/TOV+6+c9fifrOO9FAkH/3W06wGnnX
 3vrq4pQmeq81tlu/bBnrvky3Xvkp0gcXveV8W4UlBFqrTgSv29htxpq8rIenXASWspjf
 L86iQPTPrdJOcjsbkrg310OS16UcRYETR27Rf8IGNuTw8CXgu5oO+Ej9+oganYmiTnhi
 9CZe38QMh+s9FcoVzWhTKaTxClcjtSdzO3er99ktbzfZ0NDcuUkiDEJYFMCGf7ImtvJ+ EA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34fwvewh0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Oct 2020 15:53:18 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09TJkhTe022987;
        Thu, 29 Oct 2020 19:53:16 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 34e56quavj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Oct 2020 19:53:16 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09TJrEpO30933382
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Oct 2020 19:53:14 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E7B24C059;
        Thu, 29 Oct 2020 19:53:14 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF3E54C040;
        Thu, 29 Oct 2020 19:53:12 +0000 (GMT)
Received: from riteshh-domain.ibmuc.com (unknown [9.199.33.247])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 29 Oct 2020 19:53:12 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests@vger.kernel.org
Cc:     anju@linux.vnet.ibm.com, Eryu Guan <guan@eryu.me>,
        linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH 3/3] common/rc: source common/xfs and common/btrfs
Date:   Fri, 30 Oct 2020 01:22:53 +0530
Message-Id: <8d7db41971a227c5bd83677464d139399607e720.1604000570.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604000570.git.riteshh@linux.ibm.com>
References: <cover.1604000570.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-29_12:2020-10-29,2020-10-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=1
 mlxlogscore=940 bulkscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010290131
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Without this patch I am unable to test for multiple different
filesystem sections for the same tests. Since we anyway have only
function definitions in these files, so it should be ok to source it
by default too.
e.g. when I run ./check -s btrfs tests/generic/613 with 3 different [***_fs]
sections from local.config file, I see below failures.

./common/rc: line 2801: _check_btrfs_filesystem: command not found

./check -s xfs_4k -g swap (for XFS this fails like below)
./common/rc: line 749: _scratch_mkfs_xfs: command not found
check: failed to mkfs $SCRATCH_DEV using specified options

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 common/rc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/common/rc b/common/rc
index 4c59968a6bd3..e9ba1b6e8265 100644
--- a/common/rc
+++ b/common/rc
@@ -3,6 +3,8 @@
 # Copyright (c) 2000-2006 Silicon Graphics, Inc.  All Rights Reserved.
 
 . common/config
+. ./common/xfs
+. ./common/btrfs
 
 BC=$(which bc 2> /dev/null) || BC=
 
-- 
2.26.2

