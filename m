Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFEDE1E5554
	for <lists+linux-ext4@lfdr.de>; Thu, 28 May 2020 07:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbgE1FID (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 May 2020 01:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgE1FID (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 May 2020 01:08:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D846C05BD1E
        for <linux-ext4@vger.kernel.org>; Wed, 27 May 2020 22:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V5QLD4zdKSEJpoLAnwfDxhnTh96d8tXkpbttgyQipG4=; b=NLed3qe3gKTnGzF+1AefCZElU9
        43yUIIB/MJtfVlkN7YHRA8esqVF66t3uDX55K9k2uTpGOsxcPph6JmzE/f+4+A/jwpgqH8FrubYKn
        j7aks8ZCRBWYv0vcB1MqPzqZLU/2pb+uau8Fndi5W6n4nowyxzhQrI2jrdAF/5knXR172Xb9IrV/A
        ZPzciU0nicDJua4XPc99SnvmHPkmc3d6aex9+1Y4TFsTPyjANXasjucrTn8oEwNQKfF1P0uo8GUTv
        sXZ2aUkJGyESmJ1KyybGYPf335qI1SDJh66uGhbvT0z5JT/CgJnVfpjXU4+Ycqb3ilBcC2M6t4kTR
        KUS3iw0g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeAlp-0006aP-6Y; Thu, 28 May 2020 05:07:57 +0000
Date:   Wed, 27 May 2020 22:07:57 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz,
        adilger.kernel@dilger.ca, zhangxiaoxu5@huawei.com
Subject: Re: [PATCH 02/10] fs: pick out ll_rw_one_block() helper function
Message-ID: <20200528050757.GA14198@infradead.org>
References: <20200526071754.33819-1-yi.zhang@huawei.com>
 <20200526071754.33819-3-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526071754.33819-3-yi.zhang@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, May 26, 2020 at 03:17:46PM +0800, zhangyi (F) wrote:
> Pick out ll_rw_one_block() helper function from ll_rw_block() for
> submitting one locked buffer for reading/writing.

That should probably read factor out instead of pick out.

> 
> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
> ---
>  fs/buffer.c                 | 41 ++++++++++++++++++++++---------------
>  include/linux/buffer_head.h |  1 +
>  2 files changed, 26 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index a60f60396cfa..3a2226f88b2d 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -3081,6 +3081,29 @@ int submit_bh(int op, int op_flags, struct buffer_head *bh)
>  }
>  EXPORT_SYMBOL(submit_bh);
>  
> +void ll_rw_one_block(int op, int op_flags, struct buffer_head *bh)
> +{
> +	BUG_ON(!buffer_locked(bh));
> +
> +	if (op == WRITE) {
> +		if (test_clear_buffer_dirty(bh)) {
> +			bh->b_end_io = end_buffer_write_sync;
> +			get_bh(bh);
> +			submit_bh(op, op_flags, bh);
> +			return;
> +		}
> +	} else {
> +		if (!buffer_uptodate(bh)) {
> +			bh->b_end_io = end_buffer_read_sync;
> +			get_bh(bh);
> +			submit_bh(op, op_flags, bh);
> +			return;
> +		}
> +	}
> +	unlock_buffer(bh);
> +}
> +EXPORT_SYMBOL(ll_rw_one_block);

I don't think you want separate read and write sides.  In fact I'm not
sure you want the helper at all.  At this point just open coding it
rather than adding more overhead to core code might be a better idea.
