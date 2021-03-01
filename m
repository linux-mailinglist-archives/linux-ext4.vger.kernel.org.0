Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3DD03281D7
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Mar 2021 16:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbhCAPJY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 Mar 2021 10:09:24 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56407 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S236914AbhCAPJR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 1 Mar 2021 10:09:17 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 121F8Qrh006719
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 1 Mar 2021 10:08:27 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9DABB15C3A88; Mon,  1 Mar 2021 10:08:26 -0500 (EST)
Date:   Mon, 1 Mar 2021 10:08:26 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: badblocks from e2fsprogs
Message-ID: <YD0DaqIbAf0T2tw2@mit.edu>
References: <CA+icZUXzjAniVZMzS5ePNa6HrjWL6ZrpAgzWufy74zHSyN+urQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUXzjAniVZMzS5ePNa6HrjWL6ZrpAgzWufy74zHSyN+urQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Mar 01, 2021 at 10:20:36AM +0100, Sedat Dilek wrote:
> 
> root@iniza:~/DISK-HEALTH# LC_ALL=C badblocks -v -p 1 -s /dev/sdc -o
> badblocks-v-p-1-s_dev-sdc_$(uname -r).txt
> Checking blocks 0 to 976762583
> Checking for bad blocks (read-only test): done
> Pass completed, 0 bad blocks found. (0/0/0 errors)
> 
> root@iniza:~/DISK-HEALTH# ll
> badblocks-v-p-1-s_dev-sdc_5.11.0-11646.1-amd64-clang13-cfi.txt
> -rw-r--r-- 1 root root 0 28. Feb 19:33
> badblocks-v-p-1-s_dev-sdc_5.11.0-11646.1-amd64-clang13-cfi.txt
> 
> Unfortunately, the output-file is empty.
> Do I miss something (order of options for example)?

Nope; the output file is a list of block numbers for which badblocks
found problems.

> The whole single-pass badblocks run took approx. 3 hours - last I
> looked 50% was 01:26 [hh:mm].
> On stdout (and in output-file) - no summary of the total-time.
> 
> Is that possible to have:
> 
> Pass completed, 0 bad blocks found. (0/0/0 errors) + <total-time_of_run>

The output file was designed for use to be fed into mke2fs (via the -l
option) or e2fsck (via the -l or -L options).  So we can't change the
format of the output file without breaking those programs.

You will note that the output is in the badblocks standard output:

Pass completed, 0 bad blocks found. (0/0/0 errors)

So there should be no confusion in the mind of the person running the
badblocks program.

Regards,

					- Ted
