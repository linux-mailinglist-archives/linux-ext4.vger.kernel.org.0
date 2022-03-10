Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92ACE4D50C6
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Mar 2022 18:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbiCJRoO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Mar 2022 12:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241255AbiCJRoO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Mar 2022 12:44:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E041112F15C
        for <linux-ext4@vger.kernel.org>; Thu, 10 Mar 2022 09:43:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BA3A61E13
        for <linux-ext4@vger.kernel.org>; Thu, 10 Mar 2022 17:43:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE81EC340E8;
        Thu, 10 Mar 2022 17:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646934191;
        bh=J11v0dZeoP8U3TqF3q8W8uMR8kA08ukr8hKbjh+FU/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zf/jc2YaKbq/w+lgG82k+lqb5sfF8SKltTP2lEB6ZynaSeV1I4Frp+4qMlQhwSyKg
         QBmYbeVRuCwUzaP7tCQU+KEncaox2f1KeWLFvREBX7dBHOZEIyX2BM7TI7teGJ4wdo
         CDTL5pGYtnvv6ev4R7HZ1KRXCeRY2fzRUhz0EAHv1ShF5I57L/r4PI2Zglm1jfLAqw
         w0WiJkPrggwnpnUXd/k2/Wd8CZiGp5Y5BiIA1S8EyJlrVZcmQD3BnAqXUExKKpNENt
         uUDXbBRYGt34cUiS1kMO5yJD8ul62fzMo3uV22Cmedy0UrfY+sIinzr18bTzol9ehQ
         4MRrfmoa3TMcA==
Date:   Thu, 10 Mar 2022 09:43:11 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] ext4: fix fallocate to use file_modified to update
 permissions consistently
Message-ID: <20220310174311.GA8172@magnolia>
References: <20220308185043.GA117678@magnolia>
 <Yil/Dac4kraFdMuy@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yil/Dac4kraFdMuy@sol.localdomain>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Mar 09, 2022 at 08:31:09PM -0800, Eric Biggers wrote:
> On Tue, Mar 08, 2022 at 10:50:43AM -0800, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Since the initial introduction of (posix) fallocate back at the turn of
> > the century, it has been possible to use this syscall to change the
> > user-visible contents of files.  This can happen by extending the file
> > size during a preallocation, or through any of the newer modes (punch,
> > zero, collapse, insert range).  Because the call can be used to change
> > file contents, we should treat it like we do any other modification to a
> > file -- update the mtime, and drop set[ug]id privileges/capabilities.
> > 
> > The VFS function file_modified() does all this for us if pass it a
> > locked inode, so let's make fallocate drop permissions correctly.
> > 
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> >  fs/ext4/ext4.h    |    2 +-
> >  fs/ext4/extents.c |   32 +++++++++++++++++++++++++-------
> >  fs/ext4/inode.c   |    7 ++++++-
> >  3 files changed, 32 insertions(+), 9 deletions(-)
> 
> Is there a test in xfstests that tests for this?

Not currently.  I /do/ actually have one drafted (which I'll email out
as a reply) but I was gonna tackle fixing btrfs before I actually submit
it to Eryu for upstream fstests.

--D

> - Eric
