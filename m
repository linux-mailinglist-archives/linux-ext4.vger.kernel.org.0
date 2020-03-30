Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 768731972FC
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Mar 2020 06:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgC3ERf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Mar 2020 00:17:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22962 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725268AbgC3ERf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 30 Mar 2020 00:17:35 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02U483FM011222
        for <linux-ext4@vger.kernel.org>; Mon, 30 Mar 2020 00:17:34 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3022nkw0d7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Mon, 30 Mar 2020 00:17:34 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Mon, 30 Mar 2020 05:17:21 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 30 Mar 2020 05:17:18 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02U4HS9c35848600
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Mar 2020 04:17:28 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2D1C5204F;
        Mon, 30 Mar 2020 04:17:27 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.43.173])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B25E852051;
        Mon, 30 Mar 2020 04:17:26 +0000 (GMT)
Subject: Re: [PATCH] ext4: Fix return-value types in several function
 documentation comments
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <60a3f4996f4932c45515aaa6b75ca42f2a78ec9b.1585512514.git.josh@joshtriplett.org>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Mon, 30 Mar 2020 09:47:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <60a3f4996f4932c45515aaa6b75ca42f2a78ec9b.1585512514.git.josh@joshtriplett.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20033004-0016-0000-0000-000002FAB630
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20033004-0017-0000-0000-0000335E6D85
Message-Id: <20200330041726.B25E852051@d06av21.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-29_10:2020-03-27,2020-03-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003300037
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 3/30/20 1:51 AM, Josh Triplett wrote:
> The documentation comments for ext4_read_block_bitmap_nowait and
> ext4_read_inode_bitmap describe them as returning NULL on error, but
> they return an ERR_PTR on error; update the documentation to match.
> 
> The documentation comment for ext4_wait_block_bitmap describes it as
> returning 1 on error, but it returns -errno on error; update the
> documentation to match.
> 
> Signed-off-by: Josh Triplett <josh@joshtriplett.org>

Thanks for your patch.
Reviewed-by: Ritesh Harani <riteshh@linux.ibm.com>


Just a note for next time:-
"Update the documentation to match" - could be misleading.
As 'Documentation' is generally referred as info inside Documentation/
directory in kernel. We could just say as-
"Update the function comment description"


> ---
>   fs/ext4/balloc.c | 4 ++--
>   fs/ext4/ialloc.c | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
> index 8fd0b3cdab4c..9a296008cf90 100644
> --- a/fs/ext4/balloc.c
> +++ b/fs/ext4/balloc.c
> @@ -410,7 +410,7 @@ static int ext4_validate_block_bitmap(struct super_block *sb,
>    * Read the bitmap for a given block_group,and validate the
>    * bits for block/inode/inode tables are set in the bitmaps
>    *
> - * Return buffer_head on success or NULL in case of failure.
> + * Return buffer_head on success or an ERR_PTR in case of failure.
>    */
>   struct buffer_head *
>   ext4_read_block_bitmap_nowait(struct super_block *sb, ext4_group_t block_group)
> @@ -502,7 +502,7 @@ ext4_read_block_bitmap_nowait(struct super_block *sb, ext4_group_t block_group)
>   	return ERR_PTR(err);
>   }
> 
> -/* Returns 0 on success, 1 on error */
> +/* Returns 0 on success, -errno on error */
>   int ext4_wait_block_bitmap(struct super_block *sb, ext4_group_t block_group,
>   			   struct buffer_head *bh)
>   {
> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
> index f95ee99091e4..86a96dca9ebf 100644
> --- a/fs/ext4/ialloc.c
> +++ b/fs/ext4/ialloc.c
> @@ -113,7 +113,7 @@ static int ext4_validate_inode_bitmap(struct super_block *sb,
>    * Read the inode allocation bitmap for a given block_group, reading
>    * into the specified slot in the superblock's bitmap cache.
>    *
> - * Return buffer_head of bitmap on success or NULL.
> + * Return buffer_head of bitmap on success, or an ERR_PTR on error.
>    */
>   static struct buffer_head *
>   ext4_read_inode_bitmap(struct super_block *sb, ext4_group_t block_group)
> 

