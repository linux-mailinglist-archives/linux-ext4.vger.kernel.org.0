Return-Path: <linux-ext4+bounces-9216-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C86B14808
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Jul 2025 08:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF9A3A6BDE
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Jul 2025 06:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7939F257444;
	Tue, 29 Jul 2025 06:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HptmlhRE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1E31D516F;
	Tue, 29 Jul 2025 06:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753769517; cv=none; b=o2emwaGVr/I1ENA20/sjA2YwTQudl4I1CfHtoL/tryYZQzfiqDHjHgEcUT+0bKterXzCfOBjq8plI6R1NmQ51i4LwtJ6mjkoc5o4CwI5Y2P6Y7Z8bi8MSrgVNLusuEQs4etGkxJCANfBKwPV8xqsR/sdQ4a0uo6CqznSti/tzCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753769517; c=relaxed/simple;
	bh=qyo5oaSH3pdeYg1imE8U05pRCdHr1Ahnnun4idVJrJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnjBoW0eDXhMNUOQAGmodw8OHFzcWSPOZDE85bqF/Jn8pEpuggUvD8ohr/H0h9fNHammVefeFavKdfDTf2qRWTUBIYBr+GP/CyVSd+GpjI1smuh6qLtVOyghPNrbGBPPCSMRn+puuZ1P5G5howZXZiYGE4qRJLWsXFvElFcu9nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HptmlhRE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T4YvEl016094;
	Tue, 29 Jul 2025 06:11:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=npO1rLIIWjoCLzDeblYMrxNSDFeD6Z
	/HhkoGv+2OpnA=; b=HptmlhREe3hzBhu12lm0iK4cblWK+XpvuGlJsFLgvNO241
	jDGeWu1uPJ6YyT/eJt7xEiSKJejcCQ8ZaqmLp9dfIjMmvTLUryjqG99gj0HJ3/3O
	+cG5w0LpTs9FaBs8y3BTgB4FKiKKSKVQp+5fODAFACmvwndr+L/lfxirJJeoVA8k
	aRi0SEBdSzCot7v7EkpQ3uyAzXkkDSN4CClICcAp4jtFQ6kPyE6e0oLxXbGuXwwI
	10BQdQZnHOpaG/c47QqTbabgDIBi0TMAY9/l4YIHW/BKS2K+kOUtgIQuMLmCWpGy
	8Cph5PvwFvWqTIIvdDpmi+KLHLBUrqMNLtBDl3SQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4864k7ncth-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 06:11:47 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 56T6Bkux015799;
	Tue, 29 Jul 2025 06:11:46 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4864k7ncte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 06:11:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56T3Tiwb017296;
	Tue, 29 Jul 2025 06:11:45 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4859r017c0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 06:11:45 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56T6BhHF19530128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 06:11:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4CBC20043;
	Tue, 29 Jul 2025 06:11:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9ADD20040;
	Tue, 29 Jul 2025 06:11:41 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 29 Jul 2025 06:11:41 +0000 (GMT)
Date: Tue, 29 Jul 2025 11:41:39 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 05/13] generic/1226: Add atomic write test using fio
 crc check verifier
Message-ID: <aIhmG-l4nWOAzz2I@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <aH9PwFm06n9KQ0mE@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <7fc0f04e-dcec-47a4-b522-eb5a8b90637c@oracle.com>
 <aIDozETJ8aLparYV@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <9b9ed959-bda5-4a92-90c7-a621ffe58240@oracle.com>
 <aIMjrunlU04jI2lF@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <0af205d9-6093-4931-abe9-f236acae8d44@oracle.com>
 <aIccCgrCuQ4Wf1OH@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <2ae4bb04-fbf7-4a53-b498-ea6361cdab3e@oracle.com>
 <aId8oZGXSg5DW48X@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <3a4854ac-75ad-4783-acbd-048fe7c7fdb0@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a4854ac-75ad-4783-acbd-048fe7c7fdb0@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IYi4LjlurG4EpHxQPR9WnF-Vid7bzMhI
X-Proofpoint-GUID: afJOUXw9l_wY-hnUTuydPNMQe1vB6oxa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDA0MiBTYWx0ZWRfXzlP14Ih8yYmz
 WiVXMqgSa7iUjMSHoWdZIGjLq50rZhCSTo4Y9Qel/ihc4JQMqNY8uDYgztMaywmZR/37G4yvjIx
 Og6aTrT6nfMIaCed1WpdOMIrJOG7GARzgWNO839mMqvPoAo/BcRskyaWzBi4XbvluVwWDwfTZkZ
 IAcrwQs1hcMg6sd8bqAY8Ch8QfbKc+uofaHfLXh0FDVNf9jQvYZ4/VMABIzi4X00BRh0cc4KOG9
 mrcqz9lOl2GtFPCMygJ2vqqleqodLOQW5XhmVEtSryTDCEkb+iuoE+GDZEyO6e9mMw+7d1Gp3MJ
 Qucj5bL7CO+VnQtYUXBHVOE4NKUTmrSorLmVKswsPe4Mlpn8r+JjQ3UnAYOjXAoALRSSpuYNKgy
 RZQvh9JCNLl9xyZ+I3NZIw/5UbOLoHtwzx3CUQXC9W3vrS90qfvcVhMxHmHuJ6liW79DiKD4
X-Authority-Analysis: v=2.4 cv=ZoDtK87G c=1 sm=1 tr=0 ts=68886623 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=kZ19UcRoRC3ff-rJVaEA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_01,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0 clxscore=1015
 adultscore=0 impostorscore=0 mlxlogscore=721 bulkscore=0 phishscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507290042

On Mon, Jul 28, 2025 at 03:00:40PM +0100, John Garry wrote:
> On 28/07/2025 14:35, Ojaswin Mujoo wrote:
> > > We guarantee that the write is committed all-or-nothing, but do rely on
> > > userspace not issuing racing atomic writes or racing regular writes.
> > > 
> > > I can easily change this, as I mentioned, but I am not convinced that it is
> > > a must.
> > Purely from a design point of view, I feel we are breaking atomicity and
> > hence we should serialize or just stop userspace from doing this (which
> > is a bit extreme).
> 
> If you check the man page description of RWF_ATOMIC, it does not mention
> serialization. The user should conclude that usual direct IO rules apply,
> i.e. userspace is responsible for serializing.

My mental model of serialization in context of atomic writes is that if
user does 64k atomic write A followed by a parallel overlapping 64kb
atomic write B then the user might see complete A or complete B (we
don't guarantee) but not a mix of A and B.

> 
> > 
> > I know userspace should ideally not do overwriting atomic writes but if
> > it is something we are allowing (which we do) then it is
> > kernel's responsibility to ensure atomicity. Sure we can penalize them
> > by serializing the writes but not by tearing it.
> > 
> > With that reasoning, I don't think the test should accomodate for this
> > particular scenario.
> 
> I can send a patch to the community for xfs (to provide serialization), like
> I showed earlier, to get opinion.

Thanks, that would be great.

Regards,
John
> 
> Thanks,
> John
> 

