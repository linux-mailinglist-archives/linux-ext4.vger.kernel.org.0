Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78ED573938B
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Jun 2023 02:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjFVAGY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Jun 2023 20:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjFVAGV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 21 Jun 2023 20:06:21 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4C82135
        for <linux-ext4@vger.kernel.org>; Wed, 21 Jun 2023 17:05:44 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-666eef03ebdso2838849b3a.1
        for <linux-ext4@vger.kernel.org>; Wed, 21 Jun 2023 17:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1687392290; x=1689984290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=788rYanbVHYoHymSSCDQuQkLFJmxVv3NMkigvKoFSg8=;
        b=SCTpPuLeHaddmo/McTxHe9QtBW6AE3Vg1KFczXkzvyQ37voJaocWjo/Dvl3S8v14xK
         eLs8CM3ssBwlopA47r5eXtbcFyADsyniu7ipOrZEK6IL/s6aSlbUcpLPegbVsDzJsFE1
         RuOCKD5sZI8FCzbnE7yTm0HBPTJYpbULbkke6Hq4r1cpGlvvbLsABVY6uGXyRlCZRGgU
         cyYBaHJhOQ7ZFHN1klRhR+RCxFvhhyooulI9NiHok0LxF/cYEmxXG1/nA9GcH5zOgADM
         v4tJG2EqAyITvr5D1YalB4HFSyFDMOvSbZh02hS0irxjgMD/cvkkSksWC2YDb72n3DFm
         wnIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687392290; x=1689984290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=788rYanbVHYoHymSSCDQuQkLFJmxVv3NMkigvKoFSg8=;
        b=PYF0tUPj/+BW4cBL2DWW2JEKjn66JXLrkJq00qv3+9AJR8iHtWWMH0hpD3JXWaL4FF
         Vwcw6uE2jSNfbI0JWLRdqAIBcA2gv4SmezcWpsZtep0iO0mhLnZDlQw08p29SMVmUFlI
         lgM8dBYs0Lk+0Vl3G3PpmnLGcPe/4XVxD9qLfpno+nyTza5GnEUK9kkvMLORthWshcQa
         EEPlybD0+5TwqrMAglquzQxccffGunzKshVifhVPMKuJ8+UXKYPvqIUmDSJ/aLlSbL7e
         paUfO/8Ws9tbCRCoTX3eShh1B55zrLVFOPmK8oT9XIXd/oyx5TPHBo9DX9ei8FAVzOD9
         Qllg==
X-Gm-Message-State: AC+VfDyuQDQRgRalU7PkUquMElUIKOhUsMT2zpNvqW14CG2roSRh3kDP
        Be1AO8a2Zk8+XxyYDDh7y/ldow==
X-Google-Smtp-Source: ACHHUZ74tWpyMbpCkTknjwqs/V+ciWQxw301BjKhbwxqb6hGHFfNAu/mshRXv8ebra5fcjpbW64VHg==
X-Received: by 2002:a05:6a00:3a14:b0:668:82fe:16e2 with SMTP id fj20-20020a056a003a1400b0066882fe16e2mr7321749pfb.16.1687392290498;
        Wed, 21 Jun 2023 17:04:50 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-13-202.pa.nsw.optusnet.com.au. [49.180.13.202])
        by smtp.gmail.com with ESMTPSA id j25-20020a62e919000000b00662610cf7a8sm3486378pfh.172.2023.06.21.17.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 17:04:49 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qC7oc-00EdnR-1n;
        Thu, 22 Jun 2023 10:04:46 +1000
Date:   Thu, 22 Jun 2023 10:04:46 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jeremy Bongio <bongiojp@gmail.com>
Cc:     Ted Tso <tytso@mit.edu>, "Darrick J . Wong" <djwong@kernel.org>,
        Allison Henderson <allison.henderson@oracle.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/1] For DIO writes with no mapped pages for inode, skip
 deferring completion.
Message-ID: <ZJOQHpKjghoGWYZ4@dread.disaster.area>
References: <20230621174114.1320834-1-bongiojp@gmail.com>
 <20230621174114.1320834-2-bongiojp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621174114.1320834-2-bongiojp@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 21, 2023 at 10:29:20AM -0700, Jeremy Bongio wrote:
> If there are no mapped pages for an DIO write then the page cache does not
> need to be updated. For very fast SSDs and direct async IO, deferring work
> completion can result in a significant performance loss.
> ---
>  fs/iomap/direct-io.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 019cc87d0fb3..8f27d0dc4f6d 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -168,7 +168,9 @@ void iomap_dio_bio_end_io(struct bio *bio)
>  			struct task_struct *waiter = dio->submit.waiter;
>  			WRITE_ONCE(dio->submit.waiter, NULL);
>  			blk_wake_io_task(waiter);
> -		} else if (dio->flags & IOMAP_DIO_WRITE) {
> +		} else if (dio->flags & IOMAP_DIO_WRITE &&
> +			(!dio->iocb->ki_filp->f_inode ||
> +			    dio->iocb->ki_filp->f_inode->i_mapping->nrpages))) {
>  			struct inode *inode = file_inode(dio->iocb->ki_filp);

Writes that are need O_DSYNC, unwritten extent conversion, file size
extension, etc all need to be deferred. This will break all of them,
as well as any other type of write that the filesystem itself needs
to run completion in task context.

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
