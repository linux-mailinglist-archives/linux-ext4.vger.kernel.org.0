Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01B1726933
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Jun 2023 20:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjFGSut (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Jun 2023 14:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbjFGSus (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Jun 2023 14:50:48 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C4418F
        for <linux-ext4@vger.kernel.org>; Wed,  7 Jun 2023 11:50:45 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 1B0F1540FEF
        for <linux-ext4@vger.kernel.org>; Wed,  7 Jun 2023 18:50:45 +0000 (UTC)
Received: from pdx1-sub0-mail-a264.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id A7A025401D0
        for <linux-ext4@vger.kernel.org>; Wed,  7 Jun 2023 18:50:44 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1686163844; a=rsa-sha256;
        cv=none;
        b=E4TAU5l7t/140nA7tDaob8tV76I8TNCYWv6P9Oqy+6Gy2ssaoy9Y0VrULMSMoHrcC2402q
        Pm7ZlYTo+e2KcIl+mMqzmZoj5+M1QhyutuGZJbaT6WjjJCCTLz7mUJ9wo5W5pMlIE4BGCR
        ZjDL6Op+RL+bBtU7aRcTEnkBxkS69KjTxuPWd8BKsMzNj8h1zjBt5HaCKA1haQIKclPnIU
        TLOJpjE5GI9GLuxvV0yRjNVjRFpGu/CfZV02LkPUO2GWOSOpqU6j5QZ759LqBMNzKwhHmW
        tUahqht37ZVKrap7EyBsGjbU44hWtz62BNlK+RFuaizonrC3sbPCMAvnUBkU4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1686163844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=WDt3+4i1DINQL5h5kVpxR4Ds/PxbHCAHGI5JHcsXfcA=;
        b=qqVS0I5R3WeOGGciXYPOQXBR8tg1JWvGvzYBQE2na+UtiAZfMGvteqQ/aGqOPfVTBu0+eJ
        s77POuyy3renELroC1v1+GFnWqDdJKx3wSKaoG43jVtzDXesmfUPoXQzAjxgE1DyuzFgRy
        M64t1NKnk/rl14HX94YZfNicVIp2JzTFeMR//JnGGN1Vh7C664OAatia4VEySE29e/36uk
        onumO5GKVBlbWEtVW0vRrkLVO4uL4eFyBNuDYqNy0i2M32CXvpwNu34Jq5sJOVw45+GlY4
        LX+sQBUsWDZuvXsJKHhm1ewqmtLeiBsNlAfMveqCzEoMvDfajEygCOsGuwGn6g==
ARC-Authentication-Results: i=1;
        rspamd-6f5cfd578c-md99n;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Stretch-Cure: 7904f6ec66e790e0_1686163844904_540563933
X-MC-Loop-Signature: 1686163844904:2728772384
X-MC-Ingress-Time: 1686163844904
Received: from pdx1-sub0-mail-a264.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.120.163.30 (trex/6.8.1);
        Wed, 07 Jun 2023 18:50:44 +0000
Received: from kmjvbox (c-73-93-64-36.hsd1.ca.comcast.net [73.93.64.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a264.dreamhost.com (Postfix) with ESMTPSA id 4QbxHm3C43z2p
        for <linux-ext4@vger.kernel.org>; Wed,  7 Jun 2023 11:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1686163844;
        bh=WDt3+4i1DINQL5h5kVpxR4Ds/PxbHCAHGI5JHcsXfcA=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=rd6aVzLwiglCNjgK/9XmFuNq0/iDT7vxBIMvjcoST+kBvca0qr9P7nLHtIVeM99ev
         HA4rv6vXRoP+tA0bgf+rbmi3abbWKwuh4JOqnYgKZCk8+M8Mf1KjaNj6OKeAAUhK/5
         pvKLhplM/bVgrZ4R8+S7dRHC6ECklb9NeN8hOAOc=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e0042
        by kmjvbox (DragonFly Mail Agent v0.12);
        Wed, 07 Jun 2023 11:50:41 -0700
Date:   Wed, 7 Jun 2023 11:50:41 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Krister Johansen <kjlx@templeofstupid.com>,
        linux-ext4@vger.kernel.org
Subject: Re: [e2fsprogs PATCH] resize2fs: use directio when reading superblock
Message-ID: <20230607185041.GA2023@templeofstupid.com>
References: <20230605225221.GA5737@templeofstupid.com>
 <20230607133909.GA1309044@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607133909.GA1309044@mit.edu>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 07, 2023 at 09:39:09AM -0400, Theodore Ts'o wrote:
> On Mon, Jun 05, 2023 at 03:52:21PM -0700, Krister Johansen wrote:
> > Invocations of resize2fs intermittently report failure due to superblock
> > checksum mismatches in this author's environment.  This might happen a few
> > times a week.  The following script can make this happen within minutes.
> > (It assumes /dev/nvme1n1 is available and not in use by anything else).
> 
> What version of e2fsprogs are you using, and what is your environment?

I hit this originally using e2fsprogs 1.45.5.  That didn't have your
patch for retrying the superblock read on checksum failure.  I pulled
that patch in initially, but it did not fully resolve the checksum
mismatch error.  The test provided in the report was using an EBS volume
attached to an EC2 instance.  (Let me know what additional environment
details would be useful, if these are not).

> Are you perhaps trying to change the UUID of the file system (for
> example, in a cloud image environment) in parallel with resizing the
> file system to fit the size of the block device?

The growpart / resize2fs in the reproducer are essentially verbatim from
our system provisioning scripts.  Unless those modify the UUID, we're
not taking any explicit action to do so.

Thanks,

-K
