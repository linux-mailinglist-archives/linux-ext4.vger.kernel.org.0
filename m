Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52536B557E
	for <lists+linux-ext4@lfdr.de>; Sat, 11 Mar 2023 00:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjCJXVS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Mar 2023 18:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjCJXVR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 Mar 2023 18:21:17 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9405810D300
        for <linux-ext4@vger.kernel.org>; Fri, 10 Mar 2023 15:21:13 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32ANL7Wn016908
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 18:21:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1678490470; bh=aERuYJTFhiNvAk0TIMmoiuYbNfM79mwZrLKsx6b+GvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=SR4fdEfaXsXcSdpYZrts3zzVPP0SWi6+CFJXGIbNzdshGorWGeLqilzxhXZDGcip5
         W1e9YV+q8Co13vnCz+utpqMauJYnEXqw9vURobMaqx2CzBFaYVZC20dpHkXtv8of61
         3/9zS+K/zLPN+g9lxJuDp5TUyIV2g8xSHmydq/zTNYu4tvlTfIYaM4iw9Nt1qWzBzG
         T6SiAyN4b00ij6X+U4dlOgU2DaDF+gKtNIiZ0hheKhyA+OQ1cf4Q1D9BHwctdLuRdE
         YEuHwlyq457DUE2PesUe22iPoHsk2qc9Ju1qRMzzulB4eaHkHzDCcUviufqgrQcAbF
         S6sZXmUDIoh7Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 36DDE15C42F6; Fri, 10 Mar 2023 18:21:07 -0500 (EST)
Date:   Fri, 10 Mar 2023 18:21:07 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] ext4: convert to DIV_ROUND_UP() in
 mpage_process_page_bufs()
Message-ID: <20230310232107.GE860405@mit.edu>
References: <20230310060734.8780-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310060734.8780-1-frank.li@vivo.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Mar 10, 2023 at 02:07:34PM +0800, Yangtao Li wrote:
> Just for better readability, no code logic change.

All aside from the arguments over performance, I'm not at *all*
convinced by the "it's more readable" argument.

So yeah, let's not.  We have i_blkbits for a reason, and it's because
shifting right is just simpler and easier.

BTW, doing a 64-bit division on a 32-bit platforms causes compile
failures, which was the cause of the test bot complaint:

   ld: fs/ext4/inode.o: in function `mpage_process_page_bufs':
>> inode.c:(.text+0xbda): undefined reference to `__divdi3'

On 32-bit platforms --- i386 in particular --- the 64-bit division
results in an out-of-line call to a helper function that is not
supplied in the kernel compilation environment, so not only is it
slower, it Just Doesn't Work.

						- Ted
