Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA0350185A
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Apr 2022 18:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiDNQK0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Apr 2022 12:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359250AbiDNPmv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Apr 2022 11:42:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3170C38DBA;
        Thu, 14 Apr 2022 08:29:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE5A561795;
        Thu, 14 Apr 2022 15:29:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259D1C385A1;
        Thu, 14 Apr 2022 15:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649950190;
        bh=WVPVOL2y6eFxbWQfAEW3ZH2FbE5I3pqQ3L871DtCH+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lF4jg8if+tUve0km0+OAhXP7snpbuQprjDVc3UvBJ41Uz9x6xz2t1PwJVvAuk+EIY
         VrNOgnOaK4JmlMPTjrwg6KxHpXfe4LgaNGyJDkNfWlp0hEhhz+yduD3+dQRELxDuCO
         jmuBHixmDaUo8Mqw+yxzvk5uWzN1Fhjy+YsRRWUIa+YadNNeyx44XKiXt9Co4TIdmd
         9FzjXO6qJfKHE6Wzy+8/F0XMQBbbp84GUTvur1JN8xs5KAwGbZF1QkWYEgkQUNcaOK
         Bb6JWe5HsHiGhHxn8UAaX4pDQX9vWeC3D6BszYRPt2JqF2PWbWqitWPul62PG+v1wS
         Z88+CPAKM1KxA==
Date:   Thu, 14 Apr 2022 08:29:49 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Eric Whitney <enwlinux@gmail.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] common/filter: extend _filter_xfs_io to match -nan
Message-ID: <20220414152949.GA17014@magnolia>
References: <20220414142258.761835-1-enwlinux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414142258.761835-1-enwlinux@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Apr 14, 2022 at 10:22:58AM -0400, Eric Whitney wrote:
> When run on ext4 with sufficiently fast x86_64 hardware, generic/130
> sometimes fails because xfs_io can report rate values as -nan:
> 0.000000 bytes, 0 ops; 0.0000 sec (-nan bytes/sec and -nan ops/sec)
> 
> _filter_xfs_io matches the strings 'inf' or 'nan', but not '-nan'.  In
> that case it fails to convert the actual output to a normalized form
> matching generic/130's golden output.  Extend the regular expression
> used to match xfs_io's output to fix this.
> 
> Signed-off-by: Eric Whitney <enwlinux@gmail.com>
> ---
>  common/filter | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/common/filter b/common/filter
> index 5fe86756..5b20e848 100644
> --- a/common/filter
> +++ b/common/filter
> @@ -168,9 +168,9 @@ common_line_filter()
>  
>  _filter_xfs_io()
>  {
> -    # Apart from standard numeric values, we also filter out 'inf' and 'nan'
> -    # which can result from division in some cases
> -    sed -e "s/[0-9/.]* [GMKiBbytes]*, [0-9]* ops\; [0-9/:. sec]* ([infa0-9/.]* [EPGMKiBbytes]*\/sec and [infa0-9/.]* ops\/sec)/XXX Bytes, X ops\; XX:XX:XX.X (XXX YYY\/sec and XXX ops\/sec)/"
> +    # Apart from standard numeric values, we also filter out 'inf', 'nan', and
> +    # '-nan' which can result from division in some cases
> +    sed -e "s/[0-9/.]* [GMKiBbytes]*, [0-9]* ops\; [0-9/:. sec]* ([infa0-9/.-]* [EPGMKiBbytes]*\/sec and [infa0-9/.-]* ops\/sec)/XXX Bytes, X ops\; XX:XX:XX.X (XXX YYY\/sec and XXX ops\/sec)/"

/me squints at this regular expression and /thinks/ its ok.

Took me a while to figure out "infa" tho. :P

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

>  }
>  
>  # Also filter out the offset part of xfs_io output
> -- 
> 2.30.2
> 
