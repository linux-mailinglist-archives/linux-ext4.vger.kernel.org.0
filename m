Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029BE3DE43B
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Aug 2021 04:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbhHCCCN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 2 Aug 2021 22:02:13 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43581 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233200AbhHCCCM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 2 Aug 2021 22:02:12 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17321s4l010310
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 2 Aug 2021 22:01:55 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C55E615C3DD2; Mon,  2 Aug 2021 22:01:54 -0400 (EDT)
Date:   Mon, 2 Aug 2021 22:01:54 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     wuguanghao <wuguanghao3@huawei.com>
Cc:     linux-ext4@vger.kernel.org, linfeilong@huawei.com,
        liuzhiqiang26@huawei.com
Subject: Re: [PATCH v3 05/12] ss_create_invocation: fix memory leak and check
 whether NULL pointer
Message-ID: <YQijktibAO1ESZ/G@mit.edu>
References: <20210728015648.284588-1-wuguanghao3@huawei.com>
 <20210728015648.284588-3-wuguanghao3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728015648.284588-3-wuguanghao3@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jul 28, 2021 at 09:56:46AM +0800, wuguanghao wrote:
> From: Wu Guanghao <wuguanghao3@huawei.com>
> 
> In ss_create_invocation(), it is necessary to check whether
> returned by malloc is a null pointer.
> 
> Signed-off-by: Wu Guanghao <wuguanghao3@huawei.com>
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>

Thanks, applied.

					- Ted
