Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF93183393
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Mar 2020 15:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbgCLOqt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Mar 2020 10:46:49 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48291 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727565AbgCLOqt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Mar 2020 10:46:49 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 02CEkhpK015051
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Mar 2020 10:46:43 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id DE9C8420E5E; Thu, 12 Mar 2020 10:46:42 -0400 (EDT)
Date:   Thu, 12 Mar 2020 10:46:42 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: mark extents index blocks as dirty to avoid
 information leakage
Message-ID: <20200312144642.GF7159@mit.edu>
References: <e988a1db-3105-07a0-6399-38af80656af1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e988a1db-3105-07a0-6399-38af80656af1@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Mar 03, 2020 at 04:51:06PM +0800, brookxu wrote:
> From: Chunguang Xu <brookxu@tencent.com>
> 
> In the scene of deleting a file, the physical block information in the
> extent will be cleared to 0, the buffer_head contains these extents is
> marked as dirty, and then managed by jbd2, which will clear the
> buffer_head's dirty flag by clear_buffer_dirty. However, when the entire
> extent block is deleted, it is revoked from the jbd2, but  the extents
> block is not redirtied.
> 
> Not quite reasonable here, for the following concerns:
> 
> 1. This has the risk of information leakage and leads to an interesting
> phenomenon that deleting the entire file is no more secure than truncate
> to 1 byte, because the whole extents physical block clear to zero in cache
> will never written back as the page is not redirtied.
> 
> 2. For large files, the number of index block is usually very small.
> Ignoring index pages not get much more benefit in IO performance. But if
> we remark the page as dirty, the page is then written back by the system
> writeback mechanism asynchronously with little performance impact. As a
> result, the risk of information leakage can be avoided. At least not wrose
> than truncate file length to 1 byte
> 
> Therefore, when the index block is released, we need to remark its page
> as dirty, so that the index block on the disk will be updated and the
> data is more security.
> 
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>

Trying to zero the extent block is only going to provide pretend
security; the data blocks are still there, and anyone looking for the
data can still find it if they look hard enough.  Also, for most
files, it really doesn't matter.

So, no, I don't think this patch is appropriate.a

If you are really worried about the security for deleted files, I
would suggest trying to implement the secure delete flag (chattr +s)
for ext4, and actually trying to zero out the data blocks for those
files where this kind of security is required.  (Please note that for
SSD's, this probably won't provide as much security as you would like
unless they implement the secure discard operation.)

							- Ted
