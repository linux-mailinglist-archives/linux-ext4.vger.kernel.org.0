Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE7542DB4ED
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Dec 2020 21:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgLOUTY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Dec 2020 15:19:24 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:44541 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726845AbgLOUTN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Dec 2020 15:19:13 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0BFKD6HJ000404
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Dec 2020 15:13:07 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 3A77B420280; Tue, 15 Dec 2020 15:13:06 -0500 (EST)
Date:   Tue, 15 Dec 2020 15:13:06 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: Re: [PATCH RESEND 4/8] ext4: add the gdt block of meta_bg to
 system_zone
Message-ID: <X9kY0htqhvFDNn20@mit.edu>
References: <1604764698-4269-1-git-send-email-brookxu@tencent.com>
 <1604764698-4269-4-git-send-email-brookxu@tencent.com>
 <20201203150841.GM441757@mit.edu>
 <4770d6b2-bb9f-7bc5-4fbd-2104bfeba7c2@gmail.com>
 <20201209043415.GG52960@mit.edu>
 <dd6c2921-1397-4b1a-5a20-23956f9cf956@gmail.com>
 <20201209193935.GO52960@mit.edu>
 <1704f274-fe41-4215-8e6e-ff09d080cdd5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1704f274-fe41-4215-8e6e-ff09d080cdd5@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

You did your test on a 80T file system, but that's not where someone
would be using meta_bg.  Meta_bg ges used for much larger file systems
than that!  With meta_bg, we have 3 block group descriptors every 64
block groups.  Each block group describes 128M of memory.  So for that
means we are going to have 3 entries in the system zone tree for every_
8GB of file system space, 383,216 entries for every PB.  Given that
each entry is 40 bytes, that means that the block_validity entries
will consume 15 megabytes per PB.

Now, one third of these entries overlap with the flex_bg entries
(meta_bg groups are in the first, second, and last block group of each
meta_bg, where are 64 block groups in 4k file systems), and of course,
the default flex_bg size of 16 block groups means that there are
524,288 entries per PB.  So if we include all backup sb and block
groups, in a 1 PB file system, there will be roughly 786,432 entries
in a 1 PB file system.  (I'm ignoring the entries for the backup
superblocks, but that's only about 20 or so extra entries.)

So for a flex_bg 1PB file system, the amount of memory for a
block_validity data structure is roughly 20M, and including all backup
descriptors for meta_bg on a flex_bg + meta_bg setup is roughly 30M.

I agree with you that for a non-meta_bg file system, including all of
the backup superblock and block group descriptors is not going to be
large.  But while protecting the meta_bg group descriptors is
worthwhile, protecting the backup meta_bg's is not free, and will
increase the size of the tree by 33%.

I'm also wondering whether or not Lustre (where they do have some file
systems that are in the PB range) have run into overhead issues with
block_validity.

What do folks think?

						- Ted
