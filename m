Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C703B1833F4
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Mar 2020 16:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbgCLPAM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Mar 2020 11:00:12 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50851 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726436AbgCLPAM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Mar 2020 11:00:12 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 02CF07lu020497
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Mar 2020 11:00:08 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 47FC0420E5E; Thu, 12 Mar 2020 11:00:07 -0400 (EDT)
Date:   Thu, 12 Mar 2020 11:00:07 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Eric Whitney <enwlinux@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: clean up ext4_ext_insert_extent() call in
 ext4_ext_map_blocks()
Message-ID: <20200312150007.GJ7159@mit.edu>
References: <20200311205033.25013-1-enwlinux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311205033.25013-1-enwlinux@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Mar 11, 2020 at 04:50:33PM -0400, Eric Whitney wrote:
> Now that the eofblocks code has been removed, we don't need to assign
> 0 to err before calling ext4_ext_insert_extent() since it will assign
> a return value to ret anyway.  The variable free_on_err can be
> eliminated and replaced by a reference to allocated_clusters which
> clearly conveys the idea that newly allocated blocks should be freed
> when recovering from an extent insertion failure.  The error handling
> code itself should be restructured so that it errors out immediately on
> an insertion failure in the case where no new blocks have been allocated
> (bigalloc) rather than proceeding further into the mapping code.  The
> initializer for fb_flags can also be rearranged for improved
> readability.  Finally, insert a missing space in nearby code.
> 
> No known bugs are addressed by this patch - it's simply a cleanup.
> 
> Signed-off-by: Eric Whitney <enwlinux@gmail.com>

Applied, thanks.

					- Ted
