Return-Path: <linux-ext4+bounces-9240-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AB1B16243
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Jul 2025 16:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 722F75668E7
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Jul 2025 14:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6157E2D94B3;
	Wed, 30 Jul 2025 14:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AlldpQyK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF2123182B;
	Wed, 30 Jul 2025 14:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753884492; cv=none; b=GkIBwO7dqszIkUwDJfb8PXnLQXc/oiM3lEdRJjrIipBAe2IoDx8G15jXjMJZqH5P8tzIZldp+oHm9hoLRq0hP1UmAvwoi9GE2kcHMZfS6+IZiUFGeFzJJ6aCinGrVyZ50oigwoco85qplQVrju4eEtrUiDFBVXoQjWOZnM6+YQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753884492; c=relaxed/simple;
	bh=m3OrwHDZF1LtOicd73ATRy9jRGDz2aYJppfV61jharg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7fU1fh8ePGTm9/9iqtywFie5sRqmws6kpCAv6GpWtA4dFU/vD1XvSPswBub0eWZ9irFxEPEJSykExgGkc/oloNKHB4DLfe9I3t4yMWhzfRbWp3lW4JHN7G0MYRUKSOtOclA0FmN0tflwCyHmknX4ek688avHWW/kZ/eGCQDVYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AlldpQyK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UB9aIS002909;
	Wed, 30 Jul 2025 14:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=9GtRRNURtcRq2aoWmVSdIT717zLewZ
	QD47X9qC/xrR8=; b=AlldpQyKhMD3E9z8+hInQfriuobge8PhMTwrdxGbbul/Ky
	PhB0j2XnxFJuhCJalSz4VocRwCjdKJLA+rfb0HJm4SkjQinImu8rknP+rCUnz0KM
	9n5NhtZYYLZ6SltwEfhyQD5IGY4+M4wHqOLdZircI2WBqpT8D0OLJottqZFsIyDf
	2MVtGS4/vyxYY+5V0kk/bA4+AVkZtboCxXeAKtH+RiaMDaRvGta/+o3yLPElYSf0
	Z1womTqhncbtXspH1DHRqYji6EsLoQkVZryewPKRurcyVaNTP4PiCGzf5PSZJKyO
	ibgb1fq576BwrdZU16nsxJdtiSVXEdYeGTvnl+dQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 486c6hu7v1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 14:07:07 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 56UE0BHZ019589;
	Wed, 30 Jul 2025 14:07:07 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 486c6hu7uy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 14:07:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56UAoqiv018354;
	Wed, 30 Jul 2025 14:07:06 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 485abp7sgu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 14:07:05 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56UE74iw50790674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 14:07:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 016362004B;
	Wed, 30 Jul 2025 14:07:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2426E20043;
	Wed, 30 Jul 2025 14:07:02 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.212.169])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 30 Jul 2025 14:07:01 +0000 (GMT)
Date: Wed, 30 Jul 2025 19:36:59 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, john.g.garry@oracle.com,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 12/13] ext4/063: Atomic write test for extent split
 across leaf nodes
Message-ID: <aIonAxvI9nYuIMjo@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1752329098.git.ojaswin@linux.ibm.com>
 <b6f7b73de6bb6ebfc78e533f89f0899d884e5490.1752329098.git.ojaswin@linux.ibm.com>
 <20250729194154.GT2672039@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729194154.GT2672039@frogsfrogsfrogs>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ud0YEX30nEgLYiVZ5WxS61Qcc8L4o4wy
