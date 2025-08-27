Return-Path: <linux-ext4+bounces-9709-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AABB38660
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Aug 2025 17:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46ACA9847C0
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Aug 2025 15:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9C2287252;
	Wed, 27 Aug 2025 15:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tQrILEOn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD8427FD5D;
	Wed, 27 Aug 2025 15:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756307812; cv=none; b=EmNdd/xyGVhV+YZV7WBocUJRO5SDSX1NPvYA0ngBgEXJawRFcp+5JbdLl+VfDofG8EYf7P53azZg2n+LvGxVPeBtV2oJ+FtLUSKQXXI+/rtyPOYtMJAvFCz3jRMVP5535mbpQWBnSpWIQ0EgcKtiXY2ZCfqOtpY1kg2pVQCXKIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756307812; c=relaxed/simple;
	bh=mOV+nWXhghC+6OaXr13EUm4ZGN4mHYeKxrBdFRkt1RM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFkHQBoeT9SUJ9yVHDsx32ym9hd3CFvg+g3dgONiwWQcGveEcQ4bsGeFYaBWN1DqUiTrmbQXuUuz4h5VwoP05KVoV2e5qNv51N/4UwM9GjCHy6CZwwRnwa7kLVYTNI92Ce6XQVPvZV90bUYzBIdlYoYF3yoPrKftVswAm3ifOQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tQrILEOn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57R7wpnL011849;
	Wed, 27 Aug 2025 15:16:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=SPyx11geBrvCeW8/DE+b27cLGdioY2
	twq7XbikpR9hU=; b=tQrILEOnkv2ygrRG3IyrCMGcoKLVm+C7kU+2PbwLRdD9xc
	k+zwwxhG3qr4s/HFsObRELXYawLhEKRj3ltaBYe1cHFLEoud0wzvNM+r0Wzk5hMk
	e3NPwuIZ+E/lA3yqqvf2hJ8jc9KW05gfWA4++ZKt3CvGFrrxQ2iF7Kjvck70i+sY
	zyoS6OJZ3FGu20LMFB3teNdc3yHh7kYS6KsjCdOurGRGRu46e9ixLnd/QAsDsVWT
	KnMmdrU37hV8/uSUj5Qx3tKQ5Uej02bM7nO1/VznvitGD+95vCDkFsBbFBWpNe7A
	+ximIn47kMLCHslR5Wa1+gjIKGf2YVxilLBZZRrg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q5584tyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 15:16:42 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57RFGgVX001288;
	Wed, 27 Aug 2025 15:16:42 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q5584tyc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 15:16:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57RCPxFe002473;
	Wed, 27 Aug 2025 15:16:41 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48qt6mgahc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 15:16:41 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57RFGdWA38666592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 15:16:39 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2463D2004E;
	Wed, 27 Aug 2025 15:16:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD3D120040;
	Wed, 27 Aug 2025 15:16:36 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.23.211])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 27 Aug 2025 15:16:36 +0000 (GMT)
Date: Wed, 27 Aug 2025 20:46:34 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        djwong@kernel.org, john.g.garry@oracle.com, tytso@mit.edu,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v5 02/12] common/rc: Add _require_fio_version helper
Message-ID: <aK8hUqdee-JFcFHn@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
 <955d47b2534d9236adbd2bbd13598bbd1da8fc04.1755849134.git.ojaswin@linux.ibm.com>
 <20250825160801.ffktqauw2o6l5ql3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825160801.ffktqauw2o6l5ql3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: d02U5Q3hom6xqs3PZk50E5KMp5ujhhzo
