Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C52A8179C7F
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Mar 2020 00:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388493AbgCDXjT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Mar 2020 18:39:19 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:42183 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388484AbgCDXjS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Mar 2020 18:39:18 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-105.corp.google.com [104.133.0.105] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 024NdCWC016511
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Mar 2020 18:39:13 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 0090A42045B; Wed,  4 Mar 2020 18:39:11 -0500 (EST)
Date:   Wed, 4 Mar 2020 18:39:11 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@whamcloud.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] e2fsck: avoid overflow with very large dirs
Message-ID: <20200304233911.GI74069@mit.edu>
References: <1581037786-62789-1-git-send-email-adilger@whamcloud.com>
 <1581469641-85696-1-git-send-email-adilger@whamcloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581469641-85696-1-git-send-email-adilger@whamcloud.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Feb 11, 2020 at 06:07:21PM -0700, Andreas Dilger wrote:
> In alloc_size_dir() it multiples signed ints when allocating the
> buffer for rehashing an htree-indexed directory.  This will overflow
> when the directory size is above 4GB, which is possible with largedir
> directories having about 100M entries, assuming an average 3/4 leaf
> fullness and 24-byte filenames, or fewer with longer filenames.
> The same problem exisgs in get_next_block().
> 
> Similarly, the out_dir struct used a signed int for the number of
> blocks in the directory, which may result in a negative size if the
> directory is over 2GB (about 50M entries or fewer).
> 
> Use appropriate unsigned variables for block counts, and use larger
> types for calculating the byte count for memory offsets/sizes.
> 
> Such large directories not been seen yet, but are not too far away.
> The ext2fs_get_array() function will properly calculate the needed
> memory allocation, and detect overflow on 32-bit systems.
> Add ext2fs_resize_array() to do the same for array resize.
> 
> Signed-off-by: Andreas Dilger <adilger@whamcloud.com>
> Lustre-bug-id: https://jira.whamcloud.com/browse/LU-13197

Applied, thanks.  I had to make a slight change to fix a "merge
conflict" with the patch.

					- Ted
