Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5693D5BBA2D
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Sep 2022 21:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiIQTqu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 17 Sep 2022 15:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiIQTqt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 17 Sep 2022 15:46:49 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9932BB3E
        for <linux-ext4@vger.kernel.org>; Sat, 17 Sep 2022 12:46:46 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z13so21989308edb.13
        for <linux-ext4@vger.kernel.org>; Sat, 17 Sep 2022 12:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=YyeNIHUzNbtSHe6o09PMb3YQ7MMyCYWkOVqFjUHdZoU=;
        b=iffWO/0yAzSK5e6E1WnNnRN8CWp03XEgokCUrm8VcMYG56l+/wiV3OVIX/MzEsVhZz
         Y3EZ6Hhdpb0rcQXB970URz0oZuHLHSHcPAwjzs9lGhNjN6vrSmxINM5D1mh++walEPBg
         hKBSM50RAdbX+Dlan4RT0ACVQ7geepnsAmoGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=YyeNIHUzNbtSHe6o09PMb3YQ7MMyCYWkOVqFjUHdZoU=;
        b=kSyObp6TUSjN42NSBYt7MH/jnxmkez5YdH65FMFuracoQaxK50sqGOvzEqVnkNLm2D
         Zphct/J2thumcfmzexVwOAoYIbAGjjvL0Im9P0OjI/UIPlX4e6l4iyyYcAj1ZCnAKwDA
         ml2aG7TcUiHFMjz9V1BQZ/E7/JbWzoGC+2M1587WIlLG/c8UfGXY1fOwib0Ef/86fvOL
         4rcUMnBN6BLjO0B0zCw2skicrpnR5raSwxKjGzgLTSeOk0ihrjQZfsx7+Ha2Wgiqb1Uv
         ZWWnPNQL7j+ajulSkXi+KmLSjpOjne+barNaQrV8VhoyQwcE3FlaZ29oADZkMmXzyxIn
         4DaQ==
X-Gm-Message-State: ACrzQf1Fsy7ZkMPxj9Gxtvq9m31xCWQMycYXo/QzGwmz5YMtSj/g7jbx
        tEHAyJ+2kNQaLTI+J23WoS8gThG1FyvKFfrFbui04A==
X-Google-Smtp-Source: AMsMyM4QrS6tI4fQMcBRrUQlm6Q+5pMuSSoJX62Z5PpIwpQM2juv8YcKUn5ARK9Xc2oVnRKOJlkUreM93NBIQ6zDl0w=
X-Received: by 2002:a05:6402:90a:b0:443:8b10:bcad with SMTP id
 g10-20020a056402090a00b004438b10bcadmr8770066edz.416.1663444005137; Sat, 17
 Sep 2022 12:46:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220915164826.1396245-1-sarthakkukreti@google.com> <YyU5CyQfS+64xmnm@magnolia>
In-Reply-To: <YyU5CyQfS+64xmnm@magnolia>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Sat, 17 Sep 2022 12:46:33 -0700
Message-ID: <CAG9=OMNPnsjaUw2EUG0XFjV94-V1eD63V+1anoGM=EWKyzXEfg@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH RFC 0/8] Introduce provisioning primitives for
 thinly provisioned storage
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>,
        Gwendal Grignou <gwendal@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Evan Green <evgreen@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Daniil Lunev <dlunev@google.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Sep 16, 2022 at 8:03 PM Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Thu, Sep 15, 2022 at 09:48:18AM -0700, Sarthak Kukreti wrote:
> > From: Sarthak Kukreti <sarthakkukreti@chromium.org>
> >
> > Hi,
> >
> > This patch series is an RFC of a mechanism to pass through provision
> > requests on stacked thinly provisioned storage devices/filesystems.
>
> [Reflowed text]
>
> > The linux kernel provides several mechanisms to set up thinly
> > provisioned block storage abstractions (eg. dm-thin, loop devices over
> > sparse files), either directly as block devices or backing storage for
> > filesystems. Currently, short of writing data to either the device or
> > filesystem, there is no way for users to pre-allocate space for use in
> > such storage setups. Consider the following use-cases:
> >
> > 1) Suspend-to-disk and resume from a dm-thin device: In order to
> > ensure that the underlying thinpool metadata is not modified during
> > the suspend mechanism, the dm-thin device needs to be fully
> > provisioned.
> > 2) If a filesystem uses a loop device over a sparse file, fallocate()
> > on the filesystem will allocate blocks for files but the underlying
> > sparse file will remain intact.
> > 3) Another example is virtual machine using a sparse file/dm-thin as a
> > storage device; by default, allocations within the VM boundaries will
> > not affect the host.
> > 4) Several storage standards support mechanisms for thin provisioning
> > on real hardware devices. For example:
> >   a. The NVMe spec 1.0b section 2.1.1 loosely talks about thin
> >   provisioning: "When the THINP bit in the NSFEAT field of the
> >   Identify Namespace data structure is set to =E2=80=981=E2=80=99, the =
controller ...
> >   shall track the number of allocated blocks in the Namespace
> >   Utilization field"
> >   b. The SCSi Block Commands reference - 4 section references "Thin
> >   provisioned logical units",
> >   c. UFS 3.0 spec section 13.3.3 references "Thin provisioning".
> >
> > In all of the above situations, currently the only way for
> > pre-allocating space is to issue writes (or use
> > WRITE_ZEROES/WRITE_SAME). However, that does not scale well with
> > larger pre-allocation sizes.
> >
> > This patchset introduces primitives to support block-level
> > provisioning (note: the term 'provisioning' is used to prevent
> > overloading the term 'allocations/pre-allocations') requests across
> > filesystems and block devices. This allows fallocate() and file
> > creation requests to reserve space across stacked layers of block
> > devices and filesystems. Currently, the patchset covers a prototype on
> > the device-mapper targets, loop device and ext4, but the same
> > mechanism can be extended to other filesystems/block devices as well
> > as extended for use with devices in 4 a-c.
>
> If you call REQ_OP_PROVISION on an unmapped LBA range of a block device
> and then try to read the provisioned blocks, what do you get?  Zeroes?
> Random stale disk contents?
>
> I think I saw elsewhere in the thread that any mapped LBAs within the
> provisioning range are left alone (i.e. not zeroed) so I'll proceed on
> that basis.
>
For block devices, I'd say it's definitely possible to get stale data, depe=
nding
on the implementation of the allocation layer; for example, with dm-thinpoo=
l,
the default setting via using LVM2 tools is to zero out blocks on allocatio=
n.
But that's configurable and can be turned off to improve performance.

