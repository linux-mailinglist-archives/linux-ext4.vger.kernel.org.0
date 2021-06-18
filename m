Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4463AC97B
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Jun 2021 13:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbhFRLM0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Jun 2021 07:12:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15168 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229848AbhFRLMZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 18 Jun 2021 07:12:25 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15IB3vkm143066;
        Fri, 18 Jun 2021 07:10:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=0Q3FRX/7HjKJFmTWKrRE7B7+g8htEoDzqBQ2O+XLxm0=;
 b=hrU/2bzpSvbAFms1ySDose6xSb80ABNtXvnS7fsPjWaqT3mAFfGAQi4EavPiguyjXuXb
 7hysUDS6cOGS3qkYNTgaegDqJfOQ4Ywxp8BXr5f4+jEx6Q+ye79HDoZH2twhuIfM0sUK
 1Uf2+hq7HpqzW71jSvwio7VYl2rmi+dBjbB+ZILHSJEEb49wDxNXQKCVaUMZJgDse4fM
 e1/RF8pLf3xX3DU8cPBJAdkVdoW99KLpFuj6gTBfvjTRunMYn+DcUDhXfXjVj2rzKdRI
 sR7mbNYgSPKV2XOL0mCfiLVkw6mrE0UvdlnOy0GCzUMO1ywnCRpObs9J0b99NTKgqAKj rQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 398sjh9fvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 07:10:14 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15IB8Zm7028726;
        Fri, 18 Jun 2021 11:10:12 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 394mj8u8s3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 11:10:12 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15IBAAeO9175398
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 11:10:10 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E86C0A4065;
        Fri, 18 Jun 2021 11:10:09 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93003A4062;
        Fri, 18 Jun 2021 11:10:09 +0000 (GMT)
Received: from localhost (unknown [9.85.68.238])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 18 Jun 2021 11:10:09 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH 0/9] kvmxfstests: Add 64K related configs for Power
Date:   Fri, 18 Jun 2021 16:39:51 +0530
Message-Id: <cover.1624007533.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ABKoUBnxMl0QSeHt9GzuP2UIw5rGIm5z
X-Proofpoint-GUID: ABKoUBnxMl0QSeHt9GzuP2UIw5rGIm5z
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-18_04:2021-06-18,2021-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 mlxlogscore=830 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106180064
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

These patches adds and/or fixes configs for 64K blocksize/pagesize related
platform (e.g. Power). This series adds some new configs for btrfs and 64K
related configs for ext4/xfs/btrfs.

There are also some fixes related to dax and related to SCRATCH_DEV_POOL
env variable is used by btrfs.

Then the last patch adds some extra packages which many a times are useful while
manual debugging/testing.


Reason for ccing fstests:-
=========================
In past I saw kvmxfstests patches going via fstests. One other reason
for sending it via fstests was to get a feedback on the btrfs & XFS configs.
We have started using kvmxfstests for filesystem testing of ext4/XFS/btrfs on
Power platform and are planning to scale it further to tests weekly upstream
releases too. Thus if there are any suggestions around other configs (mainly for
btrfs and/or XFS) which must (good to include) be tested as part of filesystem
testing, then I will be happy to add those into kvmxfstests suite configs.
For e.g. look at different ext4 configs [1].

[1]: https://github.com/tytso/xfstests-bld/tree/master/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg

Ritesh Harjani (9):
  ext4/cfg/dax: Fix for 64K pagesize platform
  ext4/cfg/64K: Add a 64K related config file
  ext4/cfg/fast_commit: Add explicit 4k bs option
  ext4/cfg/fast_commit_64K: Add a config file to test fast_commit with 64K bs
  xfs/cfg/dax: Fix this config to work on 64K pagesize platform too
  xfs/cfg/64K: Add a config file with 64K blocksize
  btrfs/cfg: Add 4k and 64k related configs
  runtests.sh: Fix when SCRATCH_DEV_POOL is passed
  xfstests-packages: Add some more packages.

 kvm-xfstests/test-appliance/files/root/fs/btrfs/cfg/4k      | 5 +++++
 kvm-xfstests/test-appliance/files/root/fs/btrfs/cfg/64k     | 5 +++++
 kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/64k      | 4 ++++
 kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/dax      | 4 ++--
 .../test-appliance/files/root/fs/ext4/cfg/fast_commit       | 2 +-
 .../test-appliance/files/root/fs/ext4/cfg/fast_commit_64k   | 4 ++++
 kvm-xfstests/test-appliance/files/root/fs/xfs/cfg/64k       | 3 +++
 kvm-xfstests/test-appliance/files/root/fs/xfs/cfg/dax       | 2 +-
 kvm-xfstests/test-appliance/files/root/runtests.sh          | 6 ++++++
 kvm-xfstests/test-appliance/xfstests-packages               | 4 ++++
 10 files changed, 35 insertions(+), 4 deletions(-)
 create mode 100644 kvm-xfstests/test-appliance/files/root/fs/btrfs/cfg/4k
 create mode 100644 kvm-xfstests/test-appliance/files/root/fs/btrfs/cfg/64k
 create mode 100644 kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/64k
 create mode 100644 kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/fast_commit_64k
 create mode 100644 kvm-xfstests/test-appliance/files/root/fs/xfs/cfg/64k

--
2.31.1

