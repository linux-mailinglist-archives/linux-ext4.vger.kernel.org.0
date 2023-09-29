Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8ED97B380D
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Sep 2023 18:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbjI2QkQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 29 Sep 2023 12:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbjI2QkP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 29 Sep 2023 12:40:15 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343B7BE;
        Fri, 29 Sep 2023 09:40:13 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38TGBi3H010706;
        Fri, 29 Sep 2023 16:40:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=2kXjShDlpJr9RSoehL1cnhvrAsGX3mYCQYpUygq3BSk=;
 b=EDwhddDcCNFHBiOGKkyDjaFoPp6a2YZuC2nhobcreh4mOSLtx2B/IfQrL4ad62VLHDof
 +RBJAOeeMAVE9xcYs1VOxtzuTvxDqkdphcKsr5hwts6xEEvA8azVCot113z2LALwXma4
 mI99ed76ASX8lIqf7h1UKePtIPpSl1B6QQzjYxAViMIYTp8fAxadXUPTS+V8WsQobDCP
 eDBvuISPsJwo3Cqw8T7kuoJl+32DxtoNsgw1btRScvJBEJzspiyPOJgc1VFgKcI+U4d3
 yKXyDBD52Hxlxv9ElyARtiyu7aFv94X/xV6XXPfhh2t9hSB4wvT8A5I+zKjC5XB7HVUu uQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tdyu3d9nc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 16:40:03 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38TGCZG0014704;
        Fri, 29 Sep 2023 16:40:02 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tdyu3d9bm-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 16:40:02 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38TE59rX030466;
        Fri, 29 Sep 2023 16:15:35 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tad22dc2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 16:15:35 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38TGFYd816908956
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 16:15:34 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 031D420043;
        Fri, 29 Sep 2023 16:15:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7555620040;
        Fri, 29 Sep 2023 16:15:32 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.64.208])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 29 Sep 2023 16:15:32 +0000 (GMT)
Date:   Fri, 29 Sep 2023 21:45:29 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <ritesh.list@gmail.com>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 2/3] ext4: truncate complete range in pagecache before
 calling ext4_zero_partial_blocks()
Message-ID: <ZRb4BX8bhhyWEari@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <cover.1695987265.git.ojaswin@linux.ibm.com>
 <f7aaea4a59bc1c69f87e178dae34c38d2bcfee12.1695987265.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7aaea4a59bc1c69f87e178dae34c38d2bcfee12.1695987265.git.ojaswin@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2qCvwhjt3LyslbnaaqYyMP4p_gDL8ieU
X-Proofpoint-GUID: HQkp_b2DlKuxs29qaeLkyv4bUqjMzxhd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_15,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0 impostorscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309290143
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Sep 29, 2023 at 07:40:44PM +0530, Ojaswin Mujoo wrote:
> In ext4_zero_range() and ext4_punch_hole(), the range passed could be unaligned
> however we only zero out the pagecache range that is block aligned. These
> functions are relying on ext4_zero_partial_blocks() ->
> __ext4_block_zero_page_range() to take care of zeroing the unaligned edges in
> the pageacache. However, the right thing to do is to properly zero out the whole
> range in these functions before and not rely on a different function to do it
> for us. Hence, modify ext4_zero_range() and ext4_punch_hole() to zero the
> complete range.
> 
> This will also allow us to now exit early for unwritten buffer heads in
> __ext4_block_zero_page_range(), in upcoming patch.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  fs/ext4/extents.c | 17 +++++++++++------
>  fs/ext4/inode.c   |  3 +--
>  2 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index c79b4c25afc4..2dc681cab6a5 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4582,9 +4582,6 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  
>  	/* Zero range excluding the unaligned edges */
>  	if (max_blocks > 0) {
> -		flags |= (EXT4_GET_BLOCKS_CONVERT_UNWRITTEN |
> -			  EXT4_EX_NOCACHE);
> -
>  		/*
>  		 * Prevent page faults from reinstantiating pages we have
>  		 * released from page cache.
> @@ -4609,17 +4606,25 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  		 * disk in case of crash before zeroing trans is committed.
>  		 */
>  		if (ext4_should_journal_data(inode)) {
> -			ret = filemap_write_and_wait_range(mapping, start, end - 1);
> +			ret = filemap_write_and_wait_range(mapping, start,
> +							   end - 1);

I think this accidentally creeped in, will fix it in next rev.

Anyways, I had some questions that might be unrelated to this patch,
I'll add them inline:

>  			if (ret) {
>  				filemap_invalidate_unlock(mapping);
>  				goto out_mutex;
>  			}
>  		}
> +	}

So the above if (max_blocks) {...} block runs when the range spans
multiple blocks but I think the filemap_write_and_wait_range() and
ext4_update_disksize_before_punch() should be called when we are actually
spanning multiple pages, since the disksize not updating issue and the 
truncate racing with checkpoint only happen when the complete page is
truncated. Is this understanding correct? 

> +
> +	/*
> +	 * Now truncate the pagecache and zero out non page aligned edges of the
> +	 * range (if any)
> +	 */
> +	truncate_pagecache_range(inode, offset, offset + len - 1);
>  
> -		/* Now release the pages and zero block aligned part of pages */
> -		truncate_pagecache_range(inode, start, end - 1);
> +	if (max_blocks > 0) {
>  		inode->i_mtime = inode->i_ctime = current_time(inode);
>  
> +		flags |= (EXT4_GET_BLOCKS_CONVERT_UNWRITTEN | EXT4_EX_NOCACHE);
>  		ret = ext4_alloc_file_blocks(file, lblk, max_blocks, new_size,
>  					     flags);
>  		filemap_invalidate_unlock(mapping);
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 6c490f05e2ba..de8ea8430d30 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3974,9 +3974,8 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  		ret = ext4_update_disksize_before_punch(inode, offset, length);

In this function ext4_punch_hole() I see that we call
filemap_write_and_wait_range() and then take the inode_lock() later.
Doesn't this leave a window for the pages to get dirty again? 

For example, in ext4_zero_range(), we checkpoint using
filemap_write_and_wait_range() in case of data=journal under
inode_lock() but that's not the case here. Just wondering if this 
or any other code path might still race here? 

Regards,
ojaswin

>  		if (ret)
>  			goto out_dio;
> -		truncate_pagecache_range(inode, first_block_offset,
> -					 last_block_offset);
>  	}
> +	truncate_pagecache_range(inode, offset, offset + length - 1);
>  
>  	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
>  		credits = ext4_writepage_trans_blocks(inode);
> -- 
> 2.39.3
> 
