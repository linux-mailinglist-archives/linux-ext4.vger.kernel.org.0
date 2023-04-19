Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7974F6E85CD
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Apr 2023 01:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbjDSXV1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 19 Apr 2023 19:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjDSXV0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 19 Apr 2023 19:21:26 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B3E1FC3
        for <linux-ext4@vger.kernel.org>; Wed, 19 Apr 2023 16:21:22 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1a8097c1ccfso5783485ad.1
        for <linux-ext4@vger.kernel.org>; Wed, 19 Apr 2023 16:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1681946482; x=1684538482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O4EzLlnke++OBfC+QU/8848E+9V2OKTR6syW6axwlV8=;
        b=1rSGerHklr5JAXi27oI/uAKbIpnzmbhuAcqtkq9Ewpy+oxiEbVyn+NXg0Nte1Jz5gb
         Jddew7juj8EN4LNPm7rX/98XzjawOZWNBXgYRDT4svPbR6SgKWYB3DBdvEC6M5GMrfwT
         NVGwJGMv68WQml94zJmFq7eiIKhhHdqtvpReJGsxvaD7E+Q5v+/9MtrHrCKvxTmZ6EDY
         BasRW6aVsh4KPRIad1iWbms6wcLJVor1YOWpS9y4GmXYAKYprdaeppUQ33xbvQC/eBjL
         dLUjVVOrNBmfM3cIFzadvXJVlSI7PHUWmH/8OBSUCDMgpYod0Y/sBth54czPU5qQiJoJ
         NrDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681946482; x=1684538482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4EzLlnke++OBfC+QU/8848E+9V2OKTR6syW6axwlV8=;
        b=FqgCy3NQi5l3p0DjTJcMU/ym8gsv4aNkOv8CRV2sgKN9EYjYxNRGsZ3w2T7Qqca1tF
         G9Ht7k67m9EVW7af2wQKPc/O3RDj7bTpPwjvy28aiDKVJmE2i2deAKJYpz89IjEepqn5
         YxH7s3foLWNZuvgsZoN58egSIqy4HDwHnIwNQxai+50jEPeAYbvnBWf/3iKq4ZVdgZnZ
         2ms4EsAbWXJ5+wS7F7vKzAbvYg3Bh4HmwfQXODik/IbRiiv7swjF9MrAP/WPtW3DC3ze
         vm0FApMh5IrLHaVeujm5u/ke7nvDXWNxMKtEsI5L6Rp1rMELjdSwrS9N4iBiag6JUZkv
         otow==
X-Gm-Message-State: AAQBX9cvAci1cZkvXhs3OvISuDTrNijTkLEB2AIZ+ExcIUPsuIKqZRQJ
        RevR3xxTx4zTEuZ1Hv7KIyubsw==
X-Google-Smtp-Source: AKy350Z4u0R970I4rdGzZzRQmNJeDe7b2z6B1qSAUlPIrkwDXPChvEc+qQO8pUmxrKDtn7iIylQMpQ==
X-Received: by 2002:a17:902:b089:b0:19d:611:2815 with SMTP id p9-20020a170902b08900b0019d06112815mr6659257plr.42.1681946481873;
        Wed, 19 Apr 2023 16:21:21 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-41-174.pa.nsw.optusnet.com.au. [49.180.41.174])
        by smtp.gmail.com with ESMTPSA id ja13-20020a170902efcd00b0019682e27995sm6226725plb.223.2023.04.19.16.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 16:21:21 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ppH70-005RJM-QK; Thu, 20 Apr 2023 09:21:18 +1000
Date:   Thu, 20 Apr 2023 09:21:18 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Mike Snitzer <snitzer@kernel.org>,
        Sarthak Kukreti <sarthakkukreti@chromium.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Theodore Ts'o <tytso@mit.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Daniil Lunev <dlunev@google.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v4 1/4] block: Introduce provisioning primitives
Message-ID: <20230419232118.GL447837@dread.disaster.area>
References: <20230414000219.92640-1-sarthakkukreti@chromium.org>
 <20230418221207.244685-1-sarthakkukreti@chromium.org>
 <20230418221207.244685-2-sarthakkukreti@chromium.org>
 <20230419153611.GE360885@frogsfrogsfrogs>
 <ZEAUHnWqt9cIiJRb@redhat.com>
 <20230419172602.GE360881@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419172602.GE360881@frogsfrogsfrogs>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 19, 2023 at 10:26:02AM -0700, Darrick J. Wong wrote:
> On Wed, Apr 19, 2023 at 12:17:34PM -0400, Mike Snitzer wrote:
> > (And obviously needs fixing independent of this patchset)
> > 
> > Shouldn't mkfs first check that the underlying storage supports
> > REQ_OP_PROVISION by verifying
> > /sys/block/<dev>/queue/provision_max_bytes exists and is not 0?
> > (Just saying, we need to add new features more defensively.. you just
> > made the case based on this scenario's implications alone)
> 
> Not for fallocate -- for regular files, there's no way to check if the
> filesystem actually supports the operation requested other than to try
> it and see if it succeeds.  We probably should've defined a DRY_RUN flag
> for that purpose back when it was introduced.

That ignores the fact that fallocate() was never intended to
guarantee it will work in all contexts - it's an advisory interface
at it's most basic level. If the call succeeds, then great, it does
what is says on the box, but if it fails then it should have no
visible effect on user data at all and the application still needs
to perform whatever modification it needed done in some other way.

IOWs, calling it one a block device without first checking if the
block device supports that fallocate operation is exactly how it is
supposed to be used. If the kernel can't handle this gracefully
without corrupting data, then that's a kernel bug and not an
application problem.

> For fallocate calls to block devices, yes, the program can check the
> queue limits in sysfs if fstat says the supplied path is a block device,
> but I don't know that most programs are that thorough.  The fallocate(1)
> CLI program does not check.

Right. fallocate() was intended to just do the right thing without
the application having to jump thrown an unknown number of hoops to
determine if fallocate() can be used or not in the context it is
executing in.  The kernel implementation is supposed to abstract all that
context-dependent behaviour away from the application; all the
application has to do is implement the fallocate() fast path and a
single generic "do the right thing the slow way" fallback when the
fallocate() method it called is not supported...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
