Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11FB53ABD56
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jun 2021 22:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbhFQUT1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Jun 2021 16:19:27 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:44757 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232624AbhFQUT1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Jun 2021 16:19:27 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15HKH9MD010261
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Jun 2021 16:17:09 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 494C415C3CBA; Thu, 17 Jun 2021 16:17:09 -0400 (EDT)
Date:   Thu, 17 Jun 2021 16:17:09 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        yukuai3@huawei.com
Subject: Re: [PATCH 2/2] ext4: correct the cache_nr in tracepoint
 ext4_es_shrink_exit
Message-ID: <YMutxd+XRqLnvnrj@mit.edu>
References: <20210522103045.690103-1-yi.zhang@huawei.com>
 <20210522103045.690103-3-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210522103045.690103-3-yi.zhang@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, May 22, 2021 at 06:30:45PM +0800, Zhang Yi wrote:
> The cache_cnt parameter of tracepoint ext4_es_shrink_exit means the
> remaining cache count after shrink, but now it is the cache count before
> shrink, fix it by read sbi->s_extent_cache_cnt again.
> 
> Fixes: 1ab6c4997e04 ("fs: convert fs shrinkers to new scan/count API")
> Cc: stable@vger.kernel.org # 3.12+
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Thanks, applied.

				- Ted
