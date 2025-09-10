Return-Path: <linux-ext4+bounces-9895-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B09B50E14
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Sep 2025 08:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0D6248147B
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Sep 2025 06:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750FF303A22;
	Wed, 10 Sep 2025 06:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SeEIQaGa"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83543246788;
	Wed, 10 Sep 2025 06:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757486336; cv=none; b=dVA3g92UXth3PpoIyDnWIs1rUo8RP6f2H0FPaNK+6i9sPDeJsWKb3FeIeRCr+ziyNERhqUexYPSt+vrhYMQzMuPAJIWHzE0mjpb8gAHFdF2VRkdNvIrCWO9wTT9Yh9zx16DZYMe3Zys9LF+cByh7r2QWVvW2mUaSs6l3Do35h94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757486336; c=relaxed/simple;
	bh=HtJFPVBSRLL69/fDPfGLjardcvvG2PoQkZG1CwL/WNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6WVmOJ04+LvKm2Bme9W9uZJ2Akeyy6K6kX/8rgaVAY5d9rz/HcEkPfEjHXl6eva/jsG3VXwWayQ4MVF+AD6/unc9BZWN97SE+qYyhQm1cI4UZiHl+trBFAbQjwSntBMjRBBfcG4PDOkIVlUnUDcj0lTQEv3WpR2bVAxQBj5Z68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SeEIQaGa; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58A5gQ7d026821;
	Wed, 10 Sep 2025 06:38:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=u4c9n0
	RJl5sZ/Cou/Y9CAtU3SlebsfZtlil7ogfqWlo=; b=SeEIQaGaI2rBMkmZdnUyO9
	qkF7ZOcLu5r1dMmzRnWJoxlrFljpv3yXp2cFeq8BYK74wj8r6i6PuR14h+ZCmcsN
	pDOSudSPTfSfyPGl/VnQ+9UxdWZ11lyodujIqNZi/PA7/6tnQlWT4zu60G+ftGEa
	FY9jQKdnkqf2EdR8m0cm0K9dF5ALPs9XztwriDmq2m851SwefmM2nP3JHy/WPvvA
	ZBXlj1aXCRi8U4Snfpbxyzp/Tsn4iCJB2dpBkjLW+0yK5ZtgAqPRELDdneQcXMMp
	QavuHUpr7V4TKanHVuy2ssCQMFL1QNP0grhWLTdU+ji6wkufoL4zVNvCqM94f4/A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bcsuy4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 06:38:46 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58A6ckud028548;
	Wed, 10 Sep 2025 06:38:46 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bcsuy4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 06:38:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58A5ph8k007929;
	Wed, 10 Sep 2025 06:38:45 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49109pq37b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 06:38:45 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58A6chSE55837048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 06:38:43 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8FED20043;
	Wed, 10 Sep 2025 06:38:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4CF320040;
	Wed, 10 Sep 2025 06:38:40 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.208.79])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 10 Sep 2025 06:38:40 +0000 (GMT)
Date: Wed, 10 Sep 2025 12:08:18 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>
Cc: John Garry <john.g.garry@oracle.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v5 02/12] common/rc: Add _require_fio_version helper
Message-ID: <aMEc2gW2WA0kYUks@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
 <955d47b2534d9236adbd2bbd13598bbd1da8fc04.1755849134.git.ojaswin@linux.ibm.com>
 <1b12c0d9-b564-4e57-b1a5-359e2e538e9c@oracle.com>
 <20250907052943.4r3eod6bdb2up63p@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <aL_US3g7BFpRccQE@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <08438a13-6be7-4be3-a102-35a1f6fec9a5@oracle.com>
 <aL_tLHcWyFPShrUc@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20250910060715.gc2thcbklvhzaxz2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250910060715.gc2thcbklvhzaxz2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxMCBTYWx0ZWRfX/0NtW9aEEW6h
 pnXyqnOyNm5xPrlppDsonIz3Nt9Abuk8iRHaPT5jdvWNcAA5O4YaqK2XmXS0tdr7KwxBFriIKRe
 XXNEjFr/ONYI1DTzRz47GF2/Av+epfEtlxisjtWsyjiA4mxjtFsz7Afdc6UctsvJxT73ypGbyO3
 WXyRxU44WPoODkBmWzsUPovd6l3bwN+zFocKhIF0FsNAlipUOh/L3SgyCr2o0u1FI4ItuVtUHwe
 Zf5aeVxZ+gR/CBNZpvET54SI7qosJBnPZAjTiJV55DyRL2kzHqiuwy+AuyeSIWCMZiPSVMkZcfS
 hShs0ucdhfe3uHT5JYgzVIBzn9pUrdvN1qz68Hdk30vJ5YKU8AZmDU2KWhoeCy5J+nlc5AKVXbI
 XyXFfCu4
