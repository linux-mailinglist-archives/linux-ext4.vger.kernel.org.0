Return-Path: <linux-ext4+bounces-9855-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91492B4A2BA
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Sep 2025 08:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CD8B1BC58E2
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Sep 2025 06:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926A7304BCC;
	Tue,  9 Sep 2025 06:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Sr22RboN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DBF1FDA92;
	Tue,  9 Sep 2025 06:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757401046; cv=none; b=cCZD9HD1Ez8P99huZbSTznY85ot2z0ABnVVpeZXSDkg57d298D8RzLJRvZQqfyFha2qFZQRuqLZcCTsNPck4HaZHpo2WBq8UCqG9b8da9OCbZ3vNIs18VToQM3eCafcKqKJ/7WWOP6UtB6klo3+1ilFTJ3ow4UhKbgjUaVEqm/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757401046; c=relaxed/simple;
	bh=cS4MWuIE0ADmFE0DRU64PLX5wR8zFTwbbEc/XSo/4SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rfg/ID3ETiXdd2UWhXZ0REnDn/EP3DINA0P1yrk6qef1UQL2bgHtDrOql//KheGnfJosm6upSHqz/mHK0EIK29jbiVz83LerUlL56zgVpzXw2GwwGpltLSyd1u3RD1g5rnsvtbEJQdMyNIqrjMcR5lRk/ixLo9eew/NP0qxydQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Sr22RboN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588LSDgM019819;
	Tue, 9 Sep 2025 06:57:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=kCYuieGAK/0zEEAO2rBoIMsFX1UbSM
	nvaKgT+tOmDzY=; b=Sr22RboNg8Kq2tJQQTEDv3FQeqfhi6GPYiEZlMpVhkYUec
	VkTSqhcF7RMjEW/Zh3HXItu32FGywasIXkj7FKjWQKPhr5MPFTa8EQxFtsN243jE
	uSuqMs9loKPuU8cYeF3lGXv2NPh1aqG+RO3SBz78cxzoL7UfaQ3y4pPvEai+wgdP
	9Mum2dzF/Y0j3ul9g4NspJ7Kkr0T6ZEXdf4Gq08+/Fxp3g07XFY6fWG8/fPYSdL7
	NEETdszYWVBXj/UrY9U1LoRA+u5Z64BrTYnduJgwJaqw8uFcpZQ4fIZNwyvCvN9S
	SXVkH40RiwMQOvFaBufSF7I7z9xuWe17h7FU3Gpw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490ukeb7hc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 06:57:17 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5896pFLs005882;
	Tue, 9 Sep 2025 06:57:17 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490ukeb7h9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 06:57:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5896IvN4010604;
	Tue, 9 Sep 2025 06:57:16 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4910smsqq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 06:57:16 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5896vEOx13697426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Sep 2025 06:57:14 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BFDC20043;
	Tue,  9 Sep 2025 06:57:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02F5B20040;
	Tue,  9 Sep 2025 06:57:12 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  9 Sep 2025 06:57:11 +0000 (GMT)
Date: Tue, 9 Sep 2025 12:27:09 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v5 04/12] ltp/fsx.c: Add atomic writes support to fsx
Message-ID: <aL_PxUApMCyL-6K5@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
 <8b7e007fd87918a0c3976ca7d06c089ed9b0070c.1755849134.git.ojaswin@linux.ibm.com>
 <e2892851-5426-43d3-a25e-be9d9c7f860a@oracle.com>
 <aLsP6ROqLqhdbLZz@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <448079fd-ac31-4a6e-99f8-9021c0a92476@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448079fd-ac31-4a6e-99f8-9021c0a92476@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDE5NSBTYWx0ZWRfX2FSe2J4IvgXG
 m8EohUFgTotDU+Tg2nqSpspue/zSz09uogtwJJGTAIkjxr/oQcdz6pUdMpKKuqvJqDZnSx9k8Tn
 mxd7DFQiqOjKkGq6SSV+XdD/hSy2ptDkrFVtwaGa8NUHM+YWfWtOirudRzIZuCKR/SMDtQa+Kvg
 4Rvp6DQ7LBpEq7wY/ItoqBymZemJY0lVFvhfBuJyK9Sr5CU/qvXKgKMtGR8zlW72O/CBWCnBHXP
 zpqtLhi5MtVQLO/MMk7iFxqT5aPfM4BkcCQ3SLI29fo2EId0ZQLV+0rW4trfShz0YQqiayTJ33B
 iVGZoHNzY0LXmjnC6vZ4PSj4bO6kRWC4n3qglfKOwoXVyjpW8tcEFAsvUJXEZvVxIkm4pnSGnlB
 VX47jehY
X-Proofpoint-ORIG-GUID: wpUwkgzQ6m59TNrEPOfSe7ql8RqhgdgE
X-Proofpoint-GUID: 7YiOeNKxEcmx0AEMeVjOwf9wcsOy5G9M
X-Authority-Analysis: v=2.4 cv=StCQ6OO0 c=1 sm=1 tr=0 ts=68bfcfcd cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=V3uXAB9MKXCMtpp5kXoA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060195

On Mon, Sep 08, 2025 at 08:53:59AM +0100, John Garry wrote:
> On 05/09/2025 17:29, Ojaswin Mujoo wrote:
> > > > +
> > > > +/*
> > > > + * Round down n to nearest power of 2.
> > > > + * If n is already a power of 2, return n;
> > > > + */
> > > > +static int rounddown_pow_of_2(int n) {
> > > > +	int i = 0;
> > > > +
> > > > +	if (is_power_of_2(n))
> > > > +		return n;
> > > > +
> > > > +	for (; (1 << i) < n; i++);
> > > > +
> > > > +	return 1 << (i - 1);
> > > Is this the neatest way to do this?
> > Well it is a straigforward o(logn) way. Do you have something else in
> > mind?
> 
> check what the kernel does is always a good place to start...
> 
> Thanks

So kernel pretty much does same thing:

unsigned long __rounddown_pow_of_two(unsigned long n)
{
	return 1UL << (fls_long(n) - 1);
}

where fls*() variants jump into asm for efficiency. asm is obviously not
needed here so we use the for loop to calculate the fls (find last bit
set):

	for (; (1 << i) < n; i++);

Ideally the compiler should do the right thing and optimize it.

Regards,
ojaswin

