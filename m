Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187BC340E8D
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Mar 2021 20:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbhCRTmW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Mar 2021 15:42:22 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34835 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233162AbhCRTmR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Mar 2021 15:42:17 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 12IJfx16022967
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Mar 2021 15:41:59 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id DB89715C39CA; Thu, 18 Mar 2021 15:41:58 -0400 (EDT)
Date:   Thu, 18 Mar 2021 15:41:58 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Whitney <enwlinux@gmail.com>
Cc:     linux-ext4@vger.kernel.org, willy@infradead.org
Subject: Re: generic/418 regression seen on 5.12-rc3
Message-ID: <YFOtBqSR6wq41G1T@mit.edu>
References: <20210318181613.GA13891@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318181613.GA13891@localhost.localdomain>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Mar 18, 2021 at 02:16:13PM -0400, Eric Whitney wrote:
> As mentioned in today's ext4 concall, I've seen generic/418 fail from time to
> time when run on 5.12-rc3 and 5.12-rc1 kernels.  This first occurred when
> running the 1k test case using kvm-xfstests.  I was then able to bisect the
> failure to a patch landed in the -rc1 merge window:
> 
> (bd8a1f3655a7) mm/filemap: support readpage splitting a page
> 
> Typical test output resulting from a failure looks like:
> 
>      QA output created by 418
>     +cmpbuf: offset 0: Expected: 0x1, got 0x0
>     +[6:0] FAIL - comparison failed, offset 3072
>     +diotest -w -b 512 -n 8 -i 4 failed at loop 0
>      Silence is golden
>     ...
> 
> I've also been able to reproduce the failure on -rc3 in the 4k test case as
> well.  The failure frequency there was 10 out of 100 runs.  It was anywhere
> from 2 to 8 failures out of 100 runs in the 1k case.

FWIW, testing on a kernel which is -rc2 based (ext4.git's tip) I
wasn't able to see a failure using gce-xfstests using the ext4/4k,
ext4/1k, and xfs/1k test scenarios.  This may be because of the I/O
timing for the persistent disk block device in GCE, or differences in
the number of CPU's or amount of memory available --- or in the kernel
configuration that was used to build it.

I'm currently retrying with -rc3, with and without the kernel debug
configs, to see if that makes any difference...

	 	    	   	      - Ted
