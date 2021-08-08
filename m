Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F389B3E3AC9
	for <lists+linux-ext4@lfdr.de>; Sun,  8 Aug 2021 16:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhHHO32 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 8 Aug 2021 10:29:28 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:42023 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229923AbhHHO32 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 8 Aug 2021 10:29:28 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 178ET38d023212
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 8 Aug 2021 10:29:04 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6D5BA15C3E25; Sun,  8 Aug 2021 10:29:03 -0400 (EDT)
Date:   Sun, 8 Aug 2021 10:29:03 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@dilger.ca>
Subject: Re: [PATCH 2/5] ext4: Move orphan inode handling into a separate file
Message-ID: <YQ/qL+lOaYd3iD1+@mit.edu>
References: <20210712154009.9290-1-jack@suse.cz>
 <20210712154009.9290-3-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712154009.9290-3-jack@suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jul 12, 2021 at 05:40:06PM +0200, Jan Kara wrote:
> Move functions for handling orphan inodes into a new file
> fs/ext4/orphan.c to have them in one place and somewhat reduce size of
> other files. No code changes.
> 
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>
> Signed-off-by: Jan Kara <jack@suse.cz>

Note that when you refresh this patch, you'll need to include commit
b9a037b7f3c4: ("ext4: cleanup in-core orphan list if ext4_truncate()
failed to get a transaction handle") when moving ext4_orphan_cleanup()
to fs/ext4/orphan.c.

Cheers,

	      	      	      	      	     - Ted
