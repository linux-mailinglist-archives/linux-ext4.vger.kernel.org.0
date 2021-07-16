Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B063CB126
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Jul 2021 05:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbhGPDid (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Jul 2021 23:38:33 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37887 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231230AbhGPDid (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Jul 2021 23:38:33 -0400
Received: from callcc.thunk.org (96-65-121-81-static.hfc.comcastbusiness.net [96.65.121.81])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 16G3Yvj9022484
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jul 2021 23:34:58 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 72F424202F5; Thu, 15 Jul 2021 23:34:57 -0400 (EDT)
Date:   Thu, 15 Jul 2021 23:34:57 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     wuguanghao <wuguanghao3@huawei.com>
Cc:     linux-ext4@vger.kernel.org, artem.blagodarenko@gmail.com,
        liuzhiqiang26@huawei.com, linfeilong@huawei.com
Subject: Re: [PATCH v2 05/12] ss_create_invocation: fix memory leak and check
 whether NULL pointer
Message-ID: <YPD+YbH7STaKTgxC@mit.edu>
References: <20210630082724.50838-2-wuguanghao3@huawei.com>
 <20210630082724.50838-6-wuguanghao3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630082724.50838-6-wuguanghao3@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 30, 2021 at 04:27:17PM +0800, wuguanghao wrote:
> In ss_create_invocation(), it is necessary to check whether
> returned by malloc is a null pointer.
> 
> Signed-off-by: Wu Guanghao <wuguanghao3@huawei.com>
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> ---
>  lib/ss/invocation.c | 38 ++++++++++++++++++++++++++++++++------
>  1 file changed, 32 insertions(+), 6 deletions(-)
> 

Instead of adding all of these goto targets (which is fragile if for
some reason the code gets rearranged), it would be better to make sure
everything that we might want to free is initialized, i.e.:

  	register ss_data *new_table = NULL;
  	register ss_data **table = NULL;

  	new_table = (ss_data *) malloc(sizeof(ss_data));
	if (!new_table)
		goto out;
	memset(new_table, 0, sizeof(ss_data));

and then exit path can just look like this:

out:
	if (new_table) {
		free(new_table->prompt);
		free(new_table->info_dirs);
	}
	free(new_table);
	free(table);
	*code_ptr = ENOMEM;
	return 0;

... which is much cleaner, and means in the future, you don't need to
figure out which goto label you might need to jump to.

Cheers,

					- Ted

P.S.  And if we are making all of these changes to the function's
initializers, it might be a good time to zap the "register" keywords
for any lines we are changing, or are nearby, while we're at it.
