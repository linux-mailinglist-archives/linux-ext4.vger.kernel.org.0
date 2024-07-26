Return-Path: <linux-ext4+bounces-3473-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABDB93D283
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Jul 2024 13:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F511B21D51
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Jul 2024 11:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B730178CEE;
	Fri, 26 Jul 2024 11:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sJefyCGt"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1C2E57E;
	Fri, 26 Jul 2024 11:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721994354; cv=none; b=sOiWzsytLybGcSm5P/8WVEIDEtCNbJ+e7LKl9SgKanvmv7UVqI76zvz3DUEg579aMr9wJAracOnocXNoelrxve52fHR+louBvaBBb5tb4tjf+qGtL8myPxwr+ZqQfequqzf8/2WVya22D7g2VPeeJUVIyxAm/tGIJwfEe1hMkcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721994354; c=relaxed/simple;
	bh=f1XWBUIolOUCVSiexTTD3WDQSs/rWJzHICGPQ+Hpzw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZpKQDmc7Pri14QD3gUm8p6Y7Xg3r69YjQaK2sQhg0KR0H9daWXwduO9FJNtlqPZrk4TZcI10l7W/rpfSyn4AyRN1ecWqyIjmueI3++nrzn9jGxjTjZm0K5Oyxf2nYaoCZdYB7e7dZDF6QA++Bw7toI6RdY7oKzSkWBm0LVTYmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sJefyCGt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46QBRSVG026865;
	Fri, 26 Jul 2024 11:45:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=Ef5/svIY3R9uRNnWiK+y5aQm4VD
	iqRXdZ6hHOEQamGU=; b=sJefyCGtxqhdDJSGNQq+ErzNw8IRU2hJS17vtcbIi1Z
	efBMovOF/e1lRujELWTrf8eun7mRg/cmtiyUb+iCxo1adBjcJM+//EXCybfqaY88
	1CfferFCbxd/ONhyq+WNbGoyl77+TBxG7ZC9EL09MLxmlWo1tFv6+fmPopS9UJ2L
	15vU/4edtDSwiVlKjpGvimQavyG5MOVarhX72gXSI8fcC4qfqcg948L/OgBV7J77
	4PIXWYBZmTEMNF8+DrHJwRISYcHhLZQDayZ1bBi65k4pp75n21Xio5Oaz8NfGzaq
	jTtawaU4oxnHklgzqOLszozZK1CbyQ1i5Xv3DztvNng==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40m2kv942s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 11:45:17 +0000 (GMT)
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46QBjHcd024630;
	Fri, 26 Jul 2024 11:45:17 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40m2kv942n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 11:45:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46QAXRXL009131;
	Fri, 26 Jul 2024 11:45:16 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40gt93upk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 11:45:16 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46QBjCJv53739776
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jul 2024 11:45:14 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 792D42004B;
	Fri, 26 Jul 2024 11:45:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25ECD20043;
	Fri, 26 Jul 2024 11:45:10 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.195.39.192])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 26 Jul 2024 11:45:09 +0000 (GMT)
Date: Fri, 26 Jul 2024 17:15:07 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        Baokun Li <libaokun1@huawei.com>, stable@kernel.org
Subject: Re: [PATCH 03/20] ext4: fix double brelse() the buffer of the
 extents path
Message-ID: <ZqOMQ6cIHd0hZqhY@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-4-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710040654.1714672-4-libaokun@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OBx4piRDeUaNN9irgZYn8GFJlYeKj_oT
X-Proofpoint-ORIG-GUID: Z0_GHF2dC9dEkREwX-IROVQ3vvprfsFR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-26_09,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 spamscore=0 malwarescore=0 mlxlogscore=564 mlxscore=0 priorityscore=1501
 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407260076

