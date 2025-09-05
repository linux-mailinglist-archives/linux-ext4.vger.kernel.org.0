Return-Path: <linux-ext4+bounces-9832-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6078B45E67
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Sep 2025 18:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 592041889241
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Sep 2025 16:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484F3306B35;
	Fri,  5 Sep 2025 16:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Xl6VJibm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D37306B17;
	Fri,  5 Sep 2025 16:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757090473; cv=none; b=efbvTEkR902UYdue+1nM9Zyxj0hTRYeBfwBW+ukbWso2sPGUUpEKoBGGLwSJxeMObG0ZW/j5bwdxQFsdk//JJm94C4o/2LLiCLmTj8h+XHRrE7yIbHxQDheK2G/iEBVy8dd5ZXiRkldUcveuGuhqyGNJctRxHdaWgYwfT9dC30s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757090473; c=relaxed/simple;
	bh=X/aTMQpb0rtMBlnX7xLQ6E8WBKn6voC2RinIyqduA+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVk5ClFJniWZUNcWP9m/pwyXW3xkvng6LmeDKhowgYBPWA++qlZeUyk+bFud5zJ1puKyPORR+9Z0lxPVpvEptWoJKWWD2TDmP0hFMff/ftF2dc46SCdrIxBCKWhv5DXzx3gjW00sGZzIyOmtZKA8jAdb+lCNF4m1+ggBeTCZl04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Xl6VJibm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585EUegr001901;
	Fri, 5 Sep 2025 16:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Ih7wgAlfpbT7aePtm9YAmaT7Pjj8AZ
	cDK4dRr9s87SI=; b=Xl6VJibmVLS7lr6BCHzMfD+ShTomI+S5U415dq1S1/D5t8
	JC1pO/HAr9OG7RO5dqoB0BJCEZsCYFfRXLmJNsadnH+ahJmntS4O03BP8jcZubmR
	c9KZ+vza82831zy75IJwSKgg9OjPJawDy5tS4G9I3889I4CDyxgTrfZLNjyCh2Ty
	XD72Tk8JHnxNyveb1Y2SoPuKMLyFCY0PZyvB4a9kowwwlMZgEayQWW/CAx/WweBm
	PdGkOMjdTfLQXlaXRddPqwmcufcArdd4T3XvWQzxbss/XDRMBxYutsURPRYtTvv2
	Xovx40JifhHvoZpqPIGLo08g4wDBKQmsnA0xM/8Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usuagqq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 16:40:45 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 585GPiux016505;
	Fri, 5 Sep 2025 16:40:45 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usuagqpv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 16:40:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 585E0jBW013942;
	Fri, 5 Sep 2025 16:40:44 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48veb3t2ud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 16:40:44 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 585GegeI52560272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Sep 2025 16:40:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA57B2004B;
	Fri,  5 Sep 2025 16:40:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73B6920040;
	Fri,  5 Sep 2025 16:40:40 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.220.13])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  5 Sep 2025 16:40:40 +0000 (GMT)
Date: Fri, 5 Sep 2025 22:10:37 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v5 08/12] generic: Stress fsx with atomic writes enabled
Message-ID: <aLsShUIoHulWXTDw@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
 <6d0de75776499a6751ccf12d2c3a1f059396b631.1755849134.git.ojaswin@linux.ibm.com>
 <e1777c2f-9f49-4795-82f4-3d435d79b280@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1777c2f-9f49-4795-82f4-3d435d79b280@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9nBGa7YJpPb4zm7oefRChZVv6PiyaSra
X-Authority-Analysis: v=2.4 cv=U6uSDfru c=1 sm=1 tr=0 ts=68bb128d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=yPCof4ZbAAAA:8 a=ddunMJBH8T8AnTP1uSIA:9 a=CjuIK1q_8ugA:10
 a=U1FKsahkfWQA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX6Q9sF0sM0uRu
 gTN6jKXKJXuR7dMiPalohRm/foRabniPYPTie7VRWz7VCMNjFPFqreVzUIxq37yjb5OEtz7wl6g
 VCG+j7bvQlQm4qufvQZhCdPPuECXgLq8I+d8z5N1mFzlqOQO4wePbW+82LYzMP/iSSqTE2JOIV0
 7KSduV/7bzX845KFBEQ66NPCw+m1fK9Bw+eCX6mnizaCaey2C3ZcZCNk9K42zO6Sb4lJpIXu4LH
 KxfmUqN0SpPqc7KfmltkkZAfi6bgAZrJGvx6pmRLsqlBhDayJk3Ria4fWoVQYInrFeoMrozgVqJ
 P4CcZq7857hFiL2jq3TRXhY12B52NkZpKcD+avS6VzDHHIJ2HwesmHM4SUmrIBBSXY8Ndlg3Bzh
 WtlXAFLs
X-Proofpoint-ORIG-GUID: TFj62NfsdZTEE9ejr48meZJ7ceOCYYQy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300034

On Tue, Sep 02, 2025 at 04:18:00PM +0100, John Garry wrote:
> On 22/08/2025 09:02, Ojaswin Mujoo wrote:
> > Stress file with atomic writes to ensure we excercise codepaths
> 
> exercise
> 
> > where we are mixing different FS operations with atomic writes
> > 
> > Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> 
> Reviewed-by: John Garry <john.g.garry@oracle.com>

Thanks John, I'll add the spelling changes.

Thanks,
ojaswin

