Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAC4A182D1E
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Mar 2020 11:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgCLKLT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Mar 2020 06:11:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34746 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726000AbgCLKLT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 12 Mar 2020 06:11:19 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02CAAgmT111720
        for <linux-ext4@vger.kernel.org>; Thu, 12 Mar 2020 06:11:18 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yqjj99c3k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Thu, 12 Mar 2020 06:11:17 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Thu, 12 Mar 2020 09:56:09 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 12 Mar 2020 09:56:06 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02C9u50452363438
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 09:56:05 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8559A405C;
        Thu, 12 Mar 2020 09:56:05 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 06F79A4060;
        Thu, 12 Mar 2020 09:56:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.51.79])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 Mar 2020 09:56:04 +0000 (GMT)
Subject: Re: [PATCH] ext4: remove map_from_cluster from ext4_ext_map_blocks
To:     Eric Whitney <enwlinux@gmail.com>, linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu
References: <20200311205125.25061-1-enwlinux@gmail.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Thu, 12 Mar 2020 15:26:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200311205125.25061-1-enwlinux@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20031209-0008-0000-0000-0000035C0220
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031209-0009-0000-0000-00004A7D4B49
Message-Id: <20200312095605.06F79A4060@b06wcsmtp001.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-12_01:2020-03-11,2020-03-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1015 mlxscore=0 impostorscore=0 adultscore=0 mlxlogscore=999
 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003120054
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 3/12/20 2:21 AM, Eric Whitney wrote:
> We can use the variable allocated_clusters rather than map_from_clusters
> to control reserved block/cluster accounting in ext4_ext_map_blocks.
> This eliminates a variable and associated code and improves readability
> a little.
> 
> Signed-off-by: Eric Whitney <enwlinux@gmail.com>

No objections there.

Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>


> ---
>   fs/ext4/extents.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index bc96529d1509..b12c9e52746c 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4181,7 +4181,6 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>   	unsigned int allocated_clusters = 0;
>   	struct ext4_allocation_request ar;
>   	ext4_lblk_t cluster_offset;
> -	bool map_from_cluster = false;
> 
>   	ext_debug("blocks %u/%u requested for inode %lu\n",
>   		  map->m_lblk, map->m_len, inode->i_ino);
> @@ -4296,7 +4295,6 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>   	    get_implied_cluster_alloc(inode->i_sb, map, ex, path)) {
>   		ar.len = allocated = map->m_len;
>   		newblock = map->m_pblk;
> -		map_from_cluster = true;
>   		goto got_allocated_blocks;
>   	}
> 
> @@ -4317,7 +4315,6 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>   	    get_implied_cluster_alloc(inode->i_sb, map, ex2, path)) {
>   		ar.len = allocated = map->m_len;
>   		newblock = map->m_pblk;
> -		map_from_cluster = true;
>   		goto got_allocated_blocks;
>   	}
> 
> @@ -4418,7 +4415,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>   	 * clusters discovered to be delayed allocated.  Once allocated, a
>   	 * cluster is not included in the reserved count.
>   	 */
> -	if (test_opt(inode->i_sb, DELALLOC) && !map_from_cluster) {
> +	if (test_opt(inode->i_sb, DELALLOC) && allocated_clusters) {
>   		if (flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE) {
>   			/*
>   			 * When allocating delayed allocated clusters, simply
> 

