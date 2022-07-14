Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C756357574F
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Jul 2022 00:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240794AbiGNWA7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Jul 2022 18:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbiGNWA7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Jul 2022 18:00:59 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CCB6F7F6;
        Thu, 14 Jul 2022 15:00:57 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 26EM0YUF022715
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 18:00:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1657836036; bh=gz6NEiHl+Wfm06ezTz46glT2Zntk28auy/eqXN3YzXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=F9Og2YD4r+T/BRD84RKkst4u13clEyr8OFy5SntKI1ekmOuVoPDE2Skkxoj8gjwMQ
         UC16LXV6cOk9QkbShGTmnhdSTApGfCN+WCr2Gca14nqUdg7awn6aFm4+skeiEXzUpO
         2wUKp5ZDK7nJ2XzJCNWiLIwPMnYgWPCKJmzXKcKvKhT3w5yFoeZHKlDDdfwSxKwjth
         bLLH+mo2ISx3eT8+cZJAvD7xkoSLvzHjYUWpb9H4oG5DXcdgVBcLcDWA5uTD6WWZwO
         hfO09uhh0SO3PUP+c3djOsr/WLnt5UDQ/1Uzy6vIDd9BAHob5ixRlInwtIU1iuMLIP
         ixxJIOpfbVKGg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 5656F15C003C; Thu, 14 Jul 2022 18:00:34 -0400 (EDT)
Date:   Thu, 14 Jul 2022 18:00:34 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zorro Lang <zlang@redhat.com>
Cc:     Sun Ke <sunke32@huawei.com>, fstests@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 1/2] ext4: resize fs after resize_inode without e2fsck
Message-ID: <YtCSAjiMc9RElnHu@mit.edu>
References: <20220713092859.3881376-1-sunke32@huawei.com>
 <20220713092859.3881376-2-sunke32@huawei.com>
 <20220714154607.qq6cqgvncxhsn66w@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714154607.qq6cqgvncxhsn66w@zlang-mailbox>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jul 14, 2022 at 11:46:07PM +0800, Zorro Lang wrote:
> On Wed, Jul 13, 2022 at 05:28:58PM +0800, Sun Ke wrote:
> > +
> > +# forget to run requested e2fsck after resize_inode
> > +$TUNE2FS_PROG -O ^resize_inode $SCRATCH_DEV | grep -w "e2fsck"
> > +
> > +_scratch_mount
> > +
> > +# resize fs will trigger NULL pointer in ext4_flex_group_add
> > +$RESIZE2FS_PROG $SCRATCH_DEV 1G >> $seqres.full 2>&1
> > +
> > +echo "Silence is golden"
  ...
> > diff --git a/tests/ext4/057.out b/tests/ext4/057.out
> > new file mode 100644
> > index 00000000..4784ad7e
> > --- /dev/null
> > +++ b/tests/ext4/057.out
> > @@ -0,0 +1,3 @@
> > +QA output created by 057
> > +Please run e2fsck -f on the filesystem.
> 
> If you hope to match this line, means this case isn't "Silence is golden".
> 
> I don't know why you'd to have this line, it looks not suit to be golden
> image. If you'd like to make sure current ext4 supports "resize_inode"
> feature, you can use:
>   _require_scratch_ext4_feature resize_inode

That's not the problem.

The "tune2fs -O ^resize_inode" command is printing that message as a
reminder that it would be a Really Good idea to run e2fsck on the file
system, because tune2fs doesn't completely remove the resize inode
after turning off that feature.

The commit which this test is trying to verify is that the kernel
won't oops if the system adminsitrator ignores the rather explicit
request:

Please run e2fsck -f on the filesystem.

... and blithely mounts the file system without running fsck -f on the
file system first.  While it could be argued that a system
administrator which fails to follow instructions deserves everything
they get, we decided the as a quality of implementation issue, it
would be better if the kernel didn't dereference a NULL pointer in
that case.  :-)

The one thing I'll note is that it is possible that at some point in
the future, tune2fs could be improved so that it cleanly removes the
resize_inode when the resize inode feature is removed, so that running
"fsck.ext4 -f" is no longer necessary.  So if you want to future-proof
the test so it doesn't fail once tune2fs is made more idiot-proof, it
might be better if the test did something like this:

mke2fs -t ext4 -O ^resize_inode /dev/vdc 512m
debugfs -w -R "set_super_value s_reserved_gdt_blocks 100" /dev/vdc
mount -t ext4 /dev/vdc /vdc
resize2fs /dev/vdc 1G

Translating the above from commands suitable for manual trial using
"kvm-xfstests shell" to a proper xfstests script is left as an
exercise for the reader.  :-)

					- Ted
