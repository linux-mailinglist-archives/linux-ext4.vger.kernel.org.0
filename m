Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540DF3FC124
	for <lists+linux-ext4@lfdr.de>; Tue, 31 Aug 2021 05:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239476AbhHaDFV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Aug 2021 23:05:21 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52517 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S239460AbhHaDFV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 30 Aug 2021 23:05:21 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17V34GBR029510
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Aug 2021 23:04:16 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id DACC015C3E7E; Mon, 30 Aug 2021 23:04:15 -0400 (EDT)
Date:   Mon, 30 Aug 2021 23:04:15 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        yukuai3@huawei.com
Subject: Re: [PATCH v4 1/6] ext4: move inode eio simulation behind io
 completeion
Message-ID: <YS2cL2p0P1Jz5BcX@mit.edu>
References: <20210826130412.3921207-1-yi.zhang@huawei.com>
 <20210826130412.3921207-2-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826130412.3921207-2-yi.zhang@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Aug 26, 2021 at 09:04:07PM +0800, Zhang Yi wrote:
> No EIO simulation is required if the buffer is uptodate, so move the
> simulation behind read bio completeion just like inode/block bitmap
> simulation does.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks, applied.

					- Ted
