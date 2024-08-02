Return-Path: <linux-ext4+bounces-3622-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A51589464BB
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Aug 2024 22:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 168DE1F21233
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Aug 2024 20:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEEE61FF0;
	Fri,  2 Aug 2024 20:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W5TlKkDG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAB71ABEBA;
	Fri,  2 Aug 2024 20:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722632347; cv=none; b=gs5IkfJH3QbcgkNYjpbxsqO4PQ+WEC8NgepUzUVax3nuwKNfazbqD8+LqpT4RE/7Ai3ZrkHyFu5B0l8baf3WjEv3sIjuiz2zMjjP421cXck399wsS3tsgjH0agg2h8vMjCFU1dmTDeTKFyr5MCpKAoL8TcAGJ+MnreVUIzlACwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722632347; c=relaxed/simple;
	bh=AMZ09jx4B75eq06v9qwSptsvrNaG0/xLTcQxAVq7P1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upVDj3sNrSbHTCBMZAZmTk3pVVXdKRNayqfCsJlIVbqA9sxA+YmxB9Mone1uDLs1lNVxagxRqD4yfD/jnZSeQfQTrTZjNT/8KethNntyOGFzqfvjztW4t2U3JpjtpKDUN6kD+xbjWynDQwMNOuAsq87q5GgNDtwElUMcC732S2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W5TlKkDG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 472FZsJm000895;
	Fri, 2 Aug 2024 20:58:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=ZXwEyjfTR6JMviAKfGyOd37s8Vs
	jISLrMk22g52BjL4=; b=W5TlKkDGjEtnmZ2WADSChV6abqRHO/vuaZue73oJEHB
	/xKZPR78bBBqEr9S2shJRfDhWbmXmqXcANChzVSmpZ2Kx5K9Jl5UGzaeri8RBeyR
	Ho+Kw5MSvEmAyX1voEvJ72GO1S4D0Z3Fxy4aNksPo78d8vQPs0IAvKukafi7F++i
	41Ofl5EKsaG9yS+IibCw7iAhnLTMm17k/vbzraWhGBC61wCAQT6B+XMv07HHSzqe
	FrXrGLXhkCcqOO1ZO506Ib95nWcWDUhIKtNoaF/BPJwlVS36MJYjWQlt/zL0Qx8e
	rawN9DIn+8xQrUEUPi8dA1W63VR3aFyD/Kq4aiy+gVw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rwqwsaye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 20:58:47 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 472KwkcZ026060;
	Fri, 2 Aug 2024 20:58:47 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rwqwsayb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 20:58:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 472IPgAm018797;
	Fri, 2 Aug 2024 20:58:46 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40nc7q945q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 20:58:46 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 472KwgLe33423896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Aug 2024 20:58:44 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3038D20043;
	Fri,  2 Aug 2024 20:58:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40EFA20040;
	Fri,  2 Aug 2024 20:58:40 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.195.46.209])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  2 Aug 2024 20:58:40 +0000 (GMT)
Date: Sat, 3 Aug 2024 02:28:37 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 20/20] ext4: avoid unnecessary extent path frees and
 allocations
Message-ID: <Zq1IfX3R7YSf6n5R@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-21-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710040654.1714672-21-libaokun@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AyuhhpSBi-ds3-7TMXoTZHhOpubrUqLQ
X-Proofpoint-GUID: 2garBcJxued9fPbwmmCb3mGP6fhcmdYC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_16,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=624 adultscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408020145

On Wed, Jul 10, 2024 at 12:06:54PM +0800, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> The ext4_find_extent() can update the extent path so that it does not have
> to allocate and free the path repeatedly, thus reducing the consumption of
> memory allocation and freeing in the following functions:
> 
>     ext4_ext_clear_bb
>     ext4_ext_replay_set_iblocks
>     ext4_fc_replay_add_range
>     ext4_fc_set_bitmaps_and_counters
> 
> No functional changes. Note that ext4_find_extent() does not support error
> pointers, so in this case set path to NULL first.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good Baokun, feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin

