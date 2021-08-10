Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237D53E7D4A
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Aug 2021 18:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbhHJQSZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 Aug 2021 12:18:25 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41219 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234658AbhHJQQd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 10 Aug 2021 12:16:33 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17AGFTJl012556
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Aug 2021 12:15:29 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0997115C3DD0; Tue, 10 Aug 2021 12:15:29 -0400 (EDT)
Date:   Tue, 10 Aug 2021 12:15:28 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 7/7] mkquota: Fix potental NULL pointer dereference
Message-ID: <YRKmIDH8XWBwGXAT@mit.edu>
References: <20210806095820.83731-1-lczerner@redhat.com>
 <20210806095820.83731-7-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806095820.83731-7-lczerner@redhat.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Aug 06, 2021 at 11:58:20AM +0200, Lukas Czerner wrote:
> get_dq() function can fail when the memory allocation fails and so we
> could end up dereferencing NULL pointer. Fix it.
> 
> Also, we should really return -ENOMEM instead of -1, or even 0 from
> various functions in quotaio_tree.c when memory allocation fails.
> Fix it as well.

The quota*.c files were taking from the quota_tools package, and are
currently using the converion of setting errno and returning -1.  I
don't think an incomplete conversion to the kernel error return
convention is the way to go.  My long term plan for the quota
functions in libsupport is to convert them to use the comerr_t error
return convention, remove all of the printf functions from the
functions, so they can be properly moved into libext2fs library as a
first class supported library functions, and so that the high-level
ext2fs functions would update the quota files --- so that programs
like fuse2fs would properly update the quota records.

So I'm going to drop the error handling changes from this patch before
applying it.

Cheers,

					- Ted
