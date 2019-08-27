Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABC359DBAC
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Aug 2019 04:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbfH0Cix (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Aug 2019 22:38:53 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58009 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727887AbfH0Cix (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 26 Aug 2019 22:38:53 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7R2cmxC013004
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Aug 2019 22:38:49 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A86FA42049E; Mon, 26 Aug 2019 22:38:48 -0400 (EDT)
Date:   Mon, 26 Aug 2019 22:38:48 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] ext4: attempt to shrink directory on dentry removal
Message-ID: <20190827023848.GH28066@mit.edu>
References: <20190821182740.97127-1-harshadshirwadkar@gmail.com>
 <7303B125-6C0E-41C2-A71E-4AF8C9776468@dilger.ca>
 <CAD+ocbzT=A4LW7CYBC_mxh2cf3ZxUhvffhtpO0LnfkXAJDy0Kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD+ocbzT=A4LW7CYBC_mxh2cf3ZxUhvffhtpO0LnfkXAJDy0Kw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 26, 2019 at 02:46:01PM -0700, harshad shirwadkar wrote:
> By this method we end up reading up to 2 extra blocks (one previous
> and one next) that are not going to be merged. That's the trade-off we
> have to make in order to avoid any changes to on-disk structure (If we
> modify the on-disk structure and store the fullness in the dx block,
> we would read only the blocks that need to be merged).

We can also adjust the merging strategy depending on whether the
previous and/or next blocks are in memory.  If they are in memory,
that we might try merging if the block is < 50% full.  If they are not
in memory, it might not be worth doing the read until the block is
empty, or maybe, say, 10% full.

> Since merging approach also requires a way to free up directory
> blocks, I think we could first get a patch in that can free up
> directory blocks by swapping with the last block. Once we have that
> then we could implement merging.

I agree; I'd wait to implementing merging until we get directory block
removal working.  Simply trying to shrink the directory when a leaf
block which is *not* the last block in an indexed directory is going
to be substantially better compared to waiting until the last block in
the directory is empty.

						- Ted
