Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2344D1CF361
	for <lists+linux-ext4@lfdr.de>; Tue, 12 May 2020 13:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbgELLdD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 May 2020 07:33:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16362 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726187AbgELLdD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 12 May 2020 07:33:03 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04CBX0FZ114575;
        Tue, 12 May 2020 07:33:00 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30ws2f8d2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 May 2020 07:33:00 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04CBOfnx062260;
        Tue, 12 May 2020 07:32:19 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30ws2f8d21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 May 2020 07:32:19 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04CBPMta005751;
        Tue, 12 May 2020 11:32:17 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 30wm55pbn8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 May 2020 11:32:17 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04CBWFd856557718
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 May 2020 11:32:15 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 007954C04A;
        Tue, 12 May 2020 11:32:15 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 309FC4C046;
        Tue, 12 May 2020 11:32:14 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.79.181.98])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 May 2020 11:32:13 +0000 (GMT)
Subject: Re: [PATCH] ext4: rework map struct instantiation in
 ext4_ext_map_blocks()
To:     Eric Whitney <enwlinux@gmail.com>, linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu
References: <20200510155805.18808-1-enwlinux@gmail.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Tue, 12 May 2020 17:02:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200510155805.18808-1-enwlinux@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200512113214.309FC4C046@d06av22.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-12_03:2020-05-11,2020-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 clxscore=1015 impostorscore=0 adultscore=0
 phishscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005120082
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 5/10/20 9:28 PM, Eric Whitney wrote:
> The path performing block allocations in ext4_ext_map_blocks() contains
> code trimming the length of a new extent that is repeated later
> in the function.  This code is both redundant and unnecessary as the
> exact length of the new extent has already been calculated.  Rewrite the
> instantiation of the map struct in this case to use the available
> values, avoiding the overhead of unnecessary conversions and improving
> clarity.  Add another map struct instantiation tailored specifically to
> the separate case for an existing written extent.  Remove an old comment
> that no longer appears applicable to the current code.
> 
> Signed-off-by: Eric Whitney <enwlinux@gmail.com>

Yes, the previous code around looks to be confusing.

One thing which I also checked was that, when we insert this new
extent into the tree (via ext4_ext_insert_extent()) and even if this
extent could be merged with a nearby extent, the length or pblock of
this extent is not modified for the caller.
So again doing such below calculations (line 4250 - 4254) were redundant
and it's better that this patch got rid of it. This patch hence looks
logically correct to me.

4250         /* previous routine could use block we allocated */ 

4251         newblock = ext4_ext_pblock(&newex); 

4252         allocated = ext4_ext_get_actual_len(&newex); 
 
 

4253         if (allocated > map->m_len) 

4254                 allocated = map->m_len; 



Feel free to add:
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>


