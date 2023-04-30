Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD1E6F2A25
	for <lists+linux-ext4@lfdr.de>; Sun, 30 Apr 2023 20:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjD3SCO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 30 Apr 2023 14:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjD3SCN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 30 Apr 2023 14:02:13 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A417F2D52
        for <linux-ext4@vger.kernel.org>; Sun, 30 Apr 2023 11:02:04 -0700 (PDT)
Received: from letrec.thunk.org ([76.150.80.181])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33UI1w33019246
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 30 Apr 2023 14:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1682877720; bh=cYX2LFwKOhcyjnoXW+Wjhp+F5By9aGURSF6AD9hVXqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=jq9BBOOUKamykYHFCdrNIYqdb/gjDVdBM2fiVC9tmUUXS+SQiRlFUqyngcjvjJB/g
         CeDT8N/lzGzpb38uJxoxzsetPyBmWbvElP/7JnZsb9nDft58eaVNO2S7KtY/CObgsF
         trsNhCWzS8VVaz5H5NEKP3Og3rtCugL4+lCZIRRDV3rogwpOR+73YNa9nPBCHzxVvG
         UKf9f21LxqMa17Sxvk0QBwRZzan6NJVCx5MG3/FskU4EmV5Pgo2Gzk7+TvVsmuJyOA
         uByylroo9PGY2KVySW/9dK7r0r8H6UtXWl47F8xNInralnjU658A+d+2vxjl1ovHDj
         QyrvWOp1KNxdw==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 7B17B8C026B; Sun, 30 Apr 2023 14:01:58 -0400 (EDT)
Date:   Sun, 30 Apr 2023 14:01:58 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ext4: silence complaint if CONFIG_QUOTA isn't set
Message-ID: <ZE6tFkH9rcIsd+82@mit.edu>
References: <123c391a-2569-6afd-2461-4e5b2ca298f3@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <123c391a-2569-6afd-2461-4e5b2ca298f3@kernel.dk>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Apr 30, 2023 at 10:54:38AM -0600, Jens Axboe wrote:
> Compiling the kernel ext4 spews a warning that 'i' is unused in two
> spots:

Thanks, we have a fix for this queued up for Linus already.  It should
be pushed out shortly...

Cheers,

					- Ted
