Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C511A475195
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Dec 2021 05:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239686AbhLOEHI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Dec 2021 23:07:08 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54411 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235674AbhLOEHI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Dec 2021 23:07:08 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1BF473b1006981
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Dec 2021 23:07:04 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CAFF315C00C8; Tue, 14 Dec 2021 23:07:03 -0500 (EST)
Date:   Tue, 14 Dec 2021 23:07:03 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Whitney <enwlinux@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] xfstests-bld: add ext4/044 to adv.exclude
Message-ID: <Yblp57PzXr0MVfdy@mit.edu>
References: <20211214205617.17233-1-enwlinux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214205617.17233-1-enwlinux@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Dec 14, 2021 at 03:56:17PM -0500, Eric Whitney wrote:
> Test ext4/044 fails when run in the adv test case because it explicitly
> attempts to mount a test file system created with the inline_data
> feature as ext3.  The inline_data feature and ext3 are incompatible,
> and the mount attempt fails.
> 
> This test did not fail in earlier xfstests-bld versions because the
> features included in adv were different.  In particular, the 64bit
> feature was applied, and this had an unfortunate side effect.
> Because the 64bit feature requires extents, and because the test
> attempts to create an ext3 file system, the initial attempt actually
> failed.  This was hidden by behavior in the xfstest function
> _scratch_do_mkfs, which then attempted to create the file system without
> the supplied "extra" mkfs options (those supplied for the adv test case).
> So, the test file system was not created with inline_data, the explicit
> attempt to mount the test file system as ext3 succeeded, and the test
> passed without testing anything particular to the adv test case.
> 
> Signed-off-by: Eric Whitney <enwlinux@gmail.com>

Thanks, applied.

					- Ted
