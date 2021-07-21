Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDDF3D083D
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jul 2021 07:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbhGUErg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Jul 2021 00:47:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:65032 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229450AbhGUEre (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 21 Jul 2021 00:47:34 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16L542F8028548;
        Wed, 21 Jul 2021 01:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=NICI5Rv7QYHw0dLqmtiHhsDwLuJNAn+1FJatrDjVSU0=;
 b=qFbL+FrIrowOE1Cg70OgHnRQmWS+ALZSQtC4OI9ryYpfRTUiBD7AaGYRhwbK1P5Na4uZ
 Q+mvSbs1eI+BbA7FgqSm/Ux3l/8NONGe9OJiqTnxFIgio1vfl1YxK5pxiBJWHgCS1xbp
 PIv6hU4q/NIH4Gjq104SP1PhFL8Uter8R/98DBO/T7ExcLYEiCheY8tdVzyx6Ftx7OFA
 wMtBxv85PC+8mBWJ6u4J54CGpBqByk4MbTtQ4FKswHA89idSwIv2J8TNaQ0O8xVWlcjD
 xVgOt72/Rp5pKiYHjDfUAjBXVobFgFA21LiWLQZeKTiwNpwPn6PfROQAcaHuEIhLTzIx 0w== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39xb4ttuq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jul 2021 01:28:08 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16L5DEii027484;
        Wed, 21 Jul 2021 05:28:07 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 39upfh90d4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jul 2021 05:28:07 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16L5S49S28049774
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 05:28:04 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B791DAE057;
        Wed, 21 Jul 2021 05:28:04 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45FC7AE056;
        Wed, 21 Jul 2021 05:28:04 +0000 (GMT)
Received: from localhost (unknown [9.85.82.121])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 21 Jul 2021 05:28:04 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv2 0/9] xfstests: 64K blocksize related fixes
Date:   Wed, 21 Jul 2021 10:57:53 +0530
Message-Id: <cover.1626844259.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wwJwGX9k4Xgn7Uoebcu0BkbE4vrqPd59
X-Proofpoint-ORIG-GUID: wwJwGX9k4Xgn7Uoebcu0BkbE4vrqPd59
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-21_02:2021-07-21,2021-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0
 mlxscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107210025
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

Below are the list of fixes mostly centered around 64K blocksize
and with ext4 filesystem. Tested this with both 64K & 4K blocksize on Power
with (ext4/ext3/ext2/xfs/btrfs).

v1 -> v2
1. Address comments from Ted and Darrick mentioned at [1]

[1]: https://patchwork.kernel.org/cover/12318137

Ritesh Harjani (9):
  ext4/003: Fix this test on 64K platform for dax config
  ext4/027: Correct the right code of block and inode bitmap
  ext4/306: Add -b blocksize parameter too to avoid failure with DAX config
  ext4/022: exclude this test for dax config on 64KB pagesize platform
  generic/031: Fix the test case for 64k blocksize config
  common/rc: Add _mkfs_dev_blocksized functionality
  generic/620: Use _mkfs_dev_blocksized to use 4k bs
  common/attr: Cleanup end of line whitespaces issues
  common/attr: Reduce MAX_ATTRS to leave some overhead for 64K blocksize

 common/attr           | 57 ++++++++++++++++++++++++++++++++++++-------
 common/rc             | 47 +++++++++++++++++++++++++++++++++++
 tests/ext4/003        |  3 ++-
 tests/ext4/022        |  7 ++++--
 tests/ext4/027        |  4 +--
 tests/ext4/306        |  5 +++-
 tests/generic/031     | 14 +++++++----
 tests/generic/031.out | 16 ++++++------
 tests/generic/620     |  4 ++-
 9 files changed, 128 insertions(+), 29 deletions(-)

--
2.31.1