X-Authority-Analysis: v=2.4 cv=SKNCVPvH c=1 sm=1 tr=0 ts=68c11cf7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=2Bkm4qvF8fFmuRCA4ikA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: EOPOwHLh1yDoNwu07lGqEec2q_NXr1ZK
X-Proofpoint-ORIG-GUID: UHNWWDSEJfsBFveSEPLXhrVj7i43CyCR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060010

On Wed, Sep 10, 2025 at 02:07:15PM +0800, Zorro Lang wrote:
> On Tue, Sep 09, 2025 at 02:32:36PM +0530, Ojaswin Mujoo wrote:
> > On Tue, Sep 09, 2025 at 08:26:52AM +0100, John Garry wrote:
> > > On 09/09/2025 08:16, Ojaswin Mujoo wrote:
> > > > > > This requires the user to know the version which corresponds to the feature.
> > > > > > Is that how things are done for other such utilities and their versions vs
> > > > > > features?
> > > > > > 
> > > > > > I was going to suggest exporting something like
> > > > > > _require_fio_atomic_writes(), and _require_fio_atomic_writes() calls
> > > > > > _require_fio_version() to check the version.
> > > > > (Sorry, I made a half reply in my last email)
> > > > > 
> > > > > This looks better than only using _require_fio_version. But the nature is still
> > > > > checking fio version. If we don't have a better idea to check if fio really
> > > > > support atomic writes, the _require_fio_version is still needed.
> > > > > Or we rename it to "__require_fio_version" (one more "_"), to mark it's
> > > > > not recommended using directly. But that looks a bit like a trick 😂
> > > > > 
> > > > > Thanks,
> > > > > Zorro
> > > > Hey Zorro, I agree with your points that version might not be the best
> > > > indicator esp for downstream software, but at this point I'm unsure
> > > > what's the workaround.
> 
> Hi Ojaswin, I don't have better workaround than require_fio_version for now. I mean:
> 1) name _require_fio_version as __require_fio_version, to mark it's an internal function
>    of another common function.
> 2) only call __require_fio_version in _require_fio_atomic_writes for now, don't use it
>    in any test cases directly.

Got it, I'll make this change, thanks

> 
> > > > 
> > > > One thing that comes to mind is to let fio do the atomic write and use
> > > > the tracepoints to confirm if RWF_ATOMIC was passed, but that adds a lot
> > > > of dependency on tracing framework being present (im unsure if something
> > > > like this is used somewhere in xfstests before). Further it's messy to
> > > > figure out that out of all the IO fio command will do, which one to
> > > > check for RWF_ATOMIC.
> > > > 
> > > > It can be done I suppose but is this sort of complexity something we
> > > > want to add is the question. Or do we just go ahead with the version
> > > > check.
> > > 
> > > I think that just checking the version is fine for this specific feature.
> > > But I still also think that versioning should be hidden from the end user,
> > > i.e. we should provide a helper like _require_fio_atomic_writes
> > 
> > Sure, I'm okay. @Zorro, does that sound okay to you?
> 
> Sure, that's what I tried to say as above, sorry if I made you misunderstand :)

Right I was just confirming. Thanks for the review :)

Regards,
ojaswin
> 
> Thanks,
> Zorro
> 
> > > 
> > > thanks,
> > > John
> > 
> 

