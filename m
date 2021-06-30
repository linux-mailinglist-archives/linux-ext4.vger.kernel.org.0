Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719C93B870E
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Jun 2021 18:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbhF3Q35 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Jun 2021 12:29:57 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34739 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229510AbhF3Q34 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Jun 2021 12:29:56 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15UGRLBZ003232
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Jun 2021 12:27:22 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9F8E915C3C8E; Wed, 30 Jun 2021 12:27:21 -0400 (EDT)
Date:   Wed, 30 Jun 2021 12:27:21 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/9] ext4/003: Fix this test on 64K platform for dax
 config
Message-ID: <YNybadzpnZZdwtzR@mit.edu>
References: <cover.1623651783.git.riteshh@linux.ibm.com>
 <fda7d76b27234a46c3e7165fbdfc4154708c227d.1623651783.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fda7d76b27234a46c3e7165fbdfc4154708c227d.1623651783.git.riteshh@linux.ibm.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jun 14, 2021 at 11:58:05AM +0530, Ritesh Harjani wrote:
> mkfs.ext4 by default uses 4K blocksize which doesn't mount when testing
> with dax config and the test fails. This patch fixes it.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  tests/ext4/003 | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/ext4/003 b/tests/ext4/003
> index 00ea9150..1ddb3063 100755
> --- a/tests/ext4/003
> +++ b/tests/ext4/003
> @@ -31,7 +31,8 @@ _require_scratch_ext4_feature "bigalloc"
>  
>  rm -f $seqres.full
>  
> -$MKFS_EXT4_PROG -F -O bigalloc -C 65536  -g 256 $SCRATCH_DEV 512m \
> +BLOCK_SIZE=$(get_page_size)
> +$MKFS_EXT4_PROG -F -b $BLOCK_SIZE -O bigalloc -C 65536  -g 256 $SCRATCH_DEV 512m \
>  	>> $seqres.full 2>&1
>  _scratch_mount

Thanks for the patch!

If the block size is 64k, then the cluster_size == block_size at which
point ext4/003 won't be able to test for the regression its designed
to test.  So we probably need to scale the cluster size and file
system size relative to the block size.

					- Ted
