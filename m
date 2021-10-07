Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC48425842
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Oct 2021 18:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbhJGQrO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Oct 2021 12:47:14 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35543 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233522AbhJGQrN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Oct 2021 12:47:13 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 197GjAO6024400
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Oct 2021 12:45:10 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E638915C3E70; Thu,  7 Oct 2021 12:45:09 -0400 (EDT)
Date:   Thu, 7 Oct 2021 12:45:09 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        yukuai3@huawei.com
Subject: Re: [RFC PATCH 3/3] ext4: prevent partial update of the extent blocks
Message-ID: <YV8kFRAlPWIxBK+1@mit.edu>
References: <20210908120850.4012324-1-yi.zhang@huawei.com>
 <20210908120850.4012324-4-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908120850.4012324-4-yi.zhang@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Sep 08, 2021 at 08:08:50PM +0800, Zhang Yi wrote:
> In the most error path of current extents updating operations are not
> roll back partial updates properly when some bad things happens(.e.g in
> ext4_ext_insert_extent()). So we may get an inconsistent extents tree
> if journal has been aborted due to IO error, which may probability lead
> to BUGON later when we accessing these extent entries in errors=continue
> mode. This patch drop extent buffer's verify flag before updatng the
> contents in ext4_ext_get_access(), and reset it after updating in
> __ext4_ext_dirty(). After this patch we could force to check the extent
> buffer if extents tree updating was break off, make sure the extents are
> consistent.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good, thanks

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

						- Ted