> ---
>  fs/ext4/extents.c     | 51 +++++++++++++++++++------------------------
>  fs/ext4/fast_commit.c | 11 ++++++----
>  2 files changed, 29 insertions(+), 33 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 737432bb316e..5ff92cd50dc8 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -6068,12 +6068,9 @@ int ext4_ext_replay_set_iblocks(struct inode *inode)
>  	if (IS_ERR(path))
>  		return PTR_ERR(path);
>  	ex = path[path->p_depth].p_ext;
> -	if (!ex) {
> -		ext4_free_ext_path(path);
> +	if (!ex)
>  		goto out;
> -	}
>  	end = le32_to_cpu(ex->ee_block) + ext4_ext_get_actual_len(ex);
> -	ext4_free_ext_path(path);
>  
>  	/* Count the number of data blocks */
>  	cur = 0;
> @@ -6099,32 +6096,28 @@ int ext4_ext_replay_set_iblocks(struct inode *inode)
>  	ret = skip_hole(inode, &cur);
>  	if (ret < 0)
>  		goto out;
> -	path = ext4_find_extent(inode, cur, NULL, 0);
> +	path = ext4_find_extent(inode, cur, path, 0);
>  	if (IS_ERR(path))
>  		goto out;
>  	numblks += path->p_depth;
> -	ext4_free_ext_path(path);
>  	while (cur < end) {
> -		path = ext4_find_extent(inode, cur, NULL, 0);
> +		path = ext4_find_extent(inode, cur, path, 0);
>  		if (IS_ERR(path))
>  			break;
>  		ex = path[path->p_depth].p_ext;
> -		if (!ex) {
> -			ext4_free_ext_path(path);
> -			return 0;
> -		}
> +		if (!ex)
> +			goto cleanup;
> +
>  		cur = max(cur + 1, le32_to_cpu(ex->ee_block) +
>  					ext4_ext_get_actual_len(ex));
>  		ret = skip_hole(inode, &cur);
> -		if (ret < 0) {
> -			ext4_free_ext_path(path);
> +		if (ret < 0)
>  			break;
> -		}
> -		path2 = ext4_find_extent(inode, cur, NULL, 0);
> -		if (IS_ERR(path2)) {
> -			ext4_free_ext_path(path);
> +
> +		path2 = ext4_find_extent(inode, cur, path2, 0);
> +		if (IS_ERR(path2))
>  			break;
> -		}
> +
>  		for (i = 0; i <= max(path->p_depth, path2->p_depth); i++) {
>  			cmp1 = cmp2 = 0;
>  			if (i <= path->p_depth)
> @@ -6136,13 +6129,14 @@ int ext4_ext_replay_set_iblocks(struct inode *inode)
>  			if (cmp1 != cmp2 && cmp2 != 0)
>  				numblks++;
>  		}
> -		ext4_free_ext_path(path);
> -		ext4_free_ext_path(path2);
>  	}
>  
>  out:
>  	inode->i_blocks = numblks << (inode->i_sb->s_blocksize_bits - 9);
>  	ext4_mark_inode_dirty(NULL, inode);
> +cleanup:
> +	ext4_free_ext_path(path);
> +	ext4_free_ext_path(path2);
>  	return 0;
>  }
>  
> @@ -6163,12 +6157,9 @@ int ext4_ext_clear_bb(struct inode *inode)
>  	if (IS_ERR(path))
>  		return PTR_ERR(path);
>  	ex = path[path->p_depth].p_ext;
> -	if (!ex) {
> -		ext4_free_ext_path(path);
> -		return 0;
> -	}
> +	if (!ex)
> +		goto out;
>  	end = le32_to_cpu(ex->ee_block) + ext4_ext_get_actual_len(ex);
> -	ext4_free_ext_path(path);
>  
>  	cur = 0;
>  	while (cur < end) {
> @@ -6178,16 +6169,16 @@ int ext4_ext_clear_bb(struct inode *inode)
>  		if (ret < 0)
>  			break;
>  		if (ret > 0) {
> -			path = ext4_find_extent(inode, map.m_lblk, NULL, 0);
> -			if (!IS_ERR_OR_NULL(path)) {
> +			path = ext4_find_extent(inode, map.m_lblk, path, 0);
> +			if (!IS_ERR(path)) {
>  				for (j = 0; j < path->p_depth; j++) {
> -
>  					ext4_mb_mark_bb(inode->i_sb,
>  							path[j].p_block, 1, false);
>  					ext4_fc_record_regions(inode->i_sb, inode->i_ino,
>  							0, path[j].p_block, 1, 1);
>  				}
> -				ext4_free_ext_path(path);
> +			} else {
> +				path = NULL;
>  			}
>  			ext4_mb_mark_bb(inode->i_sb, map.m_pblk, map.m_len, false);
>  			ext4_fc_record_regions(inode->i_sb, inode->i_ino,
> @@ -6196,5 +6187,7 @@ int ext4_ext_clear_bb(struct inode *inode)
>  		cur = cur + map.m_len;
>  	}
>  
> +out:
> +	ext4_free_ext_path(path);
>  	return 0;
>  }
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 1dee40477727..1426d595fab7 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -1766,7 +1766,7 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
>  
>  		if (ret == 0) {
>  			/* Range is not mapped */
> -			path = ext4_find_extent(inode, cur, NULL, 0);
> +			path = ext4_find_extent(inode, cur, path, 0);
>  			if (IS_ERR(path))
>  				goto out;
>  			memset(&newex, 0, sizeof(newex));
> @@ -1782,7 +1782,6 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
>  			up_write((&EXT4_I(inode)->i_data_sem));
>  			if (IS_ERR(path))
>  				goto out;
> -			ext4_free_ext_path(path);
>  			goto next;
>  		}
>  
> @@ -1830,6 +1829,7 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
>  	ext4_ext_replay_shrink_inode(inode, i_size_read(inode) >>
>  					sb->s_blocksize_bits);
>  out:
> +	ext4_free_ext_path(path);
>  	iput(inode);
>  	return 0;
>  }
> @@ -1930,12 +1930,13 @@ static void ext4_fc_set_bitmaps_and_counters(struct super_block *sb)
>  				break;
>  
>  			if (ret > 0) {
> -				path = ext4_find_extent(inode, map.m_lblk, NULL, 0);
> +				path = ext4_find_extent(inode, map.m_lblk, path, 0);
>  				if (!IS_ERR(path)) {
>  					for (j = 0; j < path->p_depth; j++)
>  						ext4_mb_mark_bb(inode->i_sb,
>  							path[j].p_block, 1, true);
> -					ext4_free_ext_path(path);
> +				} else {
> +					path = NULL;
>  				}
>  				cur += ret;
>  				ext4_mb_mark_bb(inode->i_sb, map.m_pblk,
> @@ -1946,6 +1947,8 @@ static void ext4_fc_set_bitmaps_and_counters(struct super_block *sb)
>  		}
>  		iput(inode);
>  	}
> +
> +	ext4_free_ext_path(path);
>  }
>  
>  /*
> -- 
> 2.39.2
> 

