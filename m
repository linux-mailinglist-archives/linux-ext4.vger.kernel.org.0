Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E578B60D993
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Oct 2022 05:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbiJZDIg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 Oct 2022 23:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbiJZDIc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 25 Oct 2022 23:08:32 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4A71A204
        for <linux-ext4@vger.kernel.org>; Tue, 25 Oct 2022 20:08:31 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y13so9464278pfp.7
        for <linux-ext4@vger.kernel.org>; Tue, 25 Oct 2022 20:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1TrGtjNZ4HefQTsduCfH5Dd6X9o9bvzQpBtAQ5hxSdo=;
        b=AM0F77WH1KcyNA6fgnuW2WOm32n92D5rDMpFVirEoDRKeiuPjXHuwaRqt0RZoOdPjd
         /mWEbarBXQv6FciREJ3OpiIx6N+gfTrQn2qJJWN+KHKBpddN8O4H/XDckIuATrCgPV6P
         795VJej6GYDPt+xTAPCCaxm3mHnOJbn8cg1NFrlRp0paotgt6ELZwoTfEUhiqlcZgcNE
         E2Tu7pd7XqxXe2qYiGBjExGifySBkT6bMUjftx5SRpfl212Pp/B2Ty02mTET/34TFI8w
         PK/0DVShg1TvnfNpGDRZ1uUgQLuI30c0p+ZGO2l8fasILEnW8uInm2DTSjlTTIMMJ8rU
         xviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1TrGtjNZ4HefQTsduCfH5Dd6X9o9bvzQpBtAQ5hxSdo=;
        b=qshceo3dUuKjIN+aJl6LvHnvJNOHf2u9m9UYGDr9L0YG+4IDclFFXc2Mu2jBMttlE8
         17uH2ne7TDGwW/Cxf/Y/gnAYcCVkIGq1trOwLDyT0FgBceb9uO0dW3wXvO8QvU9T+USc
         V8cSlpb5OxwMEziQQZoeY1YKvOUpI6i8NE6lAImXvgqR6ED9yIroWxvvchCLMJ7+n/if
         Ob2To4B2vS23/1uGA6mmV6FHJlwKQ/rRVt/UTpDKifDzlzZN5Tz/fefC3Sr3boiLGPoG
         hoe+1IyHnf3zp9IVINY41xzIe9P8is5fbgw97TF3UNMz0Qo6g3TAZhbX29uhMqiCwZhf
         mjJg==
X-Gm-Message-State: ACrzQf3YXIHYVMpvSVNBjPMFptd/GIh/qMkixg27MFqnojWXn7p6EYqn
        PD9b5z9CbSnr7G4K8D+F7UfBSA==
X-Google-Smtp-Source: AMsMyM5JEEWjL4hv9Jpw0juCgk7Hw7/RQ2jfSYLJIYKJo9PhpzVW/oNEbN+KCLc8LWLGY8x/rtiC+w==
X-Received: by 2002:a05:6a00:1348:b0:56b:f5c0:1d9d with SMTP id k8-20020a056a00134800b0056bf5c01d9dmr10746719pfu.45.1666753710853;
        Tue, 25 Oct 2022 20:08:30 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au. [49.181.106.210])
        by smtp.gmail.com with ESMTPSA id bf11-20020a170902b90b00b00186881688f2sm1852234plb.220.2022.10.25.20.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 20:08:30 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1onWmJ-006Skr-BY; Wed, 26 Oct 2022 14:08:27 +1100
Date:   Wed, 26 Oct 2022 14:08:27 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Eric Whitney <enwlinux@gmail.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH] generic/455: add $FSX_AVOID
Message-ID: <20221026030827.GT2703033@dread.disaster.area>
References: <20221021211950.510006-1-enwlinux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021211950.510006-1-enwlinux@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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

generic/457 needs this fix as well.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
