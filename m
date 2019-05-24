Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3582901C
	for <lists+linux-ext4@lfdr.de>; Fri, 24 May 2019 06:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbfEXEdv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 24 May 2019 00:33:51 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40858 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725710AbfEXEdv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 24 May 2019 00:33:51 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4O4XiT8031190
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 May 2019 00:33:45 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5D535420481; Fri, 24 May 2019 00:33:44 -0400 (EDT)
Date:   Fri, 24 May 2019 00:33:44 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] e2fsck: handle verity files in scan_extent_node()
Message-ID: <20190524043344.GF2532@mit.edu>
References: <20190523153033.22487-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523153033.22487-1-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, May 23, 2019 at 08:30:33AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Don't report PR_1_EXTENT_END_OUT_OF_BOUNDS on verity files during
> scan_extent_node(), since they will have blocks stored past i_size.
> 
> This was missed during the earlier fix because this check only triggers
> if the inode has enough extents to need at least one extent index node.
> 
> This bug is causing one of the fs-verity xfstests to fail with the
> reworked fs-verity patchset.
> 
> Fixes: 3baafde6a8ae ("e2fsck: allow verity files to have initialized blocks past i_size")
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks, applied.

Could you supply a small (~200k) file system with a verity-protected
file so we can add a regression test?  Many thanks!!

     	       	     		       	    - Ted
