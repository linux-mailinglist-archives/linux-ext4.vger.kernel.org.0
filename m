Return-Path: <linux-ext4+bounces-6902-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF9BA66DA5
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Mar 2025 09:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AA233AEFE7
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Mar 2025 08:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F4A1EF39E;
	Tue, 18 Mar 2025 08:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="q9USMN5a"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969351EF365;
	Tue, 18 Mar 2025 08:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742285568; cv=none; b=s/CeRWeud4wRK1IIDBV4yJ5KxTaYE+SvuTVWbyF5/O7Wud+vkNQ+gmx4pOwUqimkvL7GH/JO43N61bO4QYE+Y5wLXiLwKgTAHReQtHtRdfu5p05vNcdNo7Rh9qnMstMc8PeZdrKInEKCfNgfyfQCEFeVQZeTTZOKzdmNadFvq5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742285568; c=relaxed/simple;
	bh=wWJ8vp6dh4v8o3Vmyd+pP1mRq1oqhRn/l5YX8NopH28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMD2iKP1AXjDWloN8oz3N6zEJZ3XypBjE1+lBa1Pg31+lVRKU3CiN+u8Tim4ZJZ1xLGLpwVNN7Ikxd0OPo2jZ9GteEbDHO6GxVI0u1eHXBQPrO0/n+je0yt71vYyG0MLxq10W5Z47Ba78G+HIPAfS/XqKHAJXcmTWkHxnN3noFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=q9USMN5a; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52I1crmD002091;
	Tue, 18 Mar 2025 08:12:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=I+vqwvpMLJX+lL0I0ufLjd2yN4MoZp
	otbQowaZ1GZxg=; b=q9USMN5a6pnI8eA4X+tsllFae/45d45fdd1i8CM0uuXfmU
	KsmYuYbZl5zklWgj5hDANP189EEhijNlGYhx8Oci7tZbv1z3vBUowJN6VKwcjyjb
	BPKt9PmQKEB2klm4Q7bn9H4RQGLNd/oipzIl68VpnwYQP0YA8aSGWT3BIH6cqTjm
	JBm+c2rplf0jH3xYAtBaatesDRH3te1Rzgm/xas4hj2aCcXCFQNiMRgRf4Me2fNP
	haZh4CBbm1o5YoOwF/zg2woVVjgkAwgfSv3NrPCF0QWxYo7Dq4rF3lN4wRgaUAqe
	Kv3/4Q/axRE8GTUeBychSk9mKQrOjsFnteyoYuVw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45en5pvbgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 08:12:39 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52I837Cu029129;
	Tue, 18 Mar 2025 08:12:38 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45en5pvbgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 08:12:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52I7XFQx024425;
	Tue, 18 Mar 2025 08:12:37 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dncm2nga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 08:12:37 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52I8CZNf35128016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 08:12:35 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F8D920043;
	Tue, 18 Mar 2025 08:12:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1187920040;
	Tue, 18 Mar 2025 08:12:34 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.27.85])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 18 Mar 2025 08:12:33 +0000 (GMT)
Date: Tue, 18 Mar 2025 13:42:31 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Baokun Li <libaokun1@huawei.com>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: cache es->s_journal_inum in ext4_sb_info
Message-ID: <Z9kq744Q1zbbxOKH@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <d1a9328a41029f6210a1924b192a59afcd3c5cee.1741952406.git.ojaswin@linux.ibm.com>
 <20250316014128.GA787758@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250316014128.GA787758@mit.edu>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: h-sSHMe0I51aVDXxWQpakY34hC3gBHIA
X-Proofpoint-ORIG-GUID: KWIkdrdSh6ifQtNEyz6IYu3w8HVoUx5m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_03,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=757 clxscore=1015 lowpriorityscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503180056

On Sat, Mar 15, 2025 at 09:41:28PM -0400, Theodore Ts'o wrote:
> On Fri, Mar 14, 2025 at 05:11:43PM +0530, Ojaswin Mujoo wrote:
> > Currently, we access journal ino through sbi->s_es->s_journal_inum,
> > which directly reads from the ext4 sb buffer head. If someone modifies
> > this underneath us then the s_journal_inum field might get corrupted.
> > 
> > Although direct block device modifications can be expected to cause
> > issues in the FS, let's cache s_journal_inum in sbi->s_journal_ino so
> > our checks can be more resillient.
> 
> The reason why the block validity checks need to check against
> s_journal_ino is to exempt the lookups done by ext4_journal_bmap()
> from running afoul of the system zone checks, since the journal's data
> blocks are considered part of the system zone.
> 
> So this is something we need to do if the journal is actived, and if
> it's active, then sbi->s_journal will be non-NULL, and so we can just
> check to see if inode == sbi->s_journal instead.  This will simplify

I believe you mean inode == sbi->s_journal->j_inode here right?

since that is enough to confirm if we are called via ext4_journal_bmap
so we can avoid validity checks.

Regards,
ojaswin

> the code, without needing to expand the ext4_sb_info structure.
> 
> Cheers,
> 
> 						- Ted

