Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1447BAD8D
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Sep 2019 07:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731186AbfIWFoZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Sep 2019 01:44:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28220 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731158AbfIWFoZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 23 Sep 2019 01:44:25 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8N5c0iJ045877
        for <linux-ext4@vger.kernel.org>; Mon, 23 Sep 2019 01:44:22 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v6qb1sbut-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Mon, 23 Sep 2019 01:44:21 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Mon, 23 Sep 2019 06:44:19 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 23 Sep 2019 06:44:16 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8N5iE2i57606298
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Sep 2019 05:44:14 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A04FAE053;
        Mon, 23 Sep 2019 05:44:14 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E9ED0AE059;
        Mon, 23 Sep 2019 05:44:10 +0000 (GMT)
Received: from dhcp-9-199-158-218.in.ibm.com (unknown [9.199.158.218])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 23 Sep 2019 05:44:10 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org,
        adilger@dilger.ca
Cc:     joseph.qi@linux.alibaba.com, david@fromorbit.com,
        hch@infradead.org, riteshh@linux.ibm.com,
        mbobrowski@mbobrowski.org, rgoldwyn@suse.de,
        aneesh.kumar@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [RFC-v2 0/2] ext4: Improve ilock scalability to improve performance in DirectIO workloads
Date:   Mon, 23 Sep 2019 11:14:05 +0530
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19092305-0012-0000-0000-0000034F6C58
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19092305-0013-0000-0000-00002189F661
Message-Id: <20190923054407.8102-1-riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-23_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909230054
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello All, 

These are ilock patches which helps improve the current inode lock scalabiliy
problem in ext4 DIO mixed-read/write workload case. The problem was first
reported by Joseph [1]. These patches are based upon upstream discussion
with Jan Kara & Joseph [2]. 

Since these patches introduce ext4_ilock/unlock API for inode locking/
unlocking in shared v/s exclusive mode to help achieve better
scalability in DIO writes case, it was better to take care of inode_trylock
for RWF_NOWAIT case in the same patch set.
Discussion about this can be found here [3].
Please let me know if otherwise.

These patches are based on the top of ext4 iomap for DIO patches by
Matthew [4].

Now, since this is a very interesting scalability problem w.r.t locking,
I thought of collecting a comprehensive set of performance numbers for
DIO sync mixed random read/write workload w.r.t number of threads (ext4).
This commit msg will present a performance benefit histogram using this
patch set v/s vanilla kernel (v5.3-rc5) in DIO mixed randrw workload.

Git tree for this can be found at-
https://github.com/riteshharjani/linux/tree/ext4-ilock-RFC-v2

Background
==========

dioread_nolock feature in ext4, is to allow multiple DIO reads in parallel.
Also, in case of overwrites DIO since there is no block allocation needed,
those I/Os too can run in parallel. This gives a good scalable I/O
performance w.r.t multiple DIO read/writes threads.
In case of buffer write with dioread_nolock feature, ext4 will allocate
uninitialized extent and once the IO is completed will convert it back
to initialized.

But recently DIO reads got changed to be under shared inode rwsem.
commit 16c54688592c ("ext4: Allow parallel DIO reads").
It did allow parallel DIO reads to work fine, but this degraded the mixed
DIO read/write workload.


Problem description
===================

Currently in DIO writes case, we start with an exclusive inode rwsem
and only once we know that it is a overwrite (with dioread_nolock mnt
option enabled),
we demote it to shared lock. Now with mixed DIO reads & writes, this
has a scalability problem. Which is, if we have any ongoing DIO reads,
then DIO writes (since it starts with exclusive) has to wait until the
shared lock is released (which only happens when DIO read is completed).
The same can be easily observed with perf-tools trace analysis.


Implementation
==============

To fix this, we start with a shared lock (unless an exclusive lock is needed
in certain cases e.g. extending/unaligned writes) in DIO write case.
Then if it is a overwrite we continue with shared lock, if not then we
release the shared lock and switch to exclusive lock and
redo certain checks again.

