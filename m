Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E8073D5C2
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Jun 2023 04:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjFZCSk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 25 Jun 2023 22:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjFZCSk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 25 Jun 2023 22:18:40 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54C318D
        for <linux-ext4@vger.kernel.org>; Sun, 25 Jun 2023 19:18:38 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-119-246.bstnma.fios.verizon.net [173.48.119.246])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35Q2HxRN006795
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 25 Jun 2023 22:18:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1687745880; bh=rEHSJcjvBWLTA0J/CvIhhDB7WDxfHmI7nwgCmPrpbDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=SYx/ZYPD3ZomQTFtSmxuuVpj04SUFpKJ7i9trhw/zVBzYXV4uF6sZ6WMj+dvsPwTQ
         Xc7uK12RfhQZS28ZvgQQFcQZMwfaTtofxhRlOQusvzykh3YbPQzHj4n/QmZdZyMqV+
         qvTlrmWf9er1WEtvUYZjh1AXS7jYyIVH9AOycLWYPY7N48YuFzgxaECC96d447QskQ
         yUlRNYrZizv2hQLEOtrmQCtQG22jDEQK9FYRWs07vZF46eJlbY9/T0yRIMVnK4mUna
         B8mCGJrZ9cD3DaEz7KJ+lPPMSfC2fR3OeprC7qxzbeCMXOeuKpCipuVLFi1rr8PDfY
         DPRLp8lVAex9Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9648F15C027E; Sun, 25 Jun 2023 22:17:58 -0400 (EDT)
Date:   Sun, 25 Jun 2023 22:17:58 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     zhanchengbin <zhanchengbin1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, linfeilong <linfeilong@huawei.com>,
        louhongxiang@huawei.com, liuzhiqiang26@huawei.com
Subject: Re: [bug report] tune2fs: filesystem inconsistency occurs by
 concurrent write
Message-ID: <20230626021758.GF8954@mit.edu>
References: <29f6134f-ba0a-d601-0a5a-ad2b5e9bbf1d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29f6134f-ba0a-d601-0a5a-ad2b5e9bbf1d@huawei.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jun 26, 2023 at 12:00:08AM +0800, zhanchengbin wrote:
> Tune2fs does not recognize writes to the manipulated filesystem in another
> namespace, there will be two simultaneous write operations on a
> block, resulting in filesystem inconsistencies.

What you are reporting has nothing to do with namespaces, since
"tune2fs -e remount-ro /dev/sdb" is something which is allowed
regardless of whether the file system is mounted.  What reproduction
is effectively doing is trying to set up a race between when tune2fs
writes a byte to update to update the errors behavior, and when the
actual unmount of the file system happens (e.g., when the last
namespace unmounts the file system).  At that point, the kernel is
going to be updating the superblock as part of the unmount, and then
it calculates the superblock, and then it writes out the superblock.

If the tune2fs races with the unmount, it's possible for the tune2fs
update of the error beavhiour bit, and the update of the superblock
checksum, to race with the kernel's final update of the superblock,
includinig its attempt to update the checksum.

There are some workarounds to this, but ultimately, we need to replace
the ad-hoc modification of the block device by tune2fs with some
ioctls which specifically update superblock when the file system
mounted.

As far as whether or not tune2fs can detect if the file system is
mounted, what we can do is check to see if the block device is busy.
If it is mounted in some other namespace, we won't be able to see it
mounted in /proc/self/mounts, but we can see that it's not possible to
open the block device with O_EXCL.

Compare:

root@kvm-xfstests:~# /vtmp/tst_ismounted /dev/vdc
Device /dev/vdc reports flags 31
        /dev/vdc is apparently in use.
        /dev/vdc is mounted.
        /dev/vdc is mounted on /vdc.

and then "unshare -m" in another terminal, followed by umount /dev/vdc
in the first terminal:

root@kvm-xfstests:~# /vtmp/tst_ismounted /dev/vdc
Device /dev/vdc reports flags 10
        /dev/vdc is apparently in use.

... and then after we exit the last mount namespace which was keeping
/dev/vdc mounted:

root@kvm-xfstests:~# [ 2409.811328] EXT4-fs (vdc): unmounting filesystem bdc026fd-85a8-4ccf-94f8-961487000293.
root@kvm-xfstests:~# /vtmp/tst_ismounted /dev/vdc
Device /dev/vdc reports flags 00

Cheers,

						- Ted