On Wed, Jul 10, 2024 at 12:06:37PM +0800, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> In ext4_ext_try_to_merge_up(), set path[1].p_bh to NULL after it has been
> released, otherwise it may be released twice.
> 
> An example of what triggers this is as follows:
> 
>   split2    map    split1
> |--------|-------|--------|
> 
> ext4_ext_map_blocks
>  ext4_ext_handle_unwritten_extents
>   ext4_split_convert_extents
>    // path->p_depth == 0
>    ext4_split_extent
>      // 1. do split1
>      ext4_split_extent_at
>        ext4_ext_insert_extent
>          ext4_ext_create_new_leaf
>            ext4_ext_grow_indepth
>              le16_add_cpu(&neh->eh_depth, 1)
>            ext4_find_extent
>              path->p_depth = 1
>          ext4_ext_try_to_merge
>            ext4_ext_try_to_merge_up
>              path->p_depth = 0
>              brelse(path[1].p_bh)  ---> not set to NULL here
>      // 2. update path
>      ext4_find_extent
>      // 3. do split2
>      ext4_split_extent_at
>        ext4_ext_insert_extent
>          ext4_ext_create_new_leaf
>            ext4_ext_grow_indepth
>              le16_add_cpu(&neh->eh_depth, 1)
>            ext4_find_extent
>              path[0].p_bh = NULL;
>              path->p_depth = 1
>              read_extent_tree_block  ---> return err
>              // path[1].p_bh is still the old value
>  ext4_free_ext_path
>   ext4_ext_drop_refs
>    // path->p_depth == 1
>    brelse(path[1].p_bh)  ---> brelse a buffer twice

Hi Baokun,

If i'm not wrong, in this trace, we'll enter ext4_ext_insert_extent() with
gb_flags having EXT4_GET_BLOCKS_PRE_IO so we won't actually go for a
merge_up. 

That being said, there seems to be a few places where we follow the
split-insert pattern and it might be possible that one of those call
sites might not be passing EXT4_GET_BLOCKS_PRE_IO and we'll the double
free issue you mentioned. I'll check and update if I see anything.

On a separate note, isn't it a bit weird that we grow the tree indepth
(which includes allocation, marking buffer dirty etc) only to later
merge it up again and throwing all the changes we did while growing the
tree. Surely we could optimize this particular case somehow right?

> 
> Finally got the following WARRNING when removing the buffer from lru:
> 
> ============================================
> VFS: brelse: Trying to free free buffer
> WARNING: CPU: 2 PID: 72 at fs/buffer.c:1241 __brelse+0x58/0x90
> CPU: 2 PID: 72 Comm: kworker/u19:1 Not tainted 6.9.0-dirty #716
> RIP: 0010:__brelse+0x58/0x90
> Call Trace:
>  <TASK>
>  __find_get_block+0x6e7/0x810
>  bdev_getblk+0x2b/0x480
>  __ext4_get_inode_loc+0x48a/0x1240
>  ext4_get_inode_loc+0xb2/0x150
>  ext4_reserve_inode_write+0xb7/0x230
>  __ext4_mark_inode_dirty+0x144/0x6a0
>  ext4_ext_insert_extent+0x9c8/0x3230
>  ext4_ext_map_blocks+0xf45/0x2dc0
>  ext4_map_blocks+0x724/0x1700
>  ext4_do_writepages+0x12d6/0x2a70
> [...]
> ============================================
> 
> Fixes: ecb94f5fdf4b ("ext4: collapse a single extent tree block into the inode if possible")
> Cc: stable@kernel.org
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  fs/ext4/extents.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 4d589d34b30e..657baf3991c1 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -1888,6 +1888,7 @@ static void ext4_ext_try_to_merge_up(handle_t *handle,
>  	path[0].p_hdr->eh_max = cpu_to_le16(max_root);
>  
>  	brelse(path[1].p_bh);
> +	path[1].p_bh = NULL;

Anyways, I agree that adding this here is the right thing to do:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Thanks,
Ojaswin

>  	ext4_free_blocks(handle, inode, NULL, blk, 1,
>  			 EXT4_FREE_BLOCKS_METADATA | EXT4_FREE_BLOCKS_FORGET);
>  }
> -- 
> 2.39.2
> 

