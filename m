Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F9C288014
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Oct 2020 03:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730649AbgJIBnn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Oct 2020 21:43:43 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39535 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730599AbgJIBnn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Oct 2020 21:43:43 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0991hGJd025112
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Oct 2020 21:43:16 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D9EF1420107; Thu,  8 Oct 2020 21:43:15 -0400 (EDT)
Date:   Thu, 8 Oct 2020 21:43:15 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.com, adilger.kernel@dilger.ca
Subject: Re: [PATCH v2 2/7] ext4: introduce new metadata buffer read helpers
Message-ID: <20201009014315.GB816148@mit.edu>
References: <20200924073337.861472-1-yi.zhang@huawei.com>
 <20200924073337.861472-3-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924073337.861472-3-yi.zhang@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Sep 24, 2020 at 03:33:32PM +0800, zhangyi (F) wrote:
> The previous patch add clear_buffer_verified() before we read metadata
> block from disk again, but it's rather easy to miss clearing of this bit
> because currently we read metadata buffer through different open codes
> (e.g. ll_rw_block(), bh_submit_read() and invoke submit_bh() directly).
> So, it's time to add common helpers to unify in all the places reading
> metadata buffers instead. This patch add 3 helpers:
> 
>  - ext4_read_bh_nowait(): async read metadata buffer if it's actually
>    not uptodate, clear buffer_verified bit before read from disk.
>  - ext4_read_bh(): sync version of read metadata buffer, it will wait
>    until the read operation return and check the return status.
>  - ext4_read_bh_lock(): try to lock the buffer before read buffer, it
>    will skip reading if the buffer is already locked.
> 
> After this patch, we need to use these helpers in all the places reading
> metadata buffer instead of different open codes.
> 
> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
> Suggested-by: Jan Kara <jack@suse.cz>

Thanks, applied.

						- Ted
