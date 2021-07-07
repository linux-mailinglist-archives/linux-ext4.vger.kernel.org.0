Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33BA43BE0EC
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Jul 2021 04:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhGGCli (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Jul 2021 22:41:38 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45247 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229894AbhGGCli (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Jul 2021 22:41:38 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1672csQq027444
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Jul 2021 22:38:55 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 55CCB15C3CC6; Tue,  6 Jul 2021 22:38:54 -0400 (EDT)
Date:   Tue, 6 Jul 2021 22:38:54 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/6] libext2fs: improve jbd_debug() implementation
Message-ID: <YOUTvvfnwCQiGxu8@mit.edu>
References: <20210616045334.1655288-1-ebiggers@kernel.org>
 <20210616045334.1655288-2-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616045334.1655288-2-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jun 15, 2021 at 09:53:29PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Make jbd_debug() do format string checking (but still get compiled away
> to nothing) when --enable-jbd-debug isn't specified, similar to
> commit d556435156b7 ("jbd2: avoid -Wempty-body warnings") on the kernel
> side.  This should prevent --enable-jbd-debug from getting broken due to
> bad jbd_debug() statements.  It also eliminates a -Wunused-variable
> warning where a variable was only used in a jbd_debug() statement.
> 
> Also remove an alternative definition of jbd_debug() that was
> conditional on CONFIG_JBD_DEBUG && !CONFIG_JBD_DEBUG, so was dead code.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks, applied.

						- Ted
