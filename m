Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427873D8398
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Jul 2021 01:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbhG0XBR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Jul 2021 19:01:17 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55837 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232198AbhG0XBQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 27 Jul 2021 19:01:16 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 16RN1CAI007369
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jul 2021 19:01:13 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8DB3E15C3DBC; Tue, 27 Jul 2021 19:01:12 -0400 (EDT)
Date:   Tue, 27 Jul 2021 19:01:12 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Mikhail Morfikov <mmorfikov@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: Is it safe to use the bigalloc feature in the case of ext4
 filesystem?
Message-ID: <YQCQODCGtJRTKwS9@mit.edu>
References: <0dc45cbd-b3b0-97ab-66a9-f68331cb483e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dc45cbd-b3b0-97ab-66a9-f68331cb483e@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jul 23, 2021 at 05:30:13PM +0200, Mikhail Morfikov wrote:
> In the man ext4(5) we can read the following:
> 
>     Warning: The bigalloc feature is still under development, 
>     and may not be fully supported with your kernel or may 
>     have various bugs. Please see the web page 
>     http://ext4.wiki.kernel.org/index.php/Bigalloc for details. 
>     May clash with delayed allocation (see nodelalloc mount 
>     option).
> 
> According to the link above, the info is dated back to 2013, 
> which is a little bit ancient.
> 
> What's the current status of the feature? Is it safe to use 
> bigalloc on several TiB hard disks where only big files will be 
> stored?

Yes; the places where bigalloc is perhaps not as well tested is
support FALLOC_FL_COLLAPSE_RANGE, FALLOC_FL_INSERT_RANGE, and
FALLOC_FL_PUNCH_HOLE.  Bigalloc is also not very efficient for large
directories (where we allocate a full cluster for each directory
block).  Older kernels did not handle ENOSPC errors when delayed
allocation was enabled, but that has since been fixed, and bigalloc is
passing file system regression tests, so it should safe to use as
you've described.

Cheers,

					- Ted
					
