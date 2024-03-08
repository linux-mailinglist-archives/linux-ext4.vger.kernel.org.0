Return-Path: <linux-ext4+bounces-1573-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C2D8764CC
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Mar 2024 14:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A88891C21C99
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Mar 2024 13:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877D1225CE;
	Fri,  8 Mar 2024 13:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WfVPzb0F"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306EB1D545
	for <linux-ext4@vger.kernel.org>; Fri,  8 Mar 2024 13:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709903536; cv=none; b=sohMxSgsYgY0QeYW09efgYTu/gTyNaeELnMboVZNiQ59H3WpN5QUa70z5Q+PsVBpS+Ors+YtitzjdNZPWcH1ZvaAREaBOWyIpcrOpJzEgQ7YZVM8Sa60c7PrlYuoV2vPVon3LWb8JC7dHE+BbuVYxoTFEawAzfVArSyiLLQpKAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709903536; c=relaxed/simple;
	bh=M/siBoaxJHa7HVIH2CEV14U2OIqpl83thqP8KbS0Ok4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BqPUHJivonvlFYq29NMqeCSzsSoxMzGMhNMvK7cBQrgtwk+ZnzZAQPTMntglvRK3OY9oro1ot4TIqzd00FKEv2jNQHetoWaZ7XBVI8Y6576bCvNrKfxvRHuGpxsn8J3poT+RmKYEQgS5U0OblLsjHwqnwUEXZUYc43DZmTO3pm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WfVPzb0F; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 428D25RI031876;
	Fri, 8 Mar 2024 13:12:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=lHI/LgskLkA6CgQeCwHRgclJREKlGdK98tSQIEIkVFs=;
 b=WfVPzb0FCr5v2s/QEEtWTiLp44WoivbWhVFK3eo14vHN3HgvxB0wPqlDwrB6D9yAlZEG
 6APs0upG4TKBxe6owvcTXga1kKJLBMN+JAoq0flRqDJ86cPd+YjItntWKvQXtdb2VhZm
 v4rUb5F/pb1j/iqlypsvAfdm6XZa0EBAca3f+Gimu+Pynd3EGS/wixwFBPmWXjly5aZb
 Ddo2zP+Gpmwc5nQBCrgiMWR4hxi9zFsxzIQgCK8p0ux4LoBGymIyS2xUdjsVoZumYSmw
 SE3S2jviEBzLuYjGeboka6QXnv5p9REp8Hmn74mwsNn1zt8i/RHXsAJ2fwPvjBbiWv2K Gw== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr36xr6t8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 13:12:08 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 428AmK7j006051;
	Fri, 8 Mar 2024 13:11:54 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmeetmt1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 13:11:54 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 428DBpla39256462
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Mar 2024 13:11:53 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6EAC20043;
	Fri,  8 Mar 2024 13:11:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02BC420040;
	Fri,  8 Mar 2024 13:11:50 +0000 (GMT)
Received: from [9.43.33.218] (unknown [9.43.33.218])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 Mar 2024 13:11:49 +0000 (GMT)
Message-ID: <76e1e3a2-78f6-40fc-bb9c-4d4f87003eb6@linux.ibm.com>
Date: Fri, 8 Mar 2024 18:41:48 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: Avoid excessive credit estimate in ext4_tmpfile()
Content-Language: en-GB
To: Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
References: <20240307115320.28949-1-jack@suse.cz>
From: Disha Goel <disgoel@linux.ibm.com>
In-Reply-To: <20240307115320.28949-1-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -_u_siEOdArZ7SgwKiwykJDLtxr947S0
X-Proofpoint-GUID: -_u_siEOdArZ7SgwKiwykJDLtxr947S0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1011 priorityscore=1501 malwarescore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403080106

On 07/03/24 5:23 pm, Jan Kara wrote:

> A user with minimum journal size (1024 blocks these days) complained
> about the following error triggered by generic/697 test in
> ext4_tmpfile():
>
> run fstests generic/697 at 2024-02-28 05:34:46
> JBD2: vfstest wants too many credits credits:260 rsv_credits:0 max:256
> EXT4-fs error (device loop0) in __ext4_new_inode:1083: error 28
>
> Indeed the credit estimate in ext4_tmpfile() is huge.
> EXT4_MAXQUOTAS_INIT_BLOCKS() is 219, then 10 credits from ext4_tmpfile()
> itself and then ext4_xattr_credits_for_new_inode() adds more credits
> needed for security attributes and ACLs. Now the
> EXT4_MAXQUOTAS_INIT_BLOCKS() is in fact unnecessary because we've
> already initialized quotas with dquot_init() shortly before and so
> EXT4_MAXQUOTAS_TRANS_BLOCKS() is enough (which boils down to 3 credits).
>
> Fixes: af51a2ac36d1 ("ext4: ->tmpfile() support")
> Signed-off-by: Jan Kara <jack@suse.cz>

Thanks for the fix patch. I have tested the patch on a power machine with smaller
disk and journal size, generic/697 test passed (for both bs<ps and bs=ps) and no
longer seeing the error.

Feel free to add:
Tested-by: Disha Goel<disgoel@linux.ibm.com>

> ---
>   fs/ext4/namei.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 05b647e6bc19..58fee3c6febc 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -2898,7 +2898,7 @@ static int ext4_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
>   	inode = ext4_new_inode_start_handle(idmap, dir, mode,
>   					    NULL, 0, NULL,
>   					    EXT4_HT_DIR,
> -			EXT4_MAXQUOTAS_INIT_BLOCKS(dir->i_sb) +
> +			EXT4_MAXQUOTAS_TRANS_BLOCKS(dir->i_sb) +
>   			  4 + EXT4_XATTR_TRANS_BLOCKS);
>   	handle = ext4_journal_current_handle();
>   	err = PTR_ERR(inode);

