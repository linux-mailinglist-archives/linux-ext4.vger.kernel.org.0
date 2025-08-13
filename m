Return-Path: <linux-ext4+bounces-9348-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25456B24085
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Aug 2025 07:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D31BA7B9646
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Aug 2025 05:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5199B2BF005;
	Wed, 13 Aug 2025 05:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DSF/xzQ2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE801E835B;
	Wed, 13 Aug 2025 05:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755063947; cv=none; b=tiJ5tdSZdOdP1uAX6HxbMeJe7O2/2sQEpd/167FauS5V6gE9urUbS8FSR1oAfxGCOeG/+XkFfEwsnw1DthCoRvUnsSMuhQrw+1+yTzAzWkbNLU2dixut81IQfucxsHaVuXjKcSnABkZfmnCF4TvLuQJHi00/vDUPu3Jg4xG5jfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755063947; c=relaxed/simple;
	bh=ZPLGVBS25zRlO7euIJVNlJ3x6vVqODmsvGIo7YwRq8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GH7clUGxGJlEoCSYZPtl4ge28HU/RhlhADubosTiv+wO3wcI1P8rDhtz4VJyRhfIgoUclU6zlV8GzMEjou1wRxlO4qUhEs+padguAptvKzW3qmM79tzHthxTmfhiPWaxX5vH+FR5a4Vz7ZHe60FxMsysS6avgUF94/gsIeKo8WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DSF/xzQ2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CNQEe8025034;
	Wed, 13 Aug 2025 05:45:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=v/khMXsjNIxOrq06K4z/fPAhMAv1P8
	UcC6BkmouROm4=; b=DSF/xzQ2wL47J2eTsz/TEdgaxre4OiCTWgmwxf+1lH8N4N
	nJcfYmDx+18D4G9nIw95xPQSBsjMViefk9w5GKOBnn65pbdj4KAShk5sbPGgc/Sz
	YXmJJMbYx2s8QWbJ1XriiVDDgadQ8FrMGuAPji9XWqfLbc1BJrxJVa6yNQLBPWlv
	TdriEEThqpNdi/RvzgQSPwf/KoSjT4oNB7BiqP5GP0pYo4AnmDGhhuUXr8vwnh0S
	VY8hyAe22qCcFFLtbzzBoERY1ObjOxSe8MOZfKzmeWeSMBawNuRaA6DQh++5Dnr9
	Fa/J+hbCT/dmuwZ/6odvaPVqQYblDMuKEFSLH/ig==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48ehaa7031-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 05:45:20 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57D5jJ8X019474;
	Wed, 13 Aug 2025 05:45:19 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48ehaa702y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 05:45:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57D4NHHZ017588;
	Wed, 13 Aug 2025 05:45:18 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ekc3nhj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 05:45:18 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57D5jHZ217039666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 05:45:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 03E412004B;
	Wed, 13 Aug 2025 05:45:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 398C120040;
	Wed, 13 Aug 2025 05:45:15 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.214.209])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 13 Aug 2025 05:45:15 +0000 (GMT)
Date: Wed, 13 Aug 2025 11:15:07 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, john.g.garry@oracle.com,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v4 07/11] generic: Stress fsx with atomic writes enabled
Message-ID: <aJwmY8_RLBVuTkDk@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1754833177.git.ojaswin@linux.ibm.com>
 <50487b2e8a510598a93888c2674df7357d371da8.1754833177.git.ojaswin@linux.ibm.com>
 <20250812171855.GC7938@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812171855.GC7938@frogsfrogsfrogs>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KPRaDEFo c=1 sm=1 tr=0 ts=689c2670 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=jlC_BfiipCRRyT0oD4EA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 1AcaNN8oXjNCYzZdyV3HhzvKX1JUrX7n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIyNCBTYWx0ZWRfX5RZa3th2M3FD
 kwqZcEl7ECHJ8Fm7SmmQwD3yCnf6z0HPuBc3oFwYMSF/Xjm+oTZHX7CccvQ2SAh3AKse0FnP/gZ
 IpiECUfJe94XxjhASm51c5TIaS74rfEpnY/X7eMmV6F67ZDUkVyjYAtPCssli0K9LVDxXDiUy2a
 bWWLddSly9ta6nf+EevZke+0QQKjmnQBmTHFvkrjGRNhvxxcrZiceDnYqfN3hQClAaEVn4bv4us
 gcAc9n/ut1fE6Y1Wd4AaG1CIVpR/vzUZVkqUa/SrAud/clBvNQkfB5vWrpFO00Ltd5NK2YN2cZE
 TH5hBq32zKp8op3KJRlGlOz5oir0bWjv41DK+mQPj22uOC10NUId/G+zAcl9RVDLMl3Y+xB95AL
 6j/14BXW
