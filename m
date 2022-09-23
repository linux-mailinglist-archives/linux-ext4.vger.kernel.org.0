Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB7F5E7C7F
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Sep 2022 16:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbiIWOIU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 23 Sep 2022 10:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiIWOIS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 23 Sep 2022 10:08:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC6F148A0F
        for <linux-ext4@vger.kernel.org>; Fri, 23 Sep 2022 07:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663942095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LBYIB5Hr/s79C5MbXbGY0mfsUxmhEdiC6zxTkuGSCwk=;
        b=e/BXz5Xapq4s3pC2kT3QKRkV6RWRq6Hr2uZWd5oEduEc6OJLod7lun/dWD5FpzI5IsI/uV
        LQKL+yzlxEEXH+/vOuQrQtC32AnMrCxvHiyUKvQ3Vrg8LxFdJJDbNCL/P4B8vvAYDH1jhb
        v+R7n59y0s8E5sescrHadnuFsHCfL/0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-465-Jiyrdi7_NkOxOTe1ZQuC_g-1; Fri, 23 Sep 2022 10:08:13 -0400
X-MC-Unique: Jiyrdi7_NkOxOTe1ZQuC_g-1
Received: by mail-qt1-f200.google.com with SMTP id g21-20020ac87d15000000b0035bb6f08778so54374qtb.2
        for <linux-ext4@vger.kernel.org>; Fri, 23 Sep 2022 07:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=LBYIB5Hr/s79C5MbXbGY0mfsUxmhEdiC6zxTkuGSCwk=;
        b=MIQhS2GhZrHD5ILjx2WPnGsYxspmQjkZrxw8vNXqh496Ka42ZcV/5OPItMnPNPZYgC
         DWHZM/KB8404q5j/iuED1guB/2fweJw7GcK/3O8z/FZzaY7Rk9pj0X6UK/Be3VO/+kQt
         NKFVsyM9tUOsYus6QknnxdX9h44US5B0RuTnnoQny0PN0NxJ8mM5SKAqx12rMAXWF7l7
         s99VMf4iPmWVR8ws7/+OrmFqWOM7cWKPNTwtTZTL+go8TItiSgWH08YFR+sALdAxN4p7
         27g89hVhywyyIjmMNX2zL1EYoZZneSFCODgFOZl0XmEQpj6qJw6gAUHYUzRU+yePNf8b
         7ewQ==
X-Gm-Message-State: ACrzQf3ESoe3U1qjGrtFz/7TQphsMnUIAEO8HEX5ketJ5zcmwxfW0PXB
        Mom6p+cldd6TYOqugt9ZyCVjHDFE+AxaUvf5fUzC+L1rq0JsasZuXIxCcC+QBiQMGjcfRx60hRW
        5I9umIjjKpV9Ly2q3r0uQ
X-Received: by 2002:ac8:5dc9:0:b0:35c:dac8:a141 with SMTP id e9-20020ac85dc9000000b0035cdac8a141mr7271310qtx.229.1663942093306;
        Fri, 23 Sep 2022 07:08:13 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4hP35ZcbFzjjav7W2Ml66N3dqlsgPCpf9kKzESU216uoZsCAsOatn0mJ4gZX5U/fSihe9dkw==
X-Received: by 2002:ac8:5dc9:0:b0:35c:dac8:a141 with SMTP id e9-20020ac85dc9000000b0035cdac8a141mr7271263qtx.229.1663942092916;
        Fri, 23 Sep 2022 07:08:12 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id cq3-20020a05622a424300b0035ced0a8382sm5566028qtb.54.2022.09.23.07.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 07:08:12 -0700 (PDT)
Date:   Fri, 23 Sep 2022 10:08:11 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Daniil Lunev <dlunev@google.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Sarthak Kukreti <sarthakkukreti@chromium.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        Mike Snitzer <snitzer@kernel.org>,
        linux-kernel@vger.kernel.org, Gwendal Grignou <gwendal@google.com>,
        virtualization@lists.linux-foundation.org, dm-devel@redhat.com,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-ext4@vger.kernel.org, Evan Green <evgreen@google.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH RFC 0/8] Introduce provisioning primitives for thinly
 provisioned storage
