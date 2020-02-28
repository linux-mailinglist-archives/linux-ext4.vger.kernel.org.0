Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86C2C172F5F
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Feb 2020 04:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730700AbgB1Den (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 27 Feb 2020 22:34:43 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45090 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730630AbgB1Den (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 27 Feb 2020 22:34:43 -0500
Received: from callcc.thunk.org (guestnat-104-133-8-109.corp.google.com [104.133.8.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01S3Yax8019385
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Feb 2020 22:34:38 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 45663421A71; Thu, 27 Feb 2020 22:34:36 -0500 (EST)
Date:   Thu, 27 Feb 2020 22:34:36 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, sandeen@redhat.com
Subject: Re: [PATCH v2] tst_libext2fs: Avoid multiple definition of global
 variables
Message-ID: <20200228033436.GA101220@mit.edu>
References: <20200130132122.21150-1-lczerner@redhat.com>
 <20200210152459.19903-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210152459.19903-1-lczerner@redhat.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Feb 10, 2020 at 04:24:59PM +0100, Lukas Czerner wrote:
> gcc version 10 changed the default from -fcommon to -fno-common and as a
> result e2fsprogs make check tests fail because tst_libext2fs.c end up
> with a build error.
> 
> This is because it defines two global variables debug_prog_name and
> extra_cmds that are already defined in debugfs/debugfs.c. With -fcommon
> linker was able to resolve those into the same object, however with
> -fno-common it's no longer able to do it and we end up with multiple
> definition errors.
> 
> Fix the problem by using SKIP_GLOBDEFS macro to skip the variables
> definition in debugfs.c. Note that debug_prog_name is also defined in
> lib/ext2fs/extent.c when DEBUG macro is used, but this does not work even
> with older gcc versions and is never used regardless so I am not going to
> bother with it.
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>

Applied, thanks.

						- Ted
