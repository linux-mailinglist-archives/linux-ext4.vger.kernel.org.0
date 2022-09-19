Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24AA5BD24B
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Sep 2022 18:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiISQhE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 19 Sep 2022 12:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiISQhB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 19 Sep 2022 12:37:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF50E356E0
        for <linux-ext4@vger.kernel.org>; Mon, 19 Sep 2022 09:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663605418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mchxf99lMev1aFGv2K+bOlvQAf7i2XmiTm89Tkqpih0=;
        b=Jd+MzNEriGTjP16ZUou8mauS7K1ZNN9pUEC6sDfqvt9SpdXWh1nmbp161ByoGb8XcRyDjJ
        dAefJ3ub49zMO+5LEBNp0xbbOt5eMp0Wlvh73dQ6UgKqwWgFi1hUNAlGRe1Fb/GUX2aJt0
        zz5oRrReUMUbXcz2pVahRa8iKZvjHHk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-168-e-vBbojmMZqRGk6nJlTDWA-1; Mon, 19 Sep 2022 12:36:52 -0400
X-MC-Unique: e-vBbojmMZqRGk6nJlTDWA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2DC3B811E67;
        Mon, 19 Sep 2022 16:36:52 +0000 (UTC)
Received: from localhost (unknown [10.39.192.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E3F74207B34A;
        Mon, 19 Sep 2022 16:36:50 +0000 (UTC)
Date:   Mon, 19 Sep 2022 12:36:48 -0400
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>,
        Gwendal Grignou <gwendal@google.com>,
        Theodore Ts'o <tytso@mit.edu>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Evan Green <evgreen@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Daniil Lunev <dlunev@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [dm-devel] [PATCH RFC 0/8] Introduce provisioning primitives for
 thinly provisioned storage
Message-ID: <YyiaoHcueK9g5KVy@fedora>
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
 <YyU5CyQfS+64xmnm@magnolia>
 <CAG9=OMNPnsjaUw2EUG0XFjV94-V1eD63V+1anoGM=EWKyzXEfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FvyRLtY8FNQa7tFK"
Content-Disposition: inline
In-Reply-To: <CAG9=OMNPnsjaUw2EUG0XFjV94-V1eD63V+1anoGM=EWKyzXEfg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--FvyRLtY8FNQa7tFK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 17, 2022 at 12:46:33PM -0700, Sarthak Kukreti wrote:
> On Fri, Sep 16, 2022 at 8:03 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Thu, Sep 15, 2022 at 09:48:18AM -0700, Sarthak Kukreti wrote:
> > > From: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > >
> > > Hi,
> > >
> > > This patch series is an RFC of a mechanism to pass through provision
> > > requests on stacked thinly provisioned storage devices/filesystems.
> >
> > [Reflowed text]
> >
> > > The linux kernel provides several mechanisms to set up thinly
> > > provisioned block storage abstractions (eg. dm-thin, loop devices over
> > > sparse files), either directly as block devices or backing storage for
> > > filesystems. Currently, short of writing data to either the device or
> > > filesystem, there is no way for users to pre-allocate space for use in
> > > such storage setups. Consider the following use-cases:
> > >
> > > 1) Suspend-to-disk and resume from a dm-thin device: In order to
> > > ensure that the underlying thinpool metadata is not modified during
> > > the suspend mechanism, the dm-thin device needs to be fully
> > > provisioned.
> > > 2) If a filesystem uses a loop device over a sparse file, fallocate()
> > > on the filesystem will allocate blocks for files but the underlying
> > > sparse file will remain intact.
> > > 3) Another example is virtual machine using a sparse file/dm-thin as a
> > > storage device; by default, allocations within the VM boundaries will
> > > not affect the host.
> > > 4) Several storage standards support mechanisms for thin provisioning
> > > on real hardware devices. For example:
> > >   a. The NVMe spec 1.0b section 2.1.1 loosely talks about thin
> > >   provisioning: "When the THINP bit in the NSFEAT field of the
> > >   Identify Namespace data structure is set to =E2=80=981=E2=80=99, th=
e controller ...
> > >   shall track the number of allocated blocks in the Namespace
> > >   Utilization field"
> > >   b. The SCSi Block Commands reference - 4 section references "Thin
> > >   provisioned logical units",
> > >   c. UFS 3.0 spec section 13.3.3 references "Thin provisioning".
> > >
> > > In all of the above situations, currently the only way for
> > > pre-allocating space is to issue writes (or use
> > > WRITE_ZEROES/WRITE_SAME). However, that does not scale well with
> > > larger pre-allocation sizes.
> > >
> > > This patchset introduces primitives to support block-level
> > > provisioning (note: the term 'provisioning' is used to prevent
> > > overloading the term 'allocations/pre-allocations') requests across
> > > filesystems and block devices. This allows fallocate() and file
> > > creation requests to reserve space across stacked layers of block
> > > devices and filesystems. Currently, the patchset covers a prototype on
> > > the device-mapper targets, loop device and ext4, but the same
> > > mechanism can be extended to other filesystems/block devices as well
> > > as extended for use with devices in 4 a-c.
> >
> > If you call REQ_OP_PROVISION on an unmapped LBA range of a block device
> > and then try to read the provisioned blocks, what do you get?  Zeroes?
> > Random stale disk contents?
> >
> > I think I saw elsewhere in the thread that any mapped LBAs within the
> > provisioning range are left alone (i.e. not zeroed) so I'll proceed on
> > that basis.
> >
> For block devices, I'd say it's definitely possible to get stale data, de=
pending
> on the implementation of the allocation layer; for example, with dm-thinp=
ool,
> the default setting via using LVM2 tools is to zero out blocks on allocat=
ion.
> But that's configurable and can be turned off to improve performance.
>=20
> Similarly, for actual devices that end up supporting thin provisioning, u=
nless
> the specification absolutely mandates that an LBA contains zeroes post
> allocation, some implementations will definitely miss out on that (probab=
ly
> similar to the semantics of discard_zeroes_data today). I'm operating und=
er
> the assumption that it's possible to get stale data from LBAs allocated u=
sing
> provision requests at the block layer and trying to see if we can create a
> safe default operating model from that.

Please explain the semantics of REQ_OP_PROVISION in the
code/documentation in the next revision.

Thanks,
Stefan

--FvyRLtY8FNQa7tFK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmMomqAACgkQnKSrs4Gr
c8g4vQf/TYZDC6JT8LCVfsDWkwegZYqhX4pz86cryayWYFUYe3u9UmLPrY/TuE1y
XQwzM9jsI+LdCcQtLZtvre/JsJB6esC/LGv+FTGOSju2n0FLXTS7v80LujcoHnKE
7RZ0eliz4XGK/X1Q6rLVgNFhFUcQIM4yYNKsAklXpSApXwgQ5W8mKI7GVqi+rhds
UynMkkK2XKPIeBVRJg7gNCx4vTnwas+AQ5QCuAoGpRxvTcPmKlP9krCi0owiGZKR
08ORDLnl4g8uxmkJQoYR6Ep6bnJY4mq9XSeNMYwOEWAd63h3aYO27kxvClgMo0mV
wb0jbsC1V0Qd8XvrdufP80ym3TVKCg==
=HyVg
-----END PGP SIGNATURE-----

--FvyRLtY8FNQa7tFK--

