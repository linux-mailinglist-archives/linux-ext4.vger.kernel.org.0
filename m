Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCFAE58DAAD
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Aug 2022 17:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiHIPDa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 Aug 2022 11:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244741AbiHIPDJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 Aug 2022 11:03:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57F51DA5A;
        Tue,  9 Aug 2022 08:03:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1034B81142;
        Tue,  9 Aug 2022 15:03:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4197FC433C1;
        Tue,  9 Aug 2022 15:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660057381;
        bh=NBq6napXG6yp0GreuqrjVaa3HKFO1O0qhx88aTuW3so=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k3CJ2VAsE/P3e/6Awu7a5hwA2cgqTZYph+IRL/K2O6nb9OKyUqdiGi6mgcre2UIJ4
         zea/rxr/HZHh0ukjJIq9iLAHSXJPytM1+hDttloxeLub5iNyMOaG+aiaxAXbF9yn0z
         o8QpO85n+K6W7X2PFfOj9vN9dEhK1fLH0hvZq8yslNW06ZQEBNLeJUUoVxEyzbQqz7
         a5CLLZXx2MLA1YvdwkeZB4cGakFzNatMDnV4bfSjMvzU3PeYHZUndyDjOL1pbqivy7
         Hu/B+IaheFsMRoF27OojXWULe3fyhZLRNShHynd4EIOjHbVSmxzjbYyOhqE/A/4ya+
         26Tv+4tob7o5Q==
Date:   Tue, 9 Aug 2022 08:03:00 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-doc@vger.kernel.org, stable@kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        Wang Jianjian <wangjianjian3@huawei.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 5.19] Documentation: ext4: fix cell spacing of table
 heading on blockmap table
Message-ID: <YvJ3JPFQfzbhph89@magnolia>
References: <20220809080827.108363-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809080827.108363-1-bagasdotme@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Aug 09, 2022 at 03:08:28PM +0700, Bagas Sanjaya wrote:
> commit 442ec1e5bb7c46c72c41898e13a5744c84cadf51 upstream.
> 
> Commit 3103084afcf234 ("ext4, doc: remove unnecessary escaping") removes
> redundant underscore escaping, however the cell spacing in heading row of
> blockmap table became not aligned anymore, hence triggers malformed table
> warning:
> 
> Documentation/filesystems/ext4/blockmap.rst:3: WARNING: Malformed table.
> 
> +---------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
> | i.i_block Offset   | Where It Points                                                                                                                                                                                                              |
> <snipped>...
> 
> The warning caused the table not being loaded.
> 
> Realign the heading row cell by adding missing space at the first cell
> to fix the warning.
> 
> Fixes: 3103084afcf234 ("ext4, doc: remove unnecessary escaping")
> Cc: stable@kernel.org
> Cc: Andreas Dilger <adilger.kernel@dilger.ca>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Wang Jianjian <wangjianjian3@huawei.com>
> Cc: linux-ext4@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Link: https://lore.kernel.org/r/20220619072938.7334-1-bagasdotme@gmail.com
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
> 
>  Seems like this patch is merged to Linus's tree as merge window
>  material for 6.0, but it should have been -rc fix material for 5.19
>  cycle. Now that the version have been stabilized (and now on 6.0 merge
>  window), it should be logical to submit this backport for 5.19 tree.
> 
>  Documentation/filesystems/ext4/blockmap.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/ext4/blockmap.rst b/Documentation/filesystems/ext4/blockmap.rst
> index 2bd990402a5c49..cc596541ce7921 100644
> --- a/Documentation/filesystems/ext4/blockmap.rst
> +++ b/Documentation/filesystems/ext4/blockmap.rst
> @@ -1,7 +1,7 @@
>  .. SPDX-License-Identifier: GPL-2.0
>  
>  +---------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
> -| i.i_block Offset   | Where It Points                                                                                                                                                                                                              |
> +| i.i_block Offset    | Where It Points                                                                                                                                                                                                              |

AHA, that's why I kept getting screenfuls of sphinx complaints when I
was building the XFS documentation.  Thanks for fixing this...

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

>  +=====================+==============================================================================================================================================================================================================================+
>  | 0 to 11             | Direct map to file blocks 0 to 11.                                                                                                                                                                                           |
>  +---------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
> -- 
> An old man doll... just what I always wanted! - Clara
> 
