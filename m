Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07EED5DD1B
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jul 2019 05:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfGCDup (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 Jul 2019 23:50:45 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45470 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbfGCDup (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 2 Jul 2019 23:50:45 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x633mWpR016057;
        Wed, 3 Jul 2019 03:50:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=gxqRflvnos0bbWQJwJH6irArDAU/9Jbk6+4JEOv0Ca8=;
 b=fOYjRbFV0uZQvvfLKA9KVGZDE/TmMVAnAWhO6HjWq2Jev+cJqJLfp6xVdlYQ5Er4C/hf
 5cbR0m92/cX82WcgHQan7DpWv7zaCKKYjEGWbZa8WEe9ERBck6C/sq1OLCVtPETruS2V
 n2HP6vXEVSuXaBAe5nmuHS0io6HuDK5y8D6s4G9YgyLQnVBjKUAiU9/PSR0xlUGW1e1f
 HExFRVVQAPiAFNHqm3/fXvsx8NffaURdOjTjXTzvxUt+eSYEqth5H0YUb7PhjvdpMz7c
 YlkbCUjvoO+w9BX0rASvmLPfnVyZhjarGHINZAjrep6ynqfEUk7wI28IUFeDRMEoEFfJ pA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2te61e6y6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Jul 2019 03:50:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x633m3Ll060282;
        Wed, 3 Jul 2019 03:50:41 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2tebkumj2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Jul 2019 03:50:41 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x633oewV021159;
        Wed, 3 Jul 2019 03:50:40 GMT
Received: from localhost (/10.159.225.186)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Jul 2019 20:50:40 -0700
Date:   Tue, 2 Jul 2019 20:50:32 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 3/3] ext4: rename htree_inline_dir_to_tree() to
 ext4_inlinedir_to_tree()
Message-ID: <20190703035032.GC5161@magnolia>
References: <20190702212925.29989-1-tytso@mit.edu>
 <20190702212925.29989-3-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702212925.29989-3-tytso@mit.edu>
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

On Tue, Jul 02, 2019 at 05:29:25PM -0400, Theodore Ts'o wrote:
> Clean up namespace pollution by the inline_data code.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/ext4/ext4.h   | 10 +++++-----
>  fs/ext4/inline.c | 10 +++++-----
>  fs/ext4/namei.c  |  8 ++++----
>  3 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 83128bdd7abb..bf660aa7a9e0 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3104,11 +3104,11 @@ extern int ext4_try_create_inline_dir(handle_t *handle,
>  extern int ext4_read_inline_dir(struct file *filp,
>  				struct dir_context *ctx,
>  				int *has_inline_data);
> -extern int htree_inlinedir_to_tree(struct file *dir_file,
> -				   struct inode *dir, ext4_lblk_t block,
> -				   struct dx_hash_info *hinfo,
> -				   __u32 start_hash, __u32 start_minor_hash,
> -				   int *has_inline_data);
> +extern int ext4_inlinedir_to_tree(struct file *dir_file,
> +				  struct inode *dir, ext4_lblk_t block,
> +				  struct dx_hash_info *hinfo,
> +				  __u32 start_hash, __u32 start_minor_hash,
> +				  int *has_inline_data);
>  extern struct buffer_head *ext4_find_inline_entry(struct inode *dir,
>  					struct ext4_filename *fname,
>  					struct ext4_dir_entry_2 **res_dir,
> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> index 796137bb7dfa..88cdf3c90bd1 100644
> --- a/fs/ext4/inline.c
> +++ b/fs/ext4/inline.c
> @@ -1324,11 +1324,11 @@ int ext4_try_add_inline_entry(handle_t *handle, struct ext4_filename *fname,
>   * inlined dir.  It returns the number directory entries loaded
>   * into the tree.  If there is an error it is returned in err.
>   */
> -int htree_inlinedir_to_tree(struct file *dir_file,
> -			    struct inode *dir, ext4_lblk_t block,
> -			    struct dx_hash_info *hinfo,
> -			    __u32 start_hash, __u32 start_minor_hash,
> -			    int *has_inline_data)
> +int ext4_inlinedir_to_tree(struct file *dir_file,
> +			   struct inode *dir, ext4_lblk_t block,
> +			   struct dx_hash_info *hinfo,
> +			   __u32 start_hash, __u32 start_minor_hash,
> +			   int *has_inline_data)
>  {
>  	int err = 0, count = 0;
>  	unsigned int parent_ino;
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 183ad614ae3d..c9568fee9e11 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -1104,10 +1104,10 @@ int ext4_htree_fill_tree(struct file *dir_file, __u32 start_hash,
>  		hinfo.seed = EXT4_SB(dir->i_sb)->s_hash_seed;
>  		if (ext4_has_inline_data(dir)) {
>  			int has_inline_data = 1;
> -			count = htree_inlinedir_to_tree(dir_file, dir, 0,
> -							&hinfo, start_hash,
> -							start_minor_hash,
> -							&has_inline_data);
> +			count = ext4_inlinedir_to_tree(dir_file, dir, 0,
> +						       &hinfo, start_hash,
> +						       start_minor_hash,
> +						       &has_inline_data);
>  			if (has_inline_data) {
>  				*next_hash = ~0;
>  				return count;
> -- 
> 2.22.0
> 
