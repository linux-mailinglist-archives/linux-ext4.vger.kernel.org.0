Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C814372A821
	for <lists+linux-ext4@lfdr.de>; Sat, 10 Jun 2023 04:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjFJCLh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Jun 2023 22:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjFJCLf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Jun 2023 22:11:35 -0400
Received: from cheetah.elm.relay.mailchannels.net (cheetah.elm.relay.mailchannels.net [23.83.212.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE58D3A87
        for <linux-ext4@vger.kernel.org>; Fri,  9 Jun 2023 19:11:33 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 15B7B102B46
        for <linux-ext4@vger.kernel.org>; Sat, 10 Jun 2023 02:11:33 +0000 (UTC)
Received: from pdx1-sub0-mail-a273.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 90E6B102B7C
        for <linux-ext4@vger.kernel.org>; Sat, 10 Jun 2023 02:11:32 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1686363092; a=rsa-sha256;
        cv=none;
        b=Lx576aYxdMqDdycGFGcimiaSYIU02ZkWMKeZeQUJWgtYuZ5xt4bOIXaQFeFZV5KpL0WOqg
        QS//jKFCWJBDuTqSrH+9MCsdtcp8sP2tBxZoaYgbAPXpRw3TYx6yE2sVPeRaG/x0tSRmC5
        davHQcYskrZ2NeblxvxM5Dv5PSk/i+UdpqnCLEfXoCBleS2b5phr/DOJyRvF/Ccx91ljHi
        ipgwRlxRydWmo2MhUbbn3wRcuDoFZ7vsQovN6SJStDRTlJ7vMQl/BoCXZZDbL1bnUR5GFq
        S9/e7IXhzrA2FYnE0EXnTnGlOt+w6vKdQRpolxgTH6N6ojSvupCKX4MfG89wNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1686363092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=6cCrXefebxIYGQLvZVuT/h0cRGS9RpFCZigzT3GjMfU=;
        b=c99g8Awra04wdV7VfsgWR9ML3PSycgmTtO+NpjCnE2hxlpGTKmQR6ZDdtJZnmgstQ3MSI/
        w0gk+NAqWRTS9j9Pf5ef57TrBseRPZdT3HSPnIjpEyaVGR87/JBeGGY7ldqryArQSNStZD
        H7kxi+DBhNBibBQ/Kk5rVo4GXmBtr8ke0jAAo6ct3fMBS5FRpNQTabaaVrWlkckfA28TOz
        8UMY5KpiC6V5X80Ws3T2zIlLsp6nZsEX7vkAneClOUwNtOKmeiqZP0Coh7SF0z8faV2vhn
        fThBPWzFjywZeIXoVOva2y48nsE357AhKBF0Dpxnh6Dq3NoFUw7gk5+DQ+9LAw==
ARC-Authentication-Results: i=1;
        rspamd-6c69b8658d-b7mg5;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Good
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Cooing-Sponge: 24a3dd31633b301d_1686363092804_4223001024
X-MC-Loop-Signature: 1686363092804:3222045330
X-MC-Ingress-Time: 1686363092803
Received: from pdx1-sub0-mail-a273.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.127.59.15 (trex/6.8.1);
        Sat, 10 Jun 2023 02:11:32 +0000
Received: from kmjvbox (c-73-93-64-36.hsd1.ca.comcast.net [73.93.64.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a273.dreamhost.com (Postfix) with ESMTPSA id 4QdLzS2g00zCf
        for <linux-ext4@vger.kernel.org>; Fri,  9 Jun 2023 19:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1686363092;
        bh=6cCrXefebxIYGQLvZVuT/h0cRGS9RpFCZigzT3GjMfU=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=AHAr4kTtlCFbT6/D0Sq29BQFqHg5jDfh2vKt3EHuh0OM4qOdYiEvEhX316cjLRZid
         E8z2rqHq7+88uPYKtFnWbf220KozSASmpenfr4B5+oRoJXKP8MO0fG/p50jZKC6Qfl
         sdVQCSTUBSiiMHp6NO+ULnolAjkRZt0qnmhOLhQU=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e0049
        by kmjvbox (DragonFly Mail Agent v0.12);
        Fri, 09 Jun 2023 19:11:31 -0700
Date:   Fri, 9 Jun 2023 19:11:31 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [e2fsprogs PATCH] resize2fs: use directio when reading superblock
Message-ID: <20230610021131.GA6134@templeofstupid.com>
References: <20230605225221.GA5737@templeofstupid.com>
 <20230607133909.GA1309044@mit.edu>
 <20230607185041.GA2023@templeofstupid.com>
 <20230609042239.GA1436857@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609042239.GA1436857@mit.edu>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ted,

On Fri, Jun 09, 2023 at 12:22:39AM -0400, Theodore Ts'o wrote:
> On Wed, Jun 07, 2023 at 11:50:41AM -0700, Krister Johansen wrote:
> > The growpart / resize2fs in the reproducer are essentially verbatim from
> > our system provisioning scripts.  Unless those modify the UUID, we're
> > not taking any explicit action to do so.
> 
> Ah, OK.  OK, I'm guessing that your system provisioning scripts are
> attempting mess with the file system a lot (creating, deleting, etc.)
> files while trying to run resize2fs in parallel, then?

The growpart and resize bits are triggered out of cloud-init when the
machine initially boots.  Some provisioning steps are machine-type
depenent.  The instances in which this problem have manifested are on
machines where the initial provisioning has more to do.  It's also on
machine types that are frequently provisioned.  I, unfortunately, only
get to look at these machines once they break.  It's been hard to say
whether it's because some other step of the provisioning is happening in
parallel, or if the probability is roughly the same, and these systems
are hitting it because more come and go.  I wish I had a better answer
for you. :/

> As far as your patch is concerned, resize2fs can do both off-line
> (unmounted) and on-line (mounted) resizes.  And turning direct I/O
> unconditionally isn't a great idea for off-line resizes --- it will
> really trash the performance of the resize.

Thanks for the additional detail.

I also double-checked to make sure these systems had the following patch
applied:

05c2c00f3769 ext4: protect superblock modifications with a buffer lock

And they do.  Not sure if that's directly applicable to the online
resize case though.

> Does this patch work for you instead?

Thanks, it does!

> 					- Ted
> 
> diff --git a/resize/main.c b/resize/main.c
> index 94f5ec6d..f914c050 100644
> --- a/resize/main.c
> +++ b/resize/main.c
> @@ -409,6 +409,8 @@ int main (int argc, char ** argv)
>  
>  	if (!(mount_flags & EXT2_MF_MOUNTED) && !print_min_size)
>  		io_flags = EXT2_FLAG_RW | EXT2_FLAG_EXCLUSIVE;
> +	if (mount_flags & EXT2_MF_MOUNTED)
> +		io_flags |= EXT2_FLAG_DIRECT_IO;
>  
>  	io_flags |= EXT2_FLAG_64BITS | EXT2_FLAG_THREADS;
>  	if (undo_file) {

If it counts:

Reviewed-by: Krister Johansen <kjlx@templeofstupid.com>
Tested-by: Krister Johansen <kjlx@templeofstupid.com>

Thanks again,

-K
