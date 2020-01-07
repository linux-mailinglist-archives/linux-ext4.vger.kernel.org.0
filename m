Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F33213230D
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jan 2020 10:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgAGJ4c (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Jan 2020 04:56:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:59560 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbgAGJ4b (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 7 Jan 2020 04:56:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4A8A9ABB1;
        Tue,  7 Jan 2020 09:56:30 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2997C1E0B47; Tue,  7 Jan 2020 10:56:30 +0100 (CET)
Date:   Tue, 7 Jan 2020 10:56:30 +0100
From:   Jan Kara <jack@suse.cz>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/8] ext4: extents.c cleanups
Message-ID: <20200107095630.GE26849@quack2.suse.cz>
References: <20191231180444.46586-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191231180444.46586-1-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 31-12-19 12:04:36, Eric Biggers wrote:
> This series makes a few cleanups to things I noticed while reading some
> of the code in extents.c.
> 
> No actual changes in behavior.

All the cleanups look good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> Eric Biggers (8):
>   ext4: remove ext4_{ind,ext}_calc_metadata_amount()
>   ext4: clean up len and offset checks in ext4_fallocate()
>   ext4: remove redundant S_ISREG() checks from ext4_fallocate()
>   ext4: make some functions static in extents.c
>   ext4: fix documentation for ext4_ext_try_to_merge()
>   ext4: remove obsolete comment from ext4_can_extents_be_merged()
>   ext4: fix some nonstandard indentation in extents.c
>   ext4: add missing braces in ext4_ext_drop_refs()
> 
>  fs/ext4/ext4.h         |  11 ----
>  fs/ext4/ext4_extents.h |   5 --
>  fs/ext4/extents.c      | 143 +++++++++++++----------------------------
>  fs/ext4/indirect.c     |  26 --------
>  fs/ext4/inode.c        |   3 -
>  fs/ext4/super.c        |   2 -
>  6 files changed, 45 insertions(+), 145 deletions(-)
> 
> -- 
> 2.24.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
