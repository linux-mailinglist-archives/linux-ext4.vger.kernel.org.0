Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F473CB13F
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Jul 2021 05:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbhGPD6N (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Jul 2021 23:58:13 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39530 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231139AbhGPD6N (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Jul 2021 23:58:13 -0400
Received: from callcc.thunk.org (96-65-121-81-static.hfc.comcastbusiness.net [96.65.121.81])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 16G3t82r027878
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jul 2021 23:55:09 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id EBC474202F5; Thu, 15 Jul 2021 23:55:07 -0400 (EDT)
Date:   Thu, 15 Jul 2021 23:55:07 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     wuguanghao <wuguanghao3@huawei.com>
Cc:     linux-ext4@vger.kernel.org, artem.blagodarenko@gmail.com,
        liuzhiqiang26@huawei.com, linfeilong@huawei.com
Subject: Re: [PATCH v2 10/12] hashmap: change return value type of
 ext2fs_hashmap_add()
Message-ID: <YPEDG6sEoq5d4tsv@mit.edu>
References: <20210630082724.50838-2-wuguanghao3@huawei.com>
 <20210630082724.50838-11-wuguanghao3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630082724.50838-11-wuguanghao3@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 30, 2021 at 04:27:22PM +0800, wuguanghao wrote:
> From: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> 
> In ext2fs_hashmap_add(), new entry is allocated by calling
> malloc(). If malloc() return NULL, it will cause a
> segmentation fault problem.
> 
> Here, we change return value type of ext2fs_hashmap_add()
> from void to int. If allocating new entry fails, we will
> return 1, and the callers should also verify the return
> value of ext2fs_hashmap_add().

Changing the function signature of functions in libext2fs, which can
be a shared library, is problematic, since it can potentially break
callers who are depending on the existing shared library ABI.

In this case, making a function returning void return something else
isn't quite so bad, but it still puts callers in a quandry, since they
won't necessarily know if they have linked against an older library
which is not returning an error (or not).

Unfortunately, there's no other way to fix this, and creating a new
ext2fs_hashmap_add2() just to add a return code seems like overkill.
Grumble.

I guess it's OK to do it, since there _probably_ aren't users of
ext2fs_hashmap_add outside of e2fsprogs.  But if we are going to make
this change, we should really have ext2fs_hashmap_add return a
errcode_t, like the other libext2fs functions.

						- Ted
