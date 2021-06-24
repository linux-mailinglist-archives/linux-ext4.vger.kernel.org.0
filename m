Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8943B3155
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Jun 2021 16:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbhFXOcB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Jun 2021 10:32:01 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52462 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231608AbhFXOb6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Jun 2021 10:31:58 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15OETQWD003327
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Jun 2021 10:29:26 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0E9FC15C3CD7; Thu, 24 Jun 2021 10:29:26 -0400 (EDT)
Date:   Thu, 24 Jun 2021 10:29:26 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     yangerkun <yangerkun@huawei.com>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org, yukuai3@huawei.com
Subject: Re: [PATCH] ext4: no need to verify new add extent block
Message-ID: <YNSWxqmiYIYVZpKl@mit.edu>
References: <20210609075545.1442160-1-yangerkun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609075545.1442160-1-yangerkun@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 09, 2021 at 03:55:45PM +0800, yangerkun wrote:
> ext4_ext_grow_indepth will add a new extent block which has init the
> expected content. We can mark this buffer as verified so to stop a
> useless check in __read_extent_tree_block.
> 
> Signed-off-by: yangerkun <yangerkun@huawei.com>

Applied, thanks.

						- Ted
