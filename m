Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1FE435A421
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Apr 2021 18:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbhDIQ4d (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Apr 2021 12:56:33 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56663 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234239AbhDIQ4a (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Apr 2021 12:56:30 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 139GtpX5021793
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Apr 2021 12:55:51 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2EBA415C3B12; Fri,  9 Apr 2021 12:55:51 -0400 (EDT)
Date:   Fri, 9 Apr 2021 12:55:51 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Guo <guoyang2@huawei.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: [PATCH] ext4: Delete redundant uptodate check for buffer
Message-ID: <YHCHF51vxFfujzNE@mit.edu>
References: <1617260610-29770-1-git-send-email-zhangshaokun@hisilicon.com>
 <20210401112001.tjwjfrno4ygwwzh2@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401112001.tjwjfrno4ygwwzh2@riteshh-domain>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Apr 01, 2021 at 04:50:01PM +0530, Ritesh Harjani wrote:
> On 21/04/01 03:03PM, Shaokun Zhang wrote:
> > From: Yang Guo <guoyang2@huawei.com>
> >
> > The buffer uptodate state has been checked in function set_buffer_uptodate,
> > there is no need use buffer_uptodate before calling set_buffer_uptodate and
> > delete it.
> >
> > Cc: "Theodore Ts'o" <tytso@mit.edu>
> > Cc: Andreas Dilger <adilger.kernel@dilger.ca>
> > Signed-off-by: Yang Guo <guoyang2@huawei.com>
> > Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> > ---
> >  fs/ext4/inode.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> Thanks for the patch. Changes looks good and trivial.
> 
> Feel free to add -
> Reviewed-by: Ritesh Harjani <ritesh.list@gmail.com>

Thanks, applied.

					- Ted
