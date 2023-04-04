Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01906D703A
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Apr 2023 00:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236662AbjDDWl1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Apr 2023 18:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjDDWl1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Apr 2023 18:41:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B3C30C4;
        Tue,  4 Apr 2023 15:41:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2182163A18;
        Tue,  4 Apr 2023 22:41:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96D8C433D2;
        Tue,  4 Apr 2023 22:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680648085;
        bh=aM54U5iap6zscBuGqNsTwESIxnVITeGqVdCllwuI5x8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ml94zzFvd8sabIYbcobTwAoRXcLNGqW8xEpy1hwrJ+LGdNfLtPa8x+4xdHmRtKIUZ
         fsZ9jJ75A5lmEpmdem7n1pLxe2UYcM3MNfdc3YAKViyebklATamdLl05Y60lpWwFf5
         ofYhx2pJjFoCtq+GaiYkuINUe2JCSqF2pwFUFn6Zo0bfwhXouKVIOal+1AkwQaQ/YJ
         bk44SX4AtKjSWCU9Xb6pe+BY0KJ/BHIrDRJrYOB//ATaeXL09P9aN3BQWNzXNZuWDp
         3qrolO5LKpJQtkjeBwNaIywyLBY1yThisB/2n4A1Sn2mN235gQW98poQIAKB/WP56N
         ajfrwoO4Xp5Tw==
Date:   Tue, 4 Apr 2023 15:41:23 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Andrey Albershteyn <aalbersh@redhat.com>
Cc:     djwong@kernel.org, dchinner@redhat.com, hch@infradead.org,
        linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
        rpeterso@redhat.com, agruenba@redhat.com, xiang@kernel.org,
        chao@kernel.org, damien.lemoal@opensource.wdc.com, jth@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com
Subject: Re: [PATCH v2 16/23] xfs: add inode on-disk VERITY flag
Message-ID: <20230404224123.GD1893@sol.localdomain>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-17-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404145319.2057051-17-aalbersh@redhat.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Andrey,

On Tue, Apr 04, 2023 at 04:53:12PM +0200, Andrey Albershteyn wrote:
> Add flag to mark inodes which have fs-verity enabled on them (i.e.
> descriptor exist and tree is built).
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> ---
>  fs/ioctl.c                 | 4 ++++
>  fs/xfs/libxfs/xfs_format.h | 4 +++-
>  fs/xfs/xfs_inode.c         | 2 ++
>  fs/xfs/xfs_iops.c          | 2 ++
>  include/uapi/linux/fs.h    | 1 +
>  5 files changed, 12 insertions(+), 1 deletion(-)
[...]
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index b7b56871029c..5172a2eb902c 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -140,6 +140,7 @@ struct fsxattr {
>  #define FS_XFLAG_FILESTREAM	0x00004000	/* use filestream allocator */
>  #define FS_XFLAG_DAX		0x00008000	/* use DAX for IO */
>  #define FS_XFLAG_COWEXTSIZE	0x00010000	/* CoW extent size allocator hint */
> +#define FS_XFLAG_VERITY		0x00020000	/* fs-verity sealed inode */
>  #define FS_XFLAG_HASATTR	0x80000000	/* no DIFLAG for this	*/
>  

I don't think "xfs: add inode on-disk VERITY flag" is an accurate description of
a patch that involves adding something to the UAPI.

Should the other filesystems support this new flag too?

I'd also like all ways of getting the verity flag to continue to be mentioned in
Documentation/filesystems/fsverity.rst.  The existing methods (FS_IOC_GETFLAGS
and statx) are already mentioned there.

- Eric
