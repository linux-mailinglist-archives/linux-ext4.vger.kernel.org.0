Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D380149E70
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Jan 2020 04:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgA0Dzp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 26 Jan 2020 22:55:45 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:51888 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726545AbgA0Dzp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 26 Jan 2020 22:55:45 -0500
Received: from callcc.thunk.org ([67.142.235.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00R3tRJT005833
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jan 2020 22:55:37 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 9F4D7420324; Sun, 26 Jan 2020 21:56:01 -0500 (EST)
Date:   Sun, 26 Jan 2020 21:56:01 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Li Dongyang <dongyangli@ddn.com>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "adilger@dilger.ca" <adilger@dilger.ca>
Subject: Re: [PATCH v3 1/5] libext2fs: optimize
 ext2fs_convert_subcluster_bitmap()
Message-ID: <20200127025601.GA115399@mit.edu>
References: <20191120043448.249988-1-dongyangli@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120043448.249988-1-dongyangli@ddn.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 20, 2019 at 04:35:21AM +0000, Li Dongyang wrote:
> For a bigalloc filesystem, converting the block bitmap from blocks
> to chunks in ext2fs_convert_subcluster_bitmap() can take a long time
> when the device is huge, because we test the bitmap
> bit-by-bit using ext2fs_test_block_bitmap2().
> Use ext2fs_find_first_set_block_bitmap2() which is more efficient
> for mke2fs when the fs is mostly empty.
> 
> e2fsck can also benefit from this during pass1 block scanning.
> 
> Time taken for "mke2fs -O bigalloc,extent -C 131072 -b 4096" on a 1PB
> device:
> 
> without patch:
> real    27m49.457s
> user    21m36.474s
> sys     6m9.514s
> 
> with patch:
> real    6m31.908s
> user    0m1.806s
> sys    6m29.697s
> 
> Signed-off-by: Li Dongyang <dongyangli@ddn.com>
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>

Applied, thanks.

					- Ted
