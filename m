Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC204E1EEC
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Mar 2022 02:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344112AbiCUCAl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 20 Mar 2022 22:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238328AbiCUCAk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 20 Mar 2022 22:00:40 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A5512621
        for <linux-ext4@vger.kernel.org>; Sun, 20 Mar 2022 18:59:15 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KMHnK3FCWzfZ35;
        Mon, 21 Mar 2022 09:57:41 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Mar 2022 09:59:13 +0800
Received: from [127.0.0.1] (10.174.177.249) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 21 Mar
 2022 09:59:12 +0800
Subject: Re: [PATCH] e2fsck: subtract acl blocks when setting i_file_acl to
 zero
To:     Li Jinlin <lijinlin3@huawei.com>, <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, <linfeilong@huawei.com>
References: <20220317172943.2426272-1-lijinlin3@huawei.com>
 <8e8f277d-6222-5f63-0dcb-a17771a0deff@huawei.com>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <ed518b11-3c38-1c1f-a75d-3293c91f17d4@huawei.com>
Date:   Mon, 21 Mar 2022 09:59:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <8e8f277d-6222-5f63-0dcb-a17771a0deff@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.249]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

For truncating orphaned inode, we should not remove its ACL in release_inode_blocks(),
otherwise it may cause safety problems due to loss of acl.

