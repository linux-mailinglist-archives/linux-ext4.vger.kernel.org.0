Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5617E7C4467
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Oct 2023 00:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343902AbjJJWm5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 Oct 2023 18:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbjJJWm4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 10 Oct 2023 18:42:56 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091629D
        for <linux-ext4@vger.kernel.org>; Tue, 10 Oct 2023 15:42:53 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9b27bc8b65eso1037625166b.0
        for <linux-ext4@vger.kernel.org>; Tue, 10 Oct 2023 15:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696977771; x=1697582571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tb9bykOj2PFr0JPtI/2Jn1spETOn70fv/I2YmNILcfw=;
        b=CvU9EPj1lUJQyOfAGhYeGOjHZqZh94H8624ZCxtj/g4utxU07Pzp9HavSi9mU6cImZ
         p8KwpzKyS38reVcjErdfotvGWGeX62qduqXmHaCwNdXi9MaP0w2ZdfAcvbDL/66LhvoA
         Rnqj9gBEYjcg319GJ4vHBeHraFRVuGXeDWdU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696977771; x=1697582571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tb9bykOj2PFr0JPtI/2Jn1spETOn70fv/I2YmNILcfw=;
        b=Ar+mjniq6HLLhk2JfiVpCPo/OmCoRz7g76k2hh0TZMNvgu5763fAaguqes1EQthtn9
         CDB1U64Wjs2ZDG3HbL/qdQAeC3nBjCWr1Le4rCH414KAb/kumpyPvCQ6FTeuj2qz6rVh
         G1ifUA5CrDdhSa2u9r139Xs3mIggG7lFur+yLZ81bK7a8FHVkMPPohdLStDW4O1rK+ps
         rPIASUQll9J6yRpOaJ/o8uiwIsQMZBC6ItE5Ed5u96PM4FH+sje6+1+lX8AXn5VSqvF1
         MuuFWcupq0YbyD4b9ba8yq44Ql3WHMgoKiKcSBRlp+EVn0ehJKqhexJGZPlQHHxA0KPq
         GWUA==
X-Gm-Message-State: AOJu0YxUT0Ah4fV1VP0U+bg1LttesEYAIZCptXDUEwPTh0DinI62VHVF
        e6IJ2/3LL/QN1xXW7xpPkiQHGNoZUc7oBheqwWzkzQ==
X-Google-Smtp-Source: AGHT+IHovl1AnfLJUnwNPKM37IAziJkKti9gYfE82FUNcROx92edpN/rECBAy7Ui9Lg+Iqjm2+QUlHjRja83n7tAqZI=
X-Received: by 2002:a17:906:9a:b0:9b2:b149:b818 with SMTP id
 26-20020a170906009a00b009b2b149b818mr17960595ejc.70.1696977771190; Tue, 10
 Oct 2023 15:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <20231007012817.3052558-1-sarthakkukreti@chromium.org>
 <20231007012817.3052558-6-sarthakkukreti@chromium.org> <ZSM64EOTVyKNkc/X@dread.disaster.area>
In-Reply-To: <ZSM64EOTVyKNkc/X@dread.disaster.area>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Tue, 10 Oct 2023 15:42:39 -0700
Message-ID: <CAG9=OMP_YbfCyjJGGwoZfgwxO-FmR55F5zv3DO8c2-=YzY8iwA@mail.gmail.com>
Subject: Re: [PATCH v8 5/5] block: Pass unshare intent via REQ_OP_PROVISION
To:     Dave Chinner <david@fromorbit.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Oct 8, 2023 at 4:27=E2=80=AFPM Dave Chinner <david@fromorbit.com> w=
rote:
>
> On Fri, Oct 06, 2023 at 06:28:17PM -0700, Sarthak Kukreti wrote:
> > Allow REQ_OP_PROVISION to pass in an extra REQ_UNSHARE bit to
> > annotate unshare requests to underlying layers. Layers that support
> > FALLOC_FL_UNSHARE will be able to use this as an indicator of which
> > fallocate() mode to use.
> >
> > Suggested-by: Darrick J. Wong <djwong@kernel.org>
> > Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > ---
> >  block/blk-lib.c           |  6 +++++-
> >  block/fops.c              |  6 ++++--
> >  drivers/block/loop.c      | 35 +++++++++++++++++++++++++++++------
> >  include/linux/blk_types.h |  3 +++
> >  include/linux/blkdev.h    |  3 ++-
> >  5 files changed, 43 insertions(+), 10 deletions(-)
>
> I have no idea how filesystems (or even userspace applications, for
> that matter) are supposed to use this - they have no idea if the
> underlying block device has shared blocks for LBA ranges it already
> has allocated and provisioned. IOWs, I don't know waht the semantics
> of this function is, it is not documented anywhere, and there is no
> use case present that tells me how it might get used.
>
> Yes, unshare at the file level means the filesystem tries to break
> internal data extent sharing, but if the block layers or backing
> devices are doing deduplication and sharing unknown to the
> application or filesystem, how do they ever know that this operation
> might need to be performed? In what cases do we need to be able to
> unshare block device ranges, and how is that different to the
> guarantees that REQ_PROVISION is already supposed to give for
> provisioned ranges that are then subsequently shared by the block
> device (e.g. by snapshots)?
>
> Also, from an API perspective, this is an "unshare" data operation,
> not a "provision" operation. Hence I'd suggest that the API should
> be blkdev_issue_unshare() rather than optional behaviour to
> _provision() which - before this patch - had clear and well defined
> meaning....
>
Fair points, the intent from the conversation with Darrick was the
addition of support for FALLOC_FL_UNSHARE_RANGE in patch 2 of v4
(originally suggested by Brian Forster in [1]): if we allow
fallocate(UNSHARE_RANGE) on a loop device (ex. for creating a
snapshot, similar in nature to the FICLONE example you mentioned on
the loop patch), we'd (ideally) want to pass it through to the
underlying layers and let them figure out what to do with it. But it
is only for situations where we are explicitly know what the
underlying layers are and what's the mecha

I agree though that it clouds the API a bit and I don't think it
necessarily needs to be a part of the initial patch series: for now, I
propose keeping just mode zero (and FALLOC_FL_KEEP_SIZE) handling in
the block series patch and drop this patch for now. WDYT?

Best
Sarthak

[1] https://patchwork.ozlabs.org/project/linux-ext4/patch/20230414000219.92=
640-2-sarthakkukreti@chromium.org/#3097746




> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
