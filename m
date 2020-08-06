Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B7923D5FC
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Aug 2020 06:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgHFEQ4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Aug 2020 00:16:56 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41493 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725355AbgHFEQ4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Aug 2020 00:16:56 -0400
Received: from callcc.thunk.org (pool-96-230-252-158.bstnma.fios.verizon.net [96.230.252.158])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0764GFm7013867
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Aug 2020 00:16:16 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id EF0BB420263; Thu,  6 Aug 2020 00:16:14 -0400 (EDT)
Date:   Thu, 6 Aug 2020 00:16:14 -0400
From:   tytso@mit.edu
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     <linux-ext4@vger.kernel.org>, <jack@suse.cz>,
        <jiufei.xue@linux.alibaba.com>
Subject: Re: [PATCH] jbd2: add the missing unlock_buffer() in the error path
 of jbd2_write_superblock()
Message-ID: <20200806041614.GB7657@mit.edu>
References: <20200620061948.2049579-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200620061948.2049579-1-yi.zhang@huawei.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Jun 20, 2020 at 02:19:48PM +0800, zhangyi (F) wrote:
> jbd2_write_superblock() is under the buffer lock of journal superblock
> before ending that superblock write, so add a missing unlock_buffer() in
> in the error path before submitting buffer.
> 
> Fixes: 742b06b5628f ("jbd2: check superblock mapped prior to committing")
> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
> Cc: stable@kernel.org

Thanks, applied.

						- Ted
