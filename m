Return-Path: <linux-ext4+bounces-3593-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FC5944549
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Aug 2024 09:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDAEE1C217F5
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Aug 2024 07:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E1F1586C4;
	Thu,  1 Aug 2024 07:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qLT3he8/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0CC45014;
	Thu,  1 Aug 2024 07:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722496644; cv=none; b=UmTuzjM0pBAF69yLmi/MCHmzzIblwQOIVdcieYUvoGIlBaRkfSEZaoiGRmXgG1//7o16iHfBGST/en4vgYV3FTzTb+kwIcEjKEqEGL1YH3BEHA6vbTAyRRs86RFrZt4djkVPHUPyG6zmUrB0lR9NJsXw8QYAydcu4mMNjmyPMgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722496644; c=relaxed/simple;
	bh=Xg5mlr03dB9zqorap7MmuQiw/39hKt+kzBCI4fK8CbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8hjOIB1PAftSYHqM+YrXOXwIMQwGtpsqYPQDmK/EKTVV/u6+Dx/oAZjtNoB3SdbqIvxgA6Bpc3ChIgbs/ONS/ijoYeao1cQAT3cpFu1rsA/n1pfTTfdpVDN4ib+C4CbGLuJ7c44DmvZKJ7fRVZ+8q1b4L5IC92rIKaHWSx4jqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qLT3he8/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47160FRb015738;
	Thu, 1 Aug 2024 07:17:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=Iy96R6YPlYX6sX54505MS550vCt
	DrxElTTXW961xGBc=; b=qLT3he8/H5+aF/XAREFn1tr+WF/nb8IeYEjKxMYkZJ7
	5KtAwdH1uoBD335BwUcd19dKAL0RjePMz8L5TTacWXWKHNbhrhnS8ZDz2ZD2vIhe
	WI85qlIBOfUtjPyuPhpBhZlCy1kXngHrBaKe+L+mrujYtB6uvwSR/JiQpYSLPTAH
	KrLDoVEsRngGrgf2H582LA1G/NoRzwvJqHFnQhbm7ATNwC5TU/KGXye56j2XkiwY
	aMSaNzNA1NUakBLrtZzGpYJFNXdB243IgNnUvABwIiCmt6Ts+VFeXfvNHWQaXjnO
	ltF4+jI7MKs0GbUPkMUJjMd/jxG/PUXMszsZjR8kJuQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qyumrtun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 07:17:00 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4717Gxwx017259;
	Thu, 1 Aug 2024 07:16:59 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qyumrtuk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 07:16:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47151JPw018770;
	Thu, 1 Aug 2024 07:16:58 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40nc7q0dj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 07:16:58 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4717GsIO43647248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Aug 2024 07:16:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E5B62004E;
	Thu,  1 Aug 2024 07:16:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4449E20040;
	Thu,  1 Aug 2024 07:16:52 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.82])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  1 Aug 2024 07:16:52 +0000 (GMT)
Date: Thu, 1 Aug 2024 12:46:49 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 09/20] ext4: get rid of ppath in get_ext_path()
Message-ID: <Zqs2YYSZ2fPBAUw1@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-10-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710040654.1714672-10-libaokun@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IT_Ofd4M_5xu2Xhk3nDkz0Djvt9DL_6b
X-Proofpoint-ORIG-GUID: pWZmXY75zTV71JsFeXh7adJ8rZl2mEsb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_04,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxlogscore=682 spamscore=0 mlxscore=0 suspectscore=0 phishscore=0
 adultscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408010038

