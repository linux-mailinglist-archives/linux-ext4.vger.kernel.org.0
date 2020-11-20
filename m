Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0560E2BA14E
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Nov 2020 04:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgKTDmL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Nov 2020 22:42:11 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53212 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726118AbgKTDmL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Nov 2020 22:42:11 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0AK3fuIX029669
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 22:41:56 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 34843420107; Thu, 19 Nov 2020 22:41:56 -0500 (EST)
Date:   Thu, 19 Nov 2020 22:41:56 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix bogus warning in ext4_update_dx_flag()
Message-ID: <20201120034156.GC695373@mit.edu>
References: <20201118153032.17281-1-jack@suse.cz>
 <X7WXxl4gQEuvLxyO@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X7WXxl4gQEuvLxyO@sol.localdomain>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 18, 2020 at 01:53:10PM -0800, Eric Biggers wrote:
> On Wed, Nov 18, 2020 at 04:30:32PM +0100, Jan Kara wrote:
> > The idea of the warning in ext4_update_dx_flag() is that we should warn
> > when we are clearing EXT4_INODE_INDEX on a filesystem with metadata
> > checksums enabled since after clearing the flag, checksums for internal
> > htree nodes will become invalid. So there's no need to warn (or actually
> > do anything) when EXT4_INODE_INDEX is not set.
> > 
> > Reported-by: Eric Biggers <ebiggers@kernel.org>
> > Fixes: 48a34311953d ("ext4: fix checksum errors with indexed dirs")
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> Looks good,
> 
> Reviewed-by: Eric Biggers <ebiggers@google.com>

Applied, thanks.

					- Ted
