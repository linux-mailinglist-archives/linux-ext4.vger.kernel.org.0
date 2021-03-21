Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E453430CD
	for <lists+linux-ext4@lfdr.de>; Sun, 21 Mar 2021 05:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhCUEAK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 21 Mar 2021 00:00:10 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34366 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229840AbhCUEAF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 21 Mar 2021 00:00:05 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 12L3xh4l022579
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 20 Mar 2021 23:59:44 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4975815C39CA; Sat, 20 Mar 2021 23:59:43 -0400 (EDT)
Date:   Sat, 20 Mar 2021 23:59:43 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz, yangerkun@huawei.com
Subject: Re: [PATCH v1 1/2] ext4: find old entry again if failed to rename
 whiteout
Message-ID: <YFbErxtWpQJ7eTbQ@mit.edu>
References: <20210303131703.330415-1-yi.zhang@huawei.com>
 <YEo6k8kg3zF7avId@mit.edu>
 <a81cf4d6-a934-9031-7e9d-f5a91647d210@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a81cf4d6-a934-9031-7e9d-f5a91647d210@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Mar 12, 2021 at 10:01:50AM +0800, zhangyi (F) wrote:
> 
> In this error path of whiteout rename, we want to restore the old inode
> number and old name back to the old entry, it's just a rollback operation.
> The old entry will stay where it was in common cases, but it can be moved
> from the first block to the leaf block during make indexed dir for one
> special case, but it cannot be deleted in theory. So if we cannot find it
> again, there must some bad thing happen and the filesystem may probably
> inconsistency. So I calling ext4_std_error() here，or am I missing something？

After looking at this more closely, I agree, this should be OK.  The
directory is going to be locked, so it shouldn't be changing out from
under us.

Thanks, applied.

					- Ted
