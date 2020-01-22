Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 653D41450C5
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jan 2020 10:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731616AbgAVJs3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Jan 2020 04:48:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:41674 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729143AbgAVJs2 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 22 Jan 2020 04:48:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7E979AAFD;
        Wed, 22 Jan 2020 09:48:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6F8531E0A4F; Wed, 22 Jan 2020 10:48:26 +0100 (CET)
Date:   Wed, 22 Jan 2020 10:48:26 +0100
From:   Jan Kara <jack@suse.cz>
To:     wangyan <wangyan122@huawei.com>
Cc:     tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] jbd2: delete the duplicated words in the comments
Message-ID: <20200122094826.GD12845@quack2.suse.cz>
References: <12087f77-ab4d-c7ba-53b4-893dbf0026f0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12087f77-ab4d-c7ba-53b4-893dbf0026f0@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 22-01-20 17:33:10, wangyan wrote:
> Delete the duplicated words "is" in the comments
> 
> Signed-off-by: Yan Wang <wangyan122@huawei.com>

Looks good. Thanks. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>
	
								Honza

> ---
>  fs/jbd2/transaction.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index 27b9f9dee434..5c3abbaccb57 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -525,7 +525,7 @@ EXPORT_SYMBOL(jbd2__journal_start);
>   * modified buffers in the log.  We block until the log can guarantee
>   * that much space. Additionally, if rsv_blocks > 0, we also create another
>   * handle with rsv_blocks reserved blocks in the journal. This handle is
> - * is stored in h_rsv_handle. It is not attached to any particular transaction
> + * stored in h_rsv_handle. It is not attached to any particular transaction
>   * and thus doesn't block transaction commit. If the caller uses this reserved
>   * handle, it has to set h_rsv_handle to NULL as otherwise jbd2_journal_stop()
>   * on the parent handle will dispose the reserved one. Reserved handle has to
> -- 
> 2.19.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
