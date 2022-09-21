Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FC85C0104
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Sep 2022 17:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiIUPVo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Sep 2022 11:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiIUPVn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 21 Sep 2022 11:21:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7B4883E1
        for <linux-ext4@vger.kernel.org>; Wed, 21 Sep 2022 08:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663773701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YKklums/Err7Bepni4gts8csmAXQyEMPG5WxwPmhH+I=;
        b=LxEZEjCN8/+dsKjtIurayuBpoOOtpjNbUiXmkUjEkF3SHk6jiq+tjE8sYUQaPeCTkxi/bM
        Rpk7AGbLEidN61pkWuQI6M7Hqx3UMa3o86G4ILj6FFQO2VcJEeQVm70zO4hQGHLUloMoGa
        S3daL4K9sexMXcRQVID7WjLrkHvc/gA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-97-zjVG_SonMLiK__jMeIvVxQ-1; Wed, 21 Sep 2022 11:21:40 -0400
X-MC-Unique: zjVG_SonMLiK__jMeIvVxQ-1
Received: by mail-qv1-f71.google.com with SMTP id mx9-20020a0562142e0900b004a1ddfe8ee3so4487334qvb.2
        for <linux-ext4@vger.kernel.org>; Wed, 21 Sep 2022 08:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=YKklums/Err7Bepni4gts8csmAXQyEMPG5WxwPmhH+I=;
        b=0VUUxGyezNxP70/cr9DrDOu+/JJDhABDneqMqroonjKwAmIqvJ6i4i4sW8c6d+2VEp
         pU3RIHI7c8IhjrUGHprT6Mb1U2YLTC/HzNXmU7ZZCFC9ToKXVKzW5Pm099zMiBMv0PwK
         3tDKLE71YKGruNw5L+zWWkrjcrux/d5SWb9SnW9BOPsrnhT1aaV9+znn9Zk+UkNUAhmF
         sRFtCPJSBigSZeCbOrr4ZA0CwNJbNXzA8j4YeoCj15tjCnWb0u0p9b5VDDH4ZGtvaH/x
         tLye/VAerzwTi2aV5oiAN9Zypiux4e7KTl3QHrcZQZNFZ8itRhtleAllb1cjWPbaFF4Y
         U7VA==
X-Gm-Message-State: ACrzQf2Aud0eyU5EIZS6VhiZCL5eFVazLLmlfYGYLY4/CjpBYinzwn4m
        8H4YZuTBWzCXDr2jx6DO447lHI1xr9afpEhqZ92u15UMkq7IwT06hSr7TJScE8wB6Mx96Vrystn
        P1K+b0rxsCYY6Q6m6ego6
X-Received: by 2002:a05:622a:613:b0:342:f81f:4f7e with SMTP id z19-20020a05622a061300b00342f81f4f7emr23848804qta.198.1663773699670;
        Wed, 21 Sep 2022 08:21:39 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7OzWfjG2GRtTFHT6VQqKwenYDGxd0vRx6UOENP8cSn03FrcY2GR/YED/OGOmZJunHnK1JMlw==
X-Received: by 2002:a05:622a:613:b0:342:f81f:4f7e with SMTP id z19-20020a05622a061300b00342f81f4f7emr23848782qta.198.1663773699383;
        Wed, 21 Sep 2022 08:21:39 -0700 (PDT)
Received: from localhost ([217.138.198.196])
        by smtp.gmail.com with ESMTPSA id cf14-20020a05622a400e00b0031f41ea94easm1815844qtb.28.2022.09.21.08.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 08:21:39 -0700 (PDT)
Date:   Wed, 21 Sep 2022 11:21:37 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     Christoph Hellwig <hch@infradead.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>,
        Evan Green <evgreen@google.com>,
        Gwendal Grignou <gwendal@google.com>
Subject: Re: [PATCH RFC 4/8] fs: Introduce FALLOC_FL_PROVISION
Message-ID: <YyssAb/zTcIG2bev@redhat.com>
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
 <20220915164826.1396245-5-sarthakkukreti@google.com>
 <YylweQAZkIdb5ixo@infradead.org>
 <CAG9=OMNoG01UUStNs_Zhsv6mXZw0M0q2v54ZriJvHZ4aspvjEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG9=OMNoG01UUStNs_Zhsv6mXZw0M0q2v54ZriJvHZ4aspvjEQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Sep 21 2022 at  1:54P -0400,
Sarthak Kukreti <sarthakkukreti@chromium.org> wrote:

> On Tue, Sep 20, 2022 at 12:49 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Thu, Sep 15, 2022 at 09:48:22AM -0700, Sarthak Kukreti wrote:
> > > From: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > >
> > > FALLOC_FL_PROVISION is a new fallocate() allocation mode that
> > > sends a hint to (supported) thinly provisioned block devices to
> > > allocate space for the given range of sectors via REQ_OP_PROVISION.
> >
> > So, how does that "provisioning" actually work in todays world where
> > storage is usually doing out of place writes in one or more layers,
> > including the flash storage everyone is using.  Does it give you one
> > write?  And unlimited number?  Some undecided number inbetween?
> 
> Apologies, the patchset was a bit short on describing the semantics so
> I'll expand more in the next revision; I'd say that it's the minimum
> of regular mode fallocate() guarantees at each allocation layer. For
> example, the guarantees from a contrived storage stack like (left to
> right is bottom to top):
> 
> [ mmc0blkp1 | ext4(1) | sparse file | loop | dm-thinp | dm-thin | ext4(2) ]
> 
> would be predicated on the guarantees of fallocate() per allocation
> layer; if ext4(1) was replaced by a filesystem that did not support
> fallocate(), then there would be no guarantee that a write to a file
> on ext4(2) succeeds.
> 
> For dm-thinp, in the current implementation, the provision request
> allocates blocks for the range specified and adds the mapping to the
> thinpool metadata. All subsequent writes are to the same block, so
> you'll be able to write to the same block inifinitely. Brian mentioned
> this above, one case it doesn't cover is if provision is called on a
> shared block, but the natural extension would be to allocate and
> assign a new block and copy the contents of the shared block (kind of
> like copy-on-provision).

It follows that ChromiumOS isn't using dm-thinp's snapshot support?

But please do fold in incremental dm-thinp support to properly handle
shared blocks (dm-thinp already handles breaking sharing, etc.. so
I'll need to see where you're hooking into that you don't get this
"for free").

Mike

