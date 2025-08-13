Return-Path: <linux-ext4+bounces-9349-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A31B24088
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Aug 2025 07:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E388724A65
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Aug 2025 05:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE732BE629;
	Wed, 13 Aug 2025 05:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IWQxD9eg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D2021C160;
	Wed, 13 Aug 2025 05:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755063977; cv=none; b=Qw3Q75YWyfNOXlQYqT6q4VndBOBXb5gGLcLrZWgjQzNQ+wRBM41sDzTgErl2+Ue1VcOwz7FiUkfM4s7R9pwTn7XEqMER92XlQCxjDjTZagQ9H17bTRusAATHCQAQkxS5Ebl7js302Y5Tq1jPUVpXuRafjNUIWWRAWG5QgLzFWqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755063977; c=relaxed/simple;
	bh=F5ejs7PCAjdrIaJsScvOkU6qaLMxBCogfGgSUrWA7gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ph3agY9HcPQ6kMJ9tJJI1dzlaEj1ahLWZV2+1sjoJxzpFHOAjQuBa8dX0wZf3N1WlaGzhPC4vPPtcYRMw9NJxi08/JBs/d5i12x0r0eHRCfYshN+DZJhPbi2QCoD6m6V0wxXTHTuwFhsNeOd2X03vVu4HijixojYJ9+0Sz8r8lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IWQxD9eg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D1vZTL031959;
	Wed, 13 Aug 2025 05:46:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=pmK0MDvZJDpy2ZmMNZUCeu3OaJx1zX
	1XfLeoIGqrbeU=; b=IWQxD9ege2uG0zc0YVX3TudVWjPU0CMn8HJIR+gVHwlMST
	iu5iEjvCFQxKoJCXNj26NaRKGmeK1+CMz544ivJmG6Swb4DrMcQUlftiDr0ZNNb7
	9EiI3ZSgzt1OmLyyTSfjPSuu1jlJw6RCDn9HWcUYx49I86EH4mMhpZN6w6DiY9Bz
	00deTVGCMuXd709kwwhZvssAbgZAgb8cmLg5fNmqkMnnsIabg+p/+Ecl0lfmrds+
	kOlm0sfq7idAh0xj4jdahrXOoqEhgDA7RIODJRHjE7fYD8Dq44StdRUh3/y8SQiO
	1Epl1r/FZ8VU3XkcvNPufX0WuFF43Z9o2HIhDGwg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dvrp2har-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 05:46:02 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57D5k2SL012699;
	Wed, 13 Aug 2025 05:46:02 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dvrp2hap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 05:46:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57D30Hs7028571;
	Wed, 13 Aug 2025 05:46:01 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48ej5n5sa5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 05:46:01 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57D5jx4r20906272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 05:45:59 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F7642004E;
	Wed, 13 Aug 2025 05:45:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5763A20040;
	Wed, 13 Aug 2025 05:45:57 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.214.209])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 13 Aug 2025 05:45:57 +0000 (GMT)
Date: Wed, 13 Aug 2025 11:15:51 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, john.g.garry@oracle.com,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v4 11/11] ext4: Atomic write test for extent split across
 leaf nodes
Message-ID: <aJwmj39fLohMyNj_@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1754833177.git.ojaswin@linux.ibm.com>
 <2c241ea2ede39914d29aa59cd06acfc951aed160.1754833177.git.ojaswin@linux.ibm.com>
 <20250812171935.GD7938@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812171935.GD7938@frogsfrogsfrogs>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIxOSBTYWx0ZWRfX6qXXTdQEi3xL
 BFJw8lkX//bg+KaqJWyDRou/WoASlN10aHNmxYaQVzB01CmptbPhFIX7aT6WXiUSq6FuGMlJ8j1
 Knih5VDe37yLtALyhHwvizbJUHm1CkT2QWNOCxrFL+QVArqpTxCqPKj7fYHGY5qCmC9lT4fnJfu
 4qSJiE+P4RRkj333IX1KxSauvXSykDwf/0XAMyKdCWHNz8qXFX83GiA78CEfwKooQfXizwc7T3J
 PpMah9SBdS/f00EXV9h4OAOS+7lm0nQ9ankRNKlXTCDHQEle34nG4TdZwB3fnBGzrH8utXW9kD3
 H8gESbRtaV4VH0dMaaqkwPvWigP/zNuyDdBTt9MBbVYTC4ratOlDd+fBZF5W7OknRIiuvrc0Dmz
 mMj8Qyty
X-Authority-Analysis: v=2.4 cv=GrpC+l1C c=1 sm=1 tr=0 ts=689c269a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=cf2efhwwC3tEVx3DY7MA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: RdzLNblkjjG5TtlpZQcoI8TwF7UP2cEm
X-Proofpoint-ORIG-GUID: GVE1BxqP3PER5VaCwosVJajQkJKyu3W9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120219

On Tue, Aug 12, 2025 at 10:19:35AM -0700, Darrick J. Wong wrote:
> On Sun, Aug 10, 2025 at 07:12:02PM +0530, Ojaswin Mujoo wrote:
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
> >  tests/ext4/063     | 129 +++++++++++++++++++++++++++++++++++++++++++++
> >  tests/ext4/063.out |   2 +
> >  2 files changed, 131 insertions(+)
> >  create mode 100755 tests/ext4/063
> >  create mode 100644 tests/ext4/063.out
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
> 
> Thanks for the nice picture demonstrating what you're trying to test!
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

Sure, thanks for the suggestions and review!

Regards,
ojaswin

