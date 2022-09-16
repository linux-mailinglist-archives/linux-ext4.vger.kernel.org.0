Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4955BA69A
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Sep 2022 08:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiIPGKM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 16 Sep 2022 02:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiIPGKL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 16 Sep 2022 02:10:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D5E9F758
        for <linux-ext4@vger.kernel.org>; Thu, 15 Sep 2022 23:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663308607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WexFcKZFirN/jM+xTeznAj7e5nDORoI0aBqRUMifb8Y=;
        b=dB73TdfALZQrmJem+qHY9x+vNt8hVPxFisOARLGncQFyvicFDonLtJVjxIqntp8j16l7RP
        2t5AtHt74h9f08diPuRlkN1PxQMpanC2aB7ODVGYnkHzcOnw8kpxrpcghOJ9q3Wp3G3d7C
        z+nL4LUWUnxnQVMI379BW4eMGKpx5VI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-292-jZYnFVjgP6GqmjFBWdto1w-1; Fri, 16 Sep 2022 02:09:58 -0400
X-MC-Unique: jZYnFVjgP6GqmjFBWdto1w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7BE48882822;
        Fri, 16 Sep 2022 06:09:57 +0000 (UTC)
Received: from localhost (unknown [10.39.192.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 46FC3C15BA4;
        Fri, 16 Sep 2022 06:09:56 +0000 (UTC)
Date:   Fri, 16 Sep 2022 07:09:55 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>,
        Evan Green <evgreen@google.com>,
        Gwendal Grignou <gwendal@google.com>
Subject: Re: [PATCH RFC 0/8] Introduce provisioning primitives for thinly
 provisioned storage
Message-ID: <YyQTM5PRT2o/GDwy@fedora>
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="w/wnRFkY16cMLsvF"
Content-Disposition: inline
In-Reply-To: <20220915164826.1396245-1-sarthakkukreti@google.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--w/wnRFkY16cMLsvF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 15, 2022 at 09:48:18AM -0700, Sarthak Kukreti wrote:
> From: Sarthak Kukreti <sarthakkukreti@chromium.org>
>=20
> Hi,
>=20
> This patch series is an RFC of a mechanism to pass through provision requ=
ests on stacked thinly provisioned storage devices/filesystems.
>=20
> The linux kernel provides several mechanisms to set up thinly provisioned=
 block storage abstractions (eg. dm-thin, loop devices over sparse files), =
either directly as block devices or backing storage for filesystems. Curren=
tly, short of writing data to either the device or filesystem, there is no =
way for users to pre-allocate space for use in such storage setups. Conside=
r the following use-cases:
>=20
> 1) Suspend-to-disk and resume from a dm-thin device: In order to ensure t=
hat the underlying thinpool metadata is not modified during the suspend mec=
hanism, the dm-thin device needs to be fully provisioned.
> 2) If a filesystem uses a loop device over a sparse file, fallocate() on =
the filesystem will allocate blocks for files but the underlying sparse fil=
e will remain intact.
> 3) Another example is virtual machine using a sparse file/dm-thin as a st=
orage device; by default, allocations within the VM boundaries will not aff=
ect the host.
> 4) Several storage standards support mechanisms for thin provisioning on =
real hardware devices. For example:
>   a. The NVMe spec 1.0b section 2.1.1 loosely talks about thin provisioni=
ng: "When the THINP bit in the NSFEAT field of the Identify Namespace data =
structure is set to =E2=80=981=E2=80=99, the controller ... shall track the=
 number of allocated blocks in the Namespace Utilization field"
>   b. The SCSi Block Commands reference - 4 section references "Thin provi=
sioned logical units",
>   c. UFS 3.0 spec section 13.3.3 references "Thin provisioning".

When REQ_OP_PROVISION is sent on an already-allocated range of blocks,
are those blocks zeroed? NVMe Write Zeroes with Deallocate=3D0 works this
way, for example. That behavior is counterintuitive since the operation
name suggests it just affects the logical block's provisioning state,
not the contents of the blocks.

> In all of the above situations, currently the only way for pre-allocating=
 space is to issue writes (or use WRITE_ZEROES/WRITE_SAME). However, that d=
oes not scale well with larger pre-allocation sizes.=20

What exactly is the issue with WRITE_ZEROES scalability? Are you
referring to cases where the device doesn't support an efficient
WRITE_ZEROES command and actually writes blocks filled with zeroes
instead of updating internal allocation metadata cheaply?

Stefan

--w/wnRFkY16cMLsvF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmMkEzMACgkQnKSrs4Gr
c8hn3wgAjJDAhaMbZwpCmdUdohpKtyMia1I6OsTlcURdfUV2iu1afmfcG5c7Q2pV
ZPZC+DZhgUOEkpD1Aj5gCjpi8/1EXpmCwDGB36AgVnwzCMV9QLdW7B3xoCvJipNa
b+KGhLFliE0pBX9ZGYqCZ7a8Tuz2OGtNhpAsd/tUOMYCLzc6WTqTIeB6Wv6rYrw4
kIF+kP7pEK4INQYAav+pYDzZxqd4yrKINa6PEOZUMxzuLnH4eW8l+xrsTDIMbA+e
ummgls1ZrhgPhUJNqscmevqfJMLqMsZTxN6+B9zH+G6GrxAc1rqeRTdlMAwwYxYg
DIMeBAXmfutiQDOVF8Tj6W1p7wrNLw==
=s/zf
-----END PGP SIGNATURE-----

--w/wnRFkY16cMLsvF--

