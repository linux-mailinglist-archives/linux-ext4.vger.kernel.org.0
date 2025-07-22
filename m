Return-Path: <linux-ext4+bounces-9147-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCDBB0D65B
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Jul 2025 11:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E246AA02E3
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Jul 2025 09:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8990C2E03FB;
	Tue, 22 Jul 2025 09:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fXbAGeUy"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499642DEA6A;
	Tue, 22 Jul 2025 09:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753178004; cv=none; b=W+vZ+NMlEvyDWMLIfpBJt5HL3ggWJOCCgRvAOjLlWSvIMBtf5L9f6otppTD0nmJG+WGUmToxnLO6JtMb5zLRdi5AJ1iRHBplE0OjltEWDI9jAqo5yiK4rQeussa7m+kiv0QPAYTG4sWfkwq7WJza9haJLuRkAM0Z0uh/Qxn7LxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753178004; c=relaxed/simple;
	bh=0ahjYebJTcBwY5yNy4z0UV0/9vcA93nCL1qO41tahCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXD8mMH50cUKaYqaOYsdeQCpdTcc3gK1YGY38oX1X9x8iixru5UBGjo5QpceX2RXMmOyw3Kk/GQWV6veHjOEpOVaKoS/BiWBbOYHldDtDkH9I45bRHR6hYaNxLY/nxUqjg2VgQj9wpp5Ibo0VUj+9tCcKEClZC95TdBFEf+kXPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fXbAGeUy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M0oVZJ032317;
	Tue, 22 Jul 2025 09:53:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=iXPjagKe1OfX88cYSdt0ScY3MiGeMz
	nFbHV/ry44zF8=; b=fXbAGeUyES5WdcPTM3njnI/JE+Y8U8Hxh3Eep8PZlwHGZ9
	D2vOi0ZaimIx+kRvFt7x/Lo2KalvjFnIaYVZc/bDWi+jVi4teA9fqub5pNzR+Lzt
	SlzVhBptbPXimx4/P/AnVEd/qMJaHOI4bi13+3c8gY8cCT+yiDlr2D4wJtdQ7I8u
	9hDTCOMJ+vUfYJSnHfvq2vyrP+X1TRRw0fwRqXWb7T/zofueKJlEzwTISYiRJEpQ
	QKlQbhDGV5tyuwfOn44pCAk6G8n8V/uZDlIF8+XseHmAiv8NQLaW90Y7Ix3qcEUn
	qMLCzt29HKCEU7KB5yIIPz0QmD1XbWwZqW6ArIBA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805hfwk52-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 09:53:13 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56M9cwWW011936;
	Tue, 22 Jul 2025 09:53:13 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805hfwk50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 09:53:13 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56M5tSTu024964;
	Tue, 22 Jul 2025 09:53:12 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 480nptjf7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 09:53:12 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56M9r7ih51773934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 09:53:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A088720043;
	Tue, 22 Jul 2025 09:53:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 494F420040;
	Tue, 22 Jul 2025 09:53:05 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.18.185])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 22 Jul 2025 09:53:05 +0000 (GMT)
Date: Tue, 22 Jul 2025 15:23:02 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, john.g.garry@oracle.com,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 02/13] common/rc: Fix fsx for ext4 with bigalloc
Message-ID: <aH9ffl7-2ri2Exgv@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1752329098.git.ojaswin@linux.ibm.com>
 <84a1820482419a1f1fb599bc35c2b7dcc1abbcb9.1752329098.git.ojaswin@linux.ibm.com>
 <20250717161154.GF2672039@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717161154.GF2672039@frogsfrogsfrogs>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA3OSBTYWx0ZWRfX7lUwW1+Q5zWa
 wuiWsDx8+a4mjfw8gOtpvTo7qAO1Zqml6+9DARLyt9nIVz/oY938OX7KvXkeTUQuR/J0kcov4J6
 CZ2IDHDhSa6JWPpc0jjwL6lbp60HaVqnftbourjIPdW1No0CxWUd/qqvB7ELUTPO0c8idtnurEB
 vjEbDUXeretDzGAwJRuiRNi0/tebnLK8VfADZmwP1KCaS/TGk8IV0Uue8KT0jB3nXMs6lrk4noZ
 jTN1JwYypR4kRtioTk3SrWhUSUlvQL4W0wN953U3bfQyPx3BZHXkc69Zj8y8WhO8xmHF6xBdMmg
 8u7ZbYtxWUOl1hYf6i4wmOGWFiFbIz4r776HM8jk8m948FfhDI8VSNCRa1BTErhOhzxSmuxTsNS
 w9KG3Dx6Jye2Q3okqTj1O97DUZ+eMgsLAGnglyPWZ5QdbFtgyOPYQWoGwm/dpcL28AX6yAZs
