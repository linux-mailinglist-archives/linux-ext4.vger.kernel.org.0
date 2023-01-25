Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F42C67AA3F
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Jan 2023 07:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbjAYGSs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 Jan 2023 01:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjAYGSq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 Jan 2023 01:18:46 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C71328868
        for <linux-ext4@vger.kernel.org>; Tue, 24 Jan 2023 22:18:44 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 30P6I68p031494
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 01:18:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1674627489; bh=d9clueZAPzTmRgbCWwnIltYUEG6qn0aCa3DlFdOIRxU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=f3zmRTIIGZPKVQBA3Ne6eMkpw+a+QZojwz41FEWK1MFBC07Sb2slv9d2Jgejpjspg
         cpv3Nnp7+0X4kNzK4F3RhCSAex3SU1KP9ZrNDsDWhMycdkOBIaORYd2VYwWWtj1Zg1
         8b2L8pqE2VbCpFdsj4amCSBNrWOk3cuiZ1Jp9xxy2j7vyt5fw63yLsQ8j8K4uhSe5V
         ZKorK2nHZ2jg7cEKwy32udcP4SzeChqO8ZsVNWt4FOuYYyWz2atZWSmkemoMXDoqt3
         vG/83XVZQI6MIUJiYzSdnTaVOh1OEYMZO3LcLSvVDok9NjgpF/gCFrfCehaSRekaLp
         F66kdKWJBIkKQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id B975C15C469B; Wed, 25 Jan 2023 01:18:06 -0500 (EST)
Date:   Wed, 25 Jan 2023 01:18:06 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     zhanchengbin <zhanchengbin1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, linfeilong <linfeilong@huawei.com>,
        liuzhiqiang26@huawei.com
Subject: Re: [PATCH] unix_io.c: fix deadlock problem in unix_write_blk64
Message-ID: <Y9DJnh9P+FijguS2@mit.edu>
References: <310fb77f-dfed-1196-c4ee-30d5138ee5a2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <310fb77f-dfed-1196-c4ee-30d5138ee5a2@huawei.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Nov 21, 2022 at 10:00:49AM +0800, zhanchengbin wrote:
> The process is deadlocked, and an I/O error occurs when logs
> are replayed. Because in the I/O error handling function, I/O
> is sent again and catch the mutexlock of CACHE_MTX.

This is a legitimate bug, but the propsoed fix is not safe.  There is
a reason why we take the cache mutex, and that's because we need to
prevent another thread from modifying the cache, possibly by ejecting
the cache entry that we are in the middle of cleaning when
raw_write_blk() is being called in reuse_cache().

Fortunately, we're safe on the read side, because we currently very
carefully do not call raw_read_blk() while holding the CACHE_MUTEX.
Instead, we write the data from the user-supplied buffer, and *then*
take the cache mutex, and then save the data from the user-supplied
buffer into the cache.

So the problem is only on the write side, and what I think we need to
do is to lift the call to channel->write_error() to the ultimate
callers of raw_write_blk(), so that we return the error code to its
callers in reuse_cache(), flush_cache_blocks(), and
unix_write_blk64(), and let those upper-level functions call the write
handler --- after they've had the chance to release any mutexes.

					- Ted