This approach help in achieving good scalablity for mixed DIO read/writes
worloads [5-6].

Performance results
===================

The performance numbers are collected using fio tool with dioread_nolock
mount option for DIO mixed random read/write(randrw) worload with 4K & 1M burst
sizes for increasing number of threads (1, 2, 4, 8, 12, 16, 24).
The performance historgram shown below is the percentage change in
performance by using this ilock patchset as compared to vanilla kernel
(v5.3-rc5).

To check absolute score comparison with some colorful graphs, refer [5-6].

FIO command:
fio -name=DIO-mixed-randrw -filename=./testfile -direct=1 -iodepth=1 -thread \
-rw=randrw -ioengine=psync -bs=$bs -size=10G -numjobs=$thread \
-group_reporting=1 -runtime=120

With dioread_nolock mount option
================================

Below shows the performance benefit hist with this ilock patchset in (%)
w.r.t vanilla kernel(v5.3-rc5) with dioread_nolock mount option for
mixed randrw workload (for 4K block size).
If we notice, the percentage benefit increases with increasing number of
threads. So this patchset help achieve good scalability in the mentioned
workload. Also this gives upto ~70% perf improvement in 24 threads mixed randrw
workload with 4K burst size.
The performance difference can be even higher with high speed storage
devices, since bw speeds without the patch seems to flatten due to lock
contention problem in case of multiple threads.

Absolute graph comparison can be seen here - [5]

        Performance benefit (%) data randrw (read)-4K
  80 +-+------+--------+-------+--------+--------+--------+-------+------+-+   
     |        +        +       +        +        +        +       +        |   
  70 +-+                                                           **    +-+   
     |                                                    **       **      |   
  60 +-+                                          **      **       **    +-+   
     |                                            **      **       **      |   
  50 +-+                                 **       **      **       **    +-+   
     |                                   **       **      **       **      |   
  40 +-+                                 **       **      **       **    +-+   
  30 +-+                        **       **       **      **       **    +-+   
     |                          **       **       **      **       **      |   
  20 +-+                        **       **       **      **       **    +-+   
     |                          **       **       **      **       **      |   
  10 +-+               **       **       **       **      **       **    +-+   
     |         **      **       **       **       **      **       **      |   
   0 +-+       **      **       **       **       **      **       **    +-+   
     |        +        +       +        +        +        +       +        |   
 -10 +-+------+--------+-------+--------+--------+--------+-------+------+-+   
             1,       2,      4,       8,       12,      16,     24,           
                                 No. of threads                                
                                                                               

        Performance benefit (%) data randrw (write)-4K                           
  80 +-+------+--------+-------+--------+--------+--------+-------+------+-+   
     |        +        +       +        +        +        +       +        |   
  70 +-+                                                           **    +-+   
     |                                                    **       **      |   
  60 +-+                                          **      **       **    +-+   
     |                                            **      **       **      |   
  50 +-+                                 **       **      **       **    +-+   
     |                                   **       **      **       **      |   
  40 +-+                                 **       **      **       **    +-+   
  30 +-+                        **       **       **      **       **    +-+   
     |                          **       **       **      **       **      |   
  20 +-+                        **       **       **      **       **    +-+   
     |                          **       **       **      **       **      |   
  10 +-+                        **       **       **      **       **    +-+   
     |         **      **       **       **       **      **       **      |   
   0 +-+       **      **       **       **       **      **       **    +-+   
     |        +        +       +        +        +        +       +        |   
 -10 +-+------+--------+-------+--------+--------+--------+-------+------+-+   
             1,       2,      4,       8,       12,      16,     24,           
                                 No. of threads                                


