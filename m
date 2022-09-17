Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B915BB5B2
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Sep 2022 05:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiIQDDn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 16 Sep 2022 23:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiIQDDm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 16 Sep 2022 23:03:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551AB90818;
        Fri, 16 Sep 2022 20:03:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE3E362E38;
        Sat, 17 Sep 2022 03:03:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272CEC433C1;
        Sat, 17 Sep 2022 03:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663383820;
        bh=viHf2rvi9XQW9HP3Qdp1Nv8dDs2EYIeR3eo/c+/gCEM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PHDw6X/qaJmOcuC5ZBNbnqLdFugk0NLTwILyibHl3N8RQ3N6y3a8YcsQQNK4sj20J
         o7EMzPMBMg6SwfilgIBJpLKMaVKiloSJzWZGUAw5k+tk3m70BSbhdVU4SvWXG4DNee
         bQWx7nJ9x3Vf0EF+H1XDs1SMmNlSEcHhzz2U9frPJLcip0xXOEibHp8gxIVz/HpZPY
         Zikgw9vY5zOwlKuIS2/MNn3Y2u0LUkE8mZYycsaNb9WpWrQDxBXCFGe9AmwxLU7Evh
         n1ddfZRaD8R9RmwxDA/L7XHXDUGFYALHTVPjs3dEXnXe675euO2XsexTAKnc2uWYS1
         gh4ecxPLt170w==
Date:   Fri, 16 Sep 2022 20:03:39 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
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
        Stefan Hajnoczi <stefanha@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [dm-devel] [PATCH RFC 0/8] Introduce provisioning primitives for
 thinly provisioned storage
Message-ID: <YyU5CyQfS+64xmnm@magnolia>
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220915164826.1396245-1-sarthakkukreti@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Sep 15, 2022 at 09:48:18AM -0700, Sarthak Kukreti wrote:
> From: Sarthak Kukreti <sarthakkukreti@chromium.org>
> 
> Hi,
> 
> This patch series is an RFC of a mechanism to pass through provision
> requests on stacked thinly provisioned storage devices/filesystems.

[Reflowed text]

> The linux kernel provides several mechanisms to set up thinly
> provisioned block storage abstractions (eg. dm-thin, loop devices over
> sparse files), either directly as block devices or backing storage for
> filesystems. Currently, short of writing data to either the device or
> filesystem, there is no way for users to pre-allocate space for use in
> such storage setups. Consider the following use-cases:
> 
> 1) Suspend-to-disk and resume from a dm-thin device: In order to
> ensure that the underlying thinpool metadata is not modified during
> the suspend mechanism, the dm-thin device needs to be fully
> provisioned.
> 2) If a filesystem uses a loop device over a sparse file, fallocate()
> on the filesystem will allocate blocks for files but the underlying
> sparse file will remain intact.
> 3) Another example is virtual machine using a sparse file/dm-thin as a
> storage device; by default, allocations within the VM boundaries will
> not affect the host.
> 4) Several storage standards support mechanisms for thin provisioning
> on real hardware devices. For example:
>   a. The NVMe spec 1.0b section 2.1.1 loosely talks about thin
>   provisioning: "When the THINP bit in the NSFEAT field of the
>   Identify Namespace data structure is set to ‘1’, the controller ...
>   shall track the number of allocated blocks in the Namespace
>   Utilization field"
>   b. The SCSi Block Commands reference - 4 section references "Thin
>   provisioned logical units",
>   c. UFS 3.0 spec section 13.3.3 references "Thin provisioning".
> 
> In all of the above situations, currently the only way for
> pre-allocating space is to issue writes (or use
> WRITE_ZEROES/WRITE_SAME). However, that does not scale well with
> larger pre-allocation sizes. 
> 
> This patchset introduces primitives to support block-level
> provisioning (note: the term 'provisioning' is used to prevent
> overloading the term 'allocations/pre-allocations') requests across
> filesystems and block devices. This allows fallocate() and file
> creation requests to reserve space across stacked layers of block
> devices and filesystems. Currently, the patchset covers a prototype on
> the device-mapper targets, loop device and ext4, but the same
> mechanism can be extended to other filesystems/block devices as well
> as extended for use with devices in 4 a-c.

If you call REQ_OP_PROVISION on an unmapped LBA range of a block device
and then try to read the provisioned blocks, what do you get?  Zeroes?
Random stale disk contents?

I think I saw elsewhere in the thread that any mapped LBAs within the
provisioning range are left alone (i.e. not zeroed) so I'll proceed on
that basis.

> Patch 1 introduces REQ_OP_PROVISION as a new request type. The
> provision request acts like the inverse of a discard request; instead
> of notifying lower layers that the block range will no longer be used,
> provision acts as a request to lower layers to provision disk space
> for the given block range. Real hardware storage devices will
> currently disable the provisioing capability but for the standards
> listed in 4a.-c., REQ_OP_PROVISION can be overloaded for use as the
> provisioing primitive for future devices.
> 
> Patch 2 implements REQ_OP_PROVISION handling for some of the
> device-mapper targets. This additionally adds support for
> pre-allocating space for thinly provisioned logical volumes via
> fallocate()
> 
> Patch 3 implements the handling for virtio-blk.
> 
> Patch 4 introduces an fallocate() mode (FALLOC_FL_PROVISION) that
> sends a provision request to the underlying block device (and beyond).
> This acts as the primary mechanism for file-level provisioing.

Personally, I think it's well within the definition of fallocate mode==0
(aka preallocate) for XFS to call REQ_OP_PROVISION on the blocks that it
preallocates?  XFS always sets the unwritten flag on the file mapping,
so it doesn't matter if the device provisions space without zeroing the
contents.

That said, if devices are really allowed to expose stale disk blocks
then for blkdev fallocate I think you could get away with reusin
FALLOC_FL_NO_HIDE_STALE instead of introducing a new fallocate flag.

> Patch 5 wires up the loop device handling of REQ_OP_PROVISION.
> 
> Patches 6-8 cover a prototype implementation for ext4, which includes
> wiring up the fallocate() implementation, introducing a filesystem
> level option (called 'provision') to control the default allocation
> behaviour and finally a file level override to retain current
> handling, even on filesystems mounted with 'provision'

Hmm, I'll have a look.

> Testing:
> --------
> - A backport of this patch series was tested on ChromiumOS using a
> 5.10 kernel.
> - File on ext4 on a thin logical volume:
> fallocate(FALLOC_FL_PROVISION) : 4.6s, dd if=/dev/zero of=...: 6 mins.
> 
> TODOs:
> ------
> 1) The stacked block devices (dm-*, loop etc.) currently
> unconditionally pass through provision requests. Add support for
> provision, similar to how discard handling is set up (with options to
> disable, passdown or passthrough requests).
> 2) Blktests and Xfstests for validating provisioning.

Yes....

--D

> --
> dm-devel mailing list
> dm-devel@redhat.com
> https://listman.redhat.com/mailman/listinfo/dm-devel
