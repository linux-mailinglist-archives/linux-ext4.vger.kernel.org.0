Return-Path: <linux-ext4+bounces-9250-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D99E2B17D06
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Aug 2025 08:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 435311AA7B81
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Aug 2025 06:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36EC1F9F70;
	Fri,  1 Aug 2025 06:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KoeZyA6D"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53412F5E;
	Fri,  1 Aug 2025 06:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754030531; cv=none; b=uogafly67eAXUK8G/0L/Z/ru6CC6BuYeC/EntYItNCq4zYPu5SXDKyEfUKk9IH4M8xJ3oSYGGYfkw+0+i0qIha44kDmX/m5LpNMeyYuSVECylOULqHRTNU3RdJ9qDIHjjxqgF/cpMDJcAjId7rxp09iJ2I76mYQtNXcCH+SGBOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754030531; c=relaxed/simple;
	bh=frrlrKtqdwD5OQoBkPzwdul3Cy1W8v3RYnJbGWdBHJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YN7OkngAJXz+R7KqhtaedeXUi5yKi+Zv54+grpqmvQl+4N8v8OuIcSyF4agwNn/3gGHlMp10Q1H6xIg5l2v2RcgRaE7XmkAYzVfUTIoMnatPPBPQFbW6zkDCP3LjinDu7JVYKigdz5MLml8bPI4LZSHZRgLQi5ZX9OAqT8SQMeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KoeZyA6D; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VIwYho009144;
	Fri, 1 Aug 2025 06:42:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=dhfrWN/gBdiOvCn5FdF68LIDQQBqvh
	yNFjdQuQTY0wo=; b=KoeZyA6DzEzkV4CjtPQ7Mosihjz/raPK9eeD8QQiDLFIwf
	BfR1PAVazaT+Fk2dZmILmtqSFERYUdpJdnDuNspydsckm+6C//Lyz4kvaH84rvgH
	wAnXSAgn9gxDj/43/xIhxbwkK3cvT9B4QPOMM1mr2BI7Eov/z/aR3O0Xdd6BU4uP
	yu3HJ5CwRNXjV7gKQaP6837pNFdYUQ5+7pYhK3RxcbPzybLIyo0k0cTt7bhjP9Pa
	VNqMgRl8SpYErao+7zeWcsxRUxEyjy0YNIEeQVo05jKZvflnLmiyOoHr+rdPQnrE
	InDwpXuV1tnd4ZhNJohwTn7l6fxYaObGXUjW/kMA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qcgf3r2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Aug 2025 06:42:01 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5716elpu029991;
	Fri, 1 Aug 2025 06:42:00 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qcgf3qw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Aug 2025 06:42:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5715WKmd006242;
	Fri, 1 Aug 2025 06:41:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 485bjmg19u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Aug 2025 06:41:59 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5716fwtE28443210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Aug 2025 06:41:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F0FC20043;
	Fri,  1 Aug 2025 06:41:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCF3620040;
	Fri,  1 Aug 2025 06:41:55 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.215.60])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  1 Aug 2025 06:41:55 +0000 (GMT)
Date: Fri, 1 Aug 2025 12:11:53 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Zorro Lang <zlang@redhat.com>,
        fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 05/13] generic/1226: Add atomic write test using fio
 crc check verifier