X-Authority-Analysis: v=2.4 cv=Mbtsu4/f c=1 sm=1 tr=0 ts=688a270b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=29Di_AMnF8qpr2DakOsA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: ZKtsWm1CnCwotCCjOyIBxsLNPGZjYZY5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA5OSBTYWx0ZWRfX44TSSj62Mcys
 gCFwz7J7zJWopBLLssWRLOrio0EABOece1xQH6nd5plYAST1kmRzZag0ckOPHwIZp6VDF1hzick
 yIp38FE2OhQqyiv16+KzNOm3phe7e20zEBiBupl+Z/6Vx9R4DXcAnisUJulqJWDRU5s3qnhaUfY
 aGEQDsxjMBfWTWqhYHyRPcdoVGZ0trZRemC07emmSg/aLWq43w+uHY6FUljkmNeogxOuCBIgdvA
 7OY9GbVOw0ThfXno5xY4wvuADKs2a8ZS9oqpx3clw6NWtptHZNvbm5zHxXOyJItZ/E/Dmb6HVkv
 Bde4ebJpr8/LayJ0tN2+8wG8uml2Q+OPArbNamZrm/qCWdxmLDGZhjhSeIgUsFSpQtR435GWxr7
 gSPyALlssDl7Uxj53ix589WD8kGnxn9tJnVSOEF/SP+bfFSqp2RPc+wqPP9+dOBk3lUUp7rp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_04,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507300099

On Tue, Jul 29, 2025 at 12:41:54PM -0700, Darrick J. Wong wrote:
> On Sat, Jul 12, 2025 at 07:42:54PM +0530, Ojaswin Mujoo wrote:
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
> >  tests/ext4/063     | 125 +++++++++++++++++++++++++++++++++++++++++++++
> >  tests/ext4/063.out |   2 +
> >  2 files changed, 127 insertions(+)
> >  create mode 100755 tests/ext4/063
> >  create mode 100644 tests/ext4/063.out
> > 
> > diff --git a/tests/ext4/063 b/tests/ext4/063
> > new file mode 100755
> > index 00000000..25b5693d
> > --- /dev/null
> > +++ b/tests/ext4/063
> > @@ -0,0 +1,125 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> > +#
> > +# In ext4, even if an allocated range is physically and logically contiguous,
> > +# it can still be split into 2 extents. This is because ext4 does not merge
> > +# extents across leaf nodes. This is an issue for atomic writes since even for
> > +# a continuous extent the map block could (in rare cases) return a shorter map,
> > +# hence tearning the write. This test creates such a file and ensures that the
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
> > +	# fill the extent tree leaf which bs len extents at alternate offsets. For example,
> > +	# for 4k bs the tree should look as follows
> > +	#
> > +	#                  +---------+---------+
> > +	#                  | index 1 | index 2 |
> > +	#                  +-----+---+-----+---+
> > +	#               +--------+         +-------+
> > +	#               |                          |
> > +	#    +----------+--------------+     +-----+-----+
> > +	#    | ex 1 | ex 2 |... | ex n |     |  ex n + 1 |
> > +	#    +-------------------------+     +-----------+
> > +	#    0      2            680          682
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
> > +	# Now try to insert a new extent ex(new) between ex(n) and ex(n+1). Since
> > +	# this is a new FS the allocator would find continuous blocks such that
> > +	# ex(n) ex(new) ex(n+1) are physically(and logically) contiguous. However,
> > +	# since we dont merge extents across leaf we will end up with a tree as:
> > +	#
> > +	#                  +---------+---------+
> > +	#                  | index 1 | index 2 |
> > +	#                  +-----+---+-----+---+
> > +	#               +--------+         +-------+
> > +	#               |                          |
> > +	#    +----------+--------------+     +-----+-----+
> > +	#    | ex 1 | ex 2 |... | ex n |     | ex merged |
> > +	#    +-------------------------+     +-----------+
> > +	#    0      2            680          681  682  684
> 
> Where did 684 come from?  It's not in the 'before' diagram.  Did
> "ex n + 1" previously map 682-684, and now it maps 681-684?

Okay so the 684 is a bit misleading as in there is nothing there.
The extent at 682 is len=1 and spans [682-683). Now that you pointed it
out, I think the 0..2...680 logicial offsets are confusing, since they
are actually ext4_extent.ee_block values but the diagram makes it seem
like they are indexes into the array of extents. Let me see if I can
make it better.

Thanks for the review!
ojaswin

> 
> The rest looks ok though.
> 
> --D
> 

