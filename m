Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818C6425817
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Oct 2021 18:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242707AbhJGQjl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Oct 2021 12:39:41 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34234 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233594AbhJGQjk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Oct 2021 12:39:40 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 197GbWHm021228
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Oct 2021 12:37:33 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CE4DE15C3E70; Thu,  7 Oct 2021 12:37:32 -0400 (EDT)
Date:   Thu, 7 Oct 2021 12:37:32 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        yukuai3@huawei.com
Subject: Re: [RFC PATCH 2/3] ext4: check for inconsistent extents between
 index and leaf block
Message-ID: <YV8iTPcMBUQN80Ob@mit.edu>
References: <20210908120850.4012324-1-yi.zhang@huawei.com>
 <20210908120850.4012324-3-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908120850.4012324-3-yi.zhang@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Sep 08, 2021 at 08:08:49PM +0800, Zhang Yi wrote:
> Now that we can check out overlapping extents in leaf block and
> out-of-order index extents in index block. But the .ee_block in the
> first extent of one leaf block should equal to the .ei_block in it's
> parent index extent entry.

I don't believe this is always guaranteed.

The punch hole operation can remove some or part of the first entry in
the leaf block, and it won't update the parent index.  So it's OK for
the first entry of the leaf block to be greater than entry in the
parent block.  However, if the first entry of the leaf block is less
than the entry in the parent block, that's definitely going to be a
problem.

						- Ted