On Wed, Jul 10, 2024 at 12:06:43PM +0800, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> The use of path and ppath is now very confusing, so to make the code more
> readable, pass path between functions uniformly, and get rid of ppath.
> 
> After getting rid of ppath in get_ext_path(), its caller may pass an error
> pointer to ext4_free_ext_path(), so it needs to teach ext4_free_ext_path()
> and ext4_ext_drop_refs() to skip the error pointer. No functional changes.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  fs/ext4/extents.c     |  5 +++--
>  fs/ext4/move_extent.c | 34 +++++++++++++++++-----------------
>  2 files changed, 20 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 5217e6f53467..6dfb5d03e197 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -116,7 +116,7 @@ static void ext4_ext_drop_refs(struct ext4_ext_path *path)
>  {
>  	int depth, i;
>  
> -	if (!path)
> +	if (IS_ERR_OR_NULL(path))
>  		return;
>  	depth = path->p_depth;
>  	for (i = 0; i <= depth; i++, path++)
> @@ -125,6 +125,8 @@ static void ext4_ext_drop_refs(struct ext4_ext_path *path)
>  
>  void ext4_free_ext_path(struct ext4_ext_path *path)
>  {
> +	if (IS_ERR_OR_NULL(path))
> +		return;
>  	ext4_ext_drop_refs(path);
>  	kfree(path);
>  }
> @@ -4191,7 +4193,6 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>  	path = ext4_find_extent(inode, map->m_lblk, NULL, 0);
>  	if (IS_ERR(path)) {
>  		err = PTR_ERR(path);
> -		path = NULL;
>  		goto out;
>  	}
>  
> diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
> index b0ab19a913bf..a7186d63725a 100644
> --- a/fs/ext4/move_extent.c
> +++ b/fs/ext4/move_extent.c
> @@ -17,27 +17,23 @@
>   * get_ext_path() - Find an extent path for designated logical block number.
>   * @inode:	inode to be searched
>   * @lblock:	logical block number to find an extent path
> - * @ppath:	pointer to an extent path pointer (for output)
> + * @path:	pointer to an extent path
>   *
> - * ext4_find_extent wrapper. Return 0 on success, or a negative error value
> - * on failure.
> + * ext4_find_extent wrapper. Return an extent path pointer on success,
> + * or an error pointer on failure.
>   */
> -static inline int
> +static inline struct ext4_ext_path *
>  get_ext_path(struct inode *inode, ext4_lblk_t lblock,
> -		struct ext4_ext_path **ppath)
> +	     struct ext4_ext_path *path)
>  {
> -	struct ext4_ext_path *path = *ppath;
> -
> -	*ppath = NULL;
>  	path = ext4_find_extent(inode, lblock, path, EXT4_EX_NOCACHE);
>  	if (IS_ERR(path))
> -		return PTR_ERR(path);
> +		return path;
>  	if (path[ext_depth(inode)].p_ext == NULL) {
>  		ext4_free_ext_path(path);
> -		return -ENODATA;
> +		return ERR_PTR(-ENODATA);
>  	}
> -	*ppath = path;
> -	return 0;
> +	return path;
>  }
>  
>  /**
> @@ -95,9 +91,11 @@ mext_check_coverage(struct inode *inode, ext4_lblk_t from, ext4_lblk_t count,
>  	int ret = 0;
>  	ext4_lblk_t last = from + count;
>  	while (from < last) {
> -		*err = get_ext_path(inode, from, &path);
> -		if (*err)
> -			goto out;
> +		path = get_ext_path(inode, from, path);
> +		if (IS_ERR(path)) {
> +			*err = PTR_ERR(path);
> +			return ret;
> +		}
>  		ext = path[ext_depth(inode)].p_ext;
>  		if (unwritten != ext4_ext_is_unwritten(ext))
>  			goto out;
> @@ -624,9 +622,11 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
>  		int offset_in_page;
>  		int unwritten, cur_len;
>  
> -		ret = get_ext_path(orig_inode, o_start, &path);
> -		if (ret)
> +		path = get_ext_path(orig_inode, o_start, path);
> +		if (IS_ERR(path)) {
> +			ret = PTR_ERR(path);
>  			goto out;
> +		}
>  		ex = path[path->p_depth].p_ext;
>  		cur_blk = le32_to_cpu(ex->ee_block);
>  		cur_len = ext4_ext_get_actual_len(ex);
> -- 
> 2.39.2
Looks good Baokun, feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin
> 

