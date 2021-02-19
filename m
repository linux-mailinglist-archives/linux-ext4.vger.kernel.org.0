Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C90231FD05
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Feb 2021 17:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhBSQTq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 19 Feb 2021 11:19:46 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37500 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229765AbhBSQTp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 19 Feb 2021 11:19:45 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 11JGIrWj012083
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 11:18:54 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9670415C39E2; Fri, 19 Feb 2021 11:18:53 -0500 (EST)
Date:   Fri, 19 Feb 2021 11:18:53 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Alexey Lyashkov <alexey.lyashkov@gmail.com>
Cc:     Lukas Czerner <lczerner@redhat.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Eric Sandeen <sandeen@redhat.com>
Subject: Re: [PATCH v2] mmp: do not use O_DIRECT when working with regular
 file
Message-ID: <YC/k7YhZNxO7O5PF@mit.edu>
References: <20210212093719.162065-1-lczerner@redhat.com>
 <20210218095146.265302-1-lczerner@redhat.com>
 <BF8274AF-A9C6-40F4-8B99-FEBA82878C36@dilger.ca>
 <99A17D19-8764-4027-8B1E-E7ADBE5E2CEE@gmail.com>
 <20210219105713.uu2mywenytfd2e5j@work>
 <E16FB371-5DFC-4A10-A9E2-36541FCF7D30@gmail.com>
 <20210219133459.vezgrlkjpmaizvb4@work>
 <BB31D81D-F4A9-490E-8F9D-2BC6350CE6B0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BB31D81D-F4A9-490E-8F9D-2BC6350CE6B0@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Alexey,

It'd be helpful to me to understand _why_ this use case is important
for your workloads.  O_DIRECT support is rarely used as far as I know,
and fs blocksize != page size is rare as well.  The main use cases I
know of fs blocksize != page size is on architectures (not terribly
common) with 16k or 64k page sizes, that want to use 4k file system
blocksizes for interoperability reasons.

(And I suppose because mke2fs uses a 4k block size by default.  Perhaps
we should change this so that the default is that mke2fs will use a
block size == page size, unless for some reason the page size is not
one supported by ext4 (although I'm not aware of any architecture
wanting page sizes > 64k), or the user explicitly specifies the block
size using "mke2fs -b".)

Are you trying to make O_DIRECT support in e2fsprogs a first class
reason out of completeness concern?  Or is this a use case which is
important in production workloads that you are familiar with?

Thanks,

						- Ted
