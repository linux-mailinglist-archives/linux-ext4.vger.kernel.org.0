Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0438C47FE29
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Dec 2021 16:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237223AbhL0PQm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Dec 2021 10:16:42 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34573 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237305AbhL0PQm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 Dec 2021 10:16:42 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1BRFGQXl017520
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 10:16:26 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id DFC3215C33A3; Mon, 27 Dec 2021 10:16:25 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Zhang Yi <yi.zhang@huawei.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, jack@suse.cz,
        adilger.kernel@dilger.ca, yukuai3@huawei.com
Subject: Re: [PATCH] ext4: fix an use-after-free issue about data=journal writeback mode
Date:   Mon, 27 Dec 2021 10:16:24 -0500
Message-Id: <164061813992.3186289.16531799470914194648.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211225090937.712867-1-yi.zhang@huawei.com>
References: <20211225090937.712867-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, 25 Dec 2021 17:09:37 +0800, Zhang Yi wrote:
> Our syzkaller report an use-after-free issue that accessing the freed
> buffer_head on the writeback page in __ext4_journalled_writepage(). The
> problem is that if there was a truncate racing with the data=journalled
> writeback procedure, the writeback length could become zero and
> bget_one() refuse to get buffer_head's refcount, then the truncate
> procedure release buffer once we drop page lock, finally, the last
> ext4_walk_page_buffers() trigger the use-after-free problem.
> 
> [...]

Nice catch.   Applied, thanks!

[1/1] ext4: fix an use-after-free issue about data=journal writeback mode
      commit: 856dd2096e2a01f6eb2c9d60f6e0cd587aa273a8

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
