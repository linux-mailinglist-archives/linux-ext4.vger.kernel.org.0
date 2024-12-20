Return-Path: <linux-ext4+bounces-5811-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADAB9F92AB
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 13:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 263611894AF0
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 12:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309972153EB;
	Fri, 20 Dec 2024 12:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qS2BXURP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342427D07D;
	Fri, 20 Dec 2024 12:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734699441; cv=none; b=OAluqOx2yjYxe+PgCzS/JUvqgDjlDDqKQFPs7+a7v2nlvuA91W+efBPo0As4Lxyh/NiHG5Tpu/r4g265Iz7iD/q4ZMnsN6FUnOGXTDXmoelnh0U9BFrZtSW/r/3uzZ5LBx7z30waDI1hhTjnSsRgL5OlOO5ZVin/Fja/rlPlyC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734699441; c=relaxed/simple;
	bh=pq5xFQ2rikFlj6VWB4rFE7yTbhIKNHi8X8yaYcPgliA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2PcY4ctYR7IJcesTmUWg/thXwM9Pw1T/kq1cpCfulvx3nEBJwFQkQR6RHCg+xCX8h3h6IYVJo2GLPLq4oNYAOtQZ1Mi0GebtkN/KeJAHKuYfivwnCF22qYZJOjAhOknGOWelEnWVmNoC8i7Gguo6WA5QM1DNYDwKpmoHQvb00c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qS2BXURP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BK862nN014698;
	Fri, 20 Dec 2024 12:57:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=VSBcXaWO85KAZva7jE7PC5YCARy4mF
	th8qFqnmCkpfk=; b=qS2BXURPov8jqxZZBXy2sp2o9lqaziPDAHbCpMnnVV8CTg
	dsnpUq4DsVMRyDMedF/xy8SDOr6mahZoE4mNYwLsRZ/k35FCg6YMsK8yNcKb4pfU
	hUWXT/jCsX/DqeQXuk9UxMXiMsVW+JVb70SqcnDoqn63oBRak8RBYgjhf47Pwr6E
	xhxSeoU8RbCEEdHEnVpaDoZomsypGh7fX+/xqBJl0iVI36m4b894wt4DxWe03ZE4
	c2SMreqUFKeg7BGOCzU9Y2bnYKDcraO+eiztpwGGdqp22/5vnzOAE4k+YnIpgXHM
	ESW7VDYLyUjO7Tn9Xp3d3NpAx7x2A3+7HrflahSQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43n4s2s7pk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 12:57:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BKAZmwU011267;
	Fri, 20 Dec 2024 12:57:11 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hpjkhx8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 12:57:11 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BKCv9G455378302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Dec 2024 12:57:09 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96B3820040;
	Fri, 20 Dec 2024 12:57:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B4F420043;
	Fri, 20 Dec 2024 12:57:08 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.39.23.188])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 20 Dec 2024 12:57:08 +0000 (GMT)
Date: Fri, 20 Dec 2024 18:27:05 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] ext4: add missing brelse for bh2 in ext4_dx_add_entry
Message-ID: <Z2Vpa7JgPijraPQB@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20241219110027.1440876-1-shikemeng@huaweicloud.com>
 <20241219110027.1440876-2-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219110027.1440876-2-shikemeng@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wIuCvUONxIki20e4t-TazbPOLkuEitTU
X-Proofpoint-GUID: wIuCvUONxIki20e4t-TazbPOLkuEitTU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxlogscore=969 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412200103

On Thu, Dec 19, 2024 at 07:00:22PM +0800, Kemeng Shi wrote:
> Add missing brelse for bh2 in ext4_dx_add_entry.

Looks good, feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin

> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/namei.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 1012781ae9b4..adec145b6f7d 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -2580,8 +2580,10 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
>  		BUFFER_TRACE(frame->bh, "get_write_access");
>  		err = ext4_journal_get_write_access(handle, sb, frame->bh,
>  						    EXT4_JTR_NONE);
> -		if (err)
> +		if (err) {
> +			brelse(bh2);
>  			goto journal_error;
> +		}
>  		if (!add_level) {
>  			unsigned icount1 = icount/2, icount2 = icount - icount1;
>  			unsigned hash2 = dx_get_hash(entries + icount1);
> @@ -2592,8 +2594,10 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
>  			err = ext4_journal_get_write_access(handle, sb,
>  							    (frame - 1)->bh,
>  							    EXT4_JTR_NONE);
> -			if (err)
> +			if (err) {
> +				brelse(bh2);
>  				goto journal_error;
> +			}
>  
>  			memcpy((char *) entries2, (char *) (entries + icount1),
>  			       icount2 * sizeof(struct dx_entry));
> @@ -2612,8 +2616,10 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
>  			dxtrace(dx_show_index("node",
>  			       ((struct dx_node *) bh2->b_data)->entries));
>  			err = ext4_handle_dirty_dx_node(handle, dir, bh2);
> -			if (err)
> +			if (err) {
> +				brelse(bh2);
>  				goto journal_error;
> +			}
>  			brelse (bh2);
>  			err = ext4_handle_dirty_dx_node(handle, dir,
>  						   (frame - 1)->bh);
> @@ -2638,8 +2644,10 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
>  				       "Creating %d level index...\n",
>  				       dxroot->info.indirect_levels));
>  			err = ext4_handle_dirty_dx_node(handle, dir, frame->bh);
> -			if (err)
> +			if (err) {
> +				brelse(bh2);
>  				goto journal_error;
> +			}
>  			err = ext4_handle_dirty_dx_node(handle, dir, bh2);
>  			brelse(bh2);
>  			restart = 1;
> -- 
> 2.30.0
> 

