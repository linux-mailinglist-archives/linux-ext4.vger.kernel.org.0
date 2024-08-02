Return-Path: <linux-ext4+bounces-3621-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF10194649A
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Aug 2024 22:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E33221C2152C
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Aug 2024 20:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60B5763E7;
	Fri,  2 Aug 2024 20:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ct2w+Wvo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBE86E5FD;
	Fri,  2 Aug 2024 20:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722631629; cv=none; b=H95lzydKa4VHYl6jxf4xTLMArHpxXTik+8HK+58rwoU1BnAO/K2Hxtjcgl4qdr7GsHo26FNh7nMBM//biIQZdMbH9wimhNk7T5CsuMQBgmC8iulkobsJVsu2LQgwcIRG/XKp+D3WMf4Xzc1/ncqWUKA4mKMvW3BI1U8Dfyfdezs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722631629; c=relaxed/simple;
	bh=XH/GiVJXAQflmg3/mOTqWeA/uBMPR9TsOA3k74Bnpqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkMduAipElyjRqMUkIUlRAc95q2kEOTCEDgdzhqIyP+RFTFVnzklREnvVLM0kRWJT0ErCuMscIFQYGpDuAmJTdF8MYeuGipIshtvWqTZ1AoPlyfI7UtN3zg9C55bZb9lCYs6MXf1nPBZR4dSaOCWovrPqwz0y1c+ymipbvCTWdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ct2w+Wvo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 472HSlvE007386;
	Fri, 2 Aug 2024 20:46:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=71BT6OeR4E7u4CQzhungF+vIgWM
	IKChWS2ns7KwY8Q4=; b=ct2w+Wvo8dpTGE6hyRhzZ3bHHTZYWkr4PdGArcvETkl
	Nkjw6zWSUtGTR7dOtGk0x9uo/wYZSj5SYP5DwPDuik3vb+RC7YtM+TOYT0C686AZ
	pXhviYB1y2o2tBuIULOJNUyo0vqOyppkyICcM7aqLvPF91DH47RE2T0NBvzOhDzx
	ytuzpd7bdrdE7R+jvaVoiMjAyLul/x30nwrMivEU7Ai9yR8Cp949Jo5DBt7jPw20
	uhEsfdccvkZS/n3f5wjwrJHulCNrM/oBkGyxcnsXlDNoQTLNjjGrZWxluVbHhxmi
	9NRrkPQWRBz5O8pLkV00y29Ka1MuE4Z7ibKupWQVwNQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40s3vxgcx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 20:46:42 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 472KkgVP014456;
	Fri, 2 Aug 2024 20:46:42 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40s3vxgcx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 20:46:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 472ID2vF029118;
	Fri, 2 Aug 2024 20:46:41 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40nbm19870-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 20:46:40 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 472KkbAL21103358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Aug 2024 20:46:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1C2C2004B;
	Fri,  2 Aug 2024 20:46:36 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 276162004E;
	Fri,  2 Aug 2024 20:46:35 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.195.46.209])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  2 Aug 2024 20:46:34 +0000 (GMT)
Date: Sat, 3 Aug 2024 02:16:32 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 19/20] ext4: get rid of ppath in
 convert_initialized_extent()
Message-ID: <Zq1FqACuoNPFh9UJ@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-20-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710040654.1714672-20-libaokun@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lGnmLFO3lIcFhZr6ubnDTqAUba3mmp-6
X-Proofpoint-ORIG-GUID: 6dOGeoEV0UBMggvOkyRI81m6dA1UxLku
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_16,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=458 malwarescore=0
 mlxscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 phishscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408020142

On Wed, Jul 10, 2024 at 12:06:53PM +0800, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> The use of path and ppath is now very confusing, so to make the code more
> readable, pass path between functions uniformly, and get rid of ppath.
> 
> To get rid of the ppath in convert_initialized_extent(), the following is
> done here:
> 
>  * Free the extents path when an error is encountered.
> 
> No functional changes.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good Baokun, feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin

> ---
>  fs/ext4/extents.c | 37 +++++++++++++++++++------------------
>  1 file changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index badadcd64e66..737432bb316e 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3810,13 +3810,12 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
>  	return ERR_PTR(err);
>  }
>  
> -static int
> +static struct ext4_ext_path *
>  convert_initialized_extent(handle_t *handle, struct inode *inode,
>  			   struct ext4_map_blocks *map,
> -			   struct ext4_ext_path **ppath,
> +			   struct ext4_ext_path *path,
>  			   unsigned int *allocated)
>  {
> -	struct ext4_ext_path *path = *ppath;
>  	struct ext4_extent *ex;
>  	ext4_lblk_t ee_block;
>  	unsigned int ee_len;
> @@ -3841,29 +3840,25 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
>  	if (ee_block != map->m_lblk || ee_len > map->m_len) {
>  		path = ext4_split_convert_extents(handle, inode, map, path,
>  				EXT4_GET_BLOCKS_CONVERT_UNWRITTEN, NULL);
> -		if (IS_ERR(path)) {
> -			*ppath = NULL;
> -			return PTR_ERR(path);
> -		}
> +		if (IS_ERR(path))
> +			return path;
>  
>  		path = ext4_find_extent(inode, map->m_lblk, path, 0);
> -		if (IS_ERR(path)) {
> -			*ppath = NULL;
> -			return PTR_ERR(path);
> -		}
> -		*ppath = path;
> +		if (IS_ERR(path))
> +			return path;
>  		depth = ext_depth(inode);
>  		ex = path[depth].p_ext;
>  		if (!ex) {
>  			EXT4_ERROR_INODE(inode, "unexpected hole at %lu",
>  					 (unsigned long) map->m_lblk);
> -			return -EFSCORRUPTED;
> +			err = -EFSCORRUPTED;
> +			goto errout;
>  		}
>  	}
>  
>  	err = ext4_ext_get_access(handle, inode, path + depth);
>  	if (err)
> -		return err;
> +		goto errout;
>  	/* first mark the extent as unwritten */
>  	ext4_ext_mark_unwritten(ex);
>  
> @@ -3875,7 +3870,7 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
>  	/* Mark modified extent as dirty */
>  	err = ext4_ext_dirty(handle, inode, path + path->p_depth);
>  	if (err)
> -		return err;
> +		goto errout;
>  	ext4_ext_show_leaf(inode, path);
>  
>  	ext4_update_inode_fsync_trans(handle, inode, 1);
> @@ -3884,7 +3879,11 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
>  	if (*allocated > map->m_len)
>  		*allocated = map->m_len;
>  	map->m_len = *allocated;
> -	return 0;
> +	return path;
> +
> +errout:
> +	ext4_free_ext_path(path);
> +	return ERR_PTR(err);
>  }
>  
>  static struct ext4_ext_path *
> @@ -4254,8 +4253,10 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>  			 */
>  			if ((!ext4_ext_is_unwritten(ex)) &&
>  			    (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN)) {
> -				err = convert_initialized_extent(handle,
> -					inode, map, &path, &allocated);
> +				path = convert_initialized_extent(handle,
> +					inode, map, path, &allocated);
> +				if (IS_ERR(path))
> +					err = PTR_ERR(path);
>  				goto out;
>  			} else if (!ext4_ext_is_unwritten(ex)) {
>  				map->m_flags |= EXT4_MAP_MAPPED;
> -- 
> 2.39.2
> 