diff --git a/e2fsck/super.c b/e2fsck/super.c
index 31e2ffb..6249e12 100644
--- a/e2fsck/super.c
+++ b/e2fsck/super.c
@@ -236,6 +236,10 @@ static int release_inode_blocks(e2fsck_t ctx, ext2_ino_t ino,
         ext2fs_iblk_sub_blocks(fs, EXT2_INODE(inode),
                 pb.truncated_blocks);

+    /* do not clean up file acl if the inode is truncating type */
+    if (inode->i_links_count)
+        return 0;
+
     blk = ext2fs_file_acl_block(fs, EXT2_INODE(inode));
     if (blk) {
         retval = ext2fs_adjust_ea_refcount3(fs, blk, block_buf, -1,
-- 
2.27.0

On 2022/3/18 0:54, Li Jinlin wrote:
> We got issue as follows:
>     [root@localhost ~]# e2fsck -a img
>     img: recovering journal
>     img: Truncating orphaned inode 188 (uid=0, gid=0, mode=0100666, size=0)
>     img: Truncating orphaned inode 174 (uid=0, gid=0, mode=0100666, size=0)
>     img: clean, 484/128016 files, 118274/512000 blocks
>     [root@localhost ~]# e2fsck -fn img
>     e2fsck 1.46.5 (30-Dec-2021)
>     Pass 1: Checking inodes, blocks, and sizes
>     Inode 174, i_blocks is 2, should be 0.  Fix? no
>     
>     Inode 188, i_blocks is 2, should be 0.  Fix? no
>     
>     Pass 2: Checking directory structure
>     Pass 3: Checking directory connectivity
>     Pass 4: Checking reference counts
>     Pass 5: Checking group summary information
>     
>     img: ********** WARNING: Filesystem still has errors **********
>     
>     img: 484/128016 files (24.6% non-contiguous), 118274/512000 blocks
> 
> 
> File ACL would be set to zero in release_inode_blocks(), but the
> blocks count will not be subtract acl blocks, which causes this issue.
> 
> To slove this issue, subtract acl blocks when setting i_file_acl to
> zero. 
> 
> Signed-off-by: LiJinlin <lijinlin3@huawei.com>
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> ---
>  e2fsck/super.c        |  7 +++++--
>  lib/ext2fs/ext2fs.h   |  5 +++++
>  lib/ext2fs/ext_attr.c | 15 +++++++++++++--
>  3 files changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/e2fsck/super.c b/e2fsck/super.c
> index 9495e029..715a8dc9 100644
> --- a/e2fsck/super.c
> +++ b/e2fsck/super.c
> @@ -194,6 +194,7 @@ static int release_inode_blocks(e2fsck_t ctx, ext2_ino_t ino,
>  	blk64_t				blk;
>  	errcode_t			retval;
>  	__u32				count;
> +	__u32				blocks;
>  
>  	if (!ext2fs_inode_has_valid_blocks2(fs, EXT2_INODE(inode)))
>  		return 0;
> @@ -238,8 +239,10 @@ static int release_inode_blocks(e2fsck_t ctx, ext2_ino_t ino,
>  
>  	blk = ext2fs_file_acl_block(fs, EXT2_INODE(inode));
>  	if (blk) {
> -		retval = ext2fs_adjust_ea_refcount3(fs, blk, block_buf, -1,
> -				&count, ino);
> +		retval = ext2fs_adjust_ea_refcount4(fs, blk, block_buf, -1,
> +				&count, ino, &blocks);
> +		if (retval == 0)
> +			ext2fs_iblk_sub_blocks(fs, EXT2_INODE(inode), blocks);
>  		if (retval == EXT2_ET_BAD_EA_BLOCK_NUM) {
>  			retval = 0;
>  			count = 1;
> diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
> index 68f9c1fe..8ebebf31 100644
> --- a/lib/ext2fs/ext2fs.h
> +++ b/lib/ext2fs/ext2fs.h
> @@ -1289,6 +1289,11 @@ extern errcode_t ext2fs_adjust_ea_refcount3(ext2_filsys fs, blk64_t blk,
>  					   char *block_buf,
>  					   int adjust, __u32 *newcount,
>  					   ext2_ino_t inum);
> +extern errcode_t ext2fs_adjust_ea_refcount4(ext2_filsys fs, blk64_t blk,
> +					   char *block_buf,
> +					   int adjust, __u32 *newcount,
> +					   ext2_ino_t inum,
> +					   __u32 *blocks);
>  errcode_t ext2fs_xattrs_write(struct ext2_xattr_handle *handle);
>  errcode_t ext2fs_xattrs_read(struct ext2_xattr_handle *handle);
>  errcode_t ext2fs_xattrs_read_inode(struct ext2_xattr_handle *handle,
> diff --git a/lib/ext2fs/ext_attr.c b/lib/ext2fs/ext_attr.c
> index d36fe68d..1538a53a 100644
> --- a/lib/ext2fs/ext_attr.c
> +++ b/lib/ext2fs/ext_attr.c
> @@ -237,9 +237,10 @@ errcode_t ext2fs_write_ext_attr(ext2_filsys fs, blk_t block, void *inbuf)
>  /*
>   * This function adjusts the reference count of the EA block.
>   */
> -errcode_t ext2fs_adjust_ea_refcount3(ext2_filsys fs, blk64_t blk,
> +errcode_t ext2fs_adjust_ea_refcount4(ext2_filsys fs, blk64_t blk,
>  				    char *block_buf, int adjust,
> -				    __u32 *newcount, ext2_ino_t inum)
> +				    __u32 *newcount, ext2_ino_t inum,
> +				    __u32 *blocks)
>  {
>  	errcode_t	retval;
>  	struct ext2_ext_attr_header *header;
> @@ -264,6 +265,8 @@ errcode_t ext2fs_adjust_ea_refcount3(ext2_filsys fs, blk64_t blk,
>  	header->h_refcount += adjust;
>  	if (newcount)
>  		*newcount = header->h_refcount;
> +	if (blocks)
> +		*blocks = header->h_blocks;
>  
>  	retval = ext2fs_write_ext_attr3(fs, blk, block_buf, inum);
>  	if (retval)
> @@ -275,6 +278,14 @@ errout:
>  	return retval;
>  }
>  
> +errcode_t ext2fs_adjust_ea_refcount3(ext2_filsys fs, blk64_t blk,
> +				    char *block_buf, int adjust,
> +				    __u32 *newcount, ext2_ino_t inum)
> +{
> +	return ext2fs_adjust_ea_refcount4(fs, blk, block_buf, adjust,
> +					  newcount, 0, NULL);
> +}
> +
>  errcode_t ext2fs_adjust_ea_refcount2(ext2_filsys fs, blk64_t blk,
>  				    char *block_buf, int adjust,
>  				    __u32 *newcount)
> 

