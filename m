Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F0A5B0C77
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Sep 2022 20:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiIGSZb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Sep 2022 14:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiIGSZa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Sep 2022 14:25:30 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B523B2CCF
        for <linux-ext4@vger.kernel.org>; Wed,  7 Sep 2022 11:25:29 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id fv3so9246395pjb.0
        for <linux-ext4@vger.kernel.org>; Wed, 07 Sep 2022 11:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=2ZUqA026vcCJ43SJq+pCWrWjB35bmR93qk8kqzRDDU4=;
        b=QMzJ3U11SlIV6lFKovRKtaGagk8dkOSiFmtlMW7nnXFsOUEqR5UppVJXsP1YANj13D
         t7WGU4b1zFksbmu6y+tDMNbMTUvULEDvoCVnyzwpkPuBZsoWfntnuMAJCxohop1jjBdb
         s7BgpfHwLWUrVmHge6MQ3df5aT7Pxha0c+qVJkescx6s1hiHV3AgwJheEEGMaFT90lEG
         so66UG2y3IdYcRP9J3wycgg7dbSLw2/0OcFjkOB0RsjBQTyuAwWVGrIgQgzL+blcF43F
         S3SEozrW47Tqgy70jltM7vJC1GNwEAcSiaPujJ9FLrn5UrbUGRjpgl3YTBoLaaDKhv/h
         qLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=2ZUqA026vcCJ43SJq+pCWrWjB35bmR93qk8kqzRDDU4=;
        b=SFwWaNaMauOwLwgTvDrUa20m/8kOTbBVl+PEzaZAZLCUXqj6b3y1FjzdZNeC8WsszP
         85EM1Jb07C/zeUMxC3QpbeXZKotcwGDQahez5dEJOU4X//28bMMjX71406+3oXNTXxAv
         6XmpM8VoVv9DrpqsMjSPlXFcLvuP55Bm5BV0MTc/i0WyrOAJuqhSjeYeDRNnknZLtgmW
         1sCk1OkIOiG0Z4fjBgBdKn4hTtN5ApvYttKjTJWycF22oy94pX4xOaxM8ljSf8fPbSsn
         81x/aQYY3dmm5lcsVp0OReV6tWAV5xLfZ/50YJuLkPDoh9LuhEQkgV54FTeWSHy3kTUE
         nwmA==
X-Gm-Message-State: ACgBeo30GLBaZp/qt7bstYZHex7XsNwOSni8U/pc/WV8GOXpWktKQw8l
        a56chHpQp7mPt6XnMX04haM=
X-Google-Smtp-Source: AA6agR4bmKORyGh2sK1N1PkJh8YvwV1ZFbs0LO3sYWfKJYXkGwWbMk4t1GjsFcX2QUr/SE0I+rVlkQ==
X-Received: by 2002:a17:90a:4fe3:b0:1fd:b6f7:f5e3 with SMTP id q90-20020a17090a4fe300b001fdb6f7f5e3mr32057192pjh.169.1662575128646;
        Wed, 07 Sep 2022 11:25:28 -0700 (PDT)
Received: from localhost ([2406:7400:63:83c4:f166:555c:90a1:a48d])
        by smtp.gmail.com with ESMTPSA id nh20-20020a17090b365400b002004a2eab5bsm7603144pjb.14.2022.09.07.11.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 11:25:28 -0700 (PDT)
Date:   Wed, 7 Sep 2022 23:55:22 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: [PATCH 4/5] ext4: Use locality group preallocation for small
 closed files
Message-ID: <20220907182522.mvciqy4wrtmnjqv4@riteshh-domain>
References: <20220906150803.375-1-jack@suse.cz>
 <20220906152920.25584-4-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906152920.25584-4-jack@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/09/06 05:29PM, Jan Kara wrote:
> Curently we don't use any preallocation when a file is already closed
> when allocating blocks (from writeback code when converting delayed
> allocation). However for small files, using locality group preallocation

I had always wondered about this case. But yes for small files it completely
make sense to enable preallocations for smaller files even though they are
closed.


> is actually desirable as that is not specific to a particular file.
> Rather it is a method to pack small files together to reduce
> fragmentation and for that the fact the file is closed is actually even
> stronger hint the file would benefit from packing. So change the logic
> to allow locality group preallocation in this case.
> 

One thing which comes to mind is that we never discard lg preallocations.
With this change we will always enable lg preallocations for small files. 
These preallocations will then be only discarded when some allocation request
fails which will be retried after doing discard preallocations. 

Though it is not a problem, since any small file allocation will benefit out of
these lgs. But it shouldn't be too large that it starts causing performance hits 
for large files. 
Not for this patch but something to remember maybe ^^^^. 
(While we are internally looking at preallocation space for few optimizations, 
above is something to keep a note of.)


> Signed-off-by: Jan Kara <jack@suse.cz>

Looks good to me.
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
