Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10B5255F4F
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Aug 2020 19:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgH1RBy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 Aug 2020 13:01:54 -0400
Received: from mga05.intel.com ([192.55.52.43]:2616 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbgH1RBx (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 28 Aug 2020 13:01:53 -0400
IronPort-SDR: aMEZ/SUkgUHwgMudfnjNv0WCEWo2a0tiLb/bxq7deLw7vHWTeDXO5KuZz1Lkg6/X1YxaQD4MMV
 ldOGV0exN+eg==
X-IronPort-AV: E=McAfee;i="6000,8403,9727"; a="241517352"
X-IronPort-AV: E=Sophos;i="5.76,364,1592895600"; 
   d="scan'208";a="241517352"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 10:01:52 -0700
IronPort-SDR: 1HKMiWq6TNTp4a1FYiIAwz6+7s6le4E9GU3kjtD1jePnJUxeXVbovz42j5ABmaJUlN67hP3P8x
 5L/ZNMyEKChA==
X-IronPort-AV: E=Sophos;i="5.76,364,1592895600"; 
   d="scan'208";a="444895341"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 10:01:52 -0700
Date:   Fri, 28 Aug 2020 10:01:52 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     linux-ext4@vger.kernel.org, darrick.wong@oracle.com, tytso@mit.edu,
        jack@suse.cz
Subject: Re: [PATCH] ext4: Disallow modifying DAX inode flag if inline_data
 has been set
Message-ID: <20200828170151.GA1422350@iweiny-DESK2.sc.intel.com>
References: <20200828071501.8402-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828071501.8402-1-yangx.jy@cn.fujitsu.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Aug 28, 2020 at 03:15:01PM +0800, Xiao Yang wrote:
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

Thank you for the fix!

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

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
