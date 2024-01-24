Return-Path: <linux-ext4+bounces-878-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8B183A1A0
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jan 2024 06:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89BA3283DE7
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jan 2024 05:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B75BF514;
	Wed, 24 Jan 2024 05:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Rq0W828s"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D42816428;
	Wed, 24 Jan 2024 05:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706075792; cv=none; b=PyVWvwEc5eQKfzjZOJus4lH66dXjq722uO1XXB8coQ6MqussoKFVMD3x2gDjyVJMK34IsEbOtDNHT+l6vfjwG2uFjlt5es4HHBjgqRDnrMLfmxf2jmmrmZeqaTar+xWO88h82fUsORU63j8TtHfCFwQoeAABy6p2P7Q55mb/JcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706075792; c=relaxed/simple;
	bh=U7AxjWtl76YYVN9AAQAMePamqK7lCwTpHiJ55ysuw5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CgerRX6AJLeQ0NW7henO4Ql3TdCpLD6Kb2k6Bd1l7hMbgKSQWZ6guDhQSzzGaebk0asKqyzQ7kyVEqZa6BNduQzV0MvL/XUVqjJeznuAFzo0NZ+BEtyb2LSegMpyvLxrJdtgaRgEJTctp6gcZggO4ndSGyT7sxcIjqdowwj/FXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Rq0W828s; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40O5fNUB006082;
	Wed, 24 Jan 2024 05:56:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=tmGJ2Whbetk9jP/5DWFCYsWaq8KXKVaywMbIOCxezE0=;
 b=Rq0W828sSVJPRtwhxNgKxvyXVXU3iG4YkjTr5GABDCSgBWXHkrdsqEPUPsiIfkDsZMTE
 O8zje0SDdaCf/XBTtOA56bT2Xg5+yl19GzPhJx2OkEW79YSyBZEAClAD856ZGxW7edR6
 NJHrk5PJ8WQ2rWfoBpv7EL8J42l7uMt7K/Iz6LPsNpDyvQXlg7plcWScXkGYd49fViO2
 MYoNrGXgKrdTFQbaH3umC8+UJyqeXXiCaGohW82O6RgRXoE81h9ov6+1TcMuRICq2PQV
 b1/t4gU+536XSqueSm+HtYgWSxQnRMcz5H6G7C2RTRMvH9IPDisvL95dMfOdt/emBP/7 rw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vttepb2mc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 05:56:22 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40O4qv2K023794;
	Wed, 24 Jan 2024 05:56:22 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vttepb2m6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 05:56:22 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40O4QBBa022429;
	Wed, 24 Jan 2024 05:56:21 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vrt0m3ugy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 05:56:21 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40O5uJ8t23921156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 05:56:19 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3ADAA20043;
	Wed, 24 Jan 2024 05:56:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4805420040;
	Wed, 24 Jan 2024 05:56:17 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.82])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 24 Jan 2024 05:56:17 +0000 (GMT)
Date: Wed, 24 Jan 2024 11:26:14 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Pavel Machek <pavel@denx.de>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.1 08/14] ext4: enable dioread_nolock as default
 for bs < ps case
Message-ID: <ZbCmfu90bKwA2Xvq@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20240116010642.218876-1-sashal@kernel.org>
 <20240116010642.218876-8-sashal@kernel.org>
 <ZabrcCOi/hIsKk5I@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZabrcCOi/hIsKk5I@duo.ucw.cz>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -c33VtLZ1QNIZt1TzvKhfdFqaML-_uX6
X-Proofpoint-GUID: zSxOjyDFyk1hjVt9Vp2rG_mXURwFjid8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_02,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1 impostorscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 spamscore=1 clxscore=1031
 phishscore=0 suspectscore=0 mlxscore=1 mlxlogscore=190 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401240041

On Tue, Jan 16, 2024 at 09:47:44PM +0100, Pavel Machek wrote:
> Hi!
> > 
> > [ Upstream commit e89fdcc425b6feea4dfb33877e9256757905d763 ]
> > 
> > dioread_nolock was originally disabled as a default option for bs < ps
> > scenarios due to a data corruption issue. Since then, we've had some
> > fixes in this area which address such issues. Enable dioread_nolock by
> > default and remove the experimental warning message for bs < ps path.
> > 
> > dioread for bs < ps has been tested on a 64k pagesize machine using:
> > 
> > kvm-xfstest -C 3 -g auto
> > 
> > with the following configs:
> > 
> > 64k adv bigalloc_4k bigalloc_64k data_journal encrypt
> > dioread_nolock dioread_nolock_4k ext3 ext3conv nojournal
> > 
> > And no new regressions were seen compared to baseline kernel.
> 
> But no fixes, either, so not suitable for stable.
> 
> BR,
> 								Pavel

Hi Pavel, Sasha,

I agree, this can be dropped from stable since it is not a bug fix.

- ojaswin
> 
> -- 
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany



