Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 827093B85BB
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Jun 2021 17:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbhF3PHT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Jun 2021 11:07:19 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:51154 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235416AbhF3PHT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Jun 2021 11:07:19 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15UF4W1R002144
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Jun 2021 11:04:33 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A39B515C3C8E; Wed, 30 Jun 2021 11:04:32 -0400 (EDT)
Date:   Wed, 30 Jun 2021 11:04:32 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        yukuai3@huawei.com
Subject: Re: [PATCH] jbd2: fix jbd2_journal_[un]register_shrinker undefined
 error
Message-ID: <YNyIAEM2ansIKB4N@mit.edu>
References: <20210630083638.140218-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630083638.140218-1-yi.zhang@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 30, 2021 at 04:36:38PM +0800, Zhang Yi wrote:
> Export jbd2_journal_unregister_shrinker() and
> jbd2_journal_register_shrinker() to fix below error:
> 
>  ERROR: modpost: "jbd2_journal_unregister_shrinker" undefined!
>  ERROR: modpost: "jbd2_journal_register_shrinker" undefined!
> 
> Fixes: 4ba3fcdde7e3 ("jbd2,ext4: add a shrinker to release checkpointed buffers")
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Thanks applied, with a slightly clarified commit message:

commit e102693820c5b5bbd56958c0940e7bc2d2f80a5a
Author: Zhang Yi <yi.zhang@huawei.com>
Date:   Wed Jun 30 16:36:38 2021 +0800

    jbd2: export jbd2_journal_[un]register_shrinker()
    
    Export jbd2_journal_[un]register_shrinker() to fix this error when
    building ext4 as a module:
    
      ERROR: modpost: "jbd2_journal_unregister_shrinker" undefined!
      ERROR: modpost: "jbd2_journal_register_shrinker" undefined!
    
    Fixes: 4ba3fcdde7e3 ("jbd2,ext4: add a shrinker to release checkpointed buffers")
    Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
    Link: https://lore.kernel.org/r/20210630083638.140218-1-yi.zhang@huawei.com
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

						- Ted
							
