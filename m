Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3236B16FB63
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Feb 2020 10:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgBZJ52 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Feb 2020 04:57:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23762 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727359AbgBZJ51 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 26 Feb 2020 04:57:27 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01Q9nPI0069692
        for <linux-ext4@vger.kernel.org>; Wed, 26 Feb 2020 04:57:26 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ydkf8wy9m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Wed, 26 Feb 2020 04:57:26 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 26 Feb 2020 09:57:24 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 26 Feb 2020 09:57:21 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01Q9vK5P60424226
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Feb 2020 09:57:20 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2159C42042;
        Wed, 26 Feb 2020 09:57:20 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0F2A42049;
        Wed, 26 Feb 2020 09:57:17 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.47.18])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 26 Feb 2020 09:57:17 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org
Cc:     adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, hch@infradead.org, cmaiolino@redhat.com,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv3 0/6] ext4: bmap & fiemap conversion to use iomap
Date:   Wed, 26 Feb 2020 15:27:02 +0530
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022609-0016-0000-0000-000002EA6266
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022609-0017-0000-0000-0000334D9132
Message-Id: <cover.1582702366.git.riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-26_02:2020-02-25,2020-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002260074
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello All, 

Background
==========
These are v3 patches to move ext4 bmap & fiemap calls to use iomap APIs.
Previous version can be found in [RFCv2] link mentioned below.
After some discussions with the community in [RFCv2] all of the below
observational differences between the old and the new (iomap based
implementation) has been agreed upon. It looks like we should be good to move
ext4_fiemap & ext4_bmap too to iomap interface.

FYI - this patch reduces the users of ext4_get_block API and thus a step
towards getting rid of buffer_heads from ext4.
Also reduces a lot of code by making use of existing iomap_ops.

RFCv2 -> PATCHv3
================
1. Fixed IOMAP_INLINE & IOMAP_MAPPED flag setting in *xattr_fiemap() based
   on, whether it is inline v/s external block.
2. Fixed fiemap for non-extent based mapping. [PATCHv3 4/6] fixes it.
3. Updated the documentation for description about FIEMAP_EXTENT_LAST flag.
   [PATCHv3 6/6].


Testing (done on ext4 master branch)
========
'xfstests -g quick' passes with default mkfs/mount configuration
(v/s which also pass with vanilla kernel without this patch). Except
generic/473 which also failes on XFS. This seems to be the test case issue
since it expects the data in slightly different way as compared to what iomap
returns.
Point 2.a below describes more about this.

Observations/Review required
============================
1. bmap related old v/s new method differences:-
	a. In case if addr > INT_MAX, it issues a warning and
	   returns 0 as the block no. While earlier it used to return the
	   truncated value with no warning.
	[Again this should be fine, it was just an observation worth mentioning]

	b. block no. is only returned in case of iomap->type is IOMAP_MAPPED,
	   but not when iomap->type is IOMAP_UNWRITTEN. While with previously
	   we used to get block no. for both of above cases.
	[Darrick:- not much reason to map unwritten blocks. So this may not
	 be relevant here [5]]

2. Fiemap related old v/s new method differences:-
	a. iomap_fiemap returns the disk extent information in exact
	   correspondence with start of user requested logical offset till the
	   length requested by user. While in previous implementation the
	   returned information used to give the complete extent information if
	   the range requested by user lies in between the extent mapping.
	[Both behaviors should be fine here as per documentation - [5]]

	b. iomap_fiemap adds the FIEMAP_EXTENT_LAST flag also at the last
	   fiemap_extent mapping range requested by the user via fm_length (
	   if that has a valid mapped extent on the disk). But if the user
	   requested for more fm_length which could not be mapped in the last
	   fiemap_extent, then the flag is not set.
	[This does not seems to be an issue after some community discussion.
	Since this flag is not consistent across different filesystems.
	In ext4 itself for extent v/s non-extent based mapping, this flag is
	set differently. So we rather decided to update the documentation rather
	than complicating it more, which anyway no one seems to cares about -
	[6,7]]
	   

Below is CTRL-C -> CTRL-V from from previous versions
=====================================================

