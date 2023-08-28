Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F8478B53C
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Aug 2023 18:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjH1QSq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Aug 2023 12:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjH1QSa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Aug 2023 12:18:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8A812F
        for <linux-ext4@vger.kernel.org>; Mon, 28 Aug 2023 09:18:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1CCC60C81
        for <linux-ext4@vger.kernel.org>; Mon, 28 Aug 2023 16:18:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C21C433C7;
        Mon, 28 Aug 2023 16:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693239507;
        bh=mqPZ+IA8pznoP2y2S1W3tf1aHsl1QHqiyZmwZfx5yLY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P2f/qZjV5S6WgDhv/RdfaO1xRomazjB2XN2a2lYjklEKQail2m154+ly4skCa8+o8
         DJlPwdme9JKI/DetZXL/D1aSftrxfOvww1HPYcleoW/OnqpdDs4fLy5PXlMTFj2QDy
         U6d4+MDqpt0hBo4CkX1MxKv18EPLSDtH2yw1tz7PHrjBp61ULXHhIujD67nnK6iWCQ
         KtzxBI/Ae9QUChACxoULQlyN5djQDhVgQpCJEmLLwUKQ98Gds7JdSJl9AKcfeVCjol
         2qOHsVyOjwvtXVeqAB1tJuFVPNM1UH4hKMx6y70uz3z+RHnduX7VK7gW2WtmKTj3Fb
         8Cvrp0BYk2ahA==
Date:   Mon, 28 Aug 2023 09:18:26 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Haibo Liu <haiboliu6@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: ext4/super.c : Fix a goto label
Message-ID: <20230828161826.GA28156@frogsfrogsfrogs>
References: <20230828092726.19400-1-haiboliu6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828092726.19400-1-haiboliu6@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 28, 2023 at 05:27:26PM +0800, Haibo Liu wrote:
> There are 9 goto labels in ext4_init_fs: out,out05,out1,out2,out3,out4,out5,out6,out7. So I feel that replacing out5 with out0 may be better. 

...then why not replace them all with descriptions of what gets released
under each label?

	ret = init_inodecache();
	if (ret)
		goto out_unregister_mballoc;
	ret = init_somethingelse();
	if (ret)
		goto out_inodecache;

out_unregister_ext23:
	unregister_as_ext2();
	unregister_as_ext3();
out_inodecache:
	destroy_inodecache();
out_mballoc:
	ext4_exit_mballoc();

Is much more easier to understand than out[0...N], yes?

--D

> Signed-off-by: Haibo Liu <haiboliu6@gmail.com>
> ---
>  fs/ext4/super.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 03373471131c..115bbbd95a7b 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -6696,7 +6696,7 @@ static int __init ext4_init_fs(void)
>  
>  	err = ext4_fc_init_dentry_cache();
>  	if (err)
> -		goto out05;
> +		goto out0;
>  
>  	register_as_ext3();
>  	register_as_ext2();
> @@ -6708,7 +6708,7 @@ static int __init ext4_init_fs(void)
>  out:
>  	unregister_as_ext2();
>  	unregister_as_ext3();
> -out05:
> +out0:
>  	destroy_inodecache();
>  out1:
>  	ext4_exit_mballoc();
> -- 
> 2.34.1
> 
