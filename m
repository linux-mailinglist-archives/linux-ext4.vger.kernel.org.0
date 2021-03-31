Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5E334FFE3
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Mar 2021 14:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235119AbhCaMFV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 31 Mar 2021 08:05:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:56978 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235140AbhCaMFJ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 31 Mar 2021 08:05:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 75AA1B1E6;
        Wed, 31 Mar 2021 12:05:08 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 306301E4415; Wed, 31 Mar 2021 14:05:08 +0200 (CEST)
Date:   Wed, 31 Mar 2021 14:05:08 +0200
From:   Jan Kara <jack@suse.cz>
To:     ira.weiny@intel.com
Cc:     Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] ext2: Convert kmap to kmap_local_page
Message-ID: <20210331120508.GG30749@quack2.suse.cz>
References: <20210329065402.3297092-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329065402.3297092-1-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ira!

On Sun 28-03-21 23:54:00, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> kmap is inefficient and can be abused so it is being phased out in favor of
> kmap_local_page where possible.
> 
> ext2 uses kmap in ext2_[get|put]_page().  All of the calls to
> ext2_[get|put]_page() occur in single threads so it is perfectly safe and
> preferable to use kmap_local_page().
> 
> This series has a clean up which matches ext2_put_page() with ext2_dotdot() and
> ext2_find_entry().  Those calls use ext2_get_page() to map the page prior to
> returning it to their callers.  And they document that ext2_put_page() should
> be matched up with them.  This was the case but the ext2_put_page() calls were
> hidden in other functions.  We lift the ext2_put_page() calls to match up to
> the functions where ext2_dotdot() and ext2_find_entry() are called.
> 
> After that clean up convert ext2_[get|put]_page() to kmap and adjust for
> kunmap_local() requiring the page address.
> 
> Nesting of kmap_local_page() calls is maintained with minor changes.

Pulled into my tree. Thanks!

								Honza

> 
> Ira Weiny (2):
>   ext2: Match up ext2_put_page() with ext2_dotdot() and
>     ext2_find_entry()
>   fs/ext2: Replace kmap() with kmap_local_page()
> 
>  fs/ext2/dir.c   | 94 +++++++++++++++++++++++++++++++------------------
>  fs/ext2/ext2.h  | 12 ++++---
>  fs/ext2/namei.c | 34 +++++++++++-------
>  3 files changed, 89 insertions(+), 51 deletions(-)
> 
> -- 
> 2.28.0.rc0.12.gb6a658bd00c9
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
