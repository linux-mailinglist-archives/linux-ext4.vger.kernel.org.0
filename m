Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 251F5CABE2
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Oct 2019 19:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731819AbfJCQBc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Oct 2019 12:01:32 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44004 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729059AbfJCQBb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Oct 2019 12:01:31 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x93Fi0vC161752;
        Thu, 3 Oct 2019 16:01:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=rNBtmtHREfv8c6ONI1o8qK4NHG7WS6woT+AdeaU3liE=;
 b=JOEOwCab9Zda/ADJGGLciblj75OfaG+CyR3wJ1WVkh35LwVEPuwaIRHiRz1js4BjQ6l2
 GLnrIQE4Uscjc/NwFaK/DNjyatb/VgQaAfXkWf5gn7/NZk5I6tmXAVIJyTMu5ENpwjS/
 OzZiY4uFG4ewz6lFLI54khY+gYNwQ62S+mIhZANJPyZLPWK0REQMQ5CxCOtFG4eaozh7
 Zxj913vOoKHt5A6FhiyVrNrq69lirYChIe32mB8NRNkILlxE1ObH3y5Ru7fLXb1raO4i
 nNoJvq8NH7aRWi5+iJtQRPpr1ltWBK14OIqOw6l1vjDw8WTF4BuGB+p5z/1wAk5YZaQn gA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2va05s53n1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Oct 2019 16:01:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x93Ficaq068586;
        Thu, 3 Oct 2019 16:01:27 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2vdk0sbwf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Oct 2019 16:01:27 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x93G1Om2010865;
        Thu, 3 Oct 2019 16:01:24 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Oct 2019 09:01:23 -0700
Date:   Thu, 3 Oct 2019 09:01:22 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Artem Blagodarenko <artem.blagodarenko@gmail.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca
Subject: Re: [PATCH] ext2fs: add ext2fs_read_sb that returns superblock
Message-ID: <20191003160122.GB13093@magnolia>
References: <20190905110110.32627-1-c17828@cray.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905110110.32627-1-c17828@cray.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9398 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910030143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9398 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910030143
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Sep 05, 2019 at 02:01:10PM +0300, Artem Blagodarenko wrote:
> tune2fs is used to make e2label duties.  ext2fs_open2() reads group
> descriptors which are not used during disk label obtaining, but takes
> a lot of time on large partitions.
> 
> This patch adds ext2fs_read_sb(), there only initialized superblock
> is returned This saves time dramatically.
> 
> Signed-off-by: Artem Blagodarenko <c17828@cray.com>
> Cray-bug-id: LUS-5777
> ---
>  lib/ext2fs/ext2fs.h |  2 ++
>  lib/ext2fs/openfs.c | 16 ++++++++++++++++
>  misc/tune2fs.c      | 23 +++++++++++++++--------
>  3 files changed, 33 insertions(+), 8 deletions(-)
> 
> diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
> index 59fd9742..3a63b74d 100644
> --- a/lib/ext2fs/ext2fs.h
> +++ b/lib/ext2fs/ext2fs.h
> @@ -1630,6 +1630,8 @@ extern int ext2fs_journal_sb_start(int blocksize);
>  extern errcode_t ext2fs_open(const char *name, int flags, int superblock,
>  			     unsigned int block_size, io_manager manager,
>  			     ext2_filsys *ret_fs);
> +extern errcode_t ext2fs_read_sb(const char *name, io_manager manager,
> +				struct ext2_super_block * super);
>  extern errcode_t ext2fs_open2(const char *name, const char *io_options,
>  			      int flags, int superblock,
>  			      unsigned int block_size, io_manager manager,
> diff --git a/lib/ext2fs/openfs.c b/lib/ext2fs/openfs.c
> index 51b54a44..95f45d84 100644
> --- a/lib/ext2fs/openfs.c
> +++ b/lib/ext2fs/openfs.c
> @@ -99,6 +99,22 @@ static void block_sha_map_free_entry(void *data)
>  	return;
>  }
>  
> +errcode_t ext2fs_read_sb(const char *name, io_manager manager,
> +			 struct ext2_super_block * super)
> +{
> +	io_channel	io;
> +	errcode_t	retval = 0;
> +
> +	retval = manager->open(name, 0, &io);
> +	if (!retval) {
> +		retval = io_channel_read_blk(io, 1, -SUPERBLOCK_SIZE,
> +				     super);
> +		io_channel_close(io);
> +	}
> +
> +	return retval;
> +}
> +
>  /*
>   *  Note: if superblock is non-zero, block-size must also be non-zero.
>   * 	Superblock and block_size can be zero to use the default size.
> diff --git a/misc/tune2fs.c b/misc/tune2fs.c
> index 7d2d38d7..fea607e1 100644
> --- a/misc/tune2fs.c
> +++ b/misc/tune2fs.c
> @@ -2879,6 +2879,21 @@ int tune2fs_main(int argc, char **argv)
>  #endif
>  		io_ptr = unix_io_manager;
>  
> +	if (print_label) {
> +		/* For e2label emulation */
> +		struct ext2_super_block sb;
> +
> +		/* Read only superblock. Nothing else metters.*/

                                                      matters. */

> +		retval = ext2fs_read_sb(device_name, io_ptr, &sb);
> +		if (!retval) {
> +			printf("%.*s\n", (int) sizeof(sb.s_volume_name),
> +			       sb.s_volume_name);
> +		}

Um, does this drop the error without making a report?

> +
> +		remove_error_table(&et_ext2_error_table);
> +		return retval;
> +	}

I wonder if ext[24] should implement FS_IOC_[GS]ETFSLABEL for mounted
filesystems ... ?

--D

> +
>  retry_open:
>  	if ((open_flag & EXT2_FLAG_RW) == 0 || f_flag)
>  		open_flag |= EXT2_FLAG_SKIP_MMP;
> @@ -2972,14 +2987,6 @@ retry_open:
>  	sb = fs->super;
>  	fs->flags &= ~EXT2_FLAG_MASTER_SB_ONLY;
>  
> -	if (print_label) {
> -		/* For e2label emulation */
> -		printf("%.*s\n", (int) sizeof(sb->s_volume_name),
> -		       sb->s_volume_name);
> -		remove_error_table(&et_ext2_error_table);
> -		goto closefs;
> -	}
> -
>  	retval = ext2fs_check_if_mounted(device_name, &mount_flags);
>  	if (retval) {
>  		com_err("ext2fs_check_if_mount", retval,
> -- 
> 2.14.3
> 
