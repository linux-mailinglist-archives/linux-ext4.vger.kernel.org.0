Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69C4608399
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Oct 2022 04:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiJVC1k (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Oct 2022 22:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiJVC1j (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 Oct 2022 22:27:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04761CFFC;
        Fri, 21 Oct 2022 19:27:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6ACDF61FB5;
        Sat, 22 Oct 2022 02:27:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE930C433D6;
        Sat, 22 Oct 2022 02:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666405657;
        bh=v+TYlBjbGSt7WSZuvirIw+eIrYP/rKnRSSUz7kocN3E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=luec26y203ss+qngx59iZzK2mkjx4Yl9JODWA/78YOLSz3sYuewCYgmOGGh+JqQBP
         0/avS2KoRzZepPx6TCamonEFqNInKYjm2ocScKInwactqxw9Jpf/iD6HTeBILMQWOT
         av2i+iO5R5qvjcvbRV1RvIm8ZrppqUonk6hTBBAz8cvx+LpjfrCbZ7VJNj4zSpXy/O
         VwSx4lXdzTYYnKHc9FLM6lgHuWbQFnQyYOHw2gIb2QLSQhXXJL4ugSjGhGJ3DDkCGW
         NoYZg5jCK1tC5/Dct4Vr1XFiA1egRQMN7fMwZYFhpbI3VuLXqVF+F9feqTOHhvVwiQ
         m4BvOehXwjF/A==
Date:   Fri, 21 Oct 2022 19:27:37 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Eric Whitney <enwlinux@gmail.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH] generic/455: add $FSX_AVOID
Message-ID: <Y1NVGVIt3Z92JdwS@magnolia>
References: <20221021211950.510006-1-enwlinux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021211950.510006-1-enwlinux@gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Oct 21, 2022 at 05:19:50PM -0400, Eric Whitney wrote:
> generic/455 fails when run on an ext4 bigalloc file system.  Its
> fsx invocations can make insert range and collapse range calls whose
> arguments are not cluster aligned, and ext4 will fail those calls for
> bigalloc.  They can be suppressed by adding the FSX_AVOID environment
> variable to the fsx invocation and setting its value appropriately in
> the test environment, as is done for other fsx-based tests.  This
> avoids the need to exclude the test to avoid failures and makes it
> possible to take advantage of the remainder of its coverage.
> 
> Signed-off-by: Eric Whitney <enwlinux@gmail.com>

Yup.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/generic/455 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/455 b/tests/generic/455
> index 649b5410..c13d872c 100755
> --- a/tests/generic/455
> +++ b/tests/generic/455
> @@ -77,7 +77,7 @@ FSX_OPTS="-N $NUM_OPS -d -P $SANITY_DIR -i $LOGWRITES_DMDEV"
>  seeds=(0 0 0 0)
>  # Run fsx for a while
>  for j in `seq 0 $((NUM_FILES-1))`; do
> -	run_check $here/ltp/fsx $FSX_OPTS -S ${seeds[$j]} -j $j $SCRATCH_MNT/testfile$j &
> +	run_check $here/ltp/fsx $FSX_OPTS $FSX_AVOID -S ${seeds[$j]} -j $j $SCRATCH_MNT/testfile$j &
>  done
>  wait
>  
> -- 
> 2.30.2
> 
