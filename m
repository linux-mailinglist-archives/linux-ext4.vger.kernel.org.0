Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2173430D1
	for <lists+linux-ext4@lfdr.de>; Sun, 21 Mar 2021 05:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhCUEKj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 21 Mar 2021 00:10:39 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36353 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229787AbhCUEKF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 21 Mar 2021 00:10:05 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 12L49qIs026864
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 Mar 2021 00:09:52 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D501315C39CA; Sun, 21 Mar 2021 00:09:51 -0400 (EDT)
Date:   Sun, 21 Mar 2021 00:09:51 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz, yangerkun@huawei.com
Subject: Re: [PATCH v1 2/2] ext4: Do not iput inode under running transaction
 in ext4_rename()
Message-ID: <YFbHD+jwinE0D35w@mit.edu>
References: <20210303131703.330415-1-yi.zhang@huawei.com>
 <20210303131703.330415-2-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303131703.330415-2-yi.zhang@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Mar 03, 2021 at 09:17:03PM +0800, zhangyi (F) wrote:
> In ext4_rename(), when RENAME_WHITEOUT failed to add new entry into
> directory, it ends up dropping new created whiteout inode under the
> running transaction. After commit <9b88f9fb0d2> ("ext4: Do not iput inode
> under running transaction"), we follow the assumptions that evict() does
> not get called from a transaction context but in ext4_rename() it breaks
> this suggestion. Although it's not a real problem, better to obey it, so
> this patch add inode to orphan list and stop transaction before final
> iput().
> 
> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>

Thanks, applied.

					- Ted
