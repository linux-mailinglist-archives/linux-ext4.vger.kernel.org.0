Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADCF7D2892
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Oct 2023 04:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjJWCea (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 22 Oct 2023 22:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjJWCe3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 22 Oct 2023 22:34:29 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D50519E
        for <linux-ext4@vger.kernel.org>; Sun, 22 Oct 2023 19:34:27 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-111-143.bstnma.fios.verizon.net [173.48.111.143])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 39N2YH4R007249
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 Oct 2023 22:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1698028459; bh=cX1hDm/QiO9zSpl0ScMGKNvRPEWN4dSyasZUYFS2Au8=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=Ngzki8SxclP0AGy3UqGgmxNqal42wFIiIXEU9GQcNhco6XeGzJJfwzGepGhf7GHJH
         m7Uhgvm5dkHgmIfCVKnWZ9JUyZaU3pm0u30Pec11PFKDSVyFyni8n5U/wHAUwn1csU
         l17evK1g+2+slRZEfR05d8Os8vYesoeJLbfVCzrdGeeDTYvfePJ0dMyjaYzV88CDF8
         H2/KG6b3KXHYvFtxDoN6hMZg3VVAgfcPPp82h/eqIQU6Gfh9+1wTTBKvRi0hJUm77L
         YkM5sMNuhWdSpgtF7sbqYq+/BGDxqVmv7sCv0e8qv6nIt6V4vBfvmq24SrkHgC/YFj
         YZ6LQgzT/7xcA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9520815C0247; Sun, 22 Oct 2023 22:34:17 -0400 (EDT)
Date:   Sun, 22 Oct 2023 22:34:17 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-ext4@vger.kernel.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        ebiggers@google.com, fstests@vger.kernel.org
Subject: New archtecture support in xfstests-bld
Message-ID: <20231023023417.GA1778210@mit.edu>
References: <060d9fef332979fd5d53b1c28c13b2043a16ab25.1696965271.git.ritesh.list@gmail.com>
 <20231012172835.GD255452@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012172835.GD255452@mit.edu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hey Ritesh,

I just pulled some changes from Eric Biggers into xfstests-bld which
has a start on adding riscv64 support to kvm-xfstests.  So far, he's
updated libaio to a newer upstream version (newer is relative; the
"new" version was last updated six years ago :-) for better RiscV
support, and he's added RiscV support to set_canonicalized_arch().

I'd recommend that you start with the latest upstream version of
xfstests-bld, and then add support for powerpcle64 by adding support
to find_kernel_to_use() in run=fstests/util/parse_opt_funcs, and
set_cross_compile() and get_kernel_file_info() in
run-fstests/util-arch, since those changes in the 2/2 patch series[1]
were clearly correct.  (And Eric, you should take a look at those
changes[1] for RiscV support.)

[1] https://lore.kernel.org/all/eb1f8f0fb0ff9a6358129a2a45bd0c88421ac669.1696965271.git.ritesh.list@gmail.com/

I'd also encourage you to add support for the new architectures in
selftests/appliance, since that will exercise building a kernel for
the foreign architecture using cross-compilation, and then using
qemu-system-$ARCH from kvm-xfstests.

(Yes, kvm-xfstests is starting to get very much misnamed; but kvm is
easier to type, and autocompletes much more nicely than qemu-<tab>.
The string "kvm" also is sprinkled all over the xfstests-bld scripts,
and I'm not convinced it's worth changing.  That being said, I've
added a qemu-xfstests script which gets installed into the user's bin
directory; we'll see if that is something people feel strongly about
using the new name.)

Finally, since have two separate efforts to add support for new
architectures to xfstests-bld, might I prevail on you to keep some
notes about what's needed to bootstrap a new architecture?  That might
be helpful for some future developer.

Many thanks!

					- Ted

