Return-Path: <linux-ext4+bounces-9186-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E56B1187F
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Jul 2025 08:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D46DAA3399
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Jul 2025 06:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183F22882D3;
	Fri, 25 Jul 2025 06:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LI8COTNG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151CA1E47AD;
	Fri, 25 Jul 2025 06:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753424880; cv=none; b=tP3MB3cwbZI4scIhOkqllGh7Ka02MlK5uDffNnPB5r4I17Usmk6DvbTJX3/AFZJyswaQQBsVHEkWpz7HyDJW5EymS3BYe2xmrsv+3Q1e/3cEWnbzNl6yKNpdl04uHtM8DhMhQbjfBn99xWmsX5rZ6wkwNOEEumKcu2+QGZByGtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753424880; c=relaxed/simple;
	bh=e/ZyDH4WWdJfn9bdaRkj8a5fNMoH+piypyKZpyuRjiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gjgctn7sZ3psKdbZbFjw5lulK8hT5Hq87AN7gAnaWoo1rNnIzGbotfUFm3jtS4iPP5oYg2ykVBRSdmdy6Weq8d4soIaFqNdzQ57EpVJBHqhxgnArQl2QhVBkoR72KRtJt2slzpinwVVfRdDAtW26grS5deY0/yekt3QZVib3jn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LI8COTNG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OM9PDo008091;
	Fri, 25 Jul 2025 06:27:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=4yGrmkLLgCYTkHhTdUotm3WNf/3d+Y
	qOyCYfoKmz7k4=; b=LI8COTNGdoJHxx/pJX1VXDM9vwILwCijzsOb1M0a0am3zi
	ekXKUEapDng1ZO+XggNCPSSC1gIMUWkaG+ToqfESlxu+QlJlh+dH1a9rky3ywCz4
	C2i4pt0cJ+2uFZXPc9AwvUCq188EiPV9TScnD4P1yLYAVZq9ABs8qRx0zwYJKwCm
	VvzF754oEF2Pbe7DfNWPaSZi7XTgjdPTvpscX2mnzA57Swc2okHSORoj4KgJQYcB
	a6S/vOsp1jRc+TpDqUl91/wIoJkfJxm19DztWU7bPTvu1/aq0QYuB7sK37vDjIQA
	F4JKHLx0g81/fLrfGJDJ5XlAcP98lUf40YeQYFtw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 483wcksfkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 06:27:45 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56P6RiOL032412;
	Fri, 25 Jul 2025 06:27:44 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 483wcksfkn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 06:27:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56P2r6gS025452;
	Fri, 25 Jul 2025 06:27:43 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 480npu0fh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 06:27:43 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56P6Rg9r33292962
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 06:27:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED78920043;
	Fri, 25 Jul 2025 06:27:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFCC920040;
	Fri, 25 Jul 2025 06:27:39 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.18.98])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 25 Jul 2025 06:27:39 +0000 (GMT)
Date: Fri, 25 Jul 2025 11:57:37 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 05/13] generic/1226: Add atomic write test using fio
 crc check verifier
Message-ID: <aIMjrunlU04jI2lF@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1752329098.git.ojaswin@linux.ibm.com>
 <1e6dad5f4bdc8107e670cc0bd3ce0fccd0c9037a.1752329098.git.ojaswin@linux.ibm.com>
 <5211dff7-579b-48ea-8180-72d8c6083400@oracle.com>
 <aHkAJJkvaWYJu7gC@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <b270bb66-721e-4433-adaf-fe5ae100ca6e@oracle.com>
 <aH9PwFm06n9KQ0mE@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <7fc0f04e-dcec-47a4-b522-eb5a8b90637c@oracle.com>
 <aIDozETJ8aLparYV@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <9b9ed959-bda5-4a92-90c7-a621ffe58240@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b9ed959-bda5-4a92-90c7-a621ffe58240@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sYc_7PBpxTvlyPqHDuagicv_eKpY5kS2
X-Proofpoint-ORIG-GUID: vMzHBz-bSwqd2v5TMvw1ADXB7G6xhMlm
X-Authority-Analysis: v=2.4 cv=JM47s9Kb c=1 sm=1 tr=0 ts=688323e1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=z_VCc1e3h6uH1eZaKfUA:9
 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA1MCBTYWx0ZWRfX9JeDm/uSvI9i
 64NWeb4GGZlGjhk0tjegxTOAYQfET7cOa6hNY+YJO3kxnJu1DIBh3vBFVvIFRRHeE3aW3Y5skXk
 Snu7cf0foEBenbTROZ522RhAahMUIgA13C99SivCCWa4KAHOncYBl6IAekoZT1t7tMKvbGmrJN6
 WheFc5abStptoVQl+Z3YR+sATLyOED9qahQaT0NofGmudumyKab+5e0Lejw+PsyOp0Yc0gyaKQ4
 7+N6plRiLYyaTuDEkQ0Qtx+6elFUhqabdEOc+i2PA8x01Lvt4JtXCig2kYFSWtkLZloAiHTu1kv
 7jwfSZr0bxmG8Q0S34q9Vy9JOgZwOmg5Zj3K8YR0aUhpDsRi5bIKkcG7wKAwbhZb4hatnpYbL5/
 1mar8bdD9fHF4lnAi5G/I+YUvMilp2quDcvjDPYWkdz2DiWmUitXtgBFofSEQ4CSXc2DRb1V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_01,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 bulkscore=0 mlxlogscore=570 phishscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250050

On Wed, Jul 23, 2025 at 05:25:41PM +0100, John Garry wrote:
> On 23/07/2025 14:51, Ojaswin Mujoo wrote:
> > > > No, its just something i hardcoded for that particular run. This patch
> > > > doesn't enforce hardware only atomic writes
> > > If we are to test this for XFS then we need to ensure that HW atomics are
> > > available.
> > Why is that? Now with the verification step happening after writes,
> > software atomic writes should also pass this test since there are no
> > racing writes to the verify reads.
> 
> Sure, but racing software atomic writes against other software atomic writes
> is not safe.
> 
> Thanks,
> John

What do you mean by not safe? Does it mean the test can fail? 



