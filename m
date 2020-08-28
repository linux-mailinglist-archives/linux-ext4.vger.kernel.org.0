Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC411255F50
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Aug 2020 19:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgH1RCx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 Aug 2020 13:02:53 -0400
Received: from mga14.intel.com ([192.55.52.115]:16955 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbgH1RCw (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 28 Aug 2020 13:02:52 -0400
IronPort-SDR: Pwf80R1M2++3ZubCnd9Cnhx0K4mycOR0GpAssY0rIcrGPUdA5aocNrI9UasVKfFEtw/wUBgk9u
 peS6GKlaT+sw==
X-IronPort-AV: E=McAfee;i="6000,8403,9727"; a="155964390"
X-IronPort-AV: E=Sophos;i="5.76,364,1592895600"; 
   d="scan'208";a="155964390"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 10:02:52 -0700
IronPort-SDR: uwEaPveV3/q6hAMdL9Iod5Yo3ilUWbG78Ax7U7wiAgjY1XsNKsgy8LTieWRcp6humuxvJmrn6f
 SdBBr+eIs+fA==
X-IronPort-AV: E=Sophos;i="5.76,364,1592895600"; 
   d="scan'208";a="300298719"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 10:02:51 -0700
Date:   Fri, 28 Aug 2020 10:02:51 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Xiao Yang <yangx.jy@cn.fujitsu.com>, linux-ext4@vger.kernel.org,
        darrick.wong@oracle.com, tytso@mit.edu
Subject: Re: [PATCH] ext4: Disallow modifying DAX inode flag if inline_data
 has been set
Message-ID: <20200828170251.GB1422350@iweiny-DESK2.sc.intel.com>
References: <20200828071501.8402-1-yangx.jy@cn.fujitsu.com>
 <20200828084921.GB7072@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828084921.GB7072@quack2.suse.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Aug 28, 2020 at 10:49:21AM +0200, Jan Kara wrote:
> On Fri 28-08-20 15:15:01, Xiao Yang wrote:
> > inline_data is mutually exclusive to DAX so enabling both of them triggers
> > the following issue:
> > ------------------------------------------
> > # mkfs.ext4 -F -O inline_data /dev/pmem1
> > ...
> > # mount /dev/pmem1 /mnt
> > # echo 'test' >/mnt/file
> > # lsattr -l /mnt/file
> > /mnt/file                    Inline_Data
> > # xfs_io -c "chattr +x" /mnt/file
> > # xfs_io -c "lsattr -v" /mnt/file
> > [dax] /mnt/file
> > # umount /mnt
> > # mount /dev/pmem1 /mnt
> > # cat /mnt/file
> > cat: /mnt/file: Numerical result out of range
> > ------------------------------------------
> > 
> > Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> 
> Thanks. The patch looks good to me. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> Please also add the following tag to the changelog:
> 
> Fixes: b383a73f2b83 ("fs/ext4: Introduce DAX inode flag")
> 
> so that the patch gets properly picked up to stable trees etc. Thanks!

And +1 on getting this to stable.

Thanks!
Ira

> 
> 								Honza
> 
> > ---
> >  fs/ext4/ext4.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > index 523e00d7b392..69187b6205b2 100644
> > --- a/fs/ext4/ext4.h
> > +++ b/fs/ext4/ext4.h
> > @@ -492,7 +492,7 @@ struct flex_groups {
> >  
> >  /* Flags which are mutually exclusive to DAX */
> >  #define EXT4_DAX_MUT_EXCL (EXT4_VERITY_FL | EXT4_ENCRYPT_FL |\
> > -			   EXT4_JOURNAL_DATA_FL)
> > +			   EXT4_JOURNAL_DATA_FL | EXT4_INLINE_DATA_FL)
> >  
> >  /* Mask out flags that are inappropriate for the given type of inode. */
> >  static inline __u32 ext4_mask_flags(umode_t mode, __u32 flags)
> > -- 
> > 2.25.1
> > 
> > 
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