Below shows the performance benefit hist with this ilock patchset in (%)
w.r.t vanilla kernel (v5.3-rc5) with dioread_nolock mount option for
mixed randrw workload (for 1M burst size).
This shows upto ~20% perf improvement in 24 threads workload with 1M
burst size.
Absolute graph comparison can be seen here - [6]

	Performance benefit (%) data randrw (read)-1M                         
  25 +-+------+--------+-------+--------+--------+--------+-------+------+-+   
     |        +        +       +        +        +        +       +        |   
     |                                                             **      |   
  20 +-+                                                           **    +-+   
     |                                                             **      |   
     |                                                             **      |   
  15 +-+                                                           **    +-+   
     |                                   **               **       **      |   
  10 +-+                                 **               **       **    +-+   
     |                                   **       **      **       **      |   
     |                                   **       **      **       **      |   
   5 +-+                                 **       **      **       **    +-+   
     |                                   **       **      **       **      |   
     |                 **       **       **       **      **       **      |   
   0 +-+       **      **       **       **       **      **       **    +-+   
     |         **                                                          |   
     |        +        +       +        +        +        +       +        |   
  -5 +-+------+--------+-------+--------+--------+--------+-------+------+-+   
             1,       2,      4,       8,       12,      16,     24,           
                                 No. of threads                                
                                                                               
        Performance benefit (%) data randrw (write)-1M                         
  25 +-+------+--------+-------+--------+--------+--------+-------+------+-+   
     |        +        +       +        +        +        +       +        |   
     |                                                                     |   
  20 +-+                                                           **    +-+   
     |                                                             **      |   
     |                                                             **      |   
  15 +-+                                                           **    +-+   
     |                                                    **       **      |   
  10 +-+                                 **               **       **    +-+   
     |                                   **       **      **       **      |   
     |                                   **       **      **       **      |   
   5 +-+                                 **       **      **       **    +-+   
     |                          **       **       **      **       **      |   
     |                 **       **       **       **      **       **      |   
   0 +-+       **      **       **       **       **      **       **    +-+   
     |         **                                                          |   
     |        +        +       +        +        +        +       +        |   
  -5 +-+------+--------+-------+--------+--------+--------+-------+------+-+   
             1,       2,      4,       8,       12,      16,     24,           
                                 No. of threads                                


Without dioread_nolock mount option
===================================

