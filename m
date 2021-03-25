Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80813494B3
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Mar 2021 15:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhCYOzW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 25 Mar 2021 10:55:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:57818 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231384AbhCYOy7 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 25 Mar 2021 10:54:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3E495AA55;
        Thu, 25 Mar 2021 14:54:58 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 02C6E1E4415; Thu, 25 Mar 2021 15:54:57 +0100 (CET)
Date:   Thu, 25 Mar 2021 15:54:57 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: ext2_set_link()->ext2_put_page() question
Message-ID: <20210325145457.GE13673@quack2.suse.cz>
References: <20210323004948.GR3014244@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323004948.GR3014244@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 22-03-21 17:49:48, Ira Weiny wrote:
> Jan,
> 
> Why does ext2_set_link() need to call ext2_put_page()?
> 
> I don't see any reason that we could not match up the ext2_put_page() calls
> with the ext2_find_entry().
> 
> Similarly am I missing something by moving the ext2_put_page() out of
> ext2_delete_entry()?
> 
> See below patch.

I agree that your patch improves readability. But please fixup comments
about releasing a page as well. Thanks!

> I'm in the process of changing the kmap() calls in ext2_[get|put]_page() into
> kmap_local_page() and I noticed this imbalance.  It does not really save me
> anything because I need to pass the kaddr into these calls but IMO it makes the
> code a bit easier to follow.
> 
> If you agree I will get a patch together to submit with the kmap_local_page()
> patch.

OK :).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
