Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11119671334
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Jan 2023 06:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjARF1H (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Jan 2023 00:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjARF0Y (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Jan 2023 00:26:24 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45719577FD
        for <linux-ext4@vger.kernel.org>; Tue, 17 Jan 2023 21:26:23 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 30I5Psdb032202
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 00:25:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1674019556; bh=0st8zagem7DOhNQQCWx8afixRElH3uTwdeRxPtXMct4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=BogsUmQKp9tzfEZMHLFU6RjiqrJfAcsP9zROY6ENe/IiHbZkbjvJl40lLdoyuDW4i
         5wjkPcSd9aEAfTh5otHegz4MCu8+HV6I9zGsqzfEGI64r6NAtPPhMpK4rDRyc2Q3VU
         fYHxME0jPYAbTD0OuC2NZ4Pks+uY21vUg0OoTyFdEJ/wDbS5v8LxpWByzVYhTobCr3
         Gd63+glKk0sgWBpAq0Hv+oz7VX5/WB28ZuCKRm7nNmCvBGp8zVrrCMQPvg+L2bZ3ZA
         CMxsb8L9IulbSA0QVAVqxfXQFza7Z9udL2Bs84W0/+kCgA3j5aholKWy8pbFApWS4i
         VMcUpSwsSdEWw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 889CE15C469B; Wed, 18 Jan 2023 00:25:54 -0500 (EST)
Date:   Wed, 18 Jan 2023 00:25:54 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     zhanchengbin <zhanchengbin1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, liuzhiqiang26@huawei.com,
        linfeilong@huawei.com, riteshh <riteshh@linux.ibm.com>
Subject: Re: [PATCH v3] setup_tdb : fix memory leak
Message-ID: <Y8eC4uM9b3hiBpfR@mit.edu>
References: <da92f94e-14ff-daaa-57e5-43e91bd9ff4c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da92f94e-14ff-daaa-57e5-43e91bd9ff4c@huawei.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jan 04, 2022 at 08:09:16PM +0800, zhanchengbin wrote:
> In setup_tdb(), need free tdb_dir and db->tdb_fn before return,
> otherwise it will cause memory leak.

This patch is not correct.  tdb_dir is returned by
profile_get_string(), and it does *not* need to be freed.  In fact, if
you had tested this using valgrind or AddressSanitizer, it would have
failed because tdb_dir is in the *middle* of an allocated block[1],
and this would have corrupted the heap data structures leading to all
sorts of potential problems.

[1] And that allocated block is freed by profile_release()

In addition, tdb->tdb_fn will be freed by e2fsck_free_dir_info(), and
so freeing it on the error path in setup_tdb() will result in a
double-free when e2fsck_free_dir_info() gets called.

I'm guessing you didn't actually test this patch with the code paths
in question --- that is, by triggering an error while using something
like ASan or valgrid?  Note that corrupting the heap may lead to an
exploitable security bug, so if you have applied this patch in your
production version of e2fsprogs, I suggest that you revert it.

Cheers,

					- Ted