I do see a little degradation without this mount option, but as per my performance
runs, this is within ~(-0.5 to -3)% limit. With 1M burst size, difference is even
better in some runs. So, ~(-3 to 3)% deviation is something which could be called
a run-to-run variation mostly. But for completeness sake I still present
the below data collected.

        Performance(%) data randrw (read)-4K
  3 +-+------+--------+--------+--------+-------+--------+--------+------+-+   
    |        +        +        +        +       +        +        +        |   
    |                                                                      |   
  2 +-+                                                                  +-+   
    |                                                                      |   
    |                                                                      |   
  1 +-+                                                                  +-+   
    |                                                                      |   
  0 +-+       **       **       **      **       **       **       **    +-+   
    |         **       **       **      **       **       **       **      |   
    |         **       **       **      **       **       **       **      |   
 -1 +-+                **       **      **       **       **       **    +-+   
    |                  **       **      **       **       **               |   
    |                  **       **      **       **       **               |   
 -2 +-+                **       **      **       **       **             +-+   
    |                           **      **       **       **               |   
    |        +        +        +**      **      +**      +        +        |   
 -3 +-+------+--------+--------+--------+-------+--------+--------+------+-+   
            1,       2,       4,       8,      12,      16,      24,           
                                No. of threads                                 
                                                                               
                                                                               
        Performance(%) data randrw (write)-4K                             
  3 +-+------+--------+--------+--------+-------+--------+--------+------+-+   
    |        +        +        +        +       +        +        +        |   
    |                                                                      |   
  2 +-+                                                                  +-+   
    |                                                                      |   
    |                                                                      |   
  1 +-+                                                                  +-+   
    |                                                                      |   
  0 +-+       **       **       **      **       **       **       **    +-+   
    |         **       **       **      **       **       **       **      |   
    |         **       **       **      **       **       **       **      |   
 -1 +-+                **       **      **       **       **       **    +-+   
    |                  **       **      **       **       **               |   
    |                  **       **      **       **       **               |   
 -2 +-+                **       **      **       **       **             +-+   
    |                           **      **       **       **               |   
    |        +        +        +**      +       +        +        +        |   
 -3 +-+------+--------+--------+--------+-------+--------+--------+------+-+   
            1,       2,       4,       8,      12,      16,      24,           
                                No. of threads                                 



        Performance(%) data randrw (read)-1M
  3 +-+------+--------+--------+--------+-------+--------+--------+------+-+   
    |        +        +        +        +       +        +        +        |   
    |                                                                      |   
  2 +-+       **                                                         +-+   
    |         **                                                   **      |   
    |         **                                 **                **      |   
  1 +-+       **       **                        **                **    +-+   
    |         **       **                        **                **      |   
  0 +-+       **       **       **      **       **       **       **    +-+   
    |                           **      **                **               |   
    |                           **      **                                 |   
 -1 +-+                         **                                       +-+   
    |                           **                                         |   
    |                                                                      |   
 -2 +-+                                                                  +-+   
    |                                                                      |   
    |        +        +        +        +       +        +        +        |   
 -3 +-+------+--------+--------+--------+-------+--------+--------+------+-+   
            1,       2,       4,       8,      12,      16,      24,           
                                No. of threads                                 
                                                                               
                                                                               
        Performance(%) data randrw (write)-1M
  3 +-+------+--------+--------+--------+-------+--------+--------+------+-+   
    |        +        +        +        +       +        +        +**      |   
    |                                                              **      |   
  2 +-+       **                                                   **    +-+   
    |         **                                                   **      |   
    |         **                                 **                **      |   
  1 +-+       **       **                        **       **       **    +-+   
    |         **       **                        **       **       **      |   
  0 +-+       **       **       **      **       **       **       **    +-+   
    |                           **      **                                 |   
    |                           **      **                                 |   
 -1 +-+                         **                                       +-+   
    |                           **                                         |   
    |                                                                      |   
 -2 +-+                                                                  +-+   
    |                                                                      |   
    |        +        +        +        +       +        +        +        |   
 -3 +-+------+--------+--------+--------+-------+--------+--------+------+-+   
            1,       2,       4,       8,      12,      16,      24,           
                                No. of threads                                 
                                                                              

Git tree- https://github.com/riteshharjani/linux/tree/ext4-ilock-RFC-v2

References
==========
[1]: https://lore.kernel.org/linux-ext4/1566871552-60946-4-git-send-email-joseph.qi@linux.alibaba.com/
[2]: https://lore.kernel.org/linux-ext4/20190910215720.GA7561@quack2.suse.cz/
[3]: https://lore.kernel.org/linux-fsdevel/20190911103117.E32C34C044@d06av22.portsmouth.uk.ibm.com/
[4]: https://lwn.net/Articles/799184/

[5]: https://github.com/riteshharjani/LinuxStudy/blob/master/ext4/fio-output/vanilla-vs-ilocknew-randrw-dioread-nolock-4K.png
[6]: https://github.com/riteshharjani/LinuxStudy/blob/master/ext4/fio-output/vanilla-vs-ilocknew-randrw-dioread-nolock-1M.pg

Ritesh Harjani (2):
  ext4: Add ext4_ilock & ext4_iunlock API
  ext4: Improve DIO writes locking sequence

 fs/ext4/ext4.h    |  33 ++++++
 fs/ext4/extents.c |  16 +--
 fs/ext4/file.c    | 260 ++++++++++++++++++++++++++++++++--------------
 fs/ext4/inode.c   |   4 +-
 fs/ext4/ioctl.c   |  16 +--
 fs/ext4/super.c   |  12 +--
 fs/ext4/xattr.c   |  16 +--
 7 files changed, 249 insertions(+), 108 deletions(-)

-- 
2.21.0

