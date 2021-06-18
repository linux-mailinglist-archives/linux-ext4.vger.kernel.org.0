Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4853AC982
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Jun 2021 13:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbhFRLMf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Jun 2021 07:12:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45790 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233357AbhFRLMe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 18 Jun 2021 07:12:34 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15IB2mMm080216;
        Fri, 18 Jun 2021 07:10:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=wG3dItIGJx5nWHwfOOy4fKoHijrTyKPmYfp4/LAqaFo=;
 b=qL689weGoZFbOfvX6G+IbINgeToyvXt/gNbsHaBWo/21CWYb7+BUJaThqkSOgyqLZdu2
 YfHXAg0myOYQbw+tpNTq0ooHmyj8i6WBV6mJjNL+3KPED3o6xOgNqXi00umMUCsDzDRN
 tz2ytYfTxJE900AjGXrseARTuAu0s5hVW5gVGhktS7HHatDHaelvHvzwBlxGJzfnuAkS
 38VO0R0Tg4Tp/jsux0g9XvO9CMvbeppqdBtJ+CJuj9YRMKo7kHj+2qrdoDn4ZKmK2NGC
 iWxwjhh0h5iqQuifFGJL71l6mK8VVZ9li276/yuUn8DXRvvwDBWAJoPCU94Q1yBm8L0D RA== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 398rhbu7nf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 07:10:23 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15IB7rRQ003508;
        Fri, 18 Jun 2021 11:10:21 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 394mj8st9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 11:10:21 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15IBAJDG23921148
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 11:10:19 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A3F8AE057;
        Fri, 18 Jun 2021 11:10:19 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7C44AE04D;
        Fri, 18 Jun 2021 11:10:18 +0000 (GMT)
Received: from localhost (unknown [9.85.68.238])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 18 Jun 2021 11:10:18 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH 7/9] btrfs/cfg: Add 4k and 64k related configs
Date:   Fri, 18 Jun 2021 16:39:58 +0530
Message-Id: <6580f4c95aee22762faee755804a49b275cbc2eb.1624007533.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1624007533.git.riteshh@linux.ibm.com>
References: <cover.1624007533.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rNBObqEWKOewjNRen6vpoK04WxILO6Z9
X-Proofpoint-GUID: rNBObqEWKOewjNRen6vpoK04WxILO6Z9
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-18_04:2021-06-18,2021-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 mlxlogscore=728
 bulkscore=0 mlxscore=0 impostorscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106180064
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This adds btrfs 4k and 64k configs.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 kvm-xfstests/test-appliance/files/root/fs/btrfs/cfg/4k  | 5 +++++
 kvm-xfstests/test-appliance/files/root/fs/btrfs/cfg/64k | 5 +++++
 2 files changed, 10 insertions(+)
 create mode 100644 kvm-xfstests/test-appliance/files/root/fs/btrfs/cfg/4k
 create mode 100644 kvm-xfstests/test-appliance/files/root/fs/btrfs/cfg/64k

diff --git a/kvm-xfstests/test-appliance/files/root/fs/btrfs/cfg/4k b/kvm-xfstests/test-appliance/files/root/fs/btrfs/cfg/4k
new file mode 100644
index 0000000..c384b8d
--- /dev/null
+++ b/kvm-xfstests/test-appliance/files/root/fs/btrfs/cfg/4k
@@ -0,0 +1,5 @@
+SIZE=small
+export MKFS_OPTIONS="-s 4096 -n 4096"
+export MOUNT_OPTIONS=""
+export SCRATCH_DEV_POOL="/dev/vdc /dev/vdi /dev/vdj /dev/vdk"
+TESTNAME="btrfs 4k block"
diff --git a/kvm-xfstests/test-appliance/files/root/fs/btrfs/cfg/64k b/kvm-xfstests/test-appliance/files/root/fs/btrfs/cfg/64k
new file mode 100644
index 0000000..c234101
--- /dev/null
+++ b/kvm-xfstests/test-appliance/files/root/fs/btrfs/cfg/64k
@@ -0,0 +1,5 @@
+SIZE=small
+export SCRATCH_DEV_POOL="/dev/vdc /dev/vdi /dev/vdj /dev/vdk"
+export MKFS_OPTIONS="-s 65536 -n 65536"
+export MOUNT_OPTIONS=""
+TESTNAME="btrfs 64k block"
-- 
2.31.1

