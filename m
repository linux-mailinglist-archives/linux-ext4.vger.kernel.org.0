Return-Path: <linux-ext4+bounces-5809-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1B99F9291
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 13:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D00F7A4531
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 12:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CB72153D0;
	Fri, 20 Dec 2024 12:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VsJo9doD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311FB7D07D;
	Fri, 20 Dec 2024 12:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734699104; cv=none; b=qc2Whsgfyt6VdsWKGxhQqnuD5xtxECFg6E4kVvHdT4vZI5ioUxx/p7qtWf0oHSMhgNTS9PNLWfYUxsdjEbRiUkbic2jQ5ev3pO0iwhTK0YVPS2AgS5TIL2Fh/KTXqWrimyEvKj9A1i9Ee0giyMPhowrutNxlTOx0qntx/tMLB1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734699104; c=relaxed/simple;
	bh=TAL8rxAfmUPcwdquOpkF7Tpnt9iv2jf9wb4y6WxODA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0oqPX2hzCM5WN0AcZrrv4ThpsidVq74FiFuiZ+xdLmemjze5oHaK8pUMNTmWcQrV4AurCznhOrssn0cmsnqy5xB0G4lOEg8cqTuvp2FqCUeT58CnrmkAUjbO/PqK3VJdIKzP0mHwxbFWWPK5A2kACsZyvU4aF/a9v2TA14NxIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VsJo9doD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BK3qHFV010580;
	Fri, 20 Dec 2024 12:51:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=AcHOW2X+zn98cM8KxML64DfejNzOGZ
	Yd6rs/E69gnJY=; b=VsJo9doDy8BUcq969OhMVjXdxI/6V6C5N7EiAkn7wQOSH9
	odaLReyi5DHSDaXeSwSJK83WNwMqRkCiNI2ly0ox8Txg8oR/xMuoNm/PAQ9XNqUa
	g/WknFyGFqJIPTRGxUFVI1yiF37SdJOGO0gFYwSmZsyroShRWnWt48ScI0BPIlfP
	OPv05PIeyvBDTMjw1XoMiU8gG8fmvyCnjQFy/3cLOSiQxABhC7Zz4ckeDQ2blajr
	GfCYIiQ6SorHO6c5R6SAeperaRAg7NlHpAPatowLoYzWg6ZM8Tikqxj5A/2bcXxF
	puGh8LR2Nu7B3umUp605b6yPQjpJJQHw7L+HCsUg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43n12bt73x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 12:51:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BKCbVaT029312;
	Fri, 20 Dec 2024 12:51:28 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hmbt2cgm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 12:51:28 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BKCpQcQ64750032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Dec 2024 12:51:26 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB85620043;
	Fri, 20 Dec 2024 12:51:26 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB38F20040;
	Fri, 20 Dec 2024 12:51:25 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.39.21.221])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 20 Dec 2024 12:51:25 +0000 (GMT)
Date: Fri, 20 Dec 2024 18:21:23 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] ext4: remove unneeded check in get_dx_countlimit
Message-ID: <Z2VoSwYw+sFTzMx0@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20241219110027.1440876-1-shikemeng@huaweicloud.com>
 <20241219110027.1440876-5-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219110027.1440876-5-shikemeng@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5sOq7FSAAAYr2evAibgShE4PW2hZseuu
X-Proofpoint-ORIG-GUID: 5sOq7FSAAAYr2evAibgShE4PW2hZseuu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 malwarescore=0 clxscore=1011 adultscore=0 mlxscore=0
 phishscore=0 spamscore=0 priorityscore=1501 mlxlogscore=696 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412200103

On Thu, Dec 19, 2024 at 07:00:25PM +0800, Kemeng Shi wrote:
> The "offset" is always non-NULL, remove unneeded NULL check of "offset".
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Hi Kemeng,

I know the current callers don't pass NULL but I think we should still
keep the check around just in case, to avoid NULL dereferences in
future. I don't think there's any harm in keeping it

Regards,
ojaswin

> ---
>  fs/ext4/namei.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 33670cebdedc..07a1bb570deb 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -434,8 +434,7 @@ static struct dx_countlimit *get_dx_countlimit(struct inode *inode,
>  	} else
>  		return NULL;
>  
> -	if (offset)
> -		*offset = count_offset;
> +	*offset = count_offset;
>  	return (struct dx_countlimit *)(((void *)dirent) + count_offset);
>  }
>  
> -- 
> 2.30.0
> 

