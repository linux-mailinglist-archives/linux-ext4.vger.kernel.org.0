Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0760B4C03
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 12:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbfIQKdD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Sep 2019 06:33:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35034 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725927AbfIQKdD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 17 Sep 2019 06:33:03 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8HAWfQO074008
        for <linux-ext4@vger.kernel.org>; Tue, 17 Sep 2019 06:33:02 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v2v5vvk8x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Tue, 17 Sep 2019 06:33:01 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Tue, 17 Sep 2019 11:32:59 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 17 Sep 2019 11:32:54 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8HAWsTW12189862
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Sep 2019 10:32:54 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3C414204C;
        Tue, 17 Sep 2019 10:32:53 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 402784203F;
        Tue, 17 Sep 2019 10:32:52 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.31.57])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 17 Sep 2019 10:32:52 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org,
        joseph.qi@linux.alibaba.com
Cc:     david@fromorbit.com, hch@infradead.org, adilger@dilger.ca,
        riteshh@linux.ibm.com, mbobrowski@mbobrowski.org, rgoldwyn@suse.de
Subject: [RFC 0/2] ext4: Improve locking sequence in DIO write path
Date:   Tue, 17 Sep 2019 16:02:47 +0530
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19091710-0016-0000-0000-000002AD14C9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091710-0017-0000-0000-0000330DB85F
Message-Id: <20190917103249.20335-1-riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-17_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=781 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909170107
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

This patch series is based on the upstream discussion with Jan
& Joseph @ [1].
It is based on top of Matthew's v3 ext4 iomap patch series [2]

Patch-1: Adds the ext4_ilock/unlock APIs and also replaces all
inode_lock/unlock instances from fs/ext4/*

For now I already accounted for trylock/lock issue symantics
(which was discussed here [3]) in the same patch,
since the this whole patch was around inode_lock/unlock API,
so I thought it will be best to address that issue in the same patch. 
However, kindly let me know if otherwise.

Patch-2: Commit msg of this patch describes in detail about
what it is doing.
In brief - we try to first take the shared lock (instead of exclusive
lock), unless it is a unaligned_io or extend_io. Then in
ext4_dio_write_checks(), if we start with shared lock, we see
if we can really continue with shared lock or not. If not, then
we release the shared lock then acquire exclusive lock
and restart ext4_dio_write_checks().


Tested against few xfstests (with dioread_nolock mount option),
those ran fine (ext4 & generic).

I tried testing performance numbers on my VM (since I could not get
hold of any real h/w based test device). I could test the fact
that earlier we were trying to do downgrade_write() lock, but with
this patch, that path is now avoided for fio test case
(as reported by Joseph in [4]).
But for the actual results, I am not sure if VM machine testing could
really give the reliable perf numbers which we want to take a look at.
Though I do observe some form of perf improvements, but I could not
get any reliable numbers (not even with the same list of with/without
patches with which Joseph posted his numbers [1]).


@Joseph,
Would it be possible for you to give your test case a run with this
patches? That will be really helpful.

Branch for this is hosted at below tree.

https://github.com/riteshharjani/linux/tree/ext4-ilock-RFC

[1]: https://lore.kernel.org/linux-ext4/20190910215720.GA7561@quack2.suse.cz/
[2]: https://lwn.net/Articles/799184/
[3]: https://lore.kernel.org/linux-fsdevel/20190911103117.E32C34C044@d06av22.portsmouth.uk.ibm.com/
[4]: https://lore.kernel.org/linux-ext4/1566871552-60946-4-git-send-email-joseph.qi@linux.alibaba.com/


Ritesh Harjani (2):
  ext4: Add ext4_ilock & ext4_iunlock API
  ext4: Improve DIO writes locking sequence

 fs/ext4/ext4.h    |  33 ++++++
 fs/ext4/extents.c |  16 +--
 fs/ext4/file.c    | 253 ++++++++++++++++++++++++++++++++--------------
 fs/ext4/inode.c   |   4 +-
 fs/ext4/ioctl.c   |  16 +--
 fs/ext4/super.c   |  12 +--
 fs/ext4/xattr.c   |  16 +--
 7 files changed, 244 insertions(+), 106 deletions(-)

-- 
2.21.0

