Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE711DDEA8
	for <lists+linux-ext4@lfdr.de>; Fri, 22 May 2020 06:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgEVEPq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 May 2020 00:15:46 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:52521 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725956AbgEVEPp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 22 May 2020 00:15:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TzF92eq_1590120939;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0TzF92eq_1590120939)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 22 May 2020 12:15:40 +0800
Subject: Re: [PATCH RFC] ext4: fix partial cluster initialization when
 splitting extent
From:   JeffleXu <jefflexu@linux.alibaba.com>
To:     tytso@mit.edu, enwlinux@gmail.com
Cc:     linux-ext4@vger.kernel.org, joseph.qi@linux.alibaba.com
References: <1590120164-26949-1-git-send-email-jefflexu@linux.alibaba.com>
Message-ID: <56098e56-0388-d11c-b822-291b5c8f77da@linux.alibaba.com>
Date:   Fri, 22 May 2020 12:15:39 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1590120164-26949-1-git-send-email-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Sorry I forget to remove the "RFC" flag. Please ignore this patch and I will

resend another one later.


On 5/22/20 12:02 PM, Jeffle Xu wrote:
> Fix the bug when calculating the physical block number of the first
> block in the split extent.
>
> This bug will cause xfstests shared/298 failure on ext4 with bigalloc
> enabled occasionally. Ext4 error messages indicate that previously freed
> blocks are being freed again, and the following fsck will fail due to
> the inconsistency of block bitmap and bg descriptor.
>
> The following is an example case:
>
> 1. First, Initialize a ext4 filesystem with cluster size '16K', block size
> '4K', in which case, one cluster contains four blocks.
>
> 2. Create one file (e.g., xxx.img) on this ext4 filesystem. Now the extent
> tree of this file is like:
>
> ...
> 36864:[0]4:220160
> 36868:[0]14332:145408
> 51200:[0]2:231424
> ...
>
> 3. Then execute PUNCH_HOLE fallocate on this file. The hole range is
> like:
>
> ..
> ext4_ext_remove_space: dev 254,16 ino 12 since 49506 end 49506 depth 1
> ext4_ext_remove_space: dev 254,16 ino 12 since 49544 end 49546 depth 1
> ext4_ext_remove_space: dev 254,16 ino 12 since 49605 end 49607 depth 1
> ...
>
> 4. Then the extent tree of this file after punching is like
>
> ...
> 49507:[0]37:158047
> 49547:[0]58:158087
> ...
>
> 5. Detailed procedure of punching hole [49544, 49546]
>
> 5.1. The block address space:
> ```
> lblk        ~49505  49506   49507~49543     49544~49546    49547~
> 	  ---------+------+-------------+----------------+--------
> 	    extent | hole |   extent	|	hole	 | extent
> 	  ---------+------+-------------+----------------+--------
> pblk       ~158045  158046  158047~158083  158084~158086   158087~
> ```
>
> 5.2. The detailed layout of cluster 39521:
> ```
> 		cluster 39521
> 	<------------------------------->
>
> 		hole		  extent
> 	<----------------------><--------
>
> lblk      49544   49545   49546   49547
> 	+-------+-------+-------+-------+
> 	|	|	|	|	|
> 	+-------+-------+-------+-------+
> pblk     158084  1580845  158086  158087
> ```
>
> 5.3. The ftrace output when punching hole [49544, 49546]:
> - ext4_ext_remove_space (start 49544, end 49546)
>    - ext4_ext_rm_leaf (start 49544, end 49546, last_extent [49507(158047), 40], partial [pclu 39522 lblk 0 state 2])
>      - ext4_remove_blocks (extent [49507(158047), 40], from 49544 to 49546, partial [pclu 39522 lblk 0 state 2]
>        - ext4_free_blocks: (block 158084 count 4)
>          - ext4_mballoc_free (extent 1/6753/1)
>
> 5.4. Ext4 error message in dmesg:
> EXT4-fs error (device vdb): mb_free_blocks:1457: group 1, block 158084:freeing already freed block (bit 6753); block bitmap corrupt.
> EXT4-fs error (device vdb): ext4_mb_generate_buddy:747: group 1, block bitmap and bg descriptor inconsistent: 19550 vs 19551 free clusters
>
>
> In this case, the whole cluster 39521 is freed mistakenly when freeing
> pblock 158084~158086 (i.e., the first three blocks of this cluster),
> although pblock 158087 (the last remaining block of this cluster) has
> not been freed yet.
>
> The root cause of this isuue is that, the pclu of the partial cluster is
> calculated mistakenly in ext4_ext_remove_space(). The correct
> partial_cluster.pclu (i.e., the cluster number of the first block in the
> next extent, that is, lblock 49597 (pblock 158086)) should be 39521 rather
> than 39522.
>
> Fixes: f4226d9ea400 ("ext4: fix partial cluster initialization")
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> Reviewed-by: Eric Whitney <enwlinux@gmail.com>
> Cc: stable@kernel.org # v3.19+
> ---
>   fs/ext4/extents.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index f2b577b..cb74496 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -2828,7 +2828,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
>   			 * in use to avoid freeing it when removing blocks.
>   			 */
>   			if (sbi->s_cluster_ratio > 1) {
> -				pblk = ext4_ext_pblock(ex) + end - ee_block + 2;
> +				pblk = ext4_ext_pblock(ex) + end - ee_block + 1;
>   				partial.pclu = EXT4_B2C(sbi, pblk);
>   				partial.state = nofree;
>   			}
