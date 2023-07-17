Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0827756EF5
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Jul 2023 23:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjGQVeu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 17 Jul 2023 17:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjGQVet (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 17 Jul 2023 17:34:49 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E318134
        for <linux-ext4@vger.kernel.org>; Mon, 17 Jul 2023 14:34:48 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-116-181.bstnma.fios.verizon.net [173.48.116.181])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 36HLYOe4023106
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 17:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1689629668; bh=AIJ7eQlGnPTeVEA7EYFHb4RQbDLObtg4FWLQb0yKeA0=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=AhYp6FG0XJz9UMdyC87+MA7F7E0+jqJEAN9UIBRE/YiWHYr7aES6PPKEIOwFeUmyx
         etZXfRnpfgavY+1dnsZmq6ey06zngeSKKYCUXfV3KHc49kBmgHU2zJT5LBD2WD5ZZZ
         AlTszUt4smZI1XFRhjiB8T7q1QepJ83222jdYOJsZk6umyUYQvVDQRtc32b2P3QonV
         IXKs7gUjMpbjdbpdx0y/tnHYMpERKfD0qBl8LBDTNW4wpiofms4HJqy9y2wmu3Z4+C
         ZKJi54xm2h8bE++9tWGmppPwIVElkGSNyHp166KSRlNXytYHG+9h4HIQDCmF/ov2DS
         lGV8oz6wVf/QA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 809FC15C026A; Mon, 17 Jul 2023 17:34:24 -0400 (EDT)
Date:   Mon, 17 Jul 2023 17:34:24 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, lkft-triage@lists.linaro.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: Re: next: kernel BUG at fs/ext4/mballoc.c:4369!
Message-ID: <20230717213424.GB3842864@mit.edu>
References: <87o7kbnle9.fsf@doe.com>
 <87jzuyobch.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzuyobch.fsf@doe.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jul 17, 2023 at 08:04:54PM +0530, Ritesh Harjani wrote:
> 
> These can basically trigger in extremely low memory space and only when
> such ranges exist in the PA rbtree. Hence, I guess it is a little hard
> to tigger race.

Ritesh, thanks for looking into this!

Naresh, how easy is it for you to trigger the BUG when using LTP?  I
did two xfstests runs using "gce-xfstests -c ext2/default -g auto",
one on the ext4 dev branch, and one on linux-next 20230717, and I
wasn't able to trigger the BUG.

If you can trivially trigger it using LTP (perhaps with a low memory
configuration in your test setup?), that would be useful to know.

Cheers,

					- Ted