X-Proofpoint-GUID: XuoKy--lu1DNLl5Qz4xqtYufTYbb4nD2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120224

On Tue, Aug 12, 2025 at 10:18:55AM -0700, Darrick J. Wong wrote:
> On Sun, Aug 10, 2025 at 07:11:58PM +0530, Ojaswin Mujoo wrote:
> > Stress file with atomic writes to ensure we excercise codepaths
> > where we are mixing different FS operations with atomic writes
> > 
> > Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> 
> Didn't I already tag this
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

Yes you did but since I moved the fsx avoid logic from common/rc to here
I just thought it'd be better to remove old reviews.

(also fyi, i also removed the reviews from g/1227 for the same reason)

Thanks for the review again! 

Regards,
ojaswin
> 
> --D
> 
> > ---
> >  tests/generic/1229     | 68 ++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/1229.out |  2 ++
> >  2 files changed, 70 insertions(+)
> >  create mode 100755 tests/generic/1229
> >  create mode 100644 tests/generic/1229.out
> > 
> > diff --git a/tests/generic/1229 b/tests/generic/1229
> > new file mode 100755
> > index 00000000..7fa57105
> > --- /dev/null
> > +++ b/tests/generic/1229
> > @@ -0,0 +1,68 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> > +#
> > +# FS QA Test 1229
> > +#
> > +# fuzz fsx with atomic writes
> > +#
> > +. ./common/preamble
> > +. ./common/atomicwrites
> > +_begin_fstest rw auto quick atomicwrites
> > +
> > +_require_odirect
> > +_require_scratch_write_atomic
> > +
> > +_scratch_mkfs >> $seqres.full 2>&1
> > +_scratch_mount  >> $seqres.full 2>&1
> > +
> > +testfile=$SCRATCH_MNT/testfile
> > +touch $testfile
> > +
> > +awu_max=$(_get_atomic_write_unit_max $testfile)
> > +blksz=$(_get_block_size $SCRATCH_MNT)
> > +bsize=`$here/src/min_dio_alignment $SCRATCH_MNT $SCRATCH_DEV`
> > +
> > +set_fsx_avoid() {
> > +	local file=$1
> > +
> > +	case "$FSTYP" in
> > +	"ext4")
> > +		local dev=$(findmnt -n -o SOURCE --target $testfile)
> > +
> > +		# fsx insert/collpase range support for ext4+bigalloc is
> > +		# currently broken, so disable it. Also disable incase we can't
> > +		# detect bigalloc to be on safer side.
> > +		if [ -z "$DUMPE2FS_PROG" ]; then
> > +			echo "dumpe2fs not found, disabling insert/collapse range" >> $seqres.full
> > +			FSX_AVOID+=" -I -C"
> > +			return
> > +		fi
> > +
> > +		$DUMPE2FS_PROG -h $dev 2>&1 | grep -q bigalloc && {
> > +			echo "fsx insert/collapse range not supported with bigalloc. Disabling.." >> $seqres.full
> > +			FSX_AVOID+=" -I -C"
> > +		}
> > +		;;
> > +	*)
> > +		;;
> > +	esac
> > +}
> > +
> > +# fsx usage:
> > +#
> > +# -N numops: total # operations to do
> > +# -l flen: the upper bound on file size
> > +# -o oplen: the upper bound on operation size (64k default)
> > +# -Z: O_DIRECT ()
> > +
> > +set_fsx_avoid
> > +_run_fsx_on_file $testfile -N 10000 -o $awu_max -A -l 500000 -r $bsize -w $bsize -Z $FSX_AVOID  >> $seqres.full
> > +if [[ "$?" != "0" ]]
> > +then
> > +	_fail "fsx returned error: $?"
> > +fi
> > +
> > +echo "Silence is golden"
> > +status=0
> > +exit
> > diff --git a/tests/generic/1229.out b/tests/generic/1229.out
> > new file mode 100644
> > index 00000000..737d61c6
> > --- /dev/null
> > +++ b/tests/generic/1229.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 1229
> > +Silence is golden
> > -- 
> > 2.49.0
> > 
> > 

