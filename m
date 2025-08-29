Return-Path: <linux-ext4+bounces-9759-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1CAB3C16E
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Aug 2025 19:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C4E6A22AEB
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Aug 2025 17:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5848F33EB18;
	Fri, 29 Aug 2025 17:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qi45vujP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E30433CEBC;
	Fri, 29 Aug 2025 17:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756486810; cv=none; b=Uok5+rYZ2YaZzkK/CAZyaE1Vm6D/qfYdUqUlc7DfxVtwGkrKa51MjsfP30FNHorebt79IT9wCDEUtim3RXV9cNYjH+xNpnWruAvESqPY1l8/LG689k7ZWIopir2BQOzt0VfFNbfIwFX8CiN/QD/VuCuUVL9vdaFSd93bMueovbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756486810; c=relaxed/simple;
	bh=g6J3NQ38RdU5WKk3Hf+m3anFKU1BzXIj0oo5j9iNkpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlpKzs/fnP/IKAYFnblVrUXAbo4uFykLqOorV7nKpS2c9ANaXzHjCdfUaDtkV64+IQ0U/dTF3TkykF2TevBu1ZS2L/4vhHPkvIgykgP/VaO5Thm1F2c2zNMLqnKS/Xd6PZ7knE+IcKllnqf10xytrcXxoCMuz7Cs5COLooZZXL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qi45vujP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57T8HRng006161;
	Fri, 29 Aug 2025 16:59:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=f8udolkBfpv99Y2otg4WVHHoxyWLxw
	QNg6VuBGjwyH4=; b=qi45vujPrlFtgRDYM0ysNwve6g2pLvnoSxD6iPYU7klyq0
	5F7TmU1QSBFnVYsz6aHbpDrX8Nc6zLS2EFqIp4hf8YJT3OcrQadmk1E07a1/Vay5
	HDqCVqx/E124ZIfTw+1vTRzOV8jqXvGpVyF1wGaH2pu81nHS4E0PDBatgPz1Lzrq
	Auogqjd9s+zvtkiEi1kMOEzaNNOe9F/L+mdizas9wmQidvfJP9JaJhyTZ006m5nI
	feD60uwQYGWKqr5vHBp5TBrexODoJiki5H5I+HwmiG4MrzAM5M/12pzozurtoqp9
	GmJJPgcG1nmFDDlyJh1Wzys/3qULsx41UtDzk5jQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48tuaj5e7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 16:59:59 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57TGxwCi012664;
	Fri, 29 Aug 2025 16:59:58 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48tuaj5e7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 16:59:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57TFo3Um002531;
	Fri, 29 Aug 2025 16:59:57 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48qryq2r09-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 16:59:57 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57TGxtrM47841754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 16:59:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6E822004E;
	Fri, 29 Aug 2025 16:59:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6468020043;
	Fri, 29 Aug 2025 16:59:53 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.28.38])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 29 Aug 2025 16:59:53 +0000 (GMT)
Date: Fri, 29 Aug 2025 22:29:47 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, john.g.garry@oracle.com,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v5 02/12] common/rc: Add _require_fio_version helper
Message-ID: <aLHcgyWtwqMTX-Mz@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
 <955d47b2534d9236adbd2bbd13598bbd1da8fc04.1755849134.git.ojaswin@linux.ibm.com>
 <20250825160801.ffktqauw2o6l5ql3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <aK8hUqdee-JFcFHn@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20250828150905.GB8092@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828150905.GB8092@frogsfrogsfrogs>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TUjT-E3PgxbG19TDYRR9PmjIvkU-FOtF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDE0MCBTYWx0ZWRfXwaMgocFojLvm
 GMzpozOUPf77G+gw7sldjuETFpkAJJEWRcDTV7CdNdve4PQqiRRIo6PyrPRnyyiKzAZcjVmlyGJ
 oeyU680+6raYkGgThfhj8EN/TYIY9s1suN9+OspLaHq0HzlxlxKGuaI9/2Vqzs/FqYzmUj44jX4
 QHRpJMmutZQZLX2UcySlF+uiA+WYMF+UfHDD73fuzItoPoev5EgaBlmZlKcMI56lIX/hvsiupx0
 /TGzb+LV7UDWdZOhah8en4O9ruhIEW/3+HMbtdjC43Xgd4zAeWRzhKOjhnrKPmhyA+ZI2AjiLfD
 0+9sMw8eNmMmgmtCXqh8yoe6NCs1EsaffuPvTF83It5ZVEcerlps107wQP5XsRc9Jjj4rMHgRL6
 zIED13iU
