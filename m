Return-Path: <linux-ext4+bounces-9037-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 709DCB08A93
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 12:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E04673B84EB
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 10:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5640928B417;
	Thu, 17 Jul 2025 10:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ri4R45Px"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B43D1F5413;
	Thu, 17 Jul 2025 10:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752748318; cv=none; b=pQPEvseMkACzROU/CLhuoNH7yZfEXjZFZVOnB3f7swImVvlbyEDeJTQSFT7chSJUV4tC+m/tXfLHzF2Jhd5BO+k2iat0A7B5+5gRya/qaR+5JEhWwjw4omZbUHAEYMd8aV/rHVN0Z6vVYaDM3rtTDEOGcRo1l45fSbpBEui4E7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752748318; c=relaxed/simple;
	bh=gW+x7Dae052GnKsSfXRjfCO7WlWB2qcidHvBMxFpWvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pH/0fpSZ25GP2Ovr9ONJrS4BW369+JcxnVrtt8BPbEwWucm4FCstDvwpD/4sxK/eCVSk6y0bUJpuxE1rJ2F2jPmk6q8khq6ZoB2ST5RckHtUAuhBdZ+ejIp0VYJLGFWPfBVMJB9JUGMN6E3Fe3Yfud4WBEnvQdT100qQE45YePE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ri4R45Px; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HASl5r010944;
	Thu, 17 Jul 2025 10:31:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=sEGkm5sYvIQR0NJ+SdTDjKzKLds0oZ
	aTZXPyV+Vo/Wc=; b=ri4R45Px0j4cv4xHPsKMYo34EjCvHDwkhwoldOwyFQZcHN
	605PzvrCxnHYvqjbIkFY8vsPRJOF/H63miW3x2aBrCuoBNCPQ3WEgEoQjQIsVo8f
	5A3N7xKx4klUvfunmcAFg6ht6zlhH/mDVYLdVWr48n1BllHiCtpFFDvnACF3Y8+y
	iryLw6azTJJaM39L0yifs7T5mA8tERVqD90s/XXPGTHaA9vmbBDevixP+Ce47+Xw
	QLe7meKRg+thMYmHrWccAeDSntltAfkeEq66ky27w4tz8Xk64h7+KfkmmdAHiOx9
	qOl1+l/YSwUGaOy+T8kGyM2jnFOMvdjTbVDppyoA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ue4ua67n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 10:31:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56H7J7Ap008150;
	Thu, 17 Jul 2025 10:31:23 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47v2e0uwm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 10:31:23 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56HAVLSm60031236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 10:31:21 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B05F220040;
	Thu, 17 Jul 2025 10:31:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57D4A2004B;
	Thu, 17 Jul 2025 10:31:19 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.17.40])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 17 Jul 2025 10:31:19 +0000 (GMT)
Date: Thu, 17 Jul 2025 16:01:16 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, linux-kernel@vger.kernel.org, julia.lawall@inria.fr,
        yi.zhang@huawei.com, yangerkun@huawei.com, libaokun@huaweicloud.com
Subject: Re: [PATCH v3 03/17] ext4: remove unnecessary s_mb_last_start
Message-ID: <aHjQ9BwMcHQL-2A4@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20250714130327.1830534-1-libaokun1@huawei.com>
 <20250714130327.1830534-4-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714130327.1830534-4-libaokun1@huawei.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=baBrUPPB c=1 sm=1 tr=0 ts=6878d0fc cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8 a=maETWrEbk6pMdrDMjMoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: aaZ26G40lOOUUm6bD5pATYZE2Gfca1pK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDA5MCBTYWx0ZWRfXxhN1ZPdlb1uq 84oQrsJwhMHGklGy5B8KnFrZ/SalE79+HGi4uSAnzYQQlwk/B6tHSmR06c3oObrmZUX+TcZ+UJW wyULQRLeNWmDHa7xQ8PRECy4kkPPOvY43MkoL/7ukcEtkPfoIy32GqM6vCRsGbio6OaFfe7tLEZ
 nN9I7Awx2jkfRIz1OupSHZ5Q3ITi1U0KpRso0U9R2GEe0tk9AexBeG985RV7/xO3m7T/+ZvQkSV KO/bjwisRRCJ0sJuzv7EpyGd4DfvE/xnts5MEgIxrDpBaoik5xhd8rKvA8X4PKazUFANzCl7KHv e4QKWItmZjs/cRBOrHW9+qFRVCkxRsU626Ss9mvF9nmDwHk1OkVLsLgtYcGeAGt2XV6X/jxObva
 ROwOxktciEli0S2PDQSZlrwcQ1BrQa85a1U1rDK/xZV5nT2U2b7C/m84YFTZBhwYzFzpMWMi
X-Proofpoint-ORIG-GUID: aaZ26G40lOOUUm6bD5pATYZE2Gfca1pK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=788
 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 malwarescore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170090

On Mon, Jul 14, 2025 at 09:03:13PM +0800, Baokun Li wrote:
> Since stream allocation does not use ac->ac_f_ex.fe_start, it is set to -1
> by default, so the no longer needed sbi->s_mb_last_start is removed.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/ext4.h    | 1 -
>  fs/ext4/mballoc.c | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 8750ace12935..b83095541c98 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1631,7 +1631,6 @@ struct ext4_sb_info {
>  	unsigned int s_max_dir_size_kb;
>  	/* where last allocation was done - for stream allocation */
>  	unsigned long s_mb_last_group;
> -	unsigned long s_mb_last_start;
>  	unsigned int s_mb_prefetch;
>  	unsigned int s_mb_prefetch_limit;
>  	unsigned int s_mb_best_avail_max_trim_order;
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index f56ac477c464..e3a5103e1620 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2171,7 +2171,6 @@ static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
>  	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
>  		spin_lock(&sbi->s_md_lock);
>  		sbi->s_mb_last_group = ac->ac_f_ex.fe_group;
> -		sbi->s_mb_last_start = ac->ac_f_ex.fe_start;

Looks good,

Feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin

>  		spin_unlock(&sbi->s_md_lock);
>  	}
>  	/*
> -- 
> 2.46.1
> 

