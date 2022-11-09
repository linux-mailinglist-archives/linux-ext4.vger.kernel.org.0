Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC0C622F48
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Nov 2022 16:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiKIPoY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Nov 2022 10:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbiKIPoX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Nov 2022 10:44:23 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46181117C
        for <linux-ext4@vger.kernel.org>; Wed,  9 Nov 2022 07:44:22 -0800 (PST)
Received: from letrec.thunk.org ([12.139.153.3])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2A9FhgBN027734
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 9 Nov 2022 10:43:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1668008625; bh=Rpc26MiFU0UIIQKz0rvaCeQQ2usodqbDVzocqyMJUcA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=EkR8C5jMd393BR0weR+vs8+Gks7zjfK6RErUhAtba0wgviHGZNldwxOBwSx+bI/xK
         AtsQ1YB7iqQuyMbFiJ9UgUsrIiMrQ5Ho6aKkcUCbA862KgP5F+VBhT+k4w0jKCWuSo
         zJ9uz7cjp3bYP57jiZRiFTYt0t1ToOkwAP87iLpNtIgYUQWbl7nq5ANGTUwWGk2kFy
         XLYuVLNl/18p6bA1MObV6E4laFKHsLRPXWERuLt0XbaCiQQ/d0t8aFaBZgttrzCAU7
         pga1rAW36GzJMOJigPnz4Jmb+CFu+cyW59RzOw9kc+cj/1Q8bVfpuvH3suAFHMhP92
         M6jzCnc2dNupQ==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 79ACF8C0282; Wed,  9 Nov 2022 10:43:42 -0500 (EST)
Date:   Wed, 9 Nov 2022 10:43:42 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     zhanchengbin <zhanchengbin1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, linfeilong <linfeilong@huawei.com>,
        liuzhiqiang26@huawei.com
Subject: Re: [bug report] e2fsck: The process is deadlocked
Message-ID: <Y2vKriGCf+qcOgoT@mit.edu>
References: <30ac384e-a015-259a-3efc-1c9f3ee1dabb@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30ac384e-a015-259a-3efc-1c9f3ee1dabb@huawei.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 09, 2022 at 06:40:31PM +0800, zhanchengbin wrote:
> Hi Tytso,
> The process is deadlocked, and an I/O error occurs when logs
> are replayed. Because in the I/O error handling function, I/O
> is sent again and catch the mutexlock.

What version of e2fsprogs are you using, and do you have a reliable
reproducer?

Thanks,

					- Ted
