Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D39DD29F593
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Oct 2020 20:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgJ2TxQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Oct 2020 15:53:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38726 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725780AbgJ2TxP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 29 Oct 2020 15:53:15 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09TJWGvv099474;
        Thu, 29 Oct 2020 15:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=6ckVYkG3rz+Dh40rH7ktk+hyT+SyLyYm11nHgXNnLQ8=;
 b=IVr8Zf6A2Smqj0VJPdBptw7p/tQ/l90vLTEqS3FTx96qVqhJtbbgY7uH8YFZw+LgG7P0
 TBLn0UfGloQIW3PQmZLrib5dHCuOTaeLd/vM2iTDxJnBYDqY5kXwRLRolwFJ8VsgAE0T
 yU0dnkAF4XI24YpIKpwQbmdTF6DEDJyGlOzxC4OOfLpCwUuW4OzwbxrEje6kdDZ9ZOHI
 OSWej308esATxW4ENiYBBVDctWNhue6/0vGWXJLd/aaFobgSfaGgLVJemd7q6Z8iz2qm
 OeuIBtj/43ky0NxWOzxqiDpjV5Q/m22/AzscyEnNlkAPJ8xBOiRiquTDqLTrD19mb+iq Uw== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34fnh068x9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Oct 2020 15:53:12 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09TJmK1O025113;
        Thu, 29 Oct 2020 19:53:10 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 34fvc487cr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Oct 2020 19:53:10 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09TJr8uF33948084
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Oct 2020 19:53:08 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 533E94C050;
        Thu, 29 Oct 2020 19:53:08 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92EB54C044;
        Thu, 29 Oct 2020 19:53:06 +0000 (GMT)
Received: from riteshh-domain.ibmuc.com (unknown [9.199.33.247])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 29 Oct 2020 19:53:06 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests@vger.kernel.org
Cc:     anju@linux.vnet.ibm.com, Eryu Guan <guan@eryu.me>,
        linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH 0/3] fstests: Fix tests which checks for swapfile support
Date:   Fri, 30 Oct 2020 01:22:50 +0530
Message-Id: <cover.1604000570.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-29_11:2020-10-29,2020-10-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 mlxlogscore=852 lowpriorityscore=0 clxscore=1011 impostorscore=0
 suspectscore=13 priorityscore=1501 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010290131
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

For more details, pls refer commit msg of each patch.

Patch-1: modifies _require_scratch_swapfile() to check swapon only for btrfs
Patch-2: adds a swapfile test for fallocate files for ext4, xfs (assuming
both FS supports and thus should pass).
Patch-3: added to support tests to run when multiple config section present
in local.config file.

Ritesh Harjani (3):
  common/rc: Make swapon check in _require_scratch_swapfile() specific to btrfs
  shared/001: Verify swapon on fallocated files for supported FS
  common/rc: source common/xfs and common/btrfs

 common/rc            | 20 +++++----
 tests/shared/001     | 97 ++++++++++++++++++++++++++++++++++++++++++++
 tests/shared/001.out |  6 +++
 tests/shared/group   |  1 +
 4 files changed, 116 insertions(+), 8 deletions(-)
 create mode 100755 tests/shared/001
 create mode 100644 tests/shared/001.out

--
2.26.2

