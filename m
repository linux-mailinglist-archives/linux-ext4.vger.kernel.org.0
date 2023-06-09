Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0FF728E94
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Jun 2023 05:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237872AbjFIDdE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Jun 2023 23:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236884AbjFIDdC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Jun 2023 23:33:02 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F6430EE
        for <linux-ext4@vger.kernel.org>; Thu,  8 Jun 2023 20:33:01 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6b2bdca0884so303396a34.2
        for <linux-ext4@vger.kernel.org>; Thu, 08 Jun 2023 20:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1686281580; x=1688873580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6iwigF78U3EwOQGn53e2UyWPNzHupFHtA26oaO3R2wc=;
        b=IUFu6gG5Y34+fr+pT0fZlm3gbhBerxiSZw2i1915MxIWtDQeIYZTwhIfxZmRHtIyiR
         NFlOVNBDBv4/iHd9xqTHen6L7cwEJR2miWxty9rxd+mk6AtmzR3I1xxG5LAkyihtV0UE
         3/jD4CNKGPbNmdD2KK8c1YBe88FwQhH58dTi9C94lOBqYZTDhOFWExKvxj5Kp+IXNOgU
         zX89XwkY9Pgh5GQ5zDMDjn1C2akzPzmnPzODvfSMY1/G48ZUuRJTjtxkVvp/a53l/BsA
         SRJ7B68f+Pab/mILI/Gop73OnxPKT98d3/ZDR6sz0msjAMQnDOI/J9Kzm9qPanig48z3
         RfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686281580; x=1688873580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6iwigF78U3EwOQGn53e2UyWPNzHupFHtA26oaO3R2wc=;
        b=Wgrbs1vQSvgUntgk7xgERKHb4ON7BuCK/KlFCm3C6/ByiYU5hoDkSHTpUVo7lY/HWn
         wm+XzHlNrtpLil2uwRh4vaGSrXf68Mazo+hk6oDzDdVRlReMlncddi/uxfW5Tk4oQVLu
         ARmGXOtTMHt41AsfVVzEyUjnGHZmOpiyoSXfz4u3Anc/WJKqoaVRS1YMR0P5mHzW9XYn
         nS8lIMMMPlgEkjkLSlSKFO5F8DSlC2rJF0wnv6AtHlpX5+ehXw+SX1e8BewiOGdzSxUY
         XIuIAR4fdMc6rpaOo70FlesbIWAE8WGty8HQrFNp3qtH5KHq5FMNPCyO/YoFsHfhunFG
         3fdA==
X-Gm-Message-State: AC+VfDxFRbm5WxANRKjRfLHfO6GWh9xAnJnwELMukYFhzuF6r2E0ZM+j
        7W59ft4MN+aCDR8Z2/Lgc/wGeQ==
X-Google-Smtp-Source: ACHHUZ4jpAKkv/P4I5GyogL5cyKUBbH9jdQo3rd8sW4sBbrGIyPOxPKXrqwUV/kK78Vqo7hkyQEMOA==
X-Received: by 2002:a05:6830:3a0a:b0:6a6:6121:dc60 with SMTP id di10-20020a0568303a0a00b006a66121dc60mr317885otb.10.1686281580410;
        Thu, 08 Jun 2023 20:33:00 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-79-151.pa.nsw.optusnet.com.au. [49.179.79.151])
        by smtp.gmail.com with ESMTPSA id t1-20020aa79381000000b0064381853bfcsm1723703pfe.89.2023.06.08.20.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 20:32:59 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q7Srw-009XUr-2X;
        Fri, 09 Jun 2023 13:32:56 +1000
Date:   Fri, 9 Jun 2023 13:32:56 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Joe Thornber <thornber@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        linux-kernel@vger.kernel.org, Joe Thornber <ejt@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Sarthak Kukreti <sarthakkukreti@chromium.org>,
        linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        linux-ext4@vger.kernel.org, Brian Foster <bfoster@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v7 0/5] Introduce provisioning primitives
Message-ID: <ZIKdaJNhSq9JfFDU@dread.disaster.area>
References: <ZHFEfngPyUOqlthr@dread.disaster.area>
 <CAJ0trDZJQwvAzngZLBJ1hB0XkQ1HRHQOdNQNTw9nK-U5i-0bLA@mail.gmail.com>
 <ZHYB/6l5Wi+xwkbQ@redhat.com>
 <CAJ0trDaUOevfiEpXasOESrLHTCcr=oz28ywJU+s+YOiuh7iWow@mail.gmail.com>
 <ZHYWAGmKhwwmTjW/@redhat.com>
 <CAG9=OMMnDfN++-bJP3jLmUD6O=Q_ApV5Dr392_5GqsPAi_dDkg@mail.gmail.com>
 <ZHqOvq3ORETQB31m@dread.disaster.area>
 <ZHti/MLnX5xGw9b7@redhat.com>
 <ZH/k9ss2Cg9HYrEV@dread.disaster.area>
 <ZIEXwTd17z0iYW4s@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIEXwTd17z0iYW4s@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 07, 2023 at 07:50:25PM -0400, Mike Snitzer wrote:
> Do you think you're OK to scope out, and/or implement, the XFS changes
> if you use v7 of this patchset as the starting point? (v8 should just
> be v7 minus the dm-thin.c and dm-snap.c changes).  The thinp
> support in v7 will work enough to allow XFS to issue REQ_OP_PROVISION
> and/or fallocate (via mkfs.xfs) to dm-thin devices.

Yup, XFS only needs blkdev_issue_provision() and
bdev_max_provision_sectors() to be present.  filesystem code. The
initial XFS provisioning detection and fallocate() support is just
under 50 lines of new code...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
