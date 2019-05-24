Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A67F929328
	for <lists+linux-ext4@lfdr.de>; Fri, 24 May 2019 10:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389509AbfEXIdC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 24 May 2019 04:33:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:45802 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389327AbfEXIdC (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 24 May 2019 04:33:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 81957AEEA;
        Fri, 24 May 2019 08:33:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F30FF1E1402; Fri, 24 May 2019 10:33:00 +0200 (CEST)
Date:   Fri, 24 May 2019 10:33:00 +0200
From:   Jan Kara <jack@suse.cz>
To:     "cgxu519@zoho.com.cn" <cgxu519@zoho.com.cn>
Cc:     Jan Kara <jack@suse.cz>, jack@suse.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext2: strengthen value length check in ext2_xattr_set()
Message-ID: <20190524083300.GC28972@quack2.suse.cz>
References: <20190522082846.22296-1-cgxu519@zoho.com.cn>
 <20190522095057.GH17019@quack2.suse.cz>
 <02e827aededb5b925ec74d1e38d6dfd71f165203.camel@zoho.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02e827aededb5b925ec74d1e38d6dfd71f165203.camel@zoho.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 24-05-19 14:11:34, cgxu519@zoho.com.cn wrote:
> On Wed, 2019-05-22 at 11:50 +0200, Jan Kara wrote:
> > On Wed 22-05-19 16:28:46, Chengguang Xu wrote:
> > > Actually maximum length of a valid entry value is not
> > > ->s_blocksize because header, last entry and entry
> > > name will also occupy some spaces. This patch
> > > strengthens the value length check and return -ERANGE
> > > when the length is larger than allowed maximum length.
> > > 
> > > Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>
> > 
> > Thanks for the patch! But what's the point of this change? We would return
> > ERANGE instead of ENOSPC? I don't think that's serious enough to warrant
> > changing existing behavior...
> 
> Hi Jan,
> 
> Instead of adding the check here, I propose to change value
> size limit check in ext2_xattr_entry_valid().
> 
> size = le32_to_cpu(entry->e_value_size);
> if (size > end_offs ||
>     le16_to_cpu(entry->e_value_offs) + size > end_offs)
> 
> Change to
> 
> size = EXT2_XATTR_SIZE(le32_to_cpu(entry->e_value_size));
> if (size >= end_offs - sizeof(struct ext2_xattr_header) - sizeof(__u32) ||
>     le16_to_cpu(entry->e_value_offs) + size > end_offs)

I don't think this makes a big difference. Look: end_offs is always aligned to
EXT2_XATTR_PAD (it is always block size) so if entry->e_value_offs is
properly aligned (which we may want to check), then
le16_to_cpu(entry->e_value_offs) + EXT2_XATTR_SIZE(size) > end_offs if and
only if le16_to_cpu(entry->e_value_offs) + size > end_offs.

Also the check le16_to_cpu(entry->e_value_offs) + size > end_offs is the
essential and strongest part - it checks whether the value does not extend
beyond block. The check size > end_offs is needed only for the case where
le16_to_cpu(entry->e_value_offs) + size would overflow and result in a
negative number.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
