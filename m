Return-Path: <linux-ext4+bounces-1055-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0868455FD
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Feb 2024 12:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B72AC1C23882
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Feb 2024 11:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CF915B995;
	Thu,  1 Feb 2024 11:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AM+J8TzO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4FB3A1C3;
	Thu,  1 Feb 2024 11:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706785735; cv=none; b=MNWeGrfZuNTIKKF6UikhK0yM5KnfM0frw+7dgzqm9BvFZjVUNJdTcRbc+mVVTbdyYyRbdXzWfaDjKf6qtEtAGtrvTVJP2hBu0ClCRHEwQ7kDWiMg1NofT7PGdMqe+jukGW3c8iqaiZ33ddeSBJzATS55u9I4X73iaS4ELKn3NTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706785735; c=relaxed/simple;
	bh=6bpSokjHon0c17IYlPlXNa4vGCmRvq0YvKBR2clqsoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U8ufSA9CSOM7ljA/8YsCibTMeqb/m6m4PmpFMI331CS4TXEtfhKq1Kf1dE0z3boi/WGus/t16a7rIQPu70JjFoLgu0ohhnn7PcNQ6zv1JawpI+ElNqH5tylr+dsem7kmQ07kBk2haDGtJJ0dxQ7nUAJTs2QKJQM9r0Tb7R1pNFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AM+J8TzO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 411B2JW8011863;
	Thu, 1 Feb 2024 11:08:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=XqPVJ7jlVkPhIr1he1/ixfWoyCjmJKYn9ah2UgfTpeA=;
 b=AM+J8TzOYzY1e10ffbkDCfOAGOXAwUknOUBblxTtGDUT9UNirIvi4jKMwVY4rCfrMCdC
 b4sbdD3HX0QBU1X1CbUx4MX/ZA5XtOv8hxHd59EnLa98ei18cvCk8vV2/CCmx677HiQ9
 2qG5jAvIA3n9JupOIkSVQhvtD91do5cvr9A7oj4hVo7orMg//j+g9nri0Endg529ZB68
 Ck/lavquz9MF0dDs6es/A+kk+657MlEdu03vvN1xHi6ZpeZ3rC27kEC+7uQo6HzSK0yX
 5Wp1Vid4EcUF6fw2JkXw8j7Syu7b03zV9t5L7Rm79Se2UHWrt4pAov3qymSmsiH56Gr9 8w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w0a2r848j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 11:08:41 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 411B3a6C014658;
	Thu, 1 Feb 2024 11:08:41 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w0a2r8488-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 11:08:41 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4118U9Pm007196;
	Thu, 1 Feb 2024 11:08:40 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vwev2k96s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 11:08:39 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 411B8ckn6685294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Feb 2024 11:08:38 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26DDE20043;
	Thu,  1 Feb 2024 11:08:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0859220040;
	Thu,  1 Feb 2024 11:08:36 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.82])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  1 Feb 2024 11:08:35 +0000 (GMT)
Date: Thu, 1 Feb 2024 16:38:33 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Baokun Li <libaokun1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, yukuai3@huawei.com, stable@kernel.org
Subject: Re: [PATCH] ext4: correct best extent lstart adjustment logic
Message-ID: <Zbt7setS4c/Q4fyv@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20240122123332.555370-1-libaokun1@huawei.com>
 <20240131124636.gmxaiex6yqrhvxcj@quack3>
 <3630fa7f-b432-7afd-5f79-781bc3b2c5ea@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3630fa7f-b432-7afd-5f79-781bc3b2c5ea@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: t0l8mDG-kyFUd1bHDF_sa6q-Ab2sEpc_
X-Proofpoint-ORIG-GUID: _qNtGuRtMSpxbzZrfIeiGohSONdM0oVw
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1011
 adultscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402010089

Hi Baokun, Jan

Thanks for the CC, I somehow missed this patch.

As described in the discussion Jan linked [1] , there is a known bug in the
normalize code (which i should probably get back to now ) where we sometimes
end up with a goal range which doesn't completely cover the original extent and
this was causing issues when we tried to cover the complete original request in
the PA window adjustment logic. That and to minimize fragmentation, we ended up
going with the logic we have right now.

In short, I agree that in the example Baokun pointed out, it is not optimal to
have to make an allocation request twice when we can get it in one go.

I also think Baokun is correct that if keeping the best extent at the end doesn't 
cover the original start, then any other case should not lead to it overflowing out
of goal extent, including the case where original extent is overflowing goal extent.

So, as mentioned, it boils down to a trade off between multiple allocations and slightly 
increased fragmentation. iiuc preallocations are anyways dropped when the file closes
so I think it shouldn't hurt too much fragmentation wise to prioritize less
allocations. What are your thoughts on this Jan, Baokun?

Coming to the code, the only thing I think might cause an issue is the following line:

-		BUG_ON(ac->ac_o_ex.fe_len > ac->ac_b_ex.fe_len);
+		BUG_ON(o_ex_end > extent_logical_end(sbi, &ex));

So as discussed towards the end here [1] we could have ac_o_ex that
overflows the goal and hence would be beyond the best length. I'll try
to look into the normalize logic to fix this however till then, I think
we should not have this BUG_ON since it would crash the kernel if this
happens.

Rest of it looks good to me.

Regards,
Ojaswin

[1]
https://lore.kernel.org/all/Y+UzQJRIJEiAr4Z4@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com/

