Return-Path: <linux-ext4+bounces-3618-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E9194645E
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Aug 2024 22:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EB282825D5
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Aug 2024 20:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3694F615;
	Fri,  2 Aug 2024 20:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tSOleY5H"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6011ABEB3;
	Fri,  2 Aug 2024 20:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722630540; cv=none; b=jd6feKNT+k8zeLQi7XSsrHbTrhyh8v3nsre0eZaAuvrfl6GjdJEhjf8zkyvK03yjnu4u/gZzgioAERe2Q8DlkfYwAWExxc/0HUIBusZ56f6L2hj6bBx4FL6UEuJIBuPAcsnW/RJgGOAFAHQxwxLATgaDQcAwSSJmUFEt1ktJGgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722630540; c=relaxed/simple;
	bh=OsIQaXA7NDoJ4BOQ0KSt82LyGmUzHbYEgfBtoUu30zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFAIR+txibYstv0QVPbWsbMiyD/YweaLZs/DzfGi0ZOR1zSMFnYd6WN7uOm47WPXt34sSqWmFArmfwi94UmOJblM9mRX+fANV1kclMcNKA6A3+hvhy2YIu22GAedshqoLocFP20f3GoQe2+28qqXtW0rqmVMwAKmB+GpUILo9Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tSOleY5H; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 472Il3Sv024987;
	Fri, 2 Aug 2024 20:28:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=lGOjYWzCwHdnwncbpitzxodb54Q
	3biok922/l59eztI=; b=tSOleY5HxocmirS2qvsCP7Oi4VA6hBaiatpqS5G24Kw
	N6TDRErsuIwkNmmkGgNR6hI/JpYbEIFDAHF61GJSu1Us4QNZ60zFKwG6FoPCFLIs
	6Ikxz0H47hHyM6PEdUZq0hNQPtGZ5JK3JolllE90NUQ5wdWW/s4uedFgnih02hLd
	vPqlzCLDoUSfaAo6+XoomEFvISeLEsuKYM/hPtDpsnlZnt7aCB+aWU3MetKaDwF0
	ts+oMNbbJlTQdL1M0ey/x/ouSFXJEEvQEa/MMvB6L8ssODvdIcXarevUMHohuTnG
	ElljDwqw26h7xYd9C27Gzf1w8BfU9XGJrmxMlWu2qeg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rygm92hq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 20:28:42 +0000 (GMT)
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 472KSfWD002880;
	Fri, 2 Aug 2024 20:28:41 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rygm92hn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 20:28:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 472HaSU9029103;
	Fri, 2 Aug 2024 20:28:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40nbm1967j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 20:28:40 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 472KSaKw49742202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Aug 2024 20:28:38 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5210120043;
	Fri,  2 Aug 2024 20:28:36 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6575320040;
	Fri,  2 Aug 2024 20:28:34 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.195.46.209])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  2 Aug 2024 20:28:34 +0000 (GMT)
Date: Sat, 3 Aug 2024 01:58:31 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 16/20] ext4: get rid of ppath in
 ext4_convert_unwritten_extents_endio()
Message-ID: <Zq1Bb7eeV5m7HNBS@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-17-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710040654.1714672-17-libaokun@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VyYMjhpIs0Mb0RLVnLBwe1X_-JkjQAU1
X-Proofpoint-ORIG-GUID: goHBJw4k6TUltnuikUmIXodbaHIJZp0T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_16,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=563
 bulkscore=0 clxscore=1015 impostorscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408020142

On Wed, Jul 10, 2024 at 12:06:50PM +0800, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> The use of path and ppath is now very confusing, so to make the code more
> readable, pass path between functions uniformly, and get rid of ppath.
> 
> To get rid of the ppath in ext4_convert_unwritten_extents_endio(), the
> following is done here:
> 
>  * Free the extents path when an error is encountered.
>  * Its caller needs to update ppath if it uses ppath.
> 
> No functional changes.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good Baokun, feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin

> ---
>  fs/ext4/extents.c | 43 +++++++++++++++++++++++--------------------
>  1 file changed, 23 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index a41cbb8c4475..b7f443f98e9d 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3745,12 +3745,11 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
>  				 allocated);
>  }
>  
> -static int ext4_convert_unwritten_extents_endio(handle_t *handle,
> -						struct inode *inode,
> -						struct ext4_map_blocks *map,
> -						struct ext4_ext_path **ppath)
> +static struct ext4_ext_path *
> +ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
> +				     struct ext4_map_blocks *map,
> +				     struct ext4_ext_path *path)
>  {
> -	struct ext4_ext_path *path = *ppath;
>  	struct ext4_extent *ex;
>  	ext4_lblk_t ee_block;
>  	unsigned int ee_len;
> @@ -3780,24 +3779,19 @@ static int ext4_convert_unwritten_extents_endio(handle_t *handle,
>  #endif
>  		path = ext4_split_convert_extents(handle, inode, map, path,
>  						EXT4_GET_BLOCKS_CONVERT, NULL);
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
>  	}
>  
>  	err = ext4_ext_get_access(handle, inode, path + depth);
>  	if (err)
> -		goto out;
> +		goto errout;
>  	/* first mark the extent as initialized */
>  	ext4_ext_mark_initialized(ex);
>  
> @@ -3808,9 +3802,15 @@ static int ext4_convert_unwritten_extents_endio(handle_t *handle,
>  
>  	/* Mark modified extent as dirty */
>  	err = ext4_ext_dirty(handle, inode, path + path->p_depth);
> -out:
> +	if (err)
> +		goto errout;
> +
>  	ext4_ext_show_leaf(inode, path);
> -	return err;
> +	return path;
> +
> +errout:
> +	ext4_free_ext_path(path);
> +	return ERR_PTR(err);
>  }
>  
>  static int
> @@ -3938,10 +3938,13 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
>  	}
>  	/* IO end_io complete, convert the filled extent to written */
>  	if (flags & EXT4_GET_BLOCKS_CONVERT) {
> -		err = ext4_convert_unwritten_extents_endio(handle, inode, map,
> -							   ppath);
> -		if (err < 0)
> +		*ppath = ext4_convert_unwritten_extents_endio(handle, inode,
> +							      map, *ppath);
> +		if (IS_ERR(*ppath)) {
> +			err = PTR_ERR(*ppath);
> +			*ppath = NULL;
>  			goto out2;
> +		}
>  		ext4_update_inode_fsync_trans(handle, inode, 1);
>  		goto map_out;
>  	}
> -- 
> 2.39.2
> 

