Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60C23FC125
	for <lists+linux-ext4@lfdr.de>; Tue, 31 Aug 2021 05:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239455AbhHaDFd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Aug 2021 23:05:33 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52541 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235848AbhHaDFd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 30 Aug 2021 23:05:33 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17V34SgE029546
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Aug 2021 23:04:28 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4A83215C3E7E; Mon, 30 Aug 2021 23:04:28 -0400 (EDT)
Date:   Mon, 30 Aug 2021 23:04:28 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        yukuai3@huawei.com
Subject: Re: [PATCH v4 2/6] ext4: remove an unnecessary if statement in
 __ext4_get_inode_loc()
Message-ID: <YS2cPL8px2WPFQbS@mit.edu>
References: <20210826130412.3921207-1-yi.zhang@huawei.com>
 <20210826130412.3921207-3-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826130412.3921207-3-yi.zhang@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Aug 26, 2021 at 09:04:08PM +0800, Zhang Yi wrote:
> The "if (!buffer_uptodate(bh))" hunk covered almost the whole code after
> getting buffer in __ext4_get_inode_loc() which seems unnecessary, remove
> it and switch to check ext4_buffer_uptodate(), it simplify code and make
> it more readable.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks, applied.

					- Ted