X-Proofpoint-GUID: uVC4Ndc0eYIstplw9f8qLXS3t_zWHjGM
X-Proofpoint-ORIG-GUID: 1-5EotLC-Bt5v-VEBZmlBtzd989lpf7d
X-Authority-Analysis: v=2.4 cv=X9RSKHTe c=1 sm=1 tr=0 ts=687f5f89 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=WmCSGEEz2f1fRig7hz0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_01,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 clxscore=1015 mlxscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507220079

On Thu, Jul 17, 2025 at 09:11:54AM -0700, Darrick J. Wong wrote:
> On Sat, Jul 12, 2025 at 07:42:44PM +0530, Ojaswin Mujoo wrote:
> > Insert range and collapse range only works with bigalloc in case
> > the range is cluster size aligned, which fsx doesnt take care. To
> > work past this, disable insert range and collapse range on ext4, if
> > bigalloc is enabled.
> > 
> > This is achieved by defining a new function _set_default_fsx_avoid
> > called via run_fsx helper. This can be used to selectively disable
> > fsx options based on the configuration.
> > 
> > Co-developed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >  common/rc | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> > 
> > diff --git a/common/rc b/common/rc
> > index 9a9d3cc8..218cf253 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -5113,10 +5113,37 @@ _require_hugepage_fsx()
> >  		_notrun "fsx binary does not support MADV_COLLAPSE"
> >  }
> >  
> > +_set_default_fsx_avoid() {
> > +	local file=$1
> > +
> > +	case "$FSTYP" in
> > +	"ext4")
> > +		local dev=$(findmnt -n -o SOURCE --target $file)
> > +
> > +		# open code instead of _require_dumpe2fs cause we don't
> > +		# want to _notrun if dumpe2fs is not available
> > +		if [ -z "$DUMPE2FS_PROG" ]; then
> > +			echo "_set_default_fsx_avoid: dumpe2fs not found, skipping bigalloc check." >> $seqres.full
> > +			return
> > +		fi
> 
> I hate to be the guy who says one thing and then another, but ...
> 
> If we extended _get_file_block_size to report the ext4 bigalloc cluster
> size, would that be sufficient to keep testing collapse/insert range?
> 
> I guess the tricky part here is that bigalloc allows sub-cluster
> mappings and we might not want to do all file IO testing in such big
> units.

Hmm, so maybe a better way is to just add a parameter like alloc_unit in
fsx where we can pass the cluster_size to which INSERT/COLLAPSE range be
aligned to. For now we can pass it explicitly in the tests if needed.

I do plan on working on your suggestion of exposing alloc unit via
statx(). Once we have that in the kernel, fsx can use that as well.

If this approach sounds okay I can try to maybe send the whole "fixing
of insert/collpase range in fsx" as a patchset separate from atomic
writes.


> 
> > +
> > +		$DUMPE2FS_PROG -h $dev 2>&1 | grep -q bigalloc && {
> > +			export FSX_AVOID+=" -I -C"
> 
> No need to export FSX_AVOID to subprocesses.
> 
> --D

Got it, will fix. Thanks for review!


Regards,
ojaswin
> 
> > +		}
> > +		;;
> > +	# Add other filesystem types here as needed
> > +	*)
> > +		;;
> > +	esac
> > +}
> > +
> >  _run_fsx()
> >  {
> >  	echo "fsx $*"
> >  	local args=`echo $@ | sed -e "s/ BSIZE / $bsize /g" -e "s/ PSIZE / $psize /g"`
> > +
> > +	_set_default_fsx_avoid $testfile
> > +
> >  	set -- $FSX_PROG $args $FSX_AVOID $TEST_DIR/junk
> >  	echo "$@" >>$seqres.full
> >  	rm -f $TEST_DIR/junk
> > -- 
> > 2.49.0
> > 
> > 

