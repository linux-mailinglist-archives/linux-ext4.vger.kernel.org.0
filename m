Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F45B3CB12D
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Jul 2021 05:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbhGPDol (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Jul 2021 23:44:41 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38389 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231230AbhGPDok (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Jul 2021 23:44:40 -0400
Received: from callcc.thunk.org (96-65-121-81-static.hfc.comcastbusiness.net [96.65.121.81])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 16G3fbgb024271
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jul 2021 23:41:38 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 88AD54202F5; Thu, 15 Jul 2021 23:41:37 -0400 (EDT)
Date:   Thu, 15 Jul 2021 23:41:37 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     wuguanghao <wuguanghao3@huawei.com>
Cc:     linux-ext4@vger.kernel.org, artem.blagodarenko@gmail.com,
        liuzhiqiang26@huawei.com, linfeilong@huawei.com
Subject: Re: [PATCH v2 07/12] argv_parse: check return value of malloc in
 argv_parse()
Message-ID: <YPD/8TWws4aBpvNP@mit.edu>
References: <20210630082724.50838-2-wuguanghao3@huawei.com>
 <20210630082724.50838-8-wuguanghao3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630082724.50838-8-wuguanghao3@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 30, 2021 at 04:27:19PM +0800, wuguanghao wrote:
> From: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> 
> In argv_parse(), return value of malloc should be checked
> whether it is NULL, otherwise, it may cause a segfault error.

Thanks, applied.

					- Ted
