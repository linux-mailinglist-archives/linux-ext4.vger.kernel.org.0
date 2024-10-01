Return-Path: <linux-ext4+bounces-4409-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5353B98B881
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Oct 2024 11:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 772631C222FF
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Oct 2024 09:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D742A19F102;
	Tue,  1 Oct 2024 09:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jumKnGvw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B9D19F10F;
	Tue,  1 Oct 2024 09:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727775718; cv=none; b=IcLNAb+/KBK5XTFhxbxGdUxEDNyv5OXvIJs+BGw2klrI6ZF1Ngqk1AIMNezk7bBadOhqtGH72HDfpeZYtHS9GUMtKTgDKzOLDCIRhmmdrJhJyiwJDXfmZ5PS9woMjNobouHsYJ+aoPHHEQ6YsVglFeYezQ4VyDM2LgDzy9i9Ruc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727775718; c=relaxed/simple;
	bh=Jwa85bykU8Adj1fMpebucotKMkFAWbCkIQjWDP9vKSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=keEiz6sZJLVUgEKNR7tgH6duJQC/uTensa76TlxcCQfG+yLzE971QGka/gw7/cUZlZmc66WjgK1LPmrRUsk6mJw6Y6dPYGTd/Xgu55v3PXXXFsBbyRan3+gS0eDrEapOFoKo69pRZDCaM3VETYlAcWoO32rTMMCTeTsjwz1R2Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jumKnGvw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4918qQAn012623;
	Tue, 1 Oct 2024 09:41:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=pp1; bh=nrHiM7LPMtDVpcAG0A4i3XlCAXs
	kkUGxA4RnTxJ+0n4=; b=jumKnGvwIi3zYaaIyy5jiUilzMEFG1xl84XA2HXaESJ
	44WhCIDHHram2GoIBWlOeWhDzMPmfx6HAaie+iBPfB5z0hfkbKBc7By3Sj2TSebB
	BSguxEj99AEjy5VAifCI0aDZGXoQM8IPcLUv36BPjRZe3exV/gM/PNf8oaqE7ZQ6
	en4tTs6ezf4Xof9suvEr0s9R+Q6aQJyQQFCn67LYnCGzvwj1y20wuTUfDQiYNhaQ
	aX8YidqIYKCxGSnRMSlTyTznhZBarYSVNg04ZKa9RsRWFHs2nhLHkt81OO46KqYH
	PyVZDE8fwt5YOq6D5OligWHo+yeQ3vgVzy4naGa6iTQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420bqs0xnt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 09:41:51 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4919foa6021279;
	Tue, 1 Oct 2024 09:41:50 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420bqs0xnm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 09:41:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4918b33Y020419;
	Tue, 1 Oct 2024 09:41:50 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41xv4s3puf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 09:41:49 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4919fmHc32637328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Oct 2024 09:41:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4718420049;
	Tue,  1 Oct 2024 09:41:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75CBD20040;
	Tue,  1 Oct 2024 09:41:46 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.82])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  1 Oct 2024 09:41:46 +0000 (GMT)
Date: Tue, 1 Oct 2024 15:11:44 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Qianqiang Liu <qianqiang.liu@163.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca,
        syzbot <syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] ext4: fix out-of-bounds issue in ext4_xattr_set_entry
Message-ID: <ZvvD2FeVm3ViPWIl@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <Zu+vI3EipxSsPOMe@thinkpad.lan>
 <66efba95.050a0220.3195df.008c.GAE@google.com>
 <Zu+8aQBJgMn7xVws@thinkpad.lan>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zu+8aQBJgMn7xVws@thinkpad.lan>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: M9fZ7-7Wu09kxbiGzed4v07th9EvqK1W
X-Proofpoint-ORIG-GUID: cWktyJEIShBRbuTOO-Pr0Ciylv481vp0
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_07,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 clxscore=1011 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 spamscore=0 adultscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410010062

On Sun, Sep 22, 2024 at 02:42:49PM +0800, Qianqiang Liu wrote:
> syzbot has found an out-of-bounds issue in ext4_xattr_set_entry:
> 
> ==================================================================
> BUG: KASAN: out-of-bounds in ext4_xattr_set_entry+0x8ce/0x1f60 fs/ext4/xattr.c:1781
> Read of size 18446744073709551572 at addr ffff888036426850 by task syz-executor264/5095
> 
> CPU: 0 UID: 0 PID: 5095 Comm: syz-executor264 Not tainted 6.11.0-syzkaller-03917-ga940d9a43e62 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:93 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0x169/0x550 mm/kasan/report.c:488
>  kasan_report+0x143/0x180 mm/kasan/report.c:601
>  kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
>  __asan_memmove+0x29/0x70 mm/kasan/shadow.c:94
>  ext4_xattr_set_entry+0x8ce/0x1f60 fs/ext4/xattr.c:1781
> [...]
> ==================================================================
> 
> This issue is caused by a negative size in memmove.
> We need to check for this.
> 
> Fixes: dec214d00e0d ("ext4: xattr inode deduplication")
> Reported-by: syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=f792df426ff0f5ceb8d1
> Tested-by: syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com
> Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
> ---
>  fs/ext4/xattr.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 46ce2f21fef9..336badb46246 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -1776,7 +1776,14 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
>  	} else if (s->not_found) {
>  		/* Insert new name. */
>  		size_t size = EXT4_XATTR_LEN(name_len);
> -		size_t rest = (void *)last - (void *)here + sizeof(__u32);
> +		size_t rest;
> +
> +		if (last < here) {
> +			ret = -ENOSPC;
> +			goto out;
> +		} else {
> +			rest = (void *)last - (void *)here + sizeof(__u32);
> +		}

Hey Qianqiang,

Thanks for the patch. I'm still reviewing this codepath but I do have
some questions around the patch. So I understand that xattrs are
arranged in the following format:

 *   +------------------+
 *   | header           |
 *   | entry 1          | 
 *   | entry 2          | 
 *   | entry 3          | 
 *   | four null bytes  | <--- last
 *   | . . .            | 
 *   | . . .            | <--- here
 *   | . . .            | 
 *   | value 1          | 
 *   | value 3          | 
 *   | value 2          | 
 *   +------------------+

Now, in this error, my understanding is that we are actually ending up
in a case where "here" ie the place where the new xattr entry will go is
beyond the "last" ie the last slot for xattr entry and that is causing
an underflow, something like the above diagram.

My only concern is that why were we not able to detect this in the logic
near the start of the function where we explcity check if we have enough
space? 

Perhaps we should be fixing the logic in that if {..} instead
since the comment a few lines above your fix:

	/* No failures allowed past this point. */

does suggest that we can't error out below that point, so ideally all
the checks would have been done before that.

I'm still going through the issue, will update here if needed.

Regards,
ojaswin

>  
>  		memmove((void *)here + size, here, rest);
>  		memset(here, 0, size);
> -- 
> 2.34.1
> 
> -- 
> Best,
> Qianqiang Liu
> 

