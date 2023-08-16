Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE5E77D8BF
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Aug 2023 05:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235478AbjHPDBP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Aug 2023 23:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241448AbjHPDBB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Aug 2023 23:01:01 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841A4E6B
        for <linux-ext4@vger.kernel.org>; Tue, 15 Aug 2023 20:00:59 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-114-154.bstnma.fios.verizon.net [173.48.114.154])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37G30iOf001507
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 23:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692154846; bh=hquxDuXKVS1nzq3uzw9ENIDWp5pkClJEIbJr7Cc2HDo=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=LHXh4BV+RQF5wkxpVrrEKkuYoUIVXPinzD3silHGs9hbcj3gV9qSK3qGwHXVSDkfZ
         oYGlKOUMmJmgY42ES9TikmSUJ82vxfjZ+y/RSohaapJVK/zCKMCVJWrBZsnGoXo2Nz
         1bP+XHsb09q6b1Rz9kxI0SHzgg21/dHf+qaRFSWa4ShNKgk3bMWVlXWOFQx0dCjSKg
         o9rlo4gTWN39kh33O69Qfy3KN3OEI2GVikgm1p1UubH9nicMZYLADSQMJjWfN3vULr
         x/FX5AYz39DXkccyVcsdqLHXj5vC/O1v6Do2G7Dy1TqXzYgThmIB0EHcf6AbP+Uir8
         rkNsefozE/lsw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4B9D415C0292; Tue, 15 Aug 2023 23:00:44 -0400 (EDT)
Date:   Tue, 15 Aug 2023 23:00:44 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/13] ext4: correct return value of ext4_convert_meta_bg
Message-ID: <20230816030044.GI2247938@mit.edu>
References: <20230629120044.1261968-1-shikemeng@huaweicloud.com>
 <20230629120044.1261968-4-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629120044.1261968-4-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jun 29, 2023 at 08:00:34PM +0800, Kemeng Shi wrote:
> We return error in "ret", so collect previous error in "ret" instead
> of "err" or previous error will be ignored.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/resize.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
> index 7cbc695b7005..0b3d8c808de1 100644
> --- a/fs/ext4/resize.c
> +++ b/fs/ext4/resize.c
> @@ -1984,8 +1984,8 @@ static int ext4_convert_meta_bg(struct super_block *sb, struct inode *inode)
>  
>  errout:
>  	ret = ext4_journal_stop(handle);
> -	if (!err)
> -		err = ret;
> +	if (!ret)
> +		ret = err;
>  	return ret;

If there is a previous error in "err", I think we would want to
prioritize returning that error, as opposed to the potential error
from ext4_journal_stop().  So how about this instead?

errout:
	ret = ext4_journal_stop(handle);
	if (!err)
		ret = err;
	return ret;


						- Ted
