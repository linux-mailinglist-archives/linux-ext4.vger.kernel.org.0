Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD95469EDE1
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Feb 2023 05:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjBVESb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Feb 2023 23:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjBVESa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Feb 2023 23:18:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DF14EFE;
        Tue, 21 Feb 2023 20:18:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB33B6124A;
        Wed, 22 Feb 2023 04:18:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 329C9C433EF;
        Wed, 22 Feb 2023 04:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677039507;
        bh=L+n8+ZdeW0UM8PVgpkDcbcyIeoXR/nzZSQ8cCKDr5ww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UvGiV4ACdrN9eDIQlUjF4cL4bdIJZOKbb/9NCLJUEk9fFZAcwn0VMjMGugEZdKTl8
         RRv0P5aH7gaixBmX4J1ttM4bT/BYaXbJ6dWjAwvSK0I8LiHZc+YwWbaewxW2pvNuIM
         XuPL9TLFE7hLEDkUNYMc+FgoNSSxrQiYUrNYk6TVgcuFuxHo60wzQliljICS0nX3xZ
         4V5XftZskijdIkdIIe91+rNbZAqar6bKqFa7z6+t0FEidCiQykDmXy2sKK0mRkjFup
         KcgxdRqZk64p1nglntgCw5NAZoxEnGXx8rVzgUnBA2IECIS30zH5wim2JJ2/h6AVgM
         uzZ/aRxlQJHzQ==
Date:   Tue, 21 Feb 2023 20:18:26 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Wu Bo <bo.wu@vivo.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-ext4@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: ext4: modify the group desc size to 64
Message-ID: <Y/WXkhxhJ742G4xB@magnolia>
References: <20230222013525.14748-1-bo.wu@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230222013525.14748-1-bo.wu@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Feb 22, 2023 at 09:35:24AM +0800, Wu Bo wrote:
> Since the default ext4 group desc size is 64 now (assuming that the
> 64-bit feature is enbled). And the size mentioned in this doc is 64 too.
> Change it to 64.
> 
> Signed-off-by: Wu Bo <bo.wu@vivo.com>

32-bit blockgroup descriptors aren't that ancient of a disk format, it's
probably helpful to mention that one should double the ratios for ^64bit
filesystems.

Also: Not sure what went wrong with your emptyish To: line?

If Ted's ok with this, then:
Acked-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  Documentation/filesystems/ext4/blockgroup.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/filesystems/ext4/blockgroup.rst b/Documentation/filesystems/ext4/blockgroup.rst
> index 46d78f860623..ed5a5cac6d40 100644
> --- a/Documentation/filesystems/ext4/blockgroup.rst
> +++ b/Documentation/filesystems/ext4/blockgroup.rst
> @@ -105,9 +105,9 @@ descriptors. Instead, the superblock and a single block group descriptor
>  block is placed at the beginning of the first, second, and last block
>  groups in a meta-block group. A meta-block group is a collection of
>  block groups which can be described by a single block group descriptor
> -block. Since the size of the block group descriptor structure is 32
> -bytes, a meta-block group contains 32 block groups for filesystems with
> -a 1KB block size, and 128 block groups for filesystems with a 4KB
> +block. Since the size of the block group descriptor structure is 64
> +bytes, a meta-block group contains 16 block groups for filesystems with
> +a 1KB block size, and 64 block groups for filesystems with a 4KB
>  blocksize. Filesystems can either be created using this new block group
>  descriptor layout, or existing filesystems can be resized on-line, and
>  the field s_first_meta_bg in the superblock will indicate the first
> -- 
> 2.35.3
> 