X-Authority-Analysis: v=2.4 cv=YfW95xRf c=1 sm=1 tr=0 ts=68b1dc8f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=TOWdreBBVv284GCsa5EA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: IB08rFIKoEt7MSKGNmj5GfRmR2FSR3GC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508280140

On Thu, Aug 28, 2025 at 08:09:05AM -0700, Darrick J. Wong wrote:
> On Wed, Aug 27, 2025 at 08:46:34PM +0530, Ojaswin Mujoo wrote:
> > On Tue, Aug 26, 2025 at 12:08:01AM +0800, Zorro Lang wrote:
> > > On Fri, Aug 22, 2025 at 01:32:01PM +0530, Ojaswin Mujoo wrote:
> > > > The main motivation of adding this function on top of _require_fio is
> > > > that there has been a case in fio where atomic= option was added but
> > > > later it was changed to noop since kernel didn't yet have support for
> > > > atomic writes. It was then again utilized to do atomic writes in a later
> > > > version, once kernel got the support. Due to this there is a point in
> > > > fio where _require_fio w/ atomic=1 will succeed even though it would
> > > > not be doing atomic writes.
> > > > 
> > > > Hence, add an explicit helper to ensure tests to require specific
> > > > versions of fio to work past such issues.
> > > 
> > > Actually I'm wondering if fstests really needs to care about this. This's
> > > just a temporary issue of fio, not kernel or any fs usespace program. Do
> > > we need to add a seperated helper only for a temporary fio issue? If fio
> > > doesn't break fstests running, let it run. Just the testers install proper
> > > fio (maybe latest) they need. What do you and others think?
> 
> Are there obvious failures if you try to run these new atomic write
> tests on a system with the weird versions of fio that have the no-op
> atomic= functionality?  I'm concerned that some QA person is going to do
> that unwittingly and report that everything is ok when in reality they
> didn't actually test anything.

I think John has a bit more background but afaict, RWF_ATOMIC support
was added (fio commit: d01612f3ae25) but then removed (commit:
a25ba6c64fe1) since the feature didn't make it to kernel in time.
However the option seemed to be kept in place. Later, commit 40f1fc11d
added the support back in a later version of fio. 

So yes, I think there are some version where fio will accept atomic=1
but not act upon it and the tests may start failing with no apparent
reason.

Regards,
ojaswin
> 
> --D
> 
> > > Thanks,
> > > Zorro
> > 
> > Hey Zorro,
> > 
> > Sure I'm okay with not keeping the helper and letting the user make sure
> > the fio version is correct.
> > 
> > @John, does that sound okay?
> > 
> > Regards,
> > ojaswin
> > > 
> > > > 
> > > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > > ---
> > > >  common/rc | 32 ++++++++++++++++++++++++++++++++
> > > >  1 file changed, 32 insertions(+)
> > > > 
> > > > diff --git a/common/rc b/common/rc
> > > > index 35a1c835..f45b9a38 100644
> > > > --- a/common/rc
> > > > +++ b/common/rc
> > > > @@ -5997,6 +5997,38 @@ _max() {
> > > >  	echo $ret
> > > >  }
> > > >  
> > > > +# Check the required fio version. Examples:
> > > > +#   _require_fio_version 3.38 (matches 3.38 only)
> > > > +#   _require_fio_version 3.38+ (matches 3.38 and above)
> > > > +#   _require_fio_version 3.38- (matches 3.38 and below)
> > > > +_require_fio_version() {
> > > > +	local req_ver="$1"
> > > > +	local fio_ver
> > > > +
> > > > +	_require_fio
> > > > +	_require_math
> > > > +
> > > > +	fio_ver=$(fio -v | cut -d"-" -f2)
> > > > +
> > > > +	case "$req_ver" in
> > > > +	*+)
> > > > +		req_ver=${req_ver%+}
> > > > +		test $(_math "$fio_ver >= $req_ver") -eq 1 || \
> > > > +			_notrun "need fio >= $req_ver (found $fio_ver)"
> > > > +		;;
> > > > +	*-)
> > > > +		req_ver=${req_ver%-}
> > > > +		test $(_math "$fio_ver <= $req_ver") -eq 1 || \
> > > > +			_notrun "need fio <= $req_ver (found $fio_ver)"
> > > > +		;;
> > > > +	*)
> > > > +		req_ver=${req_ver%-}
> > > > +		test $(_math "$fio_ver == $req_ver") -eq 1 || \
> > > > +			_notrun "need fio = $req_ver (found $fio_ver)"
> > > > +		;;
> > > > +	esac
> > > > +}
> > > > +
> > > >  ################################################################################
> > > >  # make sure this script returns success
> > > >  /bin/true
> > > > -- 
> > > > 2.49.0
> > > > 
> > > 
> > 