> ---
>   fs/ext4/extents.c | 50 +++++++++++++++++++++++------------------------
>   1 file changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index f2b577b315a0..c01a204ce60b 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4024,7 +4024,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>   	struct ext4_ext_path *path = NULL;
>   	struct ext4_extent newex, *ex, *ex2;
>   	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> -	ext4_fsblk_t newblock = 0;
> +	ext4_fsblk_t newblock = 0, pblk;
>   	int err = 0, depth, ret;
>   	unsigned int allocated = 0, offset = 0;
>   	unsigned int allocated_clusters = 0;
> @@ -4040,7 +4040,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>   	if (IS_ERR(path)) {
>   		err = PTR_ERR(path);
>   		path = NULL;
> -		goto out2;
> +		goto out;
>   	}
> 
>   	depth = ext_depth(inode);
> @@ -4056,7 +4056,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>   				 (unsigned long) map->m_lblk, depth,
>   				 path[depth].p_block);
>   		err = -EFSCORRUPTED;
> -		goto out2;
> +		goto out;
>   	}
> 
>   	ex = path[depth].p_ext;
> @@ -4090,8 +4090,14 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>   			    (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN)) {
>   				err = convert_initialized_extent(handle,
>   					inode, map, &path, &allocated);
> -				goto out2;
> +				goto out;
>   			} else if (!ext4_ext_is_unwritten(ex)) {
> +				map->m_flags |= EXT4_MAP_MAPPED;
> +				map->m_pblk = newblock;
> +				if (allocated > map->m_len)
> +					allocated = map->m_len;
> +				map->m_len = allocated;
> +				ext4_ext_show_leaf(inode, path);
>   				goto out;
>   			}
> 
> @@ -4102,7 +4108,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>   				err = ret;
>   			else
>   				allocated = ret;
> -			goto out2;
> +			goto out;
>   		}
>   	}
> 
> @@ -4127,7 +4133,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>   		map->m_pblk = 0;
>   		map->m_len = min_t(unsigned int, map->m_len, hole_len);
> 
> -		goto out2;
> +		goto out;
>   	}
> 
>   	/*
> @@ -4151,12 +4157,12 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>   	ar.lleft = map->m_lblk;
>   	err = ext4_ext_search_left(inode, path, &ar.lleft, &ar.pleft);
>   	if (err)
> -		goto out2;
> +		goto out;
>   	ar.lright = map->m_lblk;
>   	ex2 = NULL;
>   	err = ext4_ext_search_right(inode, path, &ar.lright, &ar.pright, &ex2);
>   	if (err)
> -		goto out2;
> +		goto out;
> 
>   	/* Check if the extent after searching to the right implies a
>   	 * cluster we can use. */
> @@ -4217,7 +4223,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>   		ar.flags |= EXT4_MB_USE_RESERVED;
>   	newblock = ext4_mb_new_blocks(handle, &ar, &err);
>   	if (!newblock)
> -		goto out2;
> +		goto out;
>   	ext_debug("allocate new block: goal %llu, found %llu/%u\n",
>   		  ar.goal, newblock, allocated);
>   	allocated_clusters = ar.len;
> @@ -4227,7 +4233,8 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
> 
>   got_allocated_blocks:
>   	/* try to insert new extent into found leaf and return */
> -	ext4_ext_store_pblock(&newex, newblock + offset);
> +	pblk = newblock + offset;
> +	ext4_ext_store_pblock(&newex, pblk);
>   	newex.ee_len = cpu_to_le16(ar.len);
>   	/* Mark unwritten */
>   	if (flags & EXT4_GET_BLOCKS_UNWRIT_EXT) {
> @@ -4252,16 +4259,9 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>   					 EXT4_C2B(sbi, allocated_clusters),
>   					 fb_flags);
>   		}
> -		goto out2;
> +		goto out;
>   	}
> 
> -	/* previous routine could use block we allocated */
> -	newblock = ext4_ext_pblock(&newex);
> -	allocated = ext4_ext_get_actual_len(&newex);
> -	if (allocated > map->m_len)
> -		allocated = map->m_len;
> -	map->m_flags |= EXT4_MAP_NEW;
> -
>   	/*
>   	 * Reduce the reserved cluster count to reflect successful deferred
>   	 * allocation of delayed allocated clusters or direct allocation of
> @@ -4307,14 +4307,14 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>   		ext4_update_inode_fsync_trans(handle, inode, 1);
>   	else
>   		ext4_update_inode_fsync_trans(handle, inode, 0);
> -out:
> -	if (allocated > map->m_len)
> -		allocated = map->m_len;
> +
> +	map->m_flags |= (EXT4_MAP_NEW | EXT4_MAP_MAPPED);
> +	map->m_pblk = pblk;
> +	map->m_len = ar.len;
> +	allocated = map->m_len;
>   	ext4_ext_show_leaf(inode, path);
> -	map->m_flags |= EXT4_MAP_MAPPED;
> -	map->m_pblk = newblock;
> -	map->m_len = allocated;
> -out2:
> +
> +out:
>   	ext4_ext_drop_refs(path);
>   	kfree(path);
> 
