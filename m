Return-Path: <linux-ext4+bounces-9487-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B36CB2F24D
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 10:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81E5960684F
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 08:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0D92C21E6;
	Thu, 21 Aug 2025 08:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mhaR019h"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E99286426;
	Thu, 21 Aug 2025 08:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764752; cv=none; b=tHvA525Oz70Pp9W8HPwysIbrowue2KQq1VbwxIcvRPwKq7puoqgP+se1dpaUFSVceG6oHRjkGy1chaVv+wmVTlxcqbii1tQVqQ0akODeyi1op8GpCNI0OLWxrkkI/qnHTuN31rX82fkYFHU9OY8Qdh6C1sXBNhng/Mb2AGA5DNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764752; c=relaxed/simple;
	bh=YH8f9LuYue17HimZLwRrZ2dKi4buVG2w+XdqQClGQTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oz6fikEac03T/rYf/Zj2mcB+iQnCwRyS5YI7a3mnbkHRLyT7buUSM5ZEeQYJEY7SYIRZdTTxcIpNhyDB+PBKAdA17OamdE58Rnaq0IOk6NOCreqcqVMs5WVA+yQTK1zsEWzxPk6YVelkhBqe8eYTNE4oTq7IJgtVmb8my/zVpf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mhaR019h; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KKqpu9011904;
	Thu, 21 Aug 2025 08:25:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=2H/MrotFsMZx/RFMlPb99IUFWAskJX
	X6bnnRaUEyK0Y=; b=mhaR019hNgG444l/N1WAzPdx8i/UdM/RiFZ5lTPBO5VeHn
	QKOnmnGq53JGIVv/awqpwNLz2VGGRl+0IIYDORFIdfcOpi+CIJ2VIIwyirt49k4Y
	ytYkMNwjNGqh8YbwDo5oIqZgJAKvCR5PpDLMbhYgmh4NubtAprvXVnypjQHFMzxI
	8zxPw0oKyxg/3dHbFw7WuJkIMaDAIC8wnSpn9Ll98rsmGzNnBek2jhrGd3u1iHAu
	UxgRnSdokYHDXUk43ZlxsLlxzzWiXsKbzrjnXrLMmOolWS3cYf2qwW868QW6JdcT
	Xtt5QnHqVqluOj0m1SY+2PsnT3sDDoHAGTrwVB/g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vfjru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 08:25:35 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57L8PYdx005612;
	Thu, 21 Aug 2025 08:25:34 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vfjrs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 08:25:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57L6m8lP027145;
	Thu, 21 Aug 2025 08:25:33 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48my4w7ds6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 08:25:33 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57L8PVDK51642802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 08:25:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B0E12004B;
	Thu, 21 Aug 2025 08:25:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1ADDC20040;
	Thu, 21 Aug 2025 08:25:29 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 21 Aug 2025 08:25:28 +0000 (GMT)
Date: Thu, 21 Aug 2025 13:55:29 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v4 11/11] ext4: Atomic write test for extent split across
 leaf nodes
Message-ID: <aKbX-dBzSC1pmPuh@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1754833177.git.ojaswin@linux.ibm.com>
 <2c241ea2ede39914d29aa59cd06acfc951aed160.1754833177.git.ojaswin@linux.ibm.com>
 <0eb2703b-a862-4a40-b271-6b8bb27b4ad4@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0eb2703b-a862-4a40-b271-6b8bb27b4ad4@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wx2NctUtzfC2yHY7-KjOM1LWGayoQw7J
X-Authority-Analysis: v=2.4 cv=IrhHsL/g c=1 sm=1 tr=0 ts=68a6d7ff cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=GWIc7fT3pVVaNgT2m1IA:9
 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfX663KAyLHuNC3
 AAIR5yR03i4dSzBzKXNy5rzLYF3XJ7OLEzHeoU5pulcVzfSawXJdjxdYgQAlYS57RFruBD+xV+g
 m+t/8YbAm+FESeQ0cdLTcJkhxQRx7HfY22ygMZoIFabyk2cFA1tslbqyQNyxGH8h17383zm839v
 voKDRpWKnwkpNBTh5NP3ukty/mg49R5NB8L8iCBsbjAL83fcxNW9kTizgT4MHiemNg/jj5Wn6Nz
 82QoOPeSuNwN8/265PyY+6Y3RSwP12zUo+9rBBGF31SQBGBTwVXSyP81CLEqEFo4MdVbBysUVui
 TkV3ifhJv9DsUAW3iKn0t9vq1lrA0q9++ekw3r5//lSXFP3tU7y4XKMjGQS/t75i2eNVE7QL9aH
 NK9ot6H83BwWYyzoOoygihoq58JZpg==
X-Proofpoint-ORIG-GUID: nfPn7lHfX-UZtQMoOIlWYEXF4EazgGlC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_01,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508190222

