Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F5728801F
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Oct 2020 03:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730772AbgJIB4N (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Oct 2020 21:56:13 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41233 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730755AbgJIB4N (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Oct 2020 21:56:13 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0991td4I028620
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Oct 2020 21:55:40 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 43E0D420107; Thu,  8 Oct 2020 21:55:39 -0400 (EDT)
Date:   Thu, 8 Oct 2020 21:55:39 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.com, adilger.kernel@dilger.ca
Subject: Re: [PATCH v2 5/7] ext4: introduce ext4_sb_breadahead_unmovable() to
 replace sb_breadahead_unmovable()
Message-ID: <20201009015539.GE816148@mit.edu>
References: <20200924073337.861472-1-yi.zhang@huawei.com>
 <20200924073337.861472-6-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924073337.861472-6-yi.zhang@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Sep 24, 2020 at 03:33:35PM +0800, zhangyi (F) wrote:
> If we readahead inode tables in __ext4_get_inode_loc(), it may bypass
> buffer_write_io_error() check, so introduce ext4_sb_breadahead_unmovable()
> to handle this special case.
> 
> This patch also replace sb_breadahead_unmovable() in ext4_fill_super()
> for the sake of unification.
> 
> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>

Thanks, applied.

					- Ted
