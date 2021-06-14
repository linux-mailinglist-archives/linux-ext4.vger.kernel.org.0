Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2146E3A6C3C
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jun 2021 18:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbhFNQn3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 14 Jun 2021 12:43:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235538AbhFNQnA (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 14 Jun 2021 12:43:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 06CD161078;
        Mon, 14 Jun 2021 16:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623688857;
        bh=+zFjYf1H+0XwZaDz4ckQ0PILBfQwwW7rEibV77nNug8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UepY0NsRt0ovL+8Px+H2/QJd8fNLoqrjyL6QGBEzRyLS2Y5X2e/tDrsU3GRaG4yLT
         UIrHzsx5+uh3H/HgIe0HS++UwAdnmBSMJEZwblW6EUOSPytVMVBfTfeyuMSN/q+HvC
         fjuf7d7oCMNQmYKRUwadOb5W7qlx0JUTF+lEDa1GdIa+DRL+GiKVtsIUfsCDw0amCm
         ygDbpP6LHZjwCVdSJZkDBdJxIALQf7V5IIBS6GHIMyZSPR/RGN21VfmYpAnHy0gcIL
         fDV7iHMNVNCTA6aRSUOgonFb1OHSut8qpQn6/OfPa23Am3fBrdgGVblW8K5T+fFj9a
         O5MG7QAAi90Ig==
Date:   Mon, 14 Jun 2021 09:40:56 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/9] ext4/027: Correct the right code of block and inode
 bitmap
Message-ID: <20210614164056.GA2945720@locust>
References: <cover.1623651783.git.riteshh@linux.ibm.com>
 <cf9babe1f24507d31886d806053dd1b93f2d144b.1623651783.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf9babe1f24507d31886d806053dd1b93f2d144b.1623651783.git.riteshh@linux.ibm.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jun 14, 2021 at 11:58:06AM +0530, Ritesh Harjani wrote:
> Observed occasional failure of this test sometimes say with 64k config
> and small device size. Reason is we were grepping for wrong values for
> inode and block bitmap.
> 
> Correct those values according to [1] to fix this test.
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/ext4/fsmap.h#n53
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  tests/ext4/027 | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/ext4/027 b/tests/ext4/027
> index 97c14cf5..83d5a413 100755
> --- a/tests/ext4/027
> +++ b/tests/ext4/027
> @@ -45,11 +45,11 @@ x=$(grep -c 'static fs metadata' $TEST_DIR/fsmap)
>  test $x -gt 0 || echo "No fs metadata?"
>  
>  echo "Check block bitmap" | tee -a $seqres.full
> -x=$(grep -c 'special 102:1' $TEST_DIR/fsmap)
> +x=$(grep -c 'special 102:3' $TEST_DIR/fsmap)
>  test $x -gt 0 || echo "No block bitmaps?"
>  
>  echo "Check inode bitmap" | tee -a $seqres.full
> -x=$(grep -c 'special 102:2' $TEST_DIR/fsmap)
> +x=$(grep -c 'special 102:4' $TEST_DIR/fsmap)

Maaaaybe I should have added textual descriptions for the ext4 getfsmap
owners.  Sorry... :(

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

>  test $x -gt 0 || echo "No inode bitmaps?"
>  
>  echo "Check inodes" | tee -a $seqres.full
> -- 
> 2.31.1
> 
