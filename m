Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C92B3CB113
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Jul 2021 05:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbhGPDWC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Jul 2021 23:22:02 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36482 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233774AbhGPDWB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Jul 2021 23:22:01 -0400
Received: from callcc.thunk.org (96-65-121-81-static.hfc.comcastbusiness.net [96.65.121.81])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 16G3ILwr018133
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jul 2021 23:18:22 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 325534202F5; Thu, 15 Jul 2021 23:18:21 -0400 (EDT)
Date:   Thu, 15 Jul 2021 23:18:21 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     wuguanghao <wuguanghao3@huawei.com>
Cc:     linux-ext4@vger.kernel.org, artem.blagodarenko@gmail.com,
        liuzhiqiang26@huawei.com, linfeilong@huawei.com
Subject: Re: [PATCH v2 01/12] profile_create_node: set magic before
 strdup(name) to avoid memory leak
Message-ID: <YPD6fSsffOYs6cEc@mit.edu>
References: <20210630082724.50838-2-wuguanghao3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630082724.50838-2-wuguanghao3@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 30, 2021 at 04:27:13PM +0800, wuguanghao wrote:
> If new->magic != PROF_MAGIC_NODE, profile_free_node() don't free node.
> This will cause the node to be unable to be released correctly and
> a memory leak will occur.
> 
> Signed-off-by: Wu Guanghao <wuguanghao3@huawei.com>
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> Reviewed-by: Wu Bo <wubo40@huawei.com>

Applied, thanks.

					- Ted
