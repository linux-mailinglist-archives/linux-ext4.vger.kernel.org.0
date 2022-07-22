Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BFC57D8D6
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Jul 2022 05:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbiGVDFh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 Jul 2022 23:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbiGVDFd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 21 Jul 2022 23:05:33 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8E1237C5
        for <linux-ext4@vger.kernel.org>; Thu, 21 Jul 2022 20:05:31 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 26M35NtR027951
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jul 2022 23:05:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1658459125; bh=5gKwZLxMeL1yhX3pqtPWqc9UZF7xh1iyGoTNldl9jco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=NdrM1vt0j/aTnZS31dY63i0+541RMkgMdgKFzwWZFfZe5bug6kYLrBnZ0cVnI8c8D
         OCpnQB9wcfFcr7ZBHe8Rjmb9NHE5Vn94hbF0k5Z4c0O96d1+QoX4sdHCVzJaDJ4nwt
         JG9Qe1+Bm3IU43qQDve4TIBFDdfUQkQx2oZkdmQMlvzFGESh7Tj/Q9vC1yCGbgY7bJ
         YyTKbIF3SHk9pawsM7WgMOqM0JHvT7kYFlQXMPyPA1OLtNmTrOUYa5qiL21h0jyVsJ
         8AZhoIDqFbx8rSnHMeCKmzB19loJVluFBZOOgI2uVZ5fZgYhg8qnsYuHgEt46tQ/zx
         XZWZGGLzD0xtQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C596C15C3EBF; Thu, 21 Jul 2022 23:05:23 -0400 (EDT)
Date:   Thu, 21 Jul 2022 23:05:23 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Whitney <enwlinux@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: minor defrag code improvements
Message-ID: <YtoT80bDyqIVuJwT@mit.edu>
References: <20220621143340.2268087-1-enwlinux@gmail.com>
 <20220714115326.qhjsrchoepnnsffu@quack3>
 <YtcjkMcYQCATlt0Y@debian-BULLSEYE-live-builder-AMD64>
 <YtgbKhYxbX4NPJts@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtgbKhYxbX4NPJts@debian-BULLSEYE-live-builder-AMD64>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jul 20, 2022 at 11:11:38AM -0400, Eric Whitney wrote:
> > Is ETXTBUSY still reported by the kernel?  I couldn't find it in a search after
> > reading this:  lwn.net/Articles/866493/
> > I didn't consider that because an executable wasn't involved - interesting that
> > it was used for some operations applied to swap files.

The LWN article is specifically about whether it's worth it to block
writes to executable files.

However, if you look at some places where ETXTBSY is returned, such as
in fs/open.c and fs/read_write.c, it's being returned when there is
attempt to operate on a swap file using fallocate(2), write(2) or
copy_file(2).  So I agree with Jan that it's better for the defrag
code to be consistent those uses of ETXTBSY.

I'll also add that, "busy" does make some sense as a concept, since if
you run "swapoff", you can now defrag the file, since it's no longer
being used as a swap file --- hence, it's no longer busy.  So I don't
have as visceral reaction to using EBUSY, but given the other ways
defrag might return EBUSY where it *would* make sense to retry the
defrag, I agree that changing the error return in the case of an
attempted defrag of a swap file to ETXTBSY makes sense.

						- Ted
