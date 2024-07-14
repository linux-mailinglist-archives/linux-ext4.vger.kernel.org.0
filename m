Return-Path: <linux-ext4+bounces-3248-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F95D930A97
	for <lists+linux-ext4@lfdr.de>; Sun, 14 Jul 2024 17:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D8D12815FC
	for <lists+linux-ext4@lfdr.de>; Sun, 14 Jul 2024 15:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829DB13A24D;
	Sun, 14 Jul 2024 15:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g73k5O4i"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D0D2F5B;
	Sun, 14 Jul 2024 15:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720971794; cv=none; b=mtnqN36GMlYgOsqYFrV6luQ/ZOQD9JDmx446VXNO6gjotUpVflDf8csaaHKdAz4Gc2DRUyGG2B9GbRDs42S2iwt7M5HKyLe29VPQ5BcqyfN6h6z1ik/iKmlMhb2xXAEoJpo+AgiPDdq40VTJX38l/5jdWit4m7GDQBxDXQtrxrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720971794; c=relaxed/simple;
	bh=SQJW5P0GPkintEkiAMlbC9eV8l5hSl14NQoqc3L53IE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NdBz5Ws8IZTofy0QI9niTz8tBXs42PrTGqqaab467OzhmlUsezyS1VAawqx87KsI7f8OGmRdKUJCehN9ev2WfqzqM4MH+pR8CdJO4r5/oV7iuNQo2TGSCqvCdux0UHjldqyf62KA2DY+bZK/2Utnpd4IEYC6hGxhLZpL4IROGSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g73k5O4i; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46EEMV1X004212;
	Sun, 14 Jul 2024 15:42:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=pp1; bh=nRgxtlyB9Ner+0S4uTaQj+6xzH0
	xbYJ6PBZ/6JO7oHs=; b=g73k5O4ifeTkpH6/sdXnRi9Vulp+4nyClzRPXhDaaaI
	MoRnM9jl5fOL1AagPbHByc0SMD0IYyjzDUWDcQGdbLhxpsDTuwMyBvzikacUgXyO
	q9jt7R6T3wfrOTKxL35QyP4FX1C/But88/JGHb1tYm1fEcT+MDiku0JHhNkK6O+6
	4yJ7VCKlOIXnnuUGxIS7y9DRzFwc0aNQ9nYutlzR3UjmTCyeuWgppRKgylQerh9L
	5MwVSDxIWQLThIDQ9x7nqTxFTEI4Vo5lMBrWTajpnmZ5aURuCNXJGe3K6H7RvvFJ
	m9BcmAhdvnJY1SGbfSUVgP/or9xXZfz6czvjeDay54Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40caah8hck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jul 2024 15:42:39 +0000 (GMT)
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46EFgd0U013816;
	Sun, 14 Jul 2024 15:42:39 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40caah8hcg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jul 2024 15:42:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46EEkAIg030534;
	Sun, 14 Jul 2024 15:42:38 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40c4a0aru1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jul 2024 15:42:38 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46EFgYv535324406
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 14 Jul 2024 15:42:36 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2EB7020049;
	Sun, 14 Jul 2024 15:42:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A97920040;
	Sun, 14 Jul 2024 15:42:31 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.195.45.184])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 14 Jul 2024 15:42:30 +0000 (GMT)
Date: Sun, 14 Jul 2024 21:12:22 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        Baokun Li <libaokun1@huawei.com>,
        zhanchengbin <zhanchengbin1@huawei.com>
Subject: Re: [PATCH 02/20] ext4: prevent partial update of the extents path
Message-ID: <ZpPx3kuO36lp9/Um@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-3-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710040654.1714672-3-libaokun@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0irJqy7XKq69TP_sMbrcHOk-Qk-piu3X
X-Proofpoint-GUID: 91GdRSqFpBMDlp0UhCOZ9Sl5lWcrWfm7
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-14_11,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxlogscore=846 clxscore=1011 priorityscore=1501 adultscore=0
 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407140122

