Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA7F539549F
	for <lists+linux-ext4@lfdr.de>; Mon, 31 May 2021 06:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhEaEak (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 31 May 2021 00:30:40 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43212 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229687AbhEaEai (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 31 May 2021 00:30:38 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 14V4Skwq011135
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 May 2021 00:28:47 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6E29815C3734; Mon, 31 May 2021 00:28:46 -0400 (EDT)
Date:   Mon, 31 May 2021 00:28:46 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Wu Guanghao <wuguanghao3@huawei.com>
Cc:     linux-ext4@vger.kernel.org,
        =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>, liuzhiqiang26@huawei.com,
        linfeilong@huawei.com
Subject: Re: [PATCH V2 00/12] e2fsprogs: some bugfixs and some code cleanups
Message-ID: <YLRl/tFB4rakYJ7q@mit.edu>
References: <00ad4a90-8a40-24c1-98d9-eb5f0da42436@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00ad4a90-8a40-24c1-98d9-eb5f0da42436@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, May 31, 2021 at 09:23:49AM +0800, Wu Guanghao wrote:
> V1 -> V2:
> 
> [PATCH V2 03/12] zap_sector: fix memory leak
> 	free and return operators placed in {} block
> 
> [PATCH V2 04/12] ss_add_info_dir: fix memory leak and check whether,NULL pointer
> 	modified "=" to "=="
> 
> [PATCH V2 06/12] append_pathname: check the value returned by realloc to avoid segfault
> [PATCH V2 07/12] argv_parse: check return value of malloc in argv_parse()
> 	Fix typos
> 
> [PATCH V2 10/12] hashmap: change return value type of, ext2fs_hashmap_add()
> 	remove "new_block = NULL;"

Did you only send the patches that you changed, and didn't resend the
patches that didn't change between V1 and V2?

It's actually better if you resend the whole series in the future.

Thanks,

					- Ted
