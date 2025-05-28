Return-Path: <linux-ext4+bounces-8210-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 952F0AC6CA8
	for <lists+linux-ext4@lfdr.de>; Wed, 28 May 2025 17:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62C721BC2C19
	for <lists+linux-ext4@lfdr.de>; Wed, 28 May 2025 15:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE0B28B7F9;
	Wed, 28 May 2025 15:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Cql3d4fk"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF1A35947;
	Wed, 28 May 2025 15:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748445132; cv=none; b=Y0ItTctlBEKHK0Zbbtc7OF87Ep0teVffnRyrOIhgnSxVO+Ujy+g6c1trJCYtCEG4vj42MNYGnHq/eQiDd+wQvb3BOFdwlxS8BjgjJngWd9rv/H8aoYMIAg2Ii68Vo5EsNzNQbHeuVmqf8GSGlrH/Zzn6zNNW0eDKV1Q2+jAVpJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748445132; c=relaxed/simple;
	bh=pSirawLR1A06Qeq9Jm2lXOIypMgiMPuaZFeVHj8RhJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=duS9xpMvVrpXzKXyHye/CEFAV0z8UCZZdrqBgT5aRyLaxDAbzPrQ1KErQZsq2yeOk5rFsBdD+BQI2rMGmzsyumAA2tcAWWZFINFAqvea4Je9EA79r5Zd3wpggRgrsBrdu0Q6x8iggfMRY+CnWqj7/AahVYjTkbQ/+e/UikAfS88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Cql3d4fk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SE9Ocj017439;
	Wed, 28 May 2025 15:11:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ecDDZtBS5TdTGtXXfID2wJ9mZNnXL8
	If1ZewND7y78I=; b=Cql3d4fk7DeSVotkPE0BxTT5dBlSilwD5fYZAYyq3/xd8U
	PiX1hmEuXIVTQLRPDAwL8q4rg9mLhOnOb66TRnZnmvuT7md6MyJRNSi2e2uDi7c1
	irtkHbloD3iHlXN7G5uph465o0Wi8jR7BAu8Mknu1Yfep1m+ij3vVaDaq/Qhw3E5
	p0Wei9Rd+qwe+K0AhnsJvvUVD5lrKkTlNDCVUkkg9PUJ/gCF3sJfkqgG0wdAfvHg
	MyEGx9gUr2zXko96kR/4OZuRFrbBrZj7Q/1XgzQ9P+4PyVwvPTlzApDPj4iSrSEm
	Wcls3JvuNv5OFlEGta/CmA3eRi2cOjdsk8ihsoIw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46x40ggcxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 15:11:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54SEvvJe015830;
	Wed, 28 May 2025 15:11:57 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46uu537qqa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 15:11:57 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54SFBtP458130740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 15:11:55 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 859F02004B;
	Wed, 28 May 2025 15:11:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8B7D20043;
	Wed, 28 May 2025 15:11:47 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.18.84])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 28 May 2025 15:11:47 +0000 (GMT)
Date: Wed, 28 May 2025 20:41:43 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, libaokun1@huawei.com
Subject: Re: [PATCH 4/4] ext4: fix typo in CR_GOAL_LEN_SLOW comment
Message-ID: <aDcnr5AyZT70WN3C@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20250523085821.1329392-1-libaokun@huaweicloud.com>
 <20250523085821.1329392-5-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523085821.1329392-5-libaokun@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=avmyCTZV c=1 sm=1 tr=0 ts=683727be cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=AiHppB-aAAAA:8 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8 a=02WT2I8dFG3kbT2Kk5cA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDEzMCBTYWx0ZWRfX94GvHdkj1CPC SfL98BrDdNKCuB9L1gT65KsDSX3Ft+kPh7EY5QCokxqM8rDicUbVlq+/Qctld/vxBrSD4v3ppUs OJKc1dwNtfexJsKaTXEsfkjWgZTbERUzH5AkGhJf3uZlngxcI9nYD2nu0EZh5mwnRdWxUIkfZFh
 VcwcECtHqNWU8HtsD1j/TpmMQCsC1HbHv8fXqUmTmQhpMXCEZjMcniXryp4/hLkMinJ1OpXensT By17aMR7sXIIphK0fuJg3leecZ/rBLYYhJqmxX2QpkPyBTlWI2Pewv/8NUFojlcIJc0qgfmvFTc 8LKHI/kuMvtOd/30vRmZFaiTU730NTBrQ6nN4tNbHDTDiQq3vvYqGh/Dq4+9VZgsQJUWPOnxY7d
 s8xYH6OkA0tcQBbGoL+nba7qgtr3nRjB5+VP/trwskBBwzMnhoBZlZ1hV5s4DTjhanr/c+P8
X-Proofpoint-GUID: 09-clRghPc5abKIhN52lkYHxzrYrm_1L
X-Proofpoint-ORIG-GUID: 09-clRghPc5abKIhN52lkYHxzrYrm_1L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_07,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=739 mlxscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505280130

On Fri, May 23, 2025 at 04:58:21PM +0800, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Remove the superfluous "find_".
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin

> ---
>  fs/ext4/ext4.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index f6d01702423d..1182700901cc 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -157,7 +157,7 @@ enum criteria {
>  
>  	/*
>  	 * Reads each block group sequentially, performing disk IO if
> -	 * necessary, to find find_suitable block group. Tries to
> +	 * necessary, to find suitable block group. Tries to
>  	 * allocate goal length but might trim the request if nothing
>  	 * is found after enough tries.
>  	 */
> -- 
> 2.46.1
> 

