Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 017DB2556DB
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Aug 2020 10:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgH1ItY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 Aug 2020 04:49:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:56364 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbgH1ItW (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 28 Aug 2020 04:49:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E47EAAC37;
        Fri, 28 Aug 2020 08:49:53 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0CFF91E12C0; Fri, 28 Aug 2020 10:49:21 +0200 (CEST)
Date:   Fri, 28 Aug 2020 10:49:21 +0200
From:   Jan Kara <jack@suse.cz>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     linux-ext4@vger.kernel.org, darrick.wong@oracle.com,
        ira.weiny@intel.com, tytso@mit.edu, jack@suse.cz
Subject: Re: [PATCH] ext4: Disallow modifying DAX inode flag if inline_data
 has been set
Message-ID: <20200828084921.GB7072@quack2.suse.cz>
References: <20200828071501.8402-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828071501.8402-1-yangx.jy@cn.fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 28-08-20 15:15:01, Xiao Yang wrote:
> inline_data is mutually exclusive to DAX so enabling both of them triggers
> the following issue:
> ------------------------------------------
> # mkfs.ext4 -F -O inline_data /dev/pmem1
> ...
> # mount /dev/pmem1 /mnt
> # echo 'test' >/mnt/file
> # lsattr -l /mnt/file
> /mnt/file                    Inline_Data
> # xfs_io -c "chattr +x" /mnt/file
> # xfs_io -c "lsattr -v" /mnt/file
> [dax] /mnt/file
> # umount /mnt
> # mount /dev/pmem1 /mnt
> # cat /mnt/file
> cat: /mnt/file: Numerical result out of range
> ------------------------------------------
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Thanks. The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

Please also add the following tag to the changelog:

Fixes: b383a73f2b83 ("fs/ext4: Introduce DAX inode flag")

so that the patch gets properly picked up to stable trees etc. Thanks!

								Honza

> ---
>  fs/ext4/ext4.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 523e00d7b392..69187b6205b2 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -492,7 +492,7 @@ struct flex_groups {
>  
>  /* Flags which are mutually exclusive to DAX */
>  #define EXT4_DAX_MUT_EXCL (EXT4_VERITY_FL | EXT4_ENCRYPT_FL |\
> -			   EXT4_JOURNAL_DATA_FL)
> +			   EXT4_JOURNAL_DATA_FL | EXT4_INLINE_DATA_FL)
>  
>  /* Mask out flags that are inappropriate for the given type of inode. */
>  static inline __u32 ext4_mask_flags(umode_t mode, __u32 flags)
> -- 
> 2.25.1
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
