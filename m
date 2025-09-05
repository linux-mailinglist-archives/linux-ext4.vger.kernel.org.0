Return-Path: <linux-ext4+bounces-9827-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C027B45D03
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Sep 2025 17:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BDAC581F49
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Sep 2025 15:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC8431D738;
	Fri,  5 Sep 2025 15:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BlF4J8nU"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC92631D72A;
	Fri,  5 Sep 2025 15:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757087487; cv=none; b=ohBUAW5SwpO9ptgP/MA/Zkq2Mgt7F485LbBvZ5Cyr2d890V4FdN94vyM3McloFSM7g5PN62bmAp7821evVudFbu/vwzYoH1h4cWwJ1q+5lSU0AQzrUAdIsLlqMCEQ/I0MMwvZcBQAohKzHLE89mglVew0kknk+YFJTXatosxR/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757087487; c=relaxed/simple;
	bh=Um+86a5YDcVUMSKYDjZdKHiY64RDEJugEGJG152V/5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wn3q4MtH6Ugv6HJypamGSGSxoRY6kstZxqqPXWIJgwp7MMeyLxeX5kC58EmJZnbRALewmf5E7EzwPFQgva39hFCT1Reb1Ma1xouMi0bZjHkiYEVa3EaLjtSLO84ldNPth8QInytDqrujuethf/HVGIa0K4s3bE1QavVW6a70p5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BlF4J8nU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5858FQ4j026963;
	Fri, 5 Sep 2025 15:51:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=lxAAVzNfsrB3MgMx0AYk352zSVfhWz
	hUdgs59EHdK9Y=; b=BlF4J8nUd4mDu/suT6e6gEaqOt3JqF/pUgwNYbYYMlOpwI
	Dwi5/0leMk+cad2kM0qEb42i2YM4hLlZrDAW4T2WM9aLArLsFNXFHILj3P/7gvYD
	SqqYc3jH6PBONWL+bEJ6eRhGJfBeec9mJaAJf4R/vASLjTKqn/+nn1fZRXGJZYf/
	Fgs5Mk3HqmMLyUk06eOuBC8aNEQjb4HkRqnTwLyi73i5y5Zwx7ge717CvK4qjf2V
	zMwoUrYEmi4QwEoeb8Iwtb3lePdIbwr6WeEgIrSEDc9FjH75tS+Ov9JqC6EkSXqk
	sAFhWLDtB0+nZV42lFmknfKPN7ZWHJKFAOIXcX6g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48uswdsj9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 15:51:18 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 585FpIOm000302;
	Fri, 5 Sep 2025 15:51:18 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48uswdsj9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 15:51:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 585CXg6E017205;
	Fri, 5 Sep 2025 15:51:16 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48vc112912-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 15:51:16 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 585FpEWe52560190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Sep 2025 15:51:14 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCC142004E;
	Fri,  5 Sep 2025 15:51:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83ADD2004B;
	Fri,  5 Sep 2025 15:51:12 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.220.13])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  5 Sep 2025 15:51:12 +0000 (GMT)
Date: Fri, 5 Sep 2025 21:21:09 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v5 02/12] common/rc: Add _require_fio_version helper
Message-ID: <aLsG7Y3jPk0DcVOU@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
 <955d47b2534d9236adbd2bbd13598bbd1da8fc04.1755849134.git.ojaswin@linux.ibm.com>
 <1b12c0d9-b564-4e57-b1a5-359e2e538e9c@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b12c0d9-b564-4e57-b1a5-359e2e538e9c@oracle.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=PeP/hjhd c=1 sm=1 tr=0 ts=68bb06f6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=un42nM1bcPd8a6zMRHMA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfXyuc1WX6hCd3V
 JFx9MuCVxEGqTaLX1kSiKbFAUcP3OgSSk4wLq+DYhh/4mfj8XbUwzB94kn0Nb/pMpxtziAqdY9j
 mX5Tbz83Mn7Rw2VDJaWTRgY0rUWFe+GbyeyWina6WqhyyhX4Tr6DZKLYmt5osIeXsmdJpogF1Dw
 ffV+ElKrhU2l577KIR4GP7CFPUySCBpmG+z/L2Shi7DqTVL6NAoFPKWYVAHj+WYgYnhMOdZuBh9
 OxPKaVsDoNqgGoGU0h1+aV7P7e+BM74Sa6a1KnLZXoh3TurJe28UG5g1n9zL5WAJ7Wf+YrwkDrH
 wRdIdywZnUjVAN28AzR1tjzcrwpF30Ed6oNxAzkmE5Unz3bMljkDlXMO2hLDYGktrdrXGvcmDU9
 1Ll5raSf
X-Proofpoint-GUID: 4XubNJwPOmbDWpHmR71uQ1WOGBZl6-BV
X-Proofpoint-ORIG-GUID: DW8Xp1Mwv1m3qCBh80Hj2vr4GKVPMIl6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0
 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300034

On Tue, Sep 02, 2025 at 03:50:10PM +0100, John Garry wrote:
> On 22/08/2025 09:02, Ojaswin Mujoo wrote:
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
> > 
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >   common/rc | 32 ++++++++++++++++++++++++++++++++
> >   1 file changed, 32 insertions(+)
> > 
> > diff --git a/common/rc b/common/rc
> > index 35a1c835..f45b9a38 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -5997,6 +5997,38 @@ _max() {
> >   	echo $ret
> >   }
> > +# Check the required fio version. Examples:
> > +#   _require_fio_version 3.38 (matches 3.38 only)
> > +#   _require_fio_version 3.38+ (matches 3.38 and above)
> > +#   _require_fio_version 3.38- (matches 3.38 and below)
> 
> This requires the user to know the version which corresponds to the feature.
> Is that how things are done for other such utilities and their versions vs
> features?

Hi John,

So there are not many such helpers but the 2 I could see were used this
way:

tests/btrfs/284:
   _require_btrfs_send_version 2

tests/nfs/001:
   _require_test_nfs_version 4

So I though of keeping it this way.

Regards,
ojaswin

> 
> I was going to suggest exporting something like
> _require_fio_atomic_writes(), and _require_fio_atomic_writes() calls
> _require_fio_version() to check the version.

> 
> Thanks,
> John

> 
> 