On Wed, Jul 10, 2024 at 12:06:36PM +0800, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> In ext4_ext_rm_idx() and ext4_ext_correct_indexes(), there is no proper
> rollback of already executed updates when updating a level of the extents
> path fails, so we may get an inconsistent extents tree, which may trigger
> some bad things in errors=continue mode.
> 
> Hence clear the verified bit of modified extents buffers if the tree fails
> to be updated in ext4_ext_rm_idx() or ext4_ext_correct_indexes(), which
> forces the extents buffers to be checked in ext4_valid_extent_entries(),
> ensuring that the extents tree is consistent.
> 
> Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
> Link: https://lore.kernel.org/r/20230213080514.535568-3-zhanchengbin1@huawei.com/
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  fs/ext4/extents.c | 31 +++++++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index bff3666c891a..4d589d34b30e 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -1749,12 +1749,23 @@ static int ext4_ext_correct_indexes(handle_t *handle, struct inode *inode,
>       break;
>     err = ext4_ext_get_access(handle, inode, path + k);
>     if (err)
> -     break;
> +     goto clean;
>     path[k].p_idx->ei_block = border;
>     err = ext4_ext_dirty(handle, inode, path + k);
>     if (err)
> -     break;
> +     goto clean;
>   }
> + return 0;
> +
> +clean:
> + /*
> +  * The path[k].p_bh is either unmodified or with no verified bit
> +  * set (see ext4_ext_get_access()). So just clear the verified bit
> +  * of the successfully modified extents buffers, which will force
> +  * these extents to be checked to avoid using inconsistent data.
> +  */
> + while (++k < depth)
> +   clear_buffer_verified(path[k].p_bh);
>  
>   return err;
>  }
> @@ -2312,12 +2323,24 @@ static int ext4_ext_rm_idx(handle_t *handle, struct inode *inode,
>       break;
>     err = ext4_ext_get_access(handle, inode, path + k);
>     if (err)
> -     break;
> +     goto clean;
>     path[k].p_idx->ei_block = path[k + 1].p_idx->ei_block;
>     err = ext4_ext_dirty(handle, inode, path + k);
>     if (err)
> -     break;
> +     goto clean;
>   }
> + return 0;
> +
> +clean:
> + /*
> +  * The path[k].p_bh is either unmodified or with no verified bit
> +  * set (see ext4_ext_get_access()). So just clear the verified bit
> +  * of the successfully modified extents buffers, which will force
> +  * these extents to be checked to avoid using inconsistent data.
> +  */
> + while (++k < depth)
> +   clear_buffer_verified(path[k].p_bh);
> +
>   return err;
>  }

Hi Baokun,

So I wanted to understand the extent handling paths for a whil and thought this
patchset was a good chance to finally take sometime and do that.

I do have a question based on my understanding of this extent deletion code:

So IIUC, ext4_find_extent() will return a path where buffer of each node is
verified (via bh = read_extent_tree_block()). So imagine we have the following
path (d=depth, blk=idx.ei_block, v=verified, nv=not-verified):

+------+     +------+     +------+     +------+     +------+
|d=0   |     |d=1   |     |d=2   |     |d=3   |     |      |
|blk=1 | --> |blk=1 | --> |blk=1 | --> |blk=1 | --> |pblk=1|
|(v)   |     |(v)   |     |(v)   |     |(v)   |     |      |
+------+     +------+     +------+     +------+     +------+
                                       |d=3   |     +------+
                                       |blk=2 | --> |      |
                                       |(v)   |     |pblk=2|
                                       +------+     |      |
                                                    +------+

Here, the the last column are the leaf nodes with only 1 extent in them.  Now,
say we want to punch the leaf having pblk=1. We'll eventually call
ext4_ext_rm_leaf() -> ext4_ext_rm_idx() to remove the index at depth = 3 and
try fixin up the indices in path with ei_block = 2

Suppose we error out at depth == 1. After the cleanup (introduced in this
patch), we'll mark depth = 1 to 4 as non verified:

+------+     +------+     +------+     +------+     +------+
|d=0   |     |d=1   |     |d=2   |     |d=3   |     |      |
|blk=1 | --> |blk=1 | --> |blk=2 | --> |blk=2 | --> |pblk=2|
|(v)   |     |(nv)  |     |(nv)  |     |(nv)  |     |(nv)  |
+------+     +------+     +------+     +------+     +------+

And we return and we won't actually mark the FS corrupt until we try to check
the bh at depth = 1 above. In this case, the first node is still pointing to
wrong ei_block but is marked valid. Aren't we silently leaving the tree in an
inconsistent state which might lead to corrupted lookups until we actually
touch the affected bh and realise that there's a corruption.

Am I missing some codepath here? Should we maybe try to clear_valid for the
whole tree?

(I hope the formatting of diagram comes out correct :) )

Regards,
ojaswin

>  
> -- 
> 2.39.2
> 

