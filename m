Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5290574FBF1
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Jul 2023 01:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjGKXx6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 11 Jul 2023 19:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjGKXx5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 11 Jul 2023 19:53:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6DD1711
        for <linux-ext4@vger.kernel.org>; Tue, 11 Jul 2023 16:53:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 203AE6165C
        for <linux-ext4@vger.kernel.org>; Tue, 11 Jul 2023 23:53:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED35C433C8;
        Tue, 11 Jul 2023 23:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689119635;
        bh=HFlF9C5qGNWGmnswDUZ75q3SnmQEVpHJGizEOljQg/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YjXYdv1bf/IXl5+9mCFpjqLZVktQcqQ8u9imKW7YKP/ipGG5S9nFXsb8qr902UJo2
         auy/INq+tezxsCXvQ/AVs5bm/qbX9pJZh7chg53m7S8TaRBm92b7gjmx3LLwjtrVN6
         yyO8us6+CliB2bWkuJCgpqS32qyYp5gz8CkXyLOoSLMDdFOuEV9+C8wfLR56jJLDvK
         6bFnx2P1ttrodFYbb9M4dsCYNB3msODh4h8uGDpzxuwFT+TlLzaqPwR8/c0VZ+rvjL
         Uom1jZ5uG0PVJFhLOSAIQnftQz/oEESgur4frZB0f0bnWg/eBD25e+UvRYy1Ef6m+X
         xAj1VFhWpzmxw==
Date:   Tue, 11 Jul 2023 16:53:54 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Johannes Schauer Marin Rodrigues <josch@mister-muffin.de>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/1] mke2fs: the -d option can now handle tarball input
Message-ID: <20230711235354.GE11476@frogsfrogsfrogs>
References: <20230620121641.469078-1-josch@mister-muffin.de>
 <20230620121641.469078-2-josch@mister-muffin.de>
 <20230630155128.GA11419@frogsfrogsfrogs>
 <168836303674.2483784.4947178089926484601@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168836303674.2483784.4947178089926484601@localhost>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jul 03, 2023 at 07:43:56AM +0200, Johannes Schauer Marin Rodrigues wrote:
> Hi,
> 
> Quoting Darrick J. Wong (2023-06-30 17:51:28)
> > On Tue, Jun 20, 2023 at 02:16:41PM +0200, Johannes Schauer Marin Rodrigues wrote:
> > > If archive.h is available during compilation, enable mke2fs to read a
> > > tarball as input. Since libarchive.so.13 is opened with dlopen,
> > > libarchive is not a hard library dependency of the resulting binary.
> > 
> > I can't say I'm in favor of adding build dependencies to e2fsprogs,
> > since the point of -d taking a directory arg was to *avoid* having to
> > understand anything other than posix(ish) directory tree walking APIs.
> 
> this is why the build dependency is optional.

As Ted said elsewhere, the big question is (a) do we really want
e2fsprogs depending on libarchive at all, and (b) is libarchive's API
stable enough that you'll maintain it for us?  Merging this patch *is*
adding to the complexity of what most distros consider to be critical
system utility.

> It should be perfectly possible
> to build e2fsprogs without libarchive as well. I copied the pattern that was
> already implemented for libmagic which is also not a hard dependency but gets
> dlopened-ed at runtime. If this mechanism is fine for libmagic it should be
> fine for others as well, no?
> 
> The tar format (minus some features) is also not terribly complicated. Would

There's at least five formats known to GNU tar, according to its manpage:

Format	UID		File Size	File Name	Devn
gnu	1.8e19		Unlimited	Unlimited	63
oldgnu	1.8e19		Unlimited	Unlimited	63
v7	2097151		8GB		99		n/a
ustar	2097151		8GB		256		21
posix	Unlimited	Unlimited	Unlimited	Unlimited

https://www.gnu.org/software/tar/manual/html_chapter/Formats.html

> you prefer I add a rudimentary tar parser that will be used in the event that
> libarchive is not available? The tar format is not that complicated but adding
> such code to e2fsprogs would be overkill for a functionality that is otherwise
> optional, no?

Indeed not.

> > > This enables the creation of filesystems containing files which would
> > > otherwise need superuser privileges to create (like device nodes, which are
> > > also not allowed in unshared user namespaces). By reading from standard
> > > input when the filename is a dash (-), mke2fs can be used as part of a
> > > shell pipeline without temporary files.
> > What if the argument is actually a Microsoft CAB archive (which libarchive
> > claims to support)?  Will it actually copy the cab archive into an ext4
> > image?
> 
> I didn't have a cab archive so I couldn't test this but it does work with other
> archive formats like zip files. Would you like me to artificially restrict the
> input format to only tarballs?

No -- if Ted wants libarchive input for e2fsprogs, it may as well take
full advantage of it.

--D

> Thanks!
> 
> cheers, josch


