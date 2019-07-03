Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62AE45DD1A
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jul 2019 05:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfGCDui (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 Jul 2019 23:50:38 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39528 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbfGCDui (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 2 Jul 2019 23:50:38 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x633mnrM116148;
        Wed, 3 Jul 2019 03:50:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=CutFAbon6Ut3LKoVJECdUIIYvq3UfjiV7KZy04JD+C4=;
 b=bG4+N720o6KBzw39sKD+OoxH98rwpQ+vxPES9ZQ4BdiuAIXBzkhI3NOoY9KNeY+aCvOT
 G4PKIwNs6iVMX//LHYfI4TbkhIITtIvv5Imz5Zw3Df4MQD2om7cXtgHH7xrly4WFqbaC
 jrJf2djy9xKFFuAjjWYxqhVE5uCeOmCtHzqYodaE9GspCembPNGTcB/uFb1EJM88Zpcd
 /eBADAAKclYz9labQlfHPC4BZDLVnQ7/7AfBEA4XmDV3e29OLl7gq32bMRzOjGF/D61B
 kYIoHA28NIQgEZwu7L3BJiziX1gk1CbznQULdWJB3KCSztW8fj398A39UcDn7pDInPgm dA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2te5tbpym0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Jul 2019 03:50:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x633m0Px071156;
        Wed, 3 Jul 2019 03:50:32 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2tebbk4eut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Jul 2019 03:50:32 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x633oWKx021094;
        Wed, 3 Jul 2019 03:50:32 GMT
Received: from localhost (/10.159.225.186)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Jul 2019 20:50:31 -0700
Date:   Tue, 2 Jul 2019 20:50:24 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 2/3] ext4: refactor initialize_dirent_tail()
Message-ID: <20190703035024.GB5161@magnolia>
References: <20190702212925.29989-1-tytso@mit.edu>
 <20190702212925.29989-2-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702212925.29989-2-tytso@mit.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9306 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907030046
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9306 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907030046
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jul 02, 2019 at 05:29:24PM -0400, Theodore Ts'o wrote:
> Move the calculation of the location of the dirent tail into
> initialize_dirent_tail().  Also prefix the function with ext4_ to fix
> kernel namepsace polution.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/ext4/ext4.h   |  4 ++--
>  fs/ext4/inline.c |  9 +++-----
>  fs/ext4/namei.c  | 54 +++++++++++++++++++-----------------------------
>  3 files changed, 26 insertions(+), 41 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 5b86df7ec326..83128bdd7abb 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3147,8 +3147,8 @@ extern struct ext4_dir_entry_2 *ext4_init_dot_dotdot(struct inode *inode,
>  				 struct ext4_dir_entry_2 *de,
>  				 int blocksize, int csum_size,
>  				 unsigned int parent_ino, int dotdot_real_len);
> -extern void initialize_dirent_tail(struct ext4_dir_entry_tail *t,
> -				   unsigned int blocksize);
> +extern void ext4_initialize_dirent_tail(struct buffer_head *bh,
> +					unsigned int blocksize);
>  extern int ext4_handle_dirty_dirblock(handle_t *handle, struct inode *inode,
>  				      struct buffer_head *bh);
>  extern int ext4_ci_compare(const struct inode *parent,
> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> index f19dd5a08d0d..796137bb7dfa 100644
> --- a/fs/ext4/inline.c
> +++ b/fs/ext4/inline.c
> @@ -1132,7 +1132,6 @@ static int ext4_finish_convert_inline_dir(handle_t *handle,
>  {
>  	int err, csum_size = 0, header_size = 0;
>  	struct ext4_dir_entry_2 *de;
> -	struct ext4_dir_entry_tail *t;
>  	void *target = dir_block->b_data;
>  
>  	/*
> @@ -1158,11 +1157,9 @@ static int ext4_finish_convert_inline_dir(handle_t *handle,
>  			inline_size - EXT4_INLINE_DOTDOT_SIZE + header_size,
>  			inode->i_sb->s_blocksize - csum_size);
>  
> -	if (csum_size) {
> -		t = EXT4_DIRENT_TAIL(dir_block->b_data,
> -				     inode->i_sb->s_blocksize);
> -		initialize_dirent_tail(t, inode->i_sb->s_blocksize);
> -	}
> +	if (csum_size)
> +		ext4_initialize_dirent_tail(dir_block,
> +					    inode->i_sb->s_blocksize);
>  	set_buffer_uptodate(dir_block);
>  	err = ext4_handle_dirty_dirblock(handle, inode, dir_block);
>  	if (err)
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 4f0bcbbcfe96..183ad614ae3d 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -293,9 +293,11 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
>  			     struct inode *dir, struct inode *inode);
>  
>  /* checksumming functions */
> -void initialize_dirent_tail(struct ext4_dir_entry_tail *t,
> -			    unsigned int blocksize)
> +void ext4_initialize_dirent_tail(struct buffer_head *bh,
> +				 unsigned int blocksize)
>  {
> +	struct ext4_dir_entry_tail *t = EXT4_DIRENT_TAIL(bh->b_data, blocksize);
> +
>  	memset(t, 0, sizeof(struct ext4_dir_entry_tail));
>  	t->det_rec_len = ext4_rec_len_to_disk(
>  			sizeof(struct ext4_dir_entry_tail), blocksize);
> @@ -370,7 +372,7 @@ int ext4_dirblock_csum_verify(struct inode *inode, struct buffer_head *bh)
>  	}
>  
>  	if (t->det_checksum != ext4_dirblock_csum(inode, bh->b_data,
> -						(char *)t - bh->b_data))
> +						  (char *)t - bh->b_data))
>  		return 0;
>  
>  	return 1;
> @@ -391,7 +393,7 @@ static void ext4_dirblock_csum_set(struct inode *inode,
>  	}
>  
>  	t->det_checksum = ext4_dirblock_csum(inode, bh->b_data,
> -					   (char *)t - bh->b_data);
> +					     (char *)t - bh->b_data);
>  }
>  
>  int ext4_handle_dirty_dirblock(handle_t *handle,
> @@ -1813,7 +1815,6 @@ static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
>  	char *data1 = (*bh)->b_data, *data2;
>  	unsigned split, move, size;
>  	struct ext4_dir_entry_2 *de = NULL, *de2;
> -	struct ext4_dir_entry_tail *t;
>  	int	csum_size = 0;
>  	int	err = 0, i;
>  
> @@ -1874,11 +1875,8 @@ static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
>  					    (char *) de2,
>  					    blocksize);
>  	if (csum_size) {
> -		t = EXT4_DIRENT_TAIL(data2, blocksize);
> -		initialize_dirent_tail(t, blocksize);
> -
> -		t = EXT4_DIRENT_TAIL(data1, blocksize);
> -		initialize_dirent_tail(t, blocksize);
> +		ext4_initialize_dirent_tail(*bh, blocksize);
> +		ext4_initialize_dirent_tail(bh2, blocksize);
>  	}
>  
>  	dxtrace(dx_show_leaf(dir, hinfo, (struct ext4_dir_entry_2 *) data1,
> @@ -2039,8 +2037,7 @@ static int make_indexed_dir(handle_t *handle, struct ext4_filename *fname,
>  	struct dx_frame	frames[EXT4_HTREE_LEVEL], *frame;
>  	struct dx_entry *entries;
>  	struct ext4_dir_entry_2	*de, *de2;
> -	struct ext4_dir_entry_tail *t;
> -	char		*data1, *top;
> +	char		*data2, *top;
>  	unsigned	len;
>  	int		retval;
>  	unsigned	blocksize;
> @@ -2080,21 +2077,18 @@ static int make_indexed_dir(handle_t *handle, struct ext4_filename *fname,
>  		return PTR_ERR(bh2);
>  	}
>  	ext4_set_inode_flag(dir, EXT4_INODE_INDEX);
> -	data1 = bh2->b_data;
> +	data2 = bh2->b_data;
>  
> -	memcpy (data1, de, len);
> -	de = (struct ext4_dir_entry_2 *) data1;
> -	top = data1 + len;
> +	memcpy(data2, de, len);
> +	de = (struct ext4_dir_entry_2 *) data2;
> +	top = data2 + len;
>  	while ((char *)(de2 = ext4_next_entry(de, blocksize)) < top)
>  		de = de2;
> -	de->rec_len = ext4_rec_len_to_disk(data1 + (blocksize - csum_size) -
> -					   (char *) de,
> -					   blocksize);
> +	de->rec_len = ext4_rec_len_to_disk(data2 + (blocksize - csum_size) -
> +					   (char *) de, blocksize);
>  
> -	if (csum_size) {
> -		t = EXT4_DIRENT_TAIL(data1, blocksize);
> -		initialize_dirent_tail(t, blocksize);
> -	}
> +	if (csum_size)
> +		ext4_initialize_dirent_tail(bh2, blocksize);
>  
>  	/* Initialize the root; the dot dirents already exist */
>  	de = (struct ext4_dir_entry_2 *) (&root->dotdot);
> @@ -2164,7 +2158,6 @@ static int ext4_add_entry(handle_t *handle, struct dentry *dentry,
>  	struct inode *dir = d_inode(dentry->d_parent);
>  	struct buffer_head *bh = NULL;
>  	struct ext4_dir_entry_2 *de;
> -	struct ext4_dir_entry_tail *t;
>  	struct super_block *sb;
>  	struct ext4_sb_info *sbi;
>  	struct ext4_filename fname;
> @@ -2249,10 +2242,8 @@ static int ext4_add_entry(handle_t *handle, struct dentry *dentry,
>  	de->inode = 0;
>  	de->rec_len = ext4_rec_len_to_disk(blocksize - csum_size, blocksize);
>  
> -	if (csum_size) {
> -		t = EXT4_DIRENT_TAIL(bh->b_data, blocksize);
> -		initialize_dirent_tail(t, blocksize);
> -	}
> +	if (csum_size)
> +		ext4_initialize_dirent_tail(bh, blocksize);
>  
>  	retval = add_dirent_to_buf(handle, &fname, dir, inode, de, bh);
>  out:
> @@ -2712,7 +2703,6 @@ static int ext4_init_new_dir(handle_t *handle, struct inode *dir,
>  {
>  	struct buffer_head *dir_block = NULL;
>  	struct ext4_dir_entry_2 *de;
> -	struct ext4_dir_entry_tail *t;
>  	ext4_lblk_t block = 0;
>  	unsigned int blocksize = dir->i_sb->s_blocksize;
>  	int csum_size = 0;
> @@ -2736,10 +2726,8 @@ static int ext4_init_new_dir(handle_t *handle, struct inode *dir,
>  	de = (struct ext4_dir_entry_2 *)dir_block->b_data;
>  	ext4_init_dot_dotdot(inode, de, blocksize, csum_size, dir->i_ino, 0);
>  	set_nlink(inode, 2);
> -	if (csum_size) {
> -		t = EXT4_DIRENT_TAIL(dir_block->b_data, blocksize);
> -		initialize_dirent_tail(t, blocksize);
> -	}
> +	if (csum_size)
> +		ext4_initialize_dirent_tail(dir_block, blocksize);
>  
>  	BUFFER_TRACE(dir_block, "call ext4_handle_dirty_metadata");
>  	err = ext4_handle_dirty_dirblock(handle, inode, dir_block);
> -- 
> 2.22.0
> 
