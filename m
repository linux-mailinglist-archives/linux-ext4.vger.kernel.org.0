Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 509F9B5193
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 17:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbfIQPb7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Sep 2019 11:31:59 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60656 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726882AbfIQPb7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Sep 2019 11:31:59 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x8HFVeKC021438
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Sep 2019 11:31:41 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 20F03420811; Tue, 17 Sep 2019 11:31:40 -0400 (EDT)
Date:   Tue, 17 Sep 2019 11:31:40 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     yangerkun <yangerkun@huawei.com>
Cc:     jack@suse.cz, linux-ext4@vger.kernel.org, yi.zhang@huawei.com,
        houtao1@huawei.com
Subject: Re: [PATCH] ext4: fix a bug in ext4_wait_for_tail_page_commit
Message-ID: <20190917153140.GF6762@mit.edu>
References: <20190917084814.40370-1-yangerkun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917084814.40370-1-yangerkun@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Sep 17, 2019 at 04:48:14PM +0800, yangerkun wrote:
> No need to wait when offset equals to 0. And it will trigger a bug since
> the latter __ext4_journalled_invalidatepage can free the buffers but leave
> page still dirty.

That's only true if the block size == the page size, no?  If the
offset is zero and the block size is 1k, we still need to wait.
Shouldn't the better fix be:

> -	if (offset > PAGE_SIZE - i_blocksize(inode))
> +	if (offset >= PAGE_SIZE - i_blocksize(inode))

  	   	      		- Ted
