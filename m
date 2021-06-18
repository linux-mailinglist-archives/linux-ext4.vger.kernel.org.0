Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D6F3AC97D
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Jun 2021 13:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbhFRLM2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Jun 2021 07:12:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36376 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229848AbhFRLM2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 18 Jun 2021 07:12:28 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15IB3J7O054799;
        Fri, 18 Jun 2021 07:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=blEQM4BBP9v1jdR3Ua/abPMsYz7Z5a0b67HOHlwmAQw=;
 b=nHJITgdu97/L0uku525xeCSVxX7UUxo+jk32XRoGRRANULJD+ZasVmcLVi0BDkhFDzXS
 RICwkYS+gejUU20l+CZtl6HAXvJq/lWmWf9RtcG7xxqdLqQ/WHVqsoEeYljfcwmkK1m3
 HSCBzvdq9YSUy03fF4zM9U6l35u74PKgVl+Bdfgdqx6gZ4S90vB6qwIaqZ4+Xxl6QeP9
 /KZgb3pKhx0+nUE5A4bopJJ/pbbvBlR0dCgDeV019IR9Ogg8TdmS4ssvYqdPS6Ufqm5J
 sbKa937gh4mVdUeReg/9IYwXIUhXSCglSpfcEIjRfJgRysaLw1azi2Fpz+5AxBXP4k2f VQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 398qenda3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 07:10:17 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15IBAC83010861;
        Fri, 18 Jun 2021 11:10:15 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 394m6hu8qb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 11:10:15 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15IBACEP34079128
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 11:10:12 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F722AE04D;
        Fri, 18 Jun 2021 11:10:12 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47B70AE053;
        Fri, 18 Jun 2021 11:10:12 +0000 (GMT)
Received: from localhost (unknown [9.85.68.238])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 18 Jun 2021 11:10:12 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH 2/9] ext4/cfg/64K: Add a 64K related config file
Date:   Fri, 18 Jun 2021 16:39:53 +0530
Message-Id: <b4de0bf3f8ef526571e1f25a5a974549f05e47d0.1624007533.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1624007533.git.riteshh@linux.ibm.com>
References: <cover.1624007533.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: t-ah1mK-jfiE6AxKY9014yio_D9Xu8Br
X-Proofpoint-GUID: t-ah1mK-jfiE6AxKY9014yio_D9Xu8Br
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-18_04:2021-06-18,2021-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 mlxlogscore=984 phishscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106180064
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add a 64K related config for platforms like PPC64.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/64k | 4 ++++
 1 file changed, 4 insertions(+)
 create mode 100644 kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/64k

diff --git a/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/64k b/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/64k
new file mode 100644
index 0000000..1f5e6f2
--- /dev/null
+++ b/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/64k
@@ -0,0 +1,4 @@
+SIZE=small
+export EXT_MKFS_OPTIONS="-b 65536"
+export EXT_MOUNT_OPTIONS=""
+TESTNAME="Ext4 64k block"
-- 
2.31.1

