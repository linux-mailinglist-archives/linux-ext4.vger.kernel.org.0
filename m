Return-Path: <linux-ext4+bounces-9862-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F066B4A681
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Sep 2025 11:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FB6B7BAAD0
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Sep 2025 09:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3648928152B;
	Tue,  9 Sep 2025 09:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WNKvpGDn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441D5276050;
	Tue,  9 Sep 2025 09:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408574; cv=none; b=oEPxtYpaZ0ae1U4r3srOadPbzpig5YDHj8cCZoNe9vMXc85C3nURLBhaPJIxmbt3Uzv5e4SaNUgvv5TXFea9GyPnNzbZZq8UJ33NKQ0I8UvAVoleUn213Ptsumu5K3KoFAHZAxTjchrUpl6V1wnEDYJHcJA/row3sQKviiKsC3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408574; c=relaxed/simple;
	bh=8pVak2VJN9E7Xhz2X/OudsUh8lpdzx4GAkHFT0mouMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJZv8IIuZW7G4SNT/eo8btO2LybGCG0h1bGdIbhMZyjvTiIkQs1a8F8BGE/fdfIjN+r03MmjLL4cf5hOqCNkrVD2HDJdSEXW36tpFNSuSsTsgKLTErDiNcnaLmXjMGx5xdS6H6UOY8UEP5H3jW8Q9mrwJUNKqKfF5n/DmTfOotU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WNKvpGDn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5896kdYW031789;
	Tue, 9 Sep 2025 09:02:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tW97Zu
	OHjL76eo35tHTIssB3DVsSl9WiA/Rq3Rl/7V8=; b=WNKvpGDnGCfACTPIHKmxFY
	Jc9kMNv9+bP/lDDVSC/+N0Dklz0zRlM4MMvUY6hy9jWwp/6oKAsvpJbT66SubmD5
	N3wFElLjGGTXUo52R/OB/uU091Kw5ZnwNq+GsXZOhJ70L5t4T58/8GPbiJ4bkYol
	RKmAO674ySvykEFXo1SyjBgsB1gctQrpSKv8M36sD5YFuO8menvLHgVcY3fscNOT
	OVmYfZW0wJHrp8qKaTTbEAj+bFrvxfZsX942xsKYiO3XLZbUS4njbBTbwN/EmEs/
	XnbynlQZ4ZjbiCjWpWZRhIgOcBTTF7PRTA2uDKqMnKXPM6KcI4Ia4VBvpSc/sI2w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490acqxk28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 09:02:45 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5898mmqw024895;
	Tue, 9 Sep 2025 09:02:44 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490acqxk23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 09:02:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5895axoG011463;
	Tue, 9 Sep 2025 09:02:43 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 490y9uaghs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 09:02:43 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58992g6j18022742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Sep 2025 09:02:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6C9B2004F;
	Tue,  9 Sep 2025 09:02:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9012120040;
	Tue,  9 Sep 2025 09:02:39 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  9 Sep 2025 09:02:39 +0000 (GMT)
Date: Tue, 9 Sep 2025 14:32:36 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v5 02/12] common/rc: Add _require_fio_version helper
Message-ID: <aL_tLHcWyFPShrUc@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
 <955d47b2534d9236adbd2bbd13598bbd1da8fc04.1755849134.git.ojaswin@linux.ibm.com>
 <1b12c0d9-b564-4e57-b1a5-359e2e538e9c@oracle.com>
 <20250907052943.4r3eod6bdb2up63p@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <aL_US3g7BFpRccQE@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <08438a13-6be7-4be3-a102-35a1f6fec9a5@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <08438a13-6be7-4be3-a102-35a1f6fec9a5@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OFh0U-xnAHaoOkqunMCf5T1jnR9AKRpY
X-Authority-Analysis: v=2.4 cv=Mp1S63ae c=1 sm=1 tr=0 ts=68bfed35 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=CWeDPxSGA1ZkMpU08kcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 27F7w318Q_q5Kbds0pY4eBIzGpe0vs3S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfX8OF13Zs6jRRa
 Uib3G8AIKkBkWLDtHpYqXfAgP2c8oHp+LzUY32WM8gUo6AknybeLcBmTL/FGlgcKV84RV6zVZkC
 qceEGd+OIHTSDG1kaSXXGNLD7omwn5gpZInCCquwpCLzOOxTdC+dmLACUKkXgfbn+RApC6j6e0f
 nBjpF+s2jtLbT4eSgHk4mT3q3UaKOw5k/BLldhL5C2PGHLfdoAjKxcPGMNyBsQxnQLVAJwL9yEU
 +pUKJCi1vtsAODzAWwPD1omhgTwqTj1EYCkg0nioxqhf1zeqybPF6oKQRU8zUc6RycmUF8zjHRW
 77q5gFLl8voiH3obnv6WYdETNDoAtfGEpL5RMfWeUx3DoLjccKxj4PCK4H2LQ3t4jx1CiLpaXa2
 7QB+xtb/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060000

On Tue, Sep 09, 2025 at 08:26:52AM +0100, John Garry wrote:
> On 09/09/2025 08:16, Ojaswin Mujoo wrote:
> > > > This requires the user to know the version which corresponds to the feature.
> > > > Is that how things are done for other such utilities and their versions vs
> > > > features?
> > > > 
> > > > I was going to suggest exporting something like
> > > > _require_fio_atomic_writes(), and _require_fio_atomic_writes() calls
> > > > _require_fio_version() to check the version.
> > > (Sorry, I made a half reply in my last email)
> > > 
> > > This looks better than only using _require_fio_version. But the nature is still
> > > checking fio version. If we don't have a better idea to check if fio really
> > > support atomic writes, the _require_fio_version is still needed.
> > > Or we rename it to "__require_fio_version" (one more "_"), to mark it's
> > > not recommended using directly. But that looks a bit like a trick 😂
> > > 
> > > Thanks,
> > > Zorro
> > Hey Zorro, I agree with your points that version might not be the best
> > indicator esp for downstream software, but at this point I'm unsure
> > what's the workaround.
> > 
> > One thing that comes to mind is to let fio do the atomic write and use
> > the tracepoints to confirm if RWF_ATOMIC was passed, but that adds a lot
> > of dependency on tracing framework being present (im unsure if something
> > like this is used somewhere in xfstests before). Further it's messy to
> > figure out that out of all the IO fio command will do, which one to
> > check for RWF_ATOMIC.
> > 
> > It can be done I suppose but is this sort of complexity something we
> > want to add is the question. Or do we just go ahead with the version
> > check.
> 
> I think that just checking the version is fine for this specific feature.
> But I still also think that versioning should be hidden from the end user,
> i.e. we should provide a helper like _require_fio_atomic_writes

Sure, I'm okay. @Zorro, does that sound okay to you?
> 
> thanks,
> John

