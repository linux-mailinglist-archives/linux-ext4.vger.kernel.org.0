Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152CE7A5532
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Sep 2023 23:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjIRVoX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Sep 2023 17:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjIRVoW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Sep 2023 17:44:22 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8EF90
        for <linux-ext4@vger.kernel.org>; Mon, 18 Sep 2023 14:44:16 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 9316B7A19C7
        for <linux-ext4@vger.kernel.org>; Mon, 18 Sep 2023 21:36:46 +0000 (UTC)
Received: from pdx1-sub0-mail-a216.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 389A37A1B19
        for <linux-ext4@vger.kernel.org>; Mon, 18 Sep 2023 21:36:46 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1695073006; a=rsa-sha256;
        cv=none;
        b=bDaPQvcG9QKuIdN8Bwdolm2H7M05od85nJFq+njLAI/xD4Pxjis1AGdwiI0MJlI5ip3plu
        RgVsKK7W/C8XjkC5NXzfP2RWD26BI0ilCjiMxhum3ApUvKHyvOdzjHivzQ9TskEB2ICX5O
        S3Eov5vICQl3BnZfUmHQAlaVte8frBg/BtK3Tv4wb1TzyEGSgZPeYSyiiGp+5XwNk2NERC
        I+oFfD6nH5SWuFuOSwIBA25Yo5zSRU67iQ/uWb8q9py0u8ba2l7wEVL6MAjvbz6rIOuqWH
        V8suURh6prD+JZA30YxextjCLQUKQXyJAcserq33LpU7hKj4cx+HETXBhL9h6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1695073006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=gEaqVanLSyyrhxTZlN7zhL9THoW6F+MDXAdXDTaKy6s=;
        b=db9ec6fMpfw87DpimVXPRe2H8R0ZL7Op0VmvFhX5Wn0+mzfmEOYfbfJgdPP/JpYhY8z6ni
        n44ALrdzZILoSlVzt++Dlma6jZMioo2PdKVg9kuW3fxVEEPOAZHvww3CEe7/fJGuq9gInA
        XHd0Su+cAfHMor3VE4NQdnwnaheCTbipfpXWjHwGjlqTsR28U5cpR9c8v3S1mi1KEmZZPo
        dWvvEWLK86RSlUpRQf7u1ytG2EJgzJ0UeFaF6HWBvCaE52N4TLXb3eCibB1yJ5PLSKvLOV
        rxMBwywH67smo5geIz+8rKPIbHHDr1K+j+3Gljd1DSRFQ1s/Hovc11dAoWEwIA==
ARC-Authentication-Results: i=1;
        rspamd-7c449d4847-m58dx;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Shoe-Descriptive: 24faa4b86cde2c75_1695073006451_1150005868
X-MC-Loop-Signature: 1695073006451:2986613553
X-MC-Ingress-Time: 1695073006450
Received: from pdx1-sub0-mail-a216.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.96.239.67 (trex/6.9.1);
        Mon, 18 Sep 2023 21:36:46 +0000
Received: from kmjvbox (c-73-231-176-24.hsd1.ca.comcast.net [73.231.176.24])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a216.dreamhost.com (Postfix) with ESMTPSA id 4RqJ5n5GwSz8n
        for <linux-ext4@vger.kernel.org>; Mon, 18 Sep 2023 14:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1695073005;
        bh=gEaqVanLSyyrhxTZlN7zhL9THoW6F+MDXAdXDTaKy6s=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=LdL0q19yEv2JDrYVzCZkKQkGoynGseIBFiM561bzL8zOoTpdjCWiXwDB04i+om1t6
         GPIz3B0HY4YoOAuNDN2jkQpbqsGuQWK9+8ET1zqVTSqDdG/VJ5ZPgat4BfddayErfB
         p9X4ip6CCeojhPjUU4Va7yjemQMrpBSDnsehPd8WY0svbLVF/NHgeeQNlZKWZDCNWu
         qCc2PAiUwA3tfmdL4Xgk78n02pQA8S9uuIuVXTFCt6nhSCdkJLOuUw3snjrYq+lxCj
         D840GrIcqTD7bxpDSEuKLNhYac/7bks0k1qdoEehQQM5F5EwACTzRuGX1V0K3FVr92
         dP/2MsH1hCrrA==
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e008c
        by kmjvbox (DragonFly Mail Agent v0.12);
        Mon, 18 Sep 2023 14:36:43 -0700
Date:   Mon, 18 Sep 2023 14:36:43 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Krister Johansen <kjlx@templeofstupid.com>,
        Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [e2fsprogs PATCH v2] resize2fs: use directio when reading
 superblock
Message-ID: <20230918213643.GA1945@templeofstupid.com>
References: <20230911183905.GA1960@templeofstupid.com>
 <729CDEF6-F6B3-4290-8120-F73C990B0D9F@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <729CDEF6-F6B3-4290-8120-F73C990B0D9F@dilger.ca>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Andreas,

On Mon, Sep 18, 2023 at 03:20:01PM -0600, Andreas Dilger wrote:
> On Sep 11, 2023, at 12:39 PM, Krister Johansen <kjlx@templeofstupid.com> wrote:
> > 
> > Invocations of resize2fs intermittently report failure due to superblock
> > checksum mismatches in this author's environment.  This might happen a few
> > times a week.  The following script can make this happen within minutes.
> > (It assumes /dev/nvme1n1 is available and not in use by anything else).
> 
> Krister,
> thanks for submitting the patch.  This particular issue was already fixed
> in commit v1.46.6-16-g43a498e93888, apparently based on your previous report:
> 
>     commit 43a498e938887956f393b5e45ea6ac79cc5f4b84
>     Author:     Theodore Ts'o <tytso@mit.edu>
>     AuthorDate: Thu Jun 15 00:17:01 2023 -0400
>     Commit:     Theodore Ts'o <tytso@mit.edu>
>     CommitDate: Thu Jun 15 00:17:01 2023 -0400
> 
>     resize2fs: use Direct I/O when reading the superblock for online resizes
> 
>     If the file system is mounted, the superblock can be changing while
>     resize2fs is trying to read the superblock, resulting in checksum
>     failures.  One way of avoiding this problem is read the superblock
>     using Direct I/O, since the kernel makes sure that what gets written
>     to disk is self-consistent.
> 
>     Suggested-by: Krister Johansen <kjlx@templeofstupid.com>
>     Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> 
> So it is landed on the e2fsprogs maint branch, but there has not been a
> maintenance release since the patch was landed.

Thanks for the response. My apologies for resubmitting this.  I had
thought that I checked the git trees before sending this out, but I
must've looked at the wrong one.  Sorry about that.

Thanks to Ted for applying his reworked patch, it's much appreciated.

-K
