Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED9373DE434
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Aug 2021 04:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbhHCCAc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 2 Aug 2021 22:00:32 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43124 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233449AbhHCCAb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 2 Aug 2021 22:00:31 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17320B1t009314
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 2 Aug 2021 22:00:11 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id EA01C15C3DD2; Mon,  2 Aug 2021 22:00:10 -0400 (EDT)
Date:   Mon, 2 Aug 2021 22:00:10 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     wuguanghao <wuguanghao3@huawei.com>
Cc:     linux-ext4@vger.kernel.org, linfeilong@huawei.com,
        liuzhiqiang26@huawei.com
Subject: Re: [PATCH v3 04/12] ss_add_info_dir: don't zap the info->info_dirs
 and check whether
Message-ID: <YQijKmP2T/XJzC0m@mit.edu>
References: <20210728015648.284588-1-wuguanghao3@huawei.com>
 <20210728015648.284588-2-wuguanghao3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728015648.284588-2-wuguanghao3@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jul 28, 2021 at 09:56:45AM +0800, wuguanghao wrote:
> From: Wu Guanghao <wuguanghao3@huawei.com>
> 
> In ss_add_info_dir(), don't zap the info->info_dirs. At the same time, it is necessary
> to check whether dirs[n_dirs] is a null pointer, otherwise a segmentation
> fault will occur.
> 
> Signed-off-by: Wu Guanghao <wuguanghao3@huawei.com>
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> Reviewed-by: Wu Bo <wubo40@huawei.com>

Thanks, applied.

					- Ted
