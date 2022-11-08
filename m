Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04FB621AF0
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Nov 2022 18:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbiKHRlh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Nov 2022 12:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbiKHRlg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Nov 2022 12:41:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B39950F14;
        Tue,  8 Nov 2022 09:41:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26EA7B81BE2;
        Tue,  8 Nov 2022 17:41:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D245C433D7;
        Tue,  8 Nov 2022 17:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667929292;
        bh=cBKSOpSy+jUBQx59agJs7B0BFousNoTpEUsuo3M6i8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r1w0CL8aqJPMtCnz0+aaL2hHdbPmMBtIIS7o+i0qWnujbARfUxmfnzw9GDeWw3B6b
         He7M78EP35fq2DvWKmNhg7rqd+z6RS7BK6eDYkvs1w0kH4AUAqGsQ4Ir1+2eXrPZ7i
         uL069c9KqxhCag1CWs7jagNH9RlhN+lyyccT6O8bgGMuq30ry6o7AqfRmWWl3pnlfz
         GTIn5U1LGJ4OdeQfWc5OFbaNBghatIkbaObTz49iDqQZ51fYnz8TGbnGIj1UamSuHc
         yvj2oMm8345Z93OdMrmjYtPbP0NS3Q6nq+exgHX2Hv8AUKowZmBGQNKeo9FMwHTLHr
         n2OXtairHNQ3w==
Date:   Tue, 8 Nov 2022 09:41:30 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     syzbot <syzbot+9767be679ef5016b6082@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Subject: Re: [syzbot] KMSAN: uninit-value in pagecache_write
Message-ID: <Y2qUylpsZcJ7HF0Z@sol.localdomain>
References: <00000000000058d01705ecddccb0@google.com>
 <CAG_fn=WAyOc+1GEC+P3PpTM2zLcLcepAX1pPXkj5C6aPyrDVUA@mail.gmail.com>
 <Y2lGu/QTIWNpzFI3@sol.localdomain>
 <CAG_fn=VQBv-sgPhT0gLVChAtMNx0F3RcQYDKdvhBL4mBpiDkFA@mail.gmail.com>
 <CAG_fn=VPvdHxQc3xm5xkqgFq3uo5oTU_w5vyMj-qQD7DvwQ4BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=VPvdHxQc3xm5xkqgFq3uo5oTU_w5vyMj-qQD7DvwQ4BA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Nov 08, 2022 at 10:08:36AM +0100, 'Alexander Potapenko' via syzkaller-bugs wrote:
> > >
> > > Anyway, this patch doesn't hurt, I suppose.  Can please you send it out as a
> > > formal patch to linux-ext4?  It would be easy for people to miss this patch
> > > buried in this thread.  Also, can you please send a patch to linux-f2fs-devel
> > > for the same code in fs/f2fs/verity.c?
> >
> > Will do!
> 
> Shall I also initialize fsdata here:
> 
> $ git grep 'void \*fsdata;'
> fs/affs/file.c:         void *fsdata;
> fs/ext4/verity.c:               void *fsdata;
> fs/f2fs/verity.c:               void *fsdata;
> fs/hfs/extent.c:                void *fsdata;
> fs/hfsplus/extents.c:           void *fsdata;
> fs/ocfs2/mmap.c:        void *fsdata;

Yes, it looks like they all need this.  Except maybe ocfs2?  It's hard to tell.

- Eric
