Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FF64E65B7
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Mar 2022 15:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242275AbiCXO4u (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Mar 2022 10:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347268AbiCXO4t (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Mar 2022 10:56:49 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D75A89302
        for <linux-ext4@vger.kernel.org>; Thu, 24 Mar 2022 07:55:17 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 22OEtATC027993
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Mar 2022 10:55:11 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id B2A3915C0038; Thu, 24 Mar 2022 10:55:10 -0400 (EDT)
Date:   Thu, 24 Mar 2022 10:55:10 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] ext4: fix fallocate to use file_modified to update
 permissions consistently
Message-ID: <YjyGToTy8cHtytun@mit.edu>
References: <20220308185043.GA117678@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308185043.GA117678@magnolia>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Mar 08, 2022 at 10:50:43AM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Since the initial introduction of (posix) fallocate back at the turn of
> the century, it has been possible to use this syscall to change the
> user-visible contents of files.  This can happen by extending the file
> size during a preallocation, or through any of the newer modes (punch,
> zero, collapse, insert range).  Because the call can be used to change
> file contents, we should treat it like we do any other modification to a
> file -- update the mtime, and drop set[ug]id privileges/capabilities.
> 
> The VFS function file_modified() does all this for us if pass it a
> locked inode, so let's make fallocate drop permissions correctly.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>

Applied, thanks!

(BTW, when you reply to a patch with a different patch, such as in
this case, "fstests: ensure we drop suid after fallocate", it
hopelessly confuses b4, which is why I'm sending this notification
manually.  Try running "b4 am 20220308185043.GA117678@magnolia" and
compare that to https://lore.kernel.org/r/20220308185043.GA117678@magnolia
and you'll see what I mean.)

					- Ted
