Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D90533BDE6A
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jul 2021 22:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhGFUZs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Jul 2021 16:25:48 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55042 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229781AbhGFUZs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Jul 2021 16:25:48 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 166KN4xk005567
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Jul 2021 16:23:05 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A0AFE15C3CC6; Tue,  6 Jul 2021 16:23:04 -0400 (EDT)
Date:   Tue, 6 Jul 2021 16:23:04 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, Dusty Mabe <dustymabe@redhat.com>
Subject: Re: [PATCH] e2fsck: fix last mount/write time when e2fsck is forced
Message-ID: <YOS7qJ2P2lIwjazY@mit.edu>
References: <20210614132725.10339-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614132725.10339-1-lczerner@redhat.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jun 14, 2021 at 03:27:25PM +0200, Lukas Czerner wrote:
> With commit c52d930f e2fsck is no longer able to fix bad last
> mount/write time by default because it is conditioned on s_checkinterval
> not being zero, which it is by default.
> 
> One place where it matters is when other e2fsprogs tools require to run
> full file system check before a certain operation. If the last mount
> time is for any reason in future, it will not allow it to run even if
> full e2fsck is ran.
> 
> Fix it by checking the last mount/write time when the e2fsck is forced,
> except for the case where we know the system clock is broken.
> 
> Fixes: c52d930f ("e2fsck: don't check for future superblock times if checkinterval == 0")
> Reported-by: Dusty Mabe <dustymabe@redhat.com>
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>

Applied, thanks.

					- Ted
