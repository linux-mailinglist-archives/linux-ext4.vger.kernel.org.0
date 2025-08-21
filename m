Return-Path: <linux-ext4+bounces-9489-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 857DFB2F253
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 10:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B8EC685068
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 08:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B022ECD12;
	Thu, 21 Aug 2025 08:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hXQGHLCQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809F42EAB7B;
	Thu, 21 Aug 2025 08:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764989; cv=none; b=MLXKFfXSf3i8dmEGYaGXna+yGPaLDYzjZLz/2uMNL5zJZMJo/fyZ+JNC58MwB/MfEZTKLyxltgXPi5VUTHmufoz31jYxpDM97lVndn4Ui/BoJ77YRs2CV1JHj26Ao7ANQfFP6xC8D73YuZdu9kTuRYjGlMCcxAd26e25Cw2UPiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764989; c=relaxed/simple;
	bh=qcdf5GBc2M8fklPHYRBcaSI02+6P2y+IyvWTSLxZOK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQ2OQIwVJgjFkAfSFPa+tVjPSxkNvAGam1Ibu+YN0uF/RIUOzsNbQTfsHImLksWQJq/VC5qcITiyWmbBlwPCLpbIyhMzSfDd4V66c7tEw299youLmBIiT1xWhdPaRv6wRLXRJfxXD0s8UDfzwxVCb6O6Ss2UrpEeqEN5Pn7iIDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hXQGHLCQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KNr6t6016990;
	Thu, 21 Aug 2025 08:29:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=TsorYhLdzju9UVcvemTKx1o6vyFbRo
	v8wOKmBiIhtWw=; b=hXQGHLCQAuk2EOaFJgM7f0n/gJ1NVUAjBJnNRBYg4TGu+8
	LKIuzkj5ei2EvWYPB4O1mmHWcVQkk/ISgnT0ujd/VQxx0pOXMgl8BTP7NS+m5W7i
	MEPDVbS9QN5cPZaxSGYest74fMt8MIwEXTcmELvW6YE5TtfpkpLqpBr71yMX0FYR
	aR4DVee0CShk4pe5afx0E82EHsULHc7mjfpAZvb5HKf1sDX8RD+NYSnSeUB1PEDP
	tBY+bECpX9hcDwAhyioOSrcIpRQTtCuaCswowZznBeJgnwdewP8SB0rk42cTyjB/
	3cvKXEudAJX3Pm87bSRSDzvcXsDVjKLpqS9AR26Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vqhsj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 08:29:41 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57L8MACr024640;
	Thu, 21 Aug 2025 08:29:40 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vqhsd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 08:29:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57L6iSUi024215;
	Thu, 21 Aug 2025 08:29:39 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48my43qd4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 08:29:39 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57L8TbRw31588938
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 08:29:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8F162004B;
	Thu, 21 Aug 2025 08:29:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A8ED20040;
	Thu, 21 Aug 2025 08:29:35 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 21 Aug 2025 08:29:35 +0000 (GMT)
Date: Thu, 21 Aug 2025 13:59:33 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v4 09/11] ext4: Atomic writes stress test for bigalloc
 using fio crc verifier
Message-ID: <aKbY7YeRuRSpptZD@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1754833177.git.ojaswin@linux.ibm.com>
 <210979d189d43165fa792101cf2f4eb8ef02bc98.1754833177.git.ojaswin@linux.ibm.com>
 <62ae0bd7-51f2-454d-a005-9a3673059d1b@oracle.com>
 <aJw51DcgwQc3yfSj@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <c916cf31-26cb-4ca6-a7f5-15ec471ad0c8@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c916cf31-26cb-4ca6-a7f5-15ec471ad0c8@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: A70glOuWYvcYo3wtt_QEwRPPkiPe3G7s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfX5vM71Tb1y82s
 +PTmGeiu//6uMq/9Z6ml38NEKxYVF9Pevglz1STAfiU144GdV4oeHVZvAkrQLeVl2s7hBeWA7+u
 yZwnybRvT5XGuXjTXAjt7IbCcB0lZRyDSlxm3e8O0+SVCSwK8NdkKjL+evuyaNkBfzlGZqxoyMI
 E4zgckSL3ScMAAz8TCPQ93T3E45x3ocIq3StIlEuMFd12X4Atkktoho1heyH4Du+pxQBwef8f+x
 W+aq5MK/xmGohzbVIcsvL1G6dRzmQxpl+Yb+K2BKeTMh8OKzQ/fAi9lsrykiiXk0ewwrQddp4ZU
 WkO5Sf+OFf0ZsQfEvqnL2Ee2MYaWCa35EhIdRE3X3/syRYsR3vWmPFgGUWViVxQL0QRbqwlZCKV
 s2EPCeDk4NViNj7ZIq75EiV7eyXLiQ==
X-Proofpoint-GUID: M3h6eb1dgImkrgPBePpv_SzQLb4PdRpH
X-Authority-Analysis: v=2.4 cv=KPwDzFFo c=1 sm=1 tr=0 ts=68a6d8f5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=RqJW-BOTMGmswbpylRgA:9
 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_01,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508190222

On Wed, Aug 13, 2025 at 08:33:44AM +0100, John Garry wrote:
> On 13/08/2025 08:08, Ojaswin Mujoo wrote:
> > > > +_begin_fstest auto rw stress atomicwrites
> > > > +
> > > > +_require_scratch_write_atomic
> > > > +_require_aiodio
> > > do you require fio with a certain version somewhere?
> > Oh right you mentioned that atomic=1 was broken on some older fios.
> 
> It was not broken - it just did nothing. I suppose that they are the same
> thing.
> 
> > Would you happen to know which version fixed it?
> 
> fio 3.38

Thanks, I'll add the version check.
> 
> thanks,
> John

