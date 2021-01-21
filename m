Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895642FEF87
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Jan 2021 16:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbhAUPy1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 Jan 2021 10:54:27 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57794 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729307AbhAUPwz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 21 Jan 2021 10:52:55 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 10LFpsox001544
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jan 2021 10:51:54 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2DC3315C35F5; Thu, 21 Jan 2021 10:51:54 -0500 (EST)
Date:   Thu, 21 Jan 2021 10:51:54 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Saranya Muruganandam <saranyamohan@google.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/5] Add threading support to e2fsprogs
Message-ID: <YAmjGnSBNBssB1XW@mit.edu>
References: <20210114002723.643589-1-saranyamohan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114002723.643589-1-saranyamohan@google.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 13, 2021 at 04:27:18PM -0800, Saranya Muruganandam wrote:
> This patch set adds the infrastructure to support threading to
> libext2fs.  It makes the unix_io I/O Manager thread-aware.  Wang's
> parallel bitmap code has been adapted to use the new threading
> infrastructure.
> 
> The code has been tested with TSAN and ASAN built into gcc 10.2:
> 
>     configure 'CFLAGS=-g -fsanitize=thread' 'LDFLAGS=-fsanitize=thread'
>     make clean ; make -j16 ; make -j16 check
>     configure 'CFLAGS=-g -fsanitize=address' 'LDFLAGS=-fsanitize=address'
>     make clean ; make -j16 ; make -j16 check
> 
> As I(tytso) needed to excerpt out some of the changes to generated patches in
> "Add configure and build support for the pthreads", the full patch
> series can be found in git:
> 
> git fetch https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git pthreads

Thanks, I've applied this patch series.  (There were some slight merge
conflicts due to some other changes from the maint branch so I had to
regenerate the aclocal.m4 and configure files.)

							- Ted
