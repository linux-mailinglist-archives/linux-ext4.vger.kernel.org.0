Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2262C17A7
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Nov 2020 22:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730578AbgKWVZ2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Nov 2020 16:25:28 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53504 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728093AbgKWVZ1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Nov 2020 16:25:27 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0ANLPGoj011310
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Nov 2020 16:25:17 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id B7678420136; Mon, 23 Nov 2020 16:25:16 -0500 (EST)
Date:   Mon, 23 Nov 2020 16:25:16 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Saranya Muruganandam <saranyamohan@google.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca
Subject: Re: [RFC PATCH v3 00/61] Introduce parallel fsck to e2fsck pass1
Message-ID: <20201123212516.GC132317@mit.edu>
References: <20201118153947.3394530-1-saranyamohan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 18, 2020 at 07:38:46AM -0800, Saranya Muruganandam wrote:
> I've tested the whole patch series using 'make test' of e2fsck itself, and i
> manually set default threads to 4 which still pass almost of test suite,
> failure cases are below:
> 
> f_h_badroot f_multithread f_multithread_logfile f_multithread_no f_multithread_ok
> 
> h_h_badroot failed because out of order checking output, and others are because
> of extra multiple threads log output.

I just tried the full series, and I'm only seeing one test failure.
Unfortunately, it's f_multithread, and it's double free crash:

...
Pass 5: Checking group summary information
Multiple threads triggered to read bitmaps
double free or corruption (!prev)
Signal (6) SIGABRT si_code=SI_TKILL
../e2fsck/e2fsck(+0x45fab)[0x556589911fab]
/lib/x86_64-linux-gnu/libpthread.so.0(+0x14140)[0x7fe52ec34140]
/lib/x86_64-linux-gnu/libc.so.6(gsignal+0x141)[0x7fe52ea96c41]
/lib/x86_64-linux-gnu/libc.so.6(abort+0x123)[0x7fe52ea80537]
/lib/x86_64-linux-gnu/libc.so.6(+0x7e6c8)[0x7fe52ead96c8]
/lib/x86_64-linux-gnu/libc.so.6(+0x859ba)[0x7fe52eae09ba]
/lib/x86_64-linux-gnu/libc.so.6(+0x86ffc)[0x7fe52eae1ffc]
../lib/libext2fs.so.2(ext2fs_free_mem+0x23)[0x7fe52ed1091a]
../lib/libext2fs.so.2(+0x47329)[0x7fe52ed1f329]
../lib/libext2fs.so.2(+0x475b4)[0x7fe52ed1f5b4]
/lib/x86_64-linux-gnu/libpthread.so.0(+0x8ea7)[0x7fe52ec28ea7]
/lib/x86_64-linux-gnu/libc.so.6(clone+0x3f)[0x7fe52eb58d4f]
Exit status is 8

Here's the contents of f_multithread_ok.1.log after running
"./test_script --valgrind f_multithread_ok" in the tests directory:

Pass 1: Checking inodes, blocks, and sizes
[Thread 0] Scan group range [0, 1)
[Thread 1] Scan group range [1, 2)
[Thread 2] Scan group range [2, 3)
[Thread 3] Scan group range [3, 4)
[Thread 2] Scanned group range [2, 3), inodes 8192
[Thread 1] Scanned group range [1, 2), inodes 8192
[Thread 3] Scanned group range [3, 4), inodes 8192
[Thread 0] Scanned group range [0, 1), inodes 8192
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
Multiple threads triggered to read bitmaps
==182288== Thread 2:
==182288== Conditional jump or move depends on uninitialised value(s)
==182288==    at 0x488E31B: read_bitmaps_range_start (rw_bitmaps.c:437)
==182288==    by 0x488E5B3: read_bitmaps_thread (rw_bitmaps.c:532)
==182288==    by 0x4965EA6: start_thread (pthread_create.c:477)
==182288==    by 0x4A7CD4E: clone (clone.S:95)
==182288== 
==182288== Conditional jump or move depends on uninitialised value(s)
==182288==    at 0x4839961: free (vg_replace_malloc.c:538)
==182288==    by 0x487F919: ext2fs_free_mem (ext2fs.h:1891)
==182288==    by 0x488E328: read_bitmaps_range_start (rw_bitmaps.c:438)
==182288==    by 0x488E5B3: read_bitmaps_thread (rw_bitmaps.c:532)
==182288==    by 0x4965EA6: start_thread (pthread_create.c:477)
==182288==    by 0x4A7CD4E: clone (clone.S:95)
==182288== 
==182288== Invalid free() / delete / delete[] / realloc()
==182288==    at 0x48399AB: free (vg_replace_malloc.c:538)
==182288==    by 0x487F919: ext2fs_free_mem (ext2fs.h:1891)
==182288==    by 0x488E328: read_bitmaps_range_start (rw_bitmaps.c:438)
==182288==    by 0x488E5B3: read_bitmaps_thread (rw_bitmaps.c:532)
==182288==    by 0x4965EA6: start_thread (pthread_create.c:477)
==182288==    by 0x4A7CD4E: clone (clone.S:95)
==182288==  Address 0x4b46100 is 0 bytes inside a block of size 3,144 free'd
==182288==    at 0x48399AB: free (vg_replace_malloc.c:538)
==182288==    by 0x487F919: ext2fs_free_mem (ext2fs.h:1891)
==182288==    by 0x488E328: read_bitmaps_range_start (rw_bitmaps.c:438)
==182288==    by 0x488E5B3: read_bitmaps_thread (rw_bitmaps.c:532)
==182288==    by 0x4965EA6: start_thread (pthread_create.c:477)
==182288==    by 0x4A7CD4E: clone (clone.S:95)
==182288==  Block was alloc'd at
==182288==    at 0x483877F: malloc (vg_replace_malloc.c:307)
==182288==    by 0x487F7C9: ext2fs_get_mem (ext2fs.h:1847)
==182288==    by 0x11EE47: e2fsck_allocate_context (e2fsck.c:27)
==182288==    by 0x11B228: PRS (unix.c:829)
==182288==    by 0x11CD55: main (unix.c:1465)
...

						- Ted
