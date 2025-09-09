Return-Path: <linux-ext4+bounces-9856-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4394DB4A345
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Sep 2025 09:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B068178E65
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Sep 2025 07:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6DB233727;
	Tue,  9 Sep 2025 07:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pUlj9UUz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86B91F63CD;
	Tue,  9 Sep 2025 07:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757402205; cv=none; b=p6LumqF1MTAeTlWsblac2d1rpYaG8cv5+P82NpkStPafDEh4d6DJiG7Hc+v+VpISEVAir3nhQhv5eodYIM4CayeCF4uBR92Kx9xFNkRa3c30OTxAhVMw+fP7945JbTuRxo+OKTs6pxNL/YjSMHEVDKNjCbMZ8PGAkhFHGSVAcMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757402205; c=relaxed/simple;
	bh=hQREbEaVSab6fA0oSS9yjWUfrq4dUsWJ0uPGr1c+mII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjT8npMm0YAE9Odp4oYjmxbQQeJTWmNp6Vjm66JQDbfagvluINuvSFti+6M6OcRPjPBXe93Qm01LiUu2KZyyKlI9H/gQcPy76di+eVZTaQgqwWMRXRYcywwWlUQ7Gv2dUXmciV5fI9UpTt0p8U43Q0PdLbvOzh0gPJaINX8LS5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pUlj9UUz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588LlYq1028671;
	Tue, 9 Sep 2025 07:16:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=mTMUOehaX8G9XYDSq5p+n6TZgkX68f
	h62k9GJjGycMU=; b=pUlj9UUzUswT5wMvbf1RhBNqini0okTYjnSwvwGxHXDc29
	Ef3Ejgax8uu32F5R38AJh2vmexn8fkQB+8vX29yLsfGFQwVw49v5gZfzhVEcTBdE
	iGJ468eQCqegk6WGcrxodH6eIRz71IBxgMOaemaSJWxctWzS53VqmlMQZosJKTLS
	yS6fwsn0hZobKC8Ni3R/Zj5a9BSleQrFesFI7C5vb18r3XKEjFGM45NLW0Ow7nyy
	ugAPiPN6nCU4wvZB7sAeJ/bqndc/qVHVAIbGOeQ++ygfMetk6u8asSt7O+0WmWFT
	8CD7HZlqhN0O+IqtYDMmxlBWMaORu434EyQfTo6Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490xycu02n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 07:16:36 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5897BoPu015898;
	Tue, 9 Sep 2025 07:16:36 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490xycu02j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 07:16:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5893EhQL001177;
	Tue, 9 Sep 2025 07:16:35 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4912039k00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 07:16:34 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5897GXHN52756922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Sep 2025 07:16:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A3602004B;
	Tue,  9 Sep 2025 07:16:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D570520040;
	Tue,  9 Sep 2025 07:16:30 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  9 Sep 2025 07:16:30 +0000 (GMT)
Date: Tue, 9 Sep 2025 12:46:27 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>
Cc: John Garry <john.g.garry@oracle.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v5 02/12] common/rc: Add _require_fio_version helper
Message-ID: <aL_US3g7BFpRccQE@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
 <955d47b2534d9236adbd2bbd13598bbd1da8fc04.1755849134.git.ojaswin@linux.ibm.com>
 <1b12c0d9-b564-4e57-b1a5-359e2e538e9c@oracle.com>
 <20250907052943.4r3eod6bdb2up63p@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250907052943.4r3eod6bdb2up63p@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cpppd1dr-2q73_zibYzFYMRO9bVEFxWv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDIzNSBTYWx0ZWRfX09Nir5E2napS
 ELVjPwoex8CJmZRGp13LgUyZLyfbbzmL+i0YG3PsKLfgiFikfNRW4AkyzNE3vHIwMHee7GyUg60
 7HvRyG2sa9NMEoqm4qclsxX3te5J/tivNeZfp6l2eosQ/JfGHniF25lHCOcfaABRC63TrNAw/jz
 vKpCqltcfWhe96Ix4Xgz8/KnoGMQRlWLhJh+OTAu8+ArzvLU8ln8QpFIFrsRJtcE+WLyif1/DMZ
 kXhbODyvg5CQOWlO7cgHSaasPDHAcOsTFXdzrfK49B94ufQoWcKRvtELnzQDfoNlHusBgrpZO0q
 IvBGDzQUPZIuaIWVV2Hq8I8qSSeLlG7yPYcDh3zqdf8si5i3bTK/2osj+0dIAY1XcxE/SJs0yJs
 v/B8bB+8
X-Proofpoint-GUID: GWd2MecVCtrnP5CM7arXcJlhp8vusOjb
X-Authority-Analysis: v=2.4 cv=F59XdrhN c=1 sm=1 tr=0 ts=68bfd454 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=c_9EunDC1JvEA1HTsxcA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060235

On Sun, Sep 07, 2025 at 01:29:43PM +0800, Zorro Lang wrote:
> On Tue, Sep 02, 2025 at 03:50:10PM +0100, John Garry wrote:
> > On 22/08/2025 09:02, Ojaswin Mujoo wrote:
> > > The main motivation of adding this function on top of _require_fio is
> > > that there has been a case in fio where atomic= option was added but
> > > later it was changed to noop since kernel didn't yet have support for
> > > atomic writes. It was then again utilized to do atomic writes in a later
> > > version, once kernel got the support. Due to this there is a point in
> > > fio where _require_fio w/ atomic=1 will succeed even though it would
> > > not be doing atomic writes.
> > > 
> > > Hence, add an explicit helper to ensure tests to require specific
> > > versions of fio to work past such issues.
> > > 
> > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > ---
> > >   common/rc | 32 ++++++++++++++++++++++++++++++++
> > >   1 file changed, 32 insertions(+)
> > > 
> > > diff --git a/common/rc b/common/rc
> > > index 35a1c835..f45b9a38 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -5997,6 +5997,38 @@ _max() {
> > >   	echo $ret
> > >   }
> > > +# Check the required fio version. Examples:
> > > +#   _require_fio_version 3.38 (matches 3.38 only)
> > > +#   _require_fio_version 3.38+ (matches 3.38 and above)
> > > +#   _require_fio_version 3.38- (matches 3.38 and below)
> > 
> > This requires the user to know the version which corresponds to the feature.
> > Is that how things are done for other such utilities and their versions vs
> > features?
> > 
> > I was going to suggest exporting something like
> > _require_fio_atomic_writes(), and _require_fio_atomic_writes() calls
> > _require_fio_version() to check the version.
> 
> (Sorry, I made a half reply in my last email)
> 
> This looks better than only using _require_fio_version. But the nature is still
> checking fio version. If we don't have a better idea to check if fio really
> support atomic writes, the _require_fio_version is still needed.
> Or we rename it to "__require_fio_version" (one more "_"), to mark it's
> not recommended using directly. But that looks a bit like a trick :-D
> 
> Thanks,
> Zorro

Hey Zorro, I agree with your points that version might not be the best
indicator esp for downstream software, but at this point I'm unsure
what's the workaround. 

One thing that comes to mind is to let fio do the atomic write and use
the tracepoints to confirm if RWF_ATOMIC was passed, but that adds a lot
of dependency on tracing framework being present (im unsure if something
like this is used somewhere in xfstests before). Further it's messy to
figure out that out of all the IO fio command will do, which one to
check for RWF_ATOMIC.

It can be done I suppose but is this sort of complexity something we
want to add is the question. Or do we just go ahead with the version
check.

Regards,
ojaswin

> 
> 
> > 
> > Thanks,
> > John
> > 
> > 
> 