Message-ID: <aIxhsV8heTrSH537@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <aIMjrunlU04jI2lF@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <0af205d9-6093-4931-abe9-f236acae8d44@oracle.com>
 <aIccCgrCuQ4Wf1OH@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <2ae4bb04-fbf7-4a53-b498-ea6361cdab3e@oracle.com>
 <aId8oZGXSg5DW48X@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <3a4854ac-75ad-4783-acbd-048fe7c7fdb0@oracle.com>
 <aIhmG-l4nWOAzz2I@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20250729144526.GB2672049@frogsfrogsfrogs>
 <aIrun9794W0eZA8d@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <22ccfefc-1be8-4942-ac27-c01706ef843e@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22ccfefc-1be8-4942-ac27-c01706ef843e@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA0MiBTYWx0ZWRfX004Y7eZqSmDu
 omH0TWNk9s6giJ867lucDEer6OvyDjixqwPDVzNZGiP+2HBFtD7IgIdxiR7qZnhEphOZsHFs+8T
 ARBWHbqNnuqUbUithCJhYyd1gWDprxu7ZMMfPsq9wJrcncYaUZMpSTFvABb2ySfHkcP0waHcMfb
 K+s8+OnsjDLnZEHIcWSfNGUh0AxpqhpSl+qKD1/0QeBUaZyi0Pxug6xq1RWzz/1n6to59tWlYG5
 wUA1tvGsZ7NaSOPiqHOxj1LbeqQ9/D0PUfPW6bH8DauKwDXcdBk9y6//YBAMHU/mchkJkK9QlvP
 m3ieubPtaVxnNW9uQWCGQX3+YD20+xc3P8B+8uGfyB4wlm7gakSlpPoP6mLqbiDtGE7pKOtDJqv
 ec+hsx3W6n9Pb67rTCVqkXijRpo1wlcttJWPx3NlurI7gd0YkDns9TPWZ/UqiIZ+am0kySlO
X-Proofpoint-ORIG-GUID: BdbK9ue7CtH-EAjoBqXY5yfYc2PQYINo
X-Authority-Analysis: v=2.4 cv=Lp2Symdc c=1 sm=1 tr=0 ts=688c61b9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=f1YMtUmYJW-UuOPZwI4A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: O86dMPyIQ6HF_u7apXJJt0Ti_JGtIbjZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_01,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010042

On Thu, Jul 31, 2025 at 08:58:59AM +0100, John Garry wrote:
> On 31/07/2025 05:18, Ojaswin Mujoo wrote:
> > > Heh, here comes that feature naming confusing again.  This is my
> > > definition:
> > > 
> > > RWF_ATOMIC means the system won't introduce new tearing when persisting
> > > file writes.  The application is allowed to introduce tearing by writing
> > > to overlapping ranges at the same time.  The system does not isolate
> > > overlapping reads from writes.
> > > 
> > > --D
> > Hey Darrick, John,
> > 
> > So seems like my expectations of RWF_ATOMIC were a bit misplaced. I
> > understand now that we don't really guarantee much when there are
> > overlapping parallel writes going on. Even 2 overlapping RWF_ATOMIC
> > writes can get torn. Seems like there are some edge cases where this
> > might happen with hardware atomic writes as well.
> > 
> > In that sense, if this fio test is doing overlapped atomic io and
> > expecting them to be untorn, I don't think that's the correct way to
> > test it since that is beyond what RWF_ATOMIC guarantees.
> 
> I think that this test has value, but can only be used for ext4 or any FS
> which only relies on HW atomics only.
> 
> The value is that we prove that we don't get any bios being split in the
> storage stack, which is essential for HW atomics support.
> 
> Both NVMe and SCSI guarantee serialization of atomic writes.

Hi John,

Got it, I think I can make this test work for ext4 only but then it might 
be more appropriate to run the fio tests directly on atomic blkdev and
skip the FS, since we anyways want to focus on the storage stack.

> 
> > 
> > I'll try to check if we can modify the tests to write on non-overlapping
> > ranges in a file.
> 
> JFYI, for testing SW-based atomic writes on XFS, I do something like this. I
> have multiple threads each writing to separate regions of a file or writing
> to separate files. I use this for power-fail testing with my RPI. Indeed, I
> have also being using this sort of test in qemu for shutting down the VM
> when fio is running - I would like to automate this, but I am not sure how
> yet.
> 
> Please let me know if you want further info on the fio script.

Got it, thanks for the insights. I was thinking of something similar now
where I can modify the fio files of this test to write on non
overlapping ranges in the same file. The only doubt i have right now is
that when I have eg, numjobs=10 filesize=1G, how do i ensure each job
writes to its own separate range and not overlap with each other.

I saw the offset_increment= fio options which might help, yet to try it
out though. If you know any better way please do share.

Thanks,
Ojaswin
> 
> Thanks,
> John
> 