On Wed, Aug 13, 2025 at 02:54:04PM +0100, John Garry wrote:
> On 10/08/2025 14:42, Ojaswin Mujoo wrote:
> > In ext4, even if an allocated range is physically and logically
> > contiguous, it can still be split into 2 extents. This is because ext4
> > does not merge extents across leaf nodes. This is an issue for atomic
> > writes since even for a continuous extent the map block could (in rare
> > cases) return a shorter map, hence tearning the write. This test creates
> > such a file and ensures that the atomic write handles this case
> > correctly
> > 
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >   tests/ext4/063     | 129 +++++++++++++++++++++++++++++++++++++++++++++
> >   tests/ext4/063.out |   2 +
> >   2 files changed, 131 insertions(+)
> >   create mode 100755 tests/ext4/063
> >   create mode 100644 tests/ext4/063.out
> > 
> > diff --git a/tests/ext4/063 b/tests/ext4/063
> > new file mode 100755
> > index 00000000..40867acb
> > --- /dev/null
> > +++ b/tests/ext4/063
> > @@ -0,0 +1,129 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> > +#
> > +# In ext4, even if an allocated range is physically and logically contiguous,
> > +# it can still be split into 2 extents.
> 
> Nit: I assume that you mean "2 or more extents"
> 
> > +# This is because ext4 does not merge
> > +# extents across leaf nodes. This is an issue for atomic writes since even for
> > +# a continuous extent the map block could (in rare cases) return a shorter map,
> > +# hence tearning the write. This test creates such a file and ensures that the
> 
> tearing
> 
> > +# atomic write handles this case correctly
> > +#
> > +. ./common/preamble
> > +. ./common/atomicwrites
> > +_begin_fstest auto atomicwrites
> > +
> > +_require_scratch_write_atomic_multi_fsblock
> > +_require_atomic_write_test_commands
> > +_require_command "$DEBUGFS_PROG" debugfs
> > +
> > +prep() {
> > +	local bs=`_get_block_size $SCRATCH_MNT`
> > +	local ex_hdr_bytes=12
> > +	local ex_entry_bytes=12
> > +	local entries_per_blk=$(( (bs - ex_hdr_bytes) / ex_entry_bytes ))
> > +
> > +	# fill the extent tree leaf with bs len extents at alternate offsets.
> > +	# The tree should look as follows
> > +	#
> > +	#                    +---------+---------+
> > +	#                    | index 1 | index 2 |
> > +	#                    +-----+---+-----+---+
> > +	#                   +------+         +-----------+
> > +	#                   |                            |
> > +	#      +-------+-------+---+---------+     +-----+----+
> > +	#      | ex 1  | ex 2  |   |  ex n   |     |  ex n+1  |
> > +	#      | off:0 | off:2 |...| off:678 |     |  off:680 |
> > +	#      | len:1 | len:1 |   |  len:1  |     |   len:1  |
> > +	#      +-------+-------+---+---------+     +----------+
> > +	#
> > +	for i in $(seq 0 $entries_per_blk)
> > +	do
> > +		$XFS_IO_PROG -fc "pwrite -b $bs $((i * 2 * bs)) $bs" $testfile > /dev/null
> > +	done
> > +	sync $testfile
> > +
> > +	echo >> $seqres.full
> > +	echo "Create file with extents spanning 2 leaves. Extents:">> $seqres.full
> > +	echo "...">> $seqres.full
> > +	$DEBUGFS_PROG -R "ex `basename $testfile`" $SCRATCH_DEV |& tail >> $seqres.full
> > +
> > +	# Now try to insert a new extent ex(new) between ex(n) and ex(n+1).
> > +	# Since this is a new FS the allocator would find continuous blocks
> > +	# such that ex(n) ex(new) ex(n+1) are physically(and logically)
> > +	# contiguous. However, since we dont merge extents across leaf we will
> 
> don't
> 
> > +	# end up with a tree as:
> > +	#
> > +	#                    +---------+---------+
> > +	#                    | index 1 | index 2 |
> > +	#                    +-----+---+-----+---+
> > +	#                   +------+         +------------+
> > +	#                   |                             |
> > +	#      +-------+-------+---+---------+     +------+-----------+
> > +	#      | ex 1  | ex 2  |   |  ex n   |     |  ex n+1 (merged) |
> > +	#      | off:0 | off:2 |...| off:678 |     |      off:679     |
> > +	#      | len:1 | len:1 |   |  len:1  |     |      len:2       |
> > +	#      +-------+-------+---+---------+     +------------------+
> > +	#
> > +	echo >> $seqres.full
> > +	torn_ex_offset=$((((entries_per_blk * 2) - 1) * bs))
> > +	$XFS_IO_PROG -c "pwrite $torn_ex_offset $bs" $testfile >> /dev/null
> > +	sync $testfile
> > +
> > +	echo >> $seqres.full
> > +	echo "Perform 1 block write at $torn_ex_offset to create torn extent. Extents:">> $seqres.full
> > +	echo "...">> $seqres.full
> > +	$DEBUGFS_PROG -R "ex `basename $testfile`" $SCRATCH_DEV |& tail >> $seqres.full
> > +
> > +	_scratch_cycle_mount
> > +}
> > +
> 
> Out of curiosity, for such a file with split extents, what would filefrag
> output look like? An example would be nice.

Hey John thanks for the review. Sorry for the late reply i had a mini
vacation followed by lei suddenly not pulling emails :/

Anyways, yes I've added the $DEBUGFS command so we can observe the
extent structure, but the filefrag would look something like this (last
few extents):

 ...
 337:      674..     674:      10130..     10130:      1:
 338:      676..     676:      10132..     10132:      1:
 339:      678..     678:      10134..     10134:      1:
 340:      679..     680:      10135..     10136:      2:             last,eof

Notice that the last 2 extents are logically and physically continuous
but not merged.

Reards,
ojaswin

> 
> Thanks,
> John

