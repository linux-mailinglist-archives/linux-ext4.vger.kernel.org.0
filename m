Return-Path: <linux-ext4+bounces-3474-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E69D93D295
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Jul 2024 13:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 755E4B21BAD
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Jul 2024 11:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A520317A926;
	Fri, 26 Jul 2024 11:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iSJ1Elfe"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DA436D;
	Fri, 26 Jul 2024 11:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721994959; cv=none; b=FcF/hosqVKA9gpF+GC1ovdDWk8U2ufsMYASVdiXyArLHaZnJU//NyjEOSrtCkg6yrAVwR2BehIabSDh5Ru49s3hY/e8P5gH4PuUEVtJShCuxYp3JfwReYQmBe/uTZxBf67U8BqwJPiW4nChKTS9d6KvfvmnQJ7i6kyUF6a/JYJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721994959; c=relaxed/simple;
	bh=LxJyFpy2Vd55m1XjGr5Bnk3WOJ0YlbAyn9P1cJr+FyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcPCHjVeG88VfnPWo4My6w0I5ACuK3n8D30hUVgBc9ny/uAzQvgvUdXk6nbFcSwk0F9KxgZFz0U4kJJTGRdggohyILOuh1iTK40E8cmpw2ZnIneafy4J/wlD4uHi70Nx3gK+iMZUKUZelHy3ORJ6by6+xuieokTJAoLfUp/rASM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iSJ1Elfe; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46QAnilW002229;
	Fri, 26 Jul 2024 11:55:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=36TlYcUNpE5WbV1wHmFqQ6fpemO
	PzThdqCiXNOj1cMg=; b=iSJ1Elfeq+iCunDocBTih1rLjOD7ssiex4+UtOrptXG
	RYnta7ImA/C41bF/d4h2M7pyvZ74SJkpdm+WJ03JCKIGqiGpvU8IqIcgGz+nbYnb
	pjhneFhH0QYpRpoUH/nG4UzjYuhlKI6NJHcO5Gnh6ZCCX1S5PPf7R5oszfAU/OUs
	KeTSYtok3HpuooG/s3NawKHpXxyvnyyh76Z7ARkmH2CTPmKFUMlLoSD3DIZDr3rn
	V/sf1uk+dYqHJ6z4BdpJWPvBfXa1HdL7OY9Zs8r8CPO8aVXd+EV+BS4R2f/JSQAO
	MGPoEVR7inP/PgW7VrAEJx61HYKZdFZY0mFMV0wphqQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40m58c8vsm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 11:55:34 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46QBtXVr015892;
	Fri, 26 Jul 2024 11:55:33 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40m58c8vrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 11:55:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46QAuTXw005870;
	Fri, 26 Jul 2024 11:53:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40gy2ptrny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 11:53:17 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46QBrDrE20185436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jul 2024 11:53:15 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7DEE2005A;
	Fri, 26 Jul 2024 11:53:13 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E791520043;
	Fri, 26 Jul 2024 11:53:10 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.195.39.192])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 26 Jul 2024 11:53:10 +0000 (GMT)
Date: Fri, 26 Jul 2024 17:23:08 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 04/20] ext4: add new ext4_ext_path_brelse() helper
Message-ID: <ZqOOJPTgMc0UBZ2M@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-5-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710040654.1714672-5-libaokun@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QqosKd6lPLIcolhD3-VPl83WjhEgL82O
X-Proofpoint-GUID: DapLPMzwnZSt2JCILIjHImUHdv-YJ2nM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-26_09,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 malwarescore=0 adultscore=0
 mlxlogscore=614 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407260079

On Wed, Jul 10, 2024 at 12:06:38PM +0800, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Add ext4_ext_path_brelse() helper function to reduce duplicate code
> and ensure that path->p_bh is set to NULL after it is released.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Hi Baokun,

The helper looks good, feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

> ---
>  fs/ext4/extents.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 657baf3991c1..6e5b5baf3aa6 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -106,6 +106,12 @@ static int ext4_ext_trunc_restart_fn(struct inode *inode, int *dropped)
>  	return 0;
>  }
>  
> +static inline void ext4_ext_path_brelse(struct ext4_ext_path *path)
> +{
> +	brelse(path->p_bh);
> +	path->p_bh = NULL;
> +}
> +
>  static void ext4_ext_drop_refs(struct ext4_ext_path *path)
>  {
>  	int depth, i;
> @@ -113,10 +119,8 @@ static void ext4_ext_drop_refs(struct ext4_ext_path *path)
>  	if (!path)
>  		return;
>  	depth = path->p_depth;
> -	for (i = 0; i <= depth; i++, path++) {
> -		brelse(path->p_bh);
> -		path->p_bh = NULL;
> -	}
> +	for (i = 0; i <= depth; i++, path++)
> +		ext4_ext_path_brelse(path);
>  }
>  
>  void ext4_free_ext_path(struct ext4_ext_path *path)
> @@ -635,8 +639,7 @@ int ext4_ext_precache(struct inode *inode)
>  		 */
>  		if ((i == depth) ||
>  		    path[i].p_idx > EXT_LAST_INDEX(path[i].p_hdr)) {
> -			brelse(path[i].p_bh);
> -			path[i].p_bh = NULL;
> +			ext4_ext_path_brelse(path + i);
>  			i--;
>  			continue;
>  		}
> @@ -1887,8 +1890,7 @@ static void ext4_ext_try_to_merge_up(handle_t *handle,
>  		(path[1].p_ext - EXT_FIRST_EXTENT(path[1].p_hdr));
>  	path[0].p_hdr->eh_max = cpu_to_le16(max_root);
>  
> -	brelse(path[1].p_bh);
> -	path[1].p_bh = NULL;
> +	ext4_ext_path_brelse(path + 1);
>  	ext4_free_blocks(handle, inode, NULL, blk, 1,
>  			 EXT4_FREE_BLOCKS_METADATA | EXT4_FREE_BLOCKS_FORGET);
>  }
> @@ -2956,8 +2958,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
>  			err = ext4_ext_rm_leaf(handle, inode, path,
>  					       &partial, start, end);
>  			/* root level has p_bh == NULL, brelse() eats this */
> -			brelse(path[i].p_bh);
> -			path[i].p_bh = NULL;
> +			ext4_ext_path_brelse(path + i);
>  			i--;
>  			continue;
>  		}
> @@ -3019,8 +3020,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
>  				err = ext4_ext_rm_idx(handle, inode, path, i);
>  			}
>  			/* root level has p_bh == NULL, brelse() eats this */
> -			brelse(path[i].p_bh);
> -			path[i].p_bh = NULL;
> +			ext4_ext_path_brelse(path + i);
>  			i--;
>  			ext_debug(inode, "return to level %d\n", i);
>  		}
> -- 
> 2.39.2
> 