X-Proofpoint-ORIG-GUID: 00srl8NFDJ-SUUPFIpEZKfq2C8CLAwNd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyMSBTYWx0ZWRfXzU/FxPxWV0P6
 2hwQiSOLB/vjx4nk+bTJyGT8MGii3+ZjEOZnyJb01w/UJ1S/AKOgcG67CH1ulmF67o9kQK4K1Xc
 Lol2JdhQEvv7wSeJHOUVsBdNRPJ0MGixviP01yc5FUUzdXdP0YIiOFTwl5L1MOovEg3UjwMHpRz
 5yDgylgLQ4BDRud4OhT9wDKC+YY954F6+8k1zrxZFSX9vcP7kRh4VGEFrCEYuYhBoqU0GlcqWH1
 DpspFAEpy4fhrvOhc+C3lzISvQDwmlHTIIg3NyaDlzPJzuyhHtYUjhtsa0noqsbrjA0EhTHrw/K
 ijcGDxOHO6oHVEShn9YXo++MlbfHZs5GvbSoufzQ0uBkuNyjoV2gA2g3pMAEjdUvyvbhEfariqm
 QMsf9fYf
X-Authority-Analysis: v=2.4 cv=A8ZsP7WG c=1 sm=1 tr=0 ts=68af215a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=eC5F5FB79jDbC9rVOvkA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_03,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230021

On Tue, Aug 26, 2025 at 12:08:01AM +0800, Zorro Lang wrote:
> On Fri, Aug 22, 2025 at 01:32:01PM +0530, Ojaswin Mujoo wrote:
> > The main motivation of adding this function on top of _require_fio is
> > that there has been a case in fio where atomic= option was added but
> > later it was changed to noop since kernel didn't yet have support for
> > atomic writes. It was then again utilized to do atomic writes in a later
> > version, once kernel got the support. Due to this there is a point in
> > fio where _require_fio w/ atomic=1 will succeed even though it would
> > not be doing atomic writes.
> > 
> > Hence, add an explicit helper to ensure tests to require specific
> > versions of fio to work past such issues.
> 
> Actually I'm wondering if fstests really needs to care about this. This's
> just a temporary issue of fio, not kernel or any fs usespace program. Do
> we need to add a seperated helper only for a temporary fio issue? If fio
> doesn't break fstests running, let it run. Just the testers install proper
> fio (maybe latest) they need. What do you and others think?
> 
> Thanks,
> Zorro

Hey Zorro,

Sure I'm okay with not keeping the helper and letting the user make sure
the fio version is correct.

@John, does that sound okay?

Regards,
ojaswin
> 
> > 
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >  common/rc | 32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> > 
> > diff --git a/common/rc b/common/rc
> > index 35a1c835..f45b9a38 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -5997,6 +5997,38 @@ _max() {
> >  	echo $ret
> >  }
> >  
> > +# Check the required fio version. Examples:
> > +#   _require_fio_version 3.38 (matches 3.38 only)
> > +#   _require_fio_version 3.38+ (matches 3.38 and above)
> > +#   _require_fio_version 3.38- (matches 3.38 and below)
> > +_require_fio_version() {
> > +	local req_ver="$1"
> > +	local fio_ver
> > +
> > +	_require_fio
> > +	_require_math
> > +
> > +	fio_ver=$(fio -v | cut -d"-" -f2)
> > +
> > +	case "$req_ver" in
> > +	*+)
> > +		req_ver=${req_ver%+}
> > +		test $(_math "$fio_ver >= $req_ver") -eq 1 || \
> > +			_notrun "need fio >= $req_ver (found $fio_ver)"
> > +		;;
> > +	*-)
> > +		req_ver=${req_ver%-}
> > +		test $(_math "$fio_ver <= $req_ver") -eq 1 || \
> > +			_notrun "need fio <= $req_ver (found $fio_ver)"
> > +		;;
> > +	*)
> > +		req_ver=${req_ver%-}
> > +		test $(_math "$fio_ver == $req_ver") -eq 1 || \
> > +			_notrun "need fio = $req_ver (found $fio_ver)"
> > +		;;
> > +	esac
> > +}
> > +
> >  ################################################################################
> >  # make sure this script returns success
> >  /bin/true
> > -- 
> > 2.49.0
> > 
> 

