Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F25677C33A
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Aug 2023 00:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjHNWGi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 14 Aug 2023 18:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbjHNWGP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 14 Aug 2023 18:06:15 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A87AB0
        for <linux-ext4@vger.kernel.org>; Mon, 14 Aug 2023 15:06:13 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-82-92.bstnma.fios.verizon.net [173.48.82.92])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37EM5bBe007191
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 18:05:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692050740; bh=iRv8SucL4d4OYoE5Cj7E+7EpEmUPiTYhpKfXfCItRcc=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=W2X1E7TgU6mM3iJA/os2+pKqmvzRMoOPS3llA/P9Ez3p2GCHiUEAj7/sH5iP1sxdl
         8+QP12zP/F9KvBlytY+gn8IJqUQdtdjJl9TYtHXc/Poi6wf7wYSYm6ssF0FETsCsv0
         LiNHbOGL0fsRYl+8HivQQz4n7VC7OhlyuYa37J5AGVnqEQ+2xk8ZUGkLar+jAqf9fA
         gcfYFrFCRRYCRqK4Hqzod7wghhHGqL7UjALL01UdX0a64Gf8rmKBouPOwVPcqosr6j
         Jeu+I8Ac3GPoc9CLqxbYFTY9mWm9ERe0TzP7o5QJg3hywDYJ9VTuKmlHXSVcbFd5SM
         Ro5WIpBPqj2cQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E75E415C0292; Mon, 14 Aug 2023 18:05:36 -0400 (EDT)
Date:   Mon, 14 Aug 2023 18:05:36 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     syzbot <syzbot+a8068dd81edde0186829@syzkaller.appspotmail.com>,
        syzkaller-lts-bugs@googlegroups.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stable <stable@vger.kernel.org>,
        regressions@lists.linux.dev, Baokun Li <libaokun1@huawei.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>
Subject: Re: [v6.1] kernel BUG in ext4_writepages
Message-ID: <20230814220536.GE2247938@mit.edu>
References: <00000000000081f8c905f6c24e0d@google.com>
 <87dcdf62-8a74-1fbf-5f10-f4f3231f774f@collabora.com>
 <4637f58c-1cf3-0691-4fc1-6fbc38ec47ce@collabora.com>
 <0fc2546b-da7c-aac4-b402-3ef4970a1789@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fc2546b-da7c-aac4-b402-3ef4970a1789@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 14, 2023 at 10:35:57AM +0500, Muhammad Usama Anjum wrote:
> > The last refactoring was done by 4e7ea81db53465 on this code in 2013. The
> > code segment in question is present from even before that. It means that
> > this bug is present for several years. 4.14 is the most old kernel being
> > maintained today. So it affects all current LTS and mainline kernels. I'll
> > report 4e7ea81db53465 with regzbot for proper tracking. Thus probably the
> > bug report will get associated with all LTS kernels as well.
> > 
> > #regzbot title: Race condition between buffer write and page_mkwrite
> 
> #regzbot title: ext4: Race condition between buffer write and page_mkwrite

If it's a long-standing bug, then it's really not something I consider
a regression.  That being said, you're assuming that the refactoring
is what has introduced the bug; that's not necessarily case.

*Especially* if it requires a maliciously fuzzed file system, since
you have to be root to mount a file system.  That's the other thing;
the different reports at the console have different reproducers, and
at least one of them has a very badly corrupted file system --- and
since you need to have root to mount the a maliciously fuzzed file
system, these are treated with a much lower priority as far as I'm
concerned.

(If you think it should be higher priority, and your company is
willing to fund such work, patches are greatfully appreciated.  :-)

I tried to reproduce this using one of the reproducers on a modern
kernel, and it doesn't reproduce there.  That being said, it's not
entirely what the reproducer is doing, since (a) passing -1 to the
in_fd and out_fd to sendfile *should* just cause sendfile to to return
an EBADF error, and (b) when I ran it, it just segfaulted on an mmap()
before it executed anything interesting.

Please let me know (a) if you can replicate this on the latest
upstream kernel, and (b) if the reproducer doesn't require a
maliciously fuzzed kernel, or where the reproducer is scribbling on
the file system image while it is mounted.

Cheers,

						- Ted
