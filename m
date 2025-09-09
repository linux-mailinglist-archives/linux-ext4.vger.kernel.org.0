Return-Path: <linux-ext4+bounces-9860-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDE7B4A640
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Sep 2025 10:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DCA27A21D4
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Sep 2025 08:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BE4275112;
	Tue,  9 Sep 2025 08:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ngZJbxPY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E618D253950;
	Tue,  9 Sep 2025 08:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408372; cv=none; b=eCmWtb4tnSz8qrtnlNHl0Juf9UvsqFm9wl+vq4TKs9fvWMbvaj94+IthdOTVf5QOvftl8Kruuhhp0O/HmoStMAUjuzLxXDySkgdyyuGy3nKXD/lqg9y4CThFtN8oEa43fr0UgjpnMVyStXm6O653yOkeRIkzdmRC9AQMI/ALrFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408372; c=relaxed/simple;
	bh=ldAqRL1w1c5lSiZ2DtEuHpyYYPfXl1xFtdexCIq84VU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGzsSaH18LFDdnewoGWQ55Jwpfx94/e4wl9O0syt90VT5L0hWXe9T8092bx0pGL3Q+EQv8AMOaxS9UFrffEVYtMUlttMx2+JsObQsc/TINe7VTpqpxiU7DE/jd9BN/T7sfj+OyfpkUfcxgicEYqolb6jwSSgIYJCwzvb5zUV7nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ngZJbxPY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5895iUZb027074;
	Tue, 9 Sep 2025 08:59:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=2wm+oep8dQcZFVr5bn5fSUvEmjP8pT
	2l7zFN2CXCWW4=; b=ngZJbxPYUrfDcePNT3wjT0OI6iXv4joqNWh29Nu5JN+zDZ
	lxBx8xNs7etmpthfm6UX/hsK6oSf/xV+2QzZ6hYWq/Av7v3xitsXMQaaHGh0eE6w
	lJBUytIisUk9wycbxwQ79LUBWByJM+ACWspONi8EYPGcoPaQovTcknja8h4R+2jp
	Iksgg7mYw+lQZG8PHqU1ZZa9PLKxYWLPQCNDJti3Bw4IguyGeS5zkJNN7CNfgiNI
	ytXlMxaGHiOpO5oGX5aDgIpM58pxhdxhMNr2zYxyxqAidrApuPzuRd+OthHCQF7C
	izT1U5H5Y640KrYWOo4guDq5HckhIbN5Ft6Pu0zg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bcspe0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 08:59:24 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5898mo6U030352;
	Tue, 9 Sep 2025 08:59:23 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bcspe0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 08:59:23 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58972UTT017172;
	Tue, 9 Sep 2025 08:59:23 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4911gma2pd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 08:59:22 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5898xLUE41419136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Sep 2025 08:59:21 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B3272004B;
	Tue,  9 Sep 2025 08:59:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEF6020043;
	Tue,  9 Sep 2025 08:59:18 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  9 Sep 2025 08:59:18 +0000 (GMT)
Date: Tue, 9 Sep 2025 14:29:16 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v5 04/12] ltp/fsx.c: Add atomic writes support to fsx
Message-ID: <aL_sZPjpK6UhD2cR@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
 <8b7e007fd87918a0c3976ca7d06c089ed9b0070c.1755849134.git.ojaswin@linux.ibm.com>
 <e2892851-5426-43d3-a25e-be9d9c7f860a@oracle.com>
 <aLsP6ROqLqhdbLZz@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <448079fd-ac31-4a6e-99f8-9021c0a92476@oracle.com>
 <aL_PxUApMCyL-6K5@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <6dfce0c1-70f5-4f96-9d1a-e8cc680354ba@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dfce0c1-70f5-4f96-9d1a-e8cc680354ba@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxMCBTYWx0ZWRfX4j8uk7dr3ahW
 0Ca8geMFytr75cIrBohTxVIKdZo0++Ouy/HiPhzs2+7a3MDDfK4gZhVM0uzkslX1bZbt+Xy8rx6
 +pgOqhTkReB8exdebOcKkV2X9uZd+YWjE/ZNaIRRFOOEHn70TWSwiZfuDIQeOqi2PZ7Zq7+Uh6F
 0RT6f8FX9Io1vUbKDhUiQxFrrGn2++Y6b8H8p+MiYYqjJwjVKsm+blpaws8iNGdE56xw+8qQcgw
 QWGxwF7exFivkfRUzWfjZGQjg6Zi6szBH08C8FVSZ7h8D6i95MBvj2nNI2Or3prwTJbU98ckPK6
 Mo+biuX2xo5aS7Zey0n7oX1nyFLBSk7Eg2xW7L2daEhXqTU1UyOvriutnRlKAnPH6Lam5OuHFeF
 v/rFnQoL
X-Authority-Analysis: v=2.4 cv=SKNCVPvH c=1 sm=1 tr=0 ts=68bfec6c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=WzhbGYWC2DiaSLCB1H4A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: zoe7N0Wyt9H7Yk05N0HpCTLbh_OladNS
X-Proofpoint-ORIG-GUID: thHYnAysgbWQWM1R_vqx8TrqdURGiQ0z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060010

On Tue, Sep 09, 2025 at 08:55:54AM +0100, John Garry wrote:
> On 09/09/2025 07:57, Ojaswin Mujoo wrote:
> > > > > > +
> > > > > > +/*
> > > > > > + * Round down n to nearest power of 2.
> > > > > > + * If n is already a power of 2, return n;
> > > > > > + */
> > > > > > +static int rounddown_pow_of_2(int n) {
> > > > > > +	int i = 0;
> > > > > > +
> > > > > > +	if (is_power_of_2(n))
> > > > > > +		return n;
> > > > > > +
> > > > > > +	for (; (1 << i) < n; i++);
> > > > > > +
> > > > > > +	return 1 << (i - 1);
> > > > > Is this the neatest way to do this?
> > > > Well it is a straigforward o(logn) way. Do you have something else in
> > > > mind?
> > > check what the kernel does is always a good place to start...
> > > 
> > > Thanks
> > So kernel pretty much does same thing:
> > 
> > unsigned long __rounddown_pow_of_two(unsigned long n)
> > {
> > 	return 1UL << (fls_long(n) - 1);
> > }
> > 
> > where fls*() variants jump into asm for efficiency. asm is obviously not
> > needed here so we use the for loop to calculate the fls (find last bit
> > set):
> > 
> > 	for (; (1 << i) < n; i++);
> > 
> > Ideally the compiler should do the right thing and optimize it.
> 
> I think that some versions of fls use builtin clz also, but I am not sure if
> that (clz) is always available for supported toolchains here.

Right, kernel also tries that whenever possible. Im unsure though if
fls() is a libc function. I think its not but I'm not able to find any
resources to confirm this. 

In case it is not, then I think the current logic should be good enough.
> 
> Thanks,
> John

