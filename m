Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCBE5BB26F
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Sep 2022 20:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiIPSst (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 16 Sep 2022 14:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiIPSst (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 16 Sep 2022 14:48:49 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAE9B8F0F
        for <linux-ext4@vger.kernel.org>; Fri, 16 Sep 2022 11:48:47 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id kr11so5369764ejc.8
        for <linux-ext4@vger.kernel.org>; Fri, 16 Sep 2022 11:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=SdKZkQSOOeZ73NFTfXwaDLPs0+FX9IJxa8fOyAWvQWo=;
        b=jPbxqkcJ18+RZwG4Xt8jUmsZkdqH2rsOtYcfpH9++ASA+lpXozL6u8Xpcawj7xrriu
         zylCptexZ4/vToAy5m1VgKpvp8wdlA7c0oByY7fIAp8hStBk9mBFWHnIUnZJAXhrT+dW
         1uLVgpXxBuAXs/wLz9oAgKyYBMlq8Eze6MK2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=SdKZkQSOOeZ73NFTfXwaDLPs0+FX9IJxa8fOyAWvQWo=;
        b=gZzujUcLItnzY9KCVQgdkvLhjORXppvPkFUrW0b7OM3TDPnZArIObQWz9knVoiBGwX
         wPEqS05gMaeBu1U0uB4nNz4tHBDBHDELEbu/2P6VgMAnCOSKUlq5M897IS/mebG9zWfs
         vU+ZubGGCfdv6+UjIABNgt6O77R5lbaKItheSIFzBWa9OdtGM7duvmLf3k6D2K6EX+eH
         ifVzabeDYbIUEv9XxikfC0TUk0cmhQhhPJPwTzgRj6ReUIRR5tkNKWG/oTgevdSeIM/b
         BV5w8An3KlWnTrcr5o2+roD6ii9vqccbrqsiXnvCOkiMAMDU0stUVRjr8+9uypV6PVPA
         RLaw==
X-Gm-Message-State: ACrzQf1QA2mhbjfMkFAGwQUmkQlcA5wXm1PjazeJNeHN6ZLyJGP2oU/f
        goumXsuefP0aQeNP53245SQj27Y2YOWEFWwEZqhy2Q==
X-Google-Smtp-Source: AMsMyM4H50Nh3fB15dbYJDOgQVr7DWdwSoN47hKf8GNOPyV4RnAetL9SU78eAuiLXsBmxUNOb3xdb298jwC8+0N02/8=
X-Received: by 2002:a17:907:628a:b0:72f:678d:6047 with SMTP id
 nd10-20020a170907628a00b0072f678d6047mr4442324ejc.456.1663354126400; Fri, 16
 Sep 2022 11:48:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220915164826.1396245-1-sarthakkukreti@google.com> <YyQTM5PRT2o/GDwy@fedora>
In-Reply-To: <YyQTM5PRT2o/GDwy@fedora>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Fri, 16 Sep 2022 11:48:34 -0700
Message-ID: <CAG9=OMPHZqdDhX=M+ovdg5fa3x4-Q_1r5SWPa8pMTQw0mr5fPg@mail.gmail.com>
Subject: Re: [PATCH RFC 0/8] Introduce provisioning primitives for thinly
 provisioned storage
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>,
        Evan Green <evgreen@google.com>,
        Gwendal Grignou <gwendal@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Sep 15, 2022 at 11:10 PM Stefan Hajnoczi <stefanha@redhat.com> wrot=
e:
>
> On Thu, Sep 15, 2022 at 09:48:18AM -0700, Sarthak Kukreti wrote:
> > From: Sarthak Kukreti <sarthakkukreti@chromium.org>
> >
> > Hi,
> >
> > This patch series is an RFC of a mechanism to pass through provision re=
quests on stacked thinly provisioned storage devices/filesystems.
> >
> > The linux kernel provides several mechanisms to set up thinly provision=
ed block storage abstractions (eg. dm-thin, loop devices over sparse files)=
, either directly as block devices or backing storage for filesystems. Curr=
ently, short of writing data to either the device or filesystem, there is n=
o way for users to pre-allocate space for use in such storage setups. Consi=
der the following use-cases:
> >
> > 1) Suspend-to-disk and resume from a dm-thin device: In order to ensure=
 that the underlying thinpool metadata is not modified during the suspend m=
echanism, the dm-thin device needs to be fully provisioned.
> > 2) If a filesystem uses a loop device over a sparse file, fallocate() o=
n the filesystem will allocate blocks for files but the underlying sparse f=
ile will remain intact.
> > 3) Another example is virtual machine using a sparse file/dm-thin as a =
storage device; by default, allocations within the VM boundaries will not a=
ffect the host.
> > 4) Several storage standards support mechanisms for thin provisioning o=
n real hardware devices. For example:
> >   a. The NVMe spec 1.0b section 2.1.1 loosely talks about thin provisio=
ning: "When the THINP bit in the NSFEAT field of the Identify Namespace dat=
a structure is set to =E2=80=981=E2=80=99, the controller ... shall track t=
he number of allocated blocks in the Namespace Utilization field"
> >   b. The SCSi Block Commands reference - 4 section references "Thin pro=
visioned logical units",
> >   c. UFS 3.0 spec section 13.3.3 references "Thin provisioning".
>
> When REQ_OP_PROVISION is sent on an already-allocated range of blocks,
> are those blocks zeroed? NVMe Write Zeroes with Deallocate=3D0 works this
> way, for example. That behavior is counterintuitive since the operation
> name suggests it just affects the logical block's provisioning state,
> not the contents of the blocks.
>
No, the blocks are not zeroed. The current implementation (in the dm
patch) is to indeed look at the provisioned state of the logical block
and provision if it is unmapped. if the block is already allocated,
REQ_OP_PROVISION should have no effect on the contents of the block.
Similarly, in the file semantics, sending an FALLOC_FL_PROVISION
requests for extents already mapped should not affect the contents in
the extents.

> > In all of the above situations, currently the only way for pre-allocati=
ng space is to issue writes (or use WRITE_ZEROES/WRITE_SAME). However, that=
 does not scale well with larger pre-allocation sizes.
>
> What exactly is the issue with WRITE_ZEROES scalability? Are you
> referring to cases where the device doesn't support an efficient
> WRITE_ZEROES command and actually writes blocks filled with zeroes
> instead of updating internal allocation metadata cheaply?
>
Yes. On ChromiumOS, we regularly deal with storage devices that don't
support WRITE_ZEROES or that need to have it disabled, via a quirk,
due to a bug in the vendor's implementation. Using WRITE_ZEROES for
allocation makes the allocation path quite slow for such devices (not
to mention the effect on storage lifetime), so having a separate
provisioning construct is very appealing. Even for devices that do
support an efficient WRITE_ZEROES implementation but don't support
logical provisioning per-se, I suppose that the allocation path might
be a bit faster (the device driver's request queue would report
'max_provision_sectors'=3D0 and the request would be short circuited
there) although I haven't benchmarked the difference.

Sarthak

> Stefan