e.g. output for above differences 2.a & 2.b
===========================================
create a file with below cmds. 
1. fallocate -o 0 -l 8K testfile.txt
2. xfs_io -c "pwrite 8K 8K" testfile.txt
3. check extent mapping:- xfs_io -c "fiemap -v" testfile.txt
4. run this binary on with and without these patches:- ./a.out (test_fiemap_diff.c) [4]

o/p of xfs_io -c "fiemap -v"
============================================
With this patch on patched kernel:-
testfile.txt:
 EXT: FILE-OFFSET      BLOCK-RANGE          TOTAL FLAGS
   0: [0..15]:         122802736..122802751    16 0x800
   1: [16..31]:        122687536..122687551    16   0x1

without patch on vanilla kernel (no difference):-
testfile.txt:
 EXT: FILE-OFFSET      BLOCK-RANGE          TOTAL FLAGS
   0: [0..15]:         332211376..332211391    16 0x800
   1: [16..31]:        332722392..332722407    16   0x1


o/p of a.out without patch:-
================
riteshh-> ./a.out 
logical: [       0..      15] phys: 332211376..332211391 flags: 0x800 tot: 16
(0) extent flag = 2048

o/p of a.out with patch (both point 2.a & 2.b could be seen)
=======================
riteshh-> ./a.out
logical: [       0..       7] phys: 122802736..122802743 flags: 0x801 tot: 8
(0) extent flag = 2049

FYI - In test_fiemap_diff.c test we had 
a. fm_extent_count = 1
b. fm_start = 0
c. fm_length = 4K
Whereas when we change fm_extent_count = 32, then we don't see any difference.

e.g. output for above difference listed in point 1.b
====================================================

o/p without patch (block no returned for unwritten block as well)
=========Testing IOCTL FIBMAP=========
File size = 16384, blkcnt = 4, blocksize = 4096
  0   41526422
  1   41526423
  2   41590299
  3   41590300

o/p with patch (0 returned for unwritten block)
=========Testing IOCTL FIBMAP=========
File size = 16384, blkcnt = 4, blocksize = 4096
  0          0          0
  1          0          0
  2   15335942      29953
  3   15335943      29953

Summary:-
========
Due to some of the observational differences to user, listed above,
requesting to please help with a careful review in moving this to iomap.
Digging into some older threads, it looks like these differences should be fine,
since the same tools have been working fine with XFS (which uses iomap based
implementation) [1]
Also as Ted suggested in [3]: Fiemap & bmap spec could be made based on the ext4
implementation. But since all the tools also work with xfs which uses iomap
based fiemap, so we should be good there.


References of some previous discussions:
=======================================
[RFCv1]: https://www.spinics.net/lists/linux-ext4/msg67077.html
[RFCv2]: https://marc.info/?l=linux-ext4&m=158020672413871&w=2 
[1]: https://www.spinics.net/lists/linux-fsdevel/msg128370.html
[2]: https://www.spinics.net/lists/linux-fsdevel/msg127675.html
[3]: https://www.spinics.net/lists/linux-fsdevel/msg128368.html
[4]: https://raw.githubusercontent.com/riteshharjani/LinuxStudy/master/tools/test_fiemap_diff.c
[5]: https://marc.info/?l=linux-fsdevel&m=158040005907862&w=2
[6]: https://marc.info/?l=linux-fsdevel&m=158221859807604&w=2
[7]: https://marc.info/?l=linux-ext4&m=158228563431539&w=2


Ritesh Harjani (6):
  ext4: Add IOMAP_F_MERGED for non-extent based mapping
  ext4: Optimize ext4_ext_precache for 0 depth
  ext4: Move ext4 bmap to use iomap infrastructure.
  ext4: Make ext4_ind_map_blocks work with fiemap
  ext4: Move ext4_fiemap to use iomap framework.
  Documentation: Correct the description of FIEMAP_EXTENT_LAST

 Documentation/filesystems/fiemap.txt |  10 +-
 fs/ext4/extents.c                    | 290 +++++----------------------
 fs/ext4/indirect.c                   |  11 +-
 fs/ext4/inline.c                     |  41 ----
 fs/ext4/inode.c                      |   6 +-
 5 files changed, 66 insertions(+), 292 deletions(-)

-- 
2.21.0

