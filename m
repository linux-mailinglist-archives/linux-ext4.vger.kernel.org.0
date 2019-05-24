Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8F662926E
	for <lists+linux-ext4@lfdr.de>; Fri, 24 May 2019 10:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389046AbfEXIHm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 24 May 2019 04:07:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:41858 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389112AbfEXIHl (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 24 May 2019 04:07:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 98697AE8A;
        Fri, 24 May 2019 08:07:40 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3FC521E1402; Fri, 24 May 2019 10:07:40 +0200 (CEST)
Date:   Fri, 24 May 2019 10:07:40 +0200
From:   Jan Kara <jack@suse.cz>
To:     "cgxu519@zoho.com.cn" <cgxu519@zoho.com.cn>
Cc:     Jan Kara <jack@suse.cz>, jack@suse.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext2: optimize ext2_xattr_get()
Message-ID: <20190524080740.GA28972@quack2.suse.cz>
References: <20190521082140.19992-1-cgxu519@zoho.com.cn>
 <20190523144612.GA18841@quack2.suse.cz>
 <afa54281eaf134b892d5f93d281d7ddf75bfe3a5.camel@zoho.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afa54281eaf134b892d5f93d281d7ddf75bfe3a5.camel@zoho.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 24-05-19 10:07:05, cgxu519@zoho.com.cn wrote:
> On Thu, 2019-05-23 at 16:46 +0200, Jan Kara wrote:
> > On Tue 21-05-19 16:21:39, Chengguang Xu wrote:
> > > Since xattr entry names are sorted, we don't have
> > > to continue when current entry name is greater than
> > > target.
> > > 
> > > Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>
> > 
> > Thanks for the patch! If we are going to do these comparisons in multiple
> > places, then please create a helper function to do the comparison (so that
> > we have the same comparison in every place). Something like:
> > 
> > int ext2_xattr_cmp(int name_index, size_t name_len, const char *name,
> > 		   struct ext2_xattr_entry *entry)
> > 
> 
> Hi Jan,
> 
> Thanks for the review and advice. 
> 
> You are right we should introduce a helper to handle this part of work
> and personally I think maybe implementing a helper to find target entry
> will be more useful, do you think it makes sense?

It makes sense but ext2_xattr_set() also computes min_offs and last during
the search so using the search function in that case won't be a readbility
win I guess. So I'm not sure the search function pays off in the end.

								Honza

> 
> 
> Thanks,
> Chengguang
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
