Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A7D5892F3
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Aug 2022 21:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbiHCT61 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Aug 2022 15:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiHCT60 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 Aug 2022 15:58:26 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5150C53D3B
        for <linux-ext4@vger.kernel.org>; Wed,  3 Aug 2022 12:58:25 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-49-209-117.bstnma.fios.verizon.net [108.49.209.117])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 273JwFBO010378
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 3 Aug 2022 15:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1659556700; bh=rroSHse7n38ZjSKXaPze7HTuW3tNwiJi1uDdrufXvb4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=g4d9QaYNejit4N0JCqp4Y0gzqkbQ523kABKJ6NDHVxB7JKa7gra0NHvo4t+GiRC1J
         /1723G1RxHe2jzGWrMYL7J5itQ+38h3KSVwzKwdbtDNBTJ0PASNWq3yTXfQGXDIdIj
         0cb825cPRI9gbMGiSe2x7v1H6vF7CTUkwqfsFLq61+9XrTV8BjpPLj8XSwEU1sL1CG
         YYXSyQZbPvoobSWtsfnJb6LNmS0sGpIl7IDOHeB4r8TYCwD3OU99csZP47GbW01b8Y
         ZO4rQx21UT/JfKdhuazq6KFsaudT9ohVx86h4loKf8VhIjoC0mJ2xa6rViglGS6zXf
         hKFgSp5Q62bjw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 748A015C00E4; Wed,  3 Aug 2022 15:58:14 -0400 (EDT)
Date:   Wed, 3 Aug 2022 15:58:14 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Alexey Lyashkov <alexey.lyashkov@gmail.com>
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@dilger.ca>,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>
Subject: Re: [PATCH] e2fsprogs: avoid code duplication
Message-ID: <YurTVlGWqwym2Hgg@mit.edu>
References: <20220803075407.538398-1-alexey.lyashkov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220803075407.538398-1-alexey.lyashkov@gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Aug 03, 2022 at 10:54:07AM +0300, Alexey Lyashkov wrote:
> debugfs and e2fsck have a so much code duplication in journal handing.
> debugfs have lack a many journal features handing also.
> Let's start code merging to avoid code duplication and lack features.

This is definitely worth doing, and as you've pointed out, there are a
number of features which are in e2fsck/journal.c, which are not in
debugfs/journal.c.  The most notable one which I picked up on is the
fast_commit code --- which is in the master/next branch, but not in
the maint branch.

I suggest that we move the functionality into the libsupport library
first.  I want to make sure we get the abstractions right before we
"cast them into stone" by moving the functions to libext2fs.
Libsupport is not exported outside of e2fsprogs, so if we decide we
want to change function signatures, or make some functions private, we
can do that more easily if we experiment with moving things into
libsupport first.

						- Ted
