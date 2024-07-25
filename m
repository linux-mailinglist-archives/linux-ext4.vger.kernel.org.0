Return-Path: <linux-ext4+bounces-3446-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C930F93BED4
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 11:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F730283ADC
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 09:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD12197552;
	Thu, 25 Jul 2024 09:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="STIL99Y3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4A4196D81;
	Thu, 25 Jul 2024 09:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721898917; cv=none; b=JdhPi41N5EgQPsJ7nmeA6PPVmKwNtHZU9m7nrkdN/xb244fUjFhVkPnC5bvPWyNYsTSNOAwcmdLw9E6OLUJTElR47qi2P54r8Xc1a+HL5XAve8+Osm81Faj00uMtx+6xG0WPgbvHm5vLv9psnGm1swqviJoG+C07LidCMzB5kAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721898917; c=relaxed/simple;
	bh=j/yEqQAjIIj8LyMCGBMo0d80ZyZhhJcxYmZ4C+SgD3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B1tsdrTnsOfC7+CM70+N/gUq5IUQ8o5qqX1fpG3+ShALfnaPjRKtmK0LCla5uWKsdK/pvvi57P4duBMhb1aacX9IQOh9u+tJDAAbEEzjWkz8Zuknri0SZrGx84JgT1Y7CQOLdx1dKVOS4o9JD7xkxMEzGWVQwTcfAaBfDkAAwD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=STIL99Y3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46P913mY031056;
	Thu, 25 Jul 2024 09:14:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:content-transfer-encoding:mime-version; s=pp1; bh=z
	d459GkdTLJ6KePvJP/djHYd8THQtJpUegDopIMFIFQ=; b=STIL99Y3trAX6alw0
	0WfNnJCoKyh/LASafm0FLOJ04dIfIgGAL14NK6gK8yoeHQN4pmWECpbEax5RALjX
	ISbT3trO6fYwWx4o4MXhu2NVZ8bCWnFyf5cmxAZMVBWHQqnl9dbueo9iIOgAiQh0
	W6lmxJDi6g8bZ8Au/Tpk/wEK4nijIp8C+5jtn6bmMO/S0KELheSrMt2OOFjcL4mc
	7Li/bTKHNRMRXhT5HiozKmeFjwmSYjwPn0SuhSG8W+cHdAaOj5L9hjS0EwDjvZCY
	t3QJJug0x0QWxtKzpv+0W+H9Nq4WlkiL9mNEPBoomw8lmUEQnxGXXr6hhcO1HcL8
	dR9jQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40kdgx0whq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 09:14:41 +0000 (GMT)
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46P9COOt020102;
	Thu, 25 Jul 2024 09:14:40 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40kdgx0whn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 09:14:40 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46P6HqQT009083;
	Thu, 25 Jul 2024 09:14:40 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40gt93nvsq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 09:14:39 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46P9Ea4q34407136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jul 2024 09:14:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B9BB20040;
	Thu, 25 Jul 2024 09:14:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C6152004E;
	Thu, 25 Jul 2024 09:14:34 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.82])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 25 Jul 2024 09:14:34 +0000 (GMT)
Date: Thu, 25 Jul 2024 14:44:32 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 01/20] ext4: refactor ext4_ext_rm_idx() to index 'path'
Message-ID: <ZqIXeLgvSZbEq74w@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-2-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240710040654.1714672-2-libaokun@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RtiPOznXzb7O-uSbQNXb8fwnyQmYVJPg
X-Proofpoint-GUID: mi4IZ8pLJ9o344ND79WJK2OQjNShjkHw
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_09,2024-07-25_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=606 adultscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407250058

On Wed, Jul 10, 2024 at 12:06:35PM +0800, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> As suggested by Honza in Link，modify ext4_ext_rm_idx() to leave 'path'
> alone and just index it like ext4_ext_correct_indexes() does it. This
> facilitates adding error handling later. No functional changes.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Link: https://lore.kernel.org/all/20230216130305.nrbtd42tppxhbynn@quack3/
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  fs/ext4/extents.c | 32 +++++++++++++++-----------------
>  1 file changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index e067f2dd0335..bff3666c891a 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -2279,27 +2279,26 @@ static int ext4_ext_rm_idx(handle_t *handle, struct inode *inode,
>  {
>  	int err;
>  	ext4_fsblk_t leaf;
> +	int k = depth - 1;
>  
>  	/* free index block */
> -	depth--;
> -	path = path + depth;
> -	leaf = ext4_idx_pblock(path->p_idx);
> -	if (unlikely(path->p_hdr->eh_entries == 0)) {
> -		EXT4_ERROR_INODE(inode, "path->p_hdr->eh_entries == 0");
> +	leaf = ext4_idx_pblock(path[k].p_idx);
> +	if (unlikely(path[k].p_hdr->eh_entries == 0)) {
> +		EXT4_ERROR_INODE(inode, "path[%d].p_hdr->eh_entries == 0", k);
>  		return -EFSCORRUPTED;
>  	}
> -	err = ext4_ext_get_access(handle, inode, path);
> +	err = ext4_ext_get_access(handle, inode, path + k);
>  	if (err)
>  		return err;
>  
> -	if (path->p_idx != EXT_LAST_INDEX(path->p_hdr)) {
> -		int len = EXT_LAST_INDEX(path->p_hdr) - path->p_idx;
> +	if (path[k].p_idx != EXT_LAST_INDEX(path[k].p_hdr)) {
> +		int len = EXT_LAST_INDEX(path[k].p_hdr) - path[k].p_idx;
>  		len *= sizeof(struct ext4_extent_idx);
> -		memmove(path->p_idx, path->p_idx + 1, len);
> +		memmove(path[k].p_idx, path[k].p_idx + 1, len);
>  	}
>  
> -	le16_add_cpu(&path->p_hdr->eh_entries, -1);
> -	err = ext4_ext_dirty(handle, inode, path);
> +	le16_add_cpu(&path[k].p_hdr->eh_entries, -1);
> +	err = ext4_ext_dirty(handle, inode, path + k);
>  	if (err)
>  		return err;
>  	ext_debug(inode, "index is empty, remove it, free block %llu\n", leaf);
> @@ -2308,15 +2307,14 @@ static int ext4_ext_rm_idx(handle_t *handle, struct inode *inode,
>  	ext4_free_blocks(handle, inode, NULL, leaf, 1,
>  			 EXT4_FREE_BLOCKS_METADATA | EXT4_FREE_BLOCKS_FORGET);
>  
> -	while (--depth >= 0) {
> -		if (path->p_idx != EXT_FIRST_INDEX(path->p_hdr))
> +	while (--k >= 0) {
> +		if (path[k + 1].p_idx != EXT_FIRST_INDEX(path[k + 1].p_hdr))
>  			break;
> -		path--;
> -		err = ext4_ext_get_access(handle, inode, path);
> +		err = ext4_ext_get_access(handle, inode, path + k);
>  		if (err)
>  			break;
> -		path->p_idx->ei_block = (path+1)->p_idx->ei_block;
> -		err = ext4_ext_dirty(handle, inode, path);
> +		path[k].p_idx->ei_block = path[k + 1].p_idx->ei_block;
> +		err = ext4_ext_dirty(handle, inode, path + k);
>  		if (err)
>  			break;
>  	}

Look good to me as well. Feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin
> -- 
> 2.39.2
> 