Message-ID: <Yy29y/jUvWM6GRZ5@redhat.com>
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
 <YyQTM5PRT2o/GDwy@fedora>
 <CAG9=OMPHZqdDhX=M+ovdg5fa3x4-Q_1r5SWPa8pMTQw0mr5fPg@mail.gmail.com>
 <Yylvvm3zVgqpqDrm@infradead.org>
 <CAAKderPF5Z5QLxyEb80Y+90+eR0sfRmL-WfgXLp=eL=HxWSZ9g@mail.gmail.com>
 <YymkSDsFVVg1nbDP@infradead.org>
 <CAAKderNcHpbBqWqqd5-WuKLRCQQUt7a_4D4ti4gy15+fKGK0vQ@mail.gmail.com>
 <Yy1zkMH0f9ski4Sg@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yy1zkMH0f9ski4Sg@infradead.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Sep 23 2022 at  4:51P -0400,
Christoph Hellwig <hch@infradead.org> wrote:

> On Wed, Sep 21, 2022 at 07:48:50AM +1000, Daniil Lunev wrote:
> > > There is no such thing as WRITE UNAVAILABLE in NVMe.
> > Apologize, that is WRITE UNCORRECTABLE. Chapter 3.2.7 of
> > NVM Express NVM Command Set Specification 1.0b
> 
> Write uncorrectable is a very different thing, and the equivalent of the
> horribly misnamed SCSI WRITE LONG COMMAND.  It injects an unrecoverable
> error, and does not provision anything.
> 
> > * Each application is potentially allowed to consume the entirety
> >   of the disk space - there is no strict size limit for application
> > * Applications need to pre-allocate space sometime, for which
> >   they use fallocate. Once the operation succeeded, the application
> >   assumed the space is guaranteed to be there for it.
> > * Since filesystems on the volumes are independent, filesystem
> >   level enforcement of size constraints is impossible and the only
> >   common level is the thin pool, thus, each fallocate has to find its
> >   representation in thin pool one way or another - otherwise you
> >   may end up in the situation, where FS thinks it has allocated space
> >   but when it tries to actually write it, the thin pool is already
> >   exhausted.
> > * Hole-Punching fallocate will not reach the thin pool, so the only
> >   solution presently is zero-writing pre-allocate.
> 
> To me it sounds like you want a non-thin pool in dm-thin and/or
> guaranted space reservations for it.

What is implemented in this patchset: enablement for dm-thinp to
actually provide guarantees which fallocate requires.

Seems you're getting hung up on the finishing details in HW (details
which are _not_ the point of this patchset).

The proposed changes are in service to _Linux_ code. The patchset
implements the primitive from top (ext4) to bottom (dm-thinp, loop).
It stops short of implementing handling everywhere that'd need it
(e.g. in XFS, etc). But those changes can come as follow-on work once
the primitive is established top to bottom.

But you know all this ;)

> > * Thus, a provisioning block operation allows an interface specific
> >   operation that guarantees the presence of the block in the
> >   mapped space. LVM Thin-pool itself is the primary target for our
> >   use case but the argument is that this operation maps well to
> >   other interfaces which allow thinly provisioned units.
> 
> I think where you are trying to go here is badly mistaken.  With flash
> (or hard drive SMR) there is no such thing as provisioning LBAs.  Every
> write is out of place, and a one time space allocation does not help
> you at all.  So fundamentally what you try to here just goes against
> the actual physics of modern storage media.  While there are some
> layers that keep up a pretence, trying to that an an exposed API
> level is a really bad idea.

This doesn't need to be so feudal.  Reserving an LBA in physical HW
really isn't the point.

Fact remains: an operation that ensures space is actually reserved via
fallocate is long overdue (just because an FS did its job doesn't mean
underlying layers reflect that). And certainly useful, even if "only"
benefiting dm-thinp and the loop driver. Like other block primitives,
REQ_OP_PROVISION is filtered out by block core if the device doesn't
support it.

That said, I agree with Brian Foster that we need really solid
documentation and justification for why fallocate mode=0 cannot be
used (but the case has been made in this thread).

Also, I do see an issue with the implementation (relative to stacked
devices): dm_table_supports_provision() is too myopic about DM. It
needs to go a step further and verify that some layer in the stack
actually services REQ_OP_PROVISION. Will respond to DM patch too.

