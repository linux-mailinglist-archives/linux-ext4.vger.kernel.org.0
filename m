Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3047B23D63F
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Aug 2020 07:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgHFFGT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Aug 2020 01:06:19 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45772 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725271AbgHFFGT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Aug 2020 01:06:19 -0400
Received: from callcc.thunk.org (pool-96-230-252-158.bstnma.fios.verizon.net [96.230.252.158])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 07656A55024162
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Aug 2020 01:06:10 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 23BBB420263; Thu,  6 Aug 2020 01:06:10 -0400 (EDT)
Date:   Thu, 6 Aug 2020 01:06:10 -0400
From:   tytso@mit.edu
To:     Jan Kara <jack@suse.cz>
Cc:     <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] ext4: Do not block RWF_NOWAIT dio write on unallocated
 space
Message-ID: <20200806050610.GG7657@mit.edu>
References: <20200708153516.9507-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708153516.9507-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jul 08, 2020 at 05:35:16PM +0200, Jan Kara wrote:
> Since commit 378f32bab371 ("ext4: introduce direct I/O write using iomap
> infrastructure") we don't properly bail out of RWF_NOWAIT direct IO
> write if underlying blocks are not allocated. Also
> ext4_dio_write_checks() does not honor RWF_NOWAIT when re-acquiring
> i_rwsem. Fix both issues.
> 
> Fixes: 378f32bab371 ("ext4: introduce direct I/O write using iomap infrastructure")
> Reported-by: Filipe Manana <fdmanana@gmail.com>
> Signed-off-by: Jan Kara <jack@suse.cz>

Applied, thanks.

					- Ted