Similarly, for actual devices that end up supporting thin provisioning, unl=
ess
the specification absolutely mandates that an LBA contains zeroes post
allocation, some implementations will definitely miss out on that (probably
similar to the semantics of discard_zeroes_data today). I'm operating under
the assumption that it's possible to get stale data from LBAs allocated usi=
ng
provision requests at the block layer and trying to see if we can create a
safe default operating model from that.

> > Patch 1 introduces REQ_OP_PROVISION as a new request type. The
> > provision request acts like the inverse of a discard request; instead
> > of notifying lower layers that the block range will no longer be used,
> > provision acts as a request to lower layers to provision disk space
> > for the given block range. Real hardware storage devices will
> > currently disable the provisioing capability but for the standards
> > listed in 4a.-c., REQ_OP_PROVISION can be overloaded for use as the
> > provisioing primitive for future devices.
> >
> > Patch 2 implements REQ_OP_PROVISION handling for some of the
> > device-mapper targets. This additionally adds support for
> > pre-allocating space for thinly provisioned logical volumes via
> > fallocate()
> >
> > Patch 3 implements the handling for virtio-blk.
> >
> > Patch 4 introduces an fallocate() mode (FALLOC_FL_PROVISION) that
> > sends a provision request to the underlying block device (and beyond).
> > This acts as the primary mechanism for file-level provisioing.
>
> Personally, I think it's well within the definition of fallocate mode=3D=
=3D0
> (aka preallocate) for XFS to call REQ_OP_PROVISION on the blocks that it
> preallocates?  XFS always sets the unwritten flag on the file mapping,
> so it doesn't matter if the device provisions space without zeroing the
> contents.
>
> That said, if devices are really allowed to expose stale disk blocks
> then for blkdev fallocate I think you could get away with reusin
> FALLOC_FL_NO_HIDE_STALE instead of introducing a new fallocate flag.
>
For filesystems, I think it's reasonable to support the mode if and only if
the filesystem can guarantee that unwritten extents return zero. For instan=
ce,
in the current ext4 implementation, the provisioned extents are still marke=
d as
unwritten, which means a read from the file would still show all zeroes (wh=
ich
I think differs from the original FALLOC_FL_NO_HIDE implementation).

That might be one more reason to keep the mode separate from the regular
modes though; to drive home the point that it is only acceptable under
the above conditions and that there's more to it than just adding
blkdev_issue_provision(..) at the end of fs_fallocate().

Best
Sarthak

> > Patch 5 wires up the loop device handling of REQ_OP_PROVISION.
> >
> > Patches 6-8 cover a prototype implementation for ext4, which includes
> > wiring up the fallocate() implementation, introducing a filesystem
> > level option (called 'provision') to control the default allocation
> > behaviour and finally a file level override to retain current
> > handling, even on filesystems mounted with 'provision'
>
> Hmm, I'll have a look.
>
> > Testing:
> > --------
> > - A backport of this patch series was tested on ChromiumOS using a
> > 5.10 kernel.
> > - File on ext4 on a thin logical volume:
> > fallocate(FALLOC_FL_PROVISION) : 4.6s, dd if=3D/dev/zero of=3D...: 6 mi=
ns.
> >
> > TODOs:
> > ------
> > 1) The stacked block devices (dm-*, loop etc.) currently
> > unconditionally pass through provision requests. Add support for
> > provision, similar to how discard handling is set up (with options to
> > disable, passdown or passthrough requests).
> > 2) Blktests and Xfstests for validating provisioning.
>
> Yes....
>
> --D
>
> > --
> > dm-devel mailing list
> > dm-devel@redhat.com
> > https://listman.redhat.com/mailman/listinfo/dm-devel
