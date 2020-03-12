Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2714182CAF
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Mar 2020 10:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgCLJrx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Mar 2020 05:47:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50764 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725268AbgCLJrw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 12 Mar 2020 05:47:52 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02C9kli1106141
        for <linux-ext4@vger.kernel.org>; Thu, 12 Mar 2020 05:47:51 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yqjjmgk46-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Thu, 12 Mar 2020 05:47:50 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Thu, 12 Mar 2020 09:46:57 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 12 Mar 2020 09:46:54 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02C9krlL36110674
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 09:46:53 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D2B7A4054;
        Thu, 12 Mar 2020 09:46:53 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51748A405C;
        Thu, 12 Mar 2020 09:46:52 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.51.79])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 Mar 2020 09:46:52 +0000 (GMT)
Subject: Re: [PATCH] ext4: clean up ext4_ext_insert_extent() call in
 ext4_ext_map_blocks()
To:     Eric Whitney <enwlinux@gmail.com>, linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu
References: <20200311205033.25013-1-enwlinux@gmail.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Thu, 12 Mar 2020 15:16:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200311205033.25013-1-enwlinux@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20031209-0020-0000-0000-000003B32A08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031209-0021-0000-0000-0000220B7D96
Message-Id: <20200312094652.51748A405C@b06wcsmtp001.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-12_01:2020-03-11,2020-03-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 suspectscore=2 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 mlxscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003120052
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 3/12/20 2:20 AM, Eric Whitney wrote:
> Now that the eofblocks code has been removed, we don't need to assign
> 0 to err before calling ext4_ext_insert_extent() since it will assign
> a return value to ret anyway.  The variable free_on_err can be
> eliminated and replaced by a reference to allocated_clusters which
> clearly conveys the idea that newly allocated blocks should be freed
> when recovering from an extent insertion failure.  The error handling
> code itself should be restructured so that it errors out immediately on
> an insertion failure in the case where no new blocks have been allocated
> (bigalloc) rather than proceeding further into the mapping code.  The

Agreed.

> initializer for fb_flags can also be rearranged for improved
> readability.  Finally, insert a missing space in nearby code.
> 
> No known bugs are addressed by this patch - it's simply a cleanup.
> 
> Signed-off-by: Eric Whitney <enwlinux@gmail.com>


Nice cleanup.

Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>


> ---
>   fs/ext4/extents.c | 30 +++++++++++++++++-------------
>   1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index bc96529d1509..c2743d024c11 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4176,7 +4176,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>   	struct ext4_extent newex, *ex, *ex2;
>   	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>   	ext4_fsblk_t newblock = 0;
> -	int free_on_err = 0, err = 0, depth, ret;
> +	int err = 0, depth, ret;
>   	unsigned int allocated = 0, offset = 0;
>   	unsigned int allocated_clusters = 0;
>   	struct ext4_allocation_request ar;
> @@ -4374,7 +4374,6 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>   		goto out2;
>   	ext_debug("allocate new block: goal %llu, found %llu/%u\n",
>   		  ar.goal, newblock, allocated);
> -	free_on_err = 1;
>   	allocated_clusters = ar.len;
>   	ar.len = EXT4_C2B(sbi, ar.len) - offset;
>   	if (ar.len > allocated)
> @@ -4385,23 +4384,28 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>   	ext4_ext_store_pblock(&newex, newblock + offset);
>   	newex.ee_len = cpu_to_le16(ar.len);
>   	/* Mark unwritten */
> -	if (flags & EXT4_GET_BLOCKS_UNWRIT_EXT){
> +	if (flags & EXT4_GET_BLOCKS_UNWRIT_EXT) {
>   		ext4_ext_mark_unwritten(&newex);
>   		map->m_flags |= EXT4_MAP_UNWRITTEN;
>   	}
> 
> -	err = 0;
>   	err = ext4_ext_insert_extent(handle, inode, &path, &newex, flags);
> +	if (err) {
> +		if (allocated_clusters) {
> +			int fb_flags = 0;
> 
> -	if (err && free_on_err) {
> -		int fb_flags = flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE ?
> -			EXT4_FREE_BLOCKS_NO_QUOT_UPDATE : 0;
> -		/* free data blocks we just allocated */
> -		/* not a good idea to call discard here directly,
> -		 * but otherwise we'd need to call it every free() */
> -		ext4_discard_preallocations(inode);
> -		ext4_free_blocks(handle, inode, NULL, newblock,
> -				 EXT4_C2B(sbi, allocated_clusters), fb_flags);
> +			/*
> +			 * free data blocks we just allocated.
> +			 * not a good idea to call discard here directly,
> +			 * but otherwise we'd need to call it every free().
> +			 */
> +			ext4_discard_preallocations(inode);
> +			if (flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE)
> +				fb_flags = EXT4_FREE_BLOCKS_NO_QUOT_UPDATE;
> +			ext4_free_blocks(handle, inode, NULL, newblock,
> +					 EXT4_C2B(sbi, allocated_clusters),
> +					 fb_flags);
> +		}
>   		goto out2;
>   	}
> 

