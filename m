Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D7B288020
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Oct 2020 03:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbgJIB5g (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Oct 2020 21:57:36 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41451 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729285AbgJIB5f (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Oct 2020 21:57:35 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0991vJta029091
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Oct 2020 21:57:19 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id DC942420107; Thu,  8 Oct 2020 21:57:18 -0400 (EDT)
Date:   Thu, 8 Oct 2020 21:57:18 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.com, adilger.kernel@dilger.ca
Subject: Re: [PATCH v2 6/7] ext4: use ext4_sb_bread() instead of sb_bread()
Message-ID: <20201009015718.GF816148@mit.edu>
References: <20200924073337.861472-1-yi.zhang@huawei.com>
 <20200924073337.861472-7-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924073337.861472-7-yi.zhang@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Sep 24, 2020 at 03:33:36PM +0800, zhangyi (F) wrote:
> We have already remove open codes that invoke helpers provide by
> fs/buffer.c in all places reading metadata buffers. This patch switch to
> use ext4_sb_bread() to replace all sb_bread() helpers, which is
> ext4_read_bh() helper back end.
> 
> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>

Thanks, applied.

					- Ted
