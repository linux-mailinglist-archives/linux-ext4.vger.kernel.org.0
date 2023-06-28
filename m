Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31EA741C1D
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Jun 2023 01:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjF1XCs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 28 Jun 2023 19:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbjF1XCl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 28 Jun 2023 19:02:41 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6312974
        for <linux-ext4@vger.kernel.org>; Wed, 28 Jun 2023 16:02:31 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id D27044C0AC9
        for <linux-ext4@vger.kernel.org>; Wed, 28 Jun 2023 23:02:30 +0000 (UTC)
Received: from pdx1-sub0-mail-a212.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 76E7E4C0D2D
        for <linux-ext4@vger.kernel.org>; Wed, 28 Jun 2023 23:02:30 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1687993350; a=rsa-sha256;
        cv=none;
        b=At8M89B2Z6M6znJSbUVYw/cr9G4AUeZaBWDsYZx8zt01o3FiwtKRPOWerYP5GvkOKRVpMp
        bfh7BLB1CGCzQ/LqhhHlZsIB3YPGXGp5IDmeIvX7FMKuexHmuJxMj3YbmdvQxlegCc2T1J
        RvLdMVWSpqK5MNSYiw/B/Pt9Dypiw/gCcyFlSZRO03WQO2nW9i8huqurec6GZtZiBzGLGn
        di7RjXZB2Biux9WI+LFHojbRaYDkRoNstU2MKe3PFavTHGx3cd464yuZ/3A3Ul2TqpV2b2
        bYr1CfSETXBmELfBwYEeDAoCBJ8D+skEFDXdUHGkIC0P9Gh2w2Hg6zRjv7RNSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1687993350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=2IoTljm8EPHWCmfYJ3nUFVT2+sl2dZ5i9L17UB5xOF4=;
        b=iUIa3ILE9uqXhqQ6WUGaob9nCFY4d80VZjpTPP0Te9m2xkOoC2plC/W7c+ny41Svv13Qzs
        B03tP+GR2LtBEcTslTjG7R618tRyXsyUh8FCILxQnLwKuqwn/8YtMtzV79X7Rz6+bE8dg4
        OJKTj5jpcMsQg49LHzHElceR1vahk8fMEZViYK2WUM+PTnxUhR63mpPBU4qhCOqZ2OrA5x
        uttfqFlVZtCwLEXNwrfQs0q0FoQHR6RhabyXIBa5Uu6BWjDvzEY6xojA56t8Ae7Z4DZ+Uz
        x865eQ6a5Zrs8Jwpg6fk8WgCdcmgVX5t4H0CSH58ysL982HqaxOjzY8yB4aT4g==
ARC-Authentication-Results: i=1;
        rspamd-7ccd4b867f-jxzgt;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Thoughtful-Trade: 136f1b20115f727a_1687993350687_378453928
X-MC-Loop-Signature: 1687993350687:3821724473
X-MC-Ingress-Time: 1687993350687
Received: from pdx1-sub0-mail-a212.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.120.73.150 (trex/6.9.1);
        Wed, 28 Jun 2023 23:02:30 +0000
Received: from kmjvbox (c-73-93-64-36.hsd1.ca.comcast.net [73.93.64.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a212.dreamhost.com (Postfix) with ESMTPSA id 4QrxtZ20pnzVH
        for <linux-ext4@vger.kernel.org>; Wed, 28 Jun 2023 16:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1687993350;
        bh=2IoTljm8EPHWCmfYJ3nUFVT2+sl2dZ5i9L17UB5xOF4=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=q476eTQxBLV58Qz+bBCx8B1eyNXZJMNuOQ8g8vxU3DwMVUfOjvE8OHC3EH3kMZHOl
         WUx9j+OUZKbp/+AIHi7cYYvXpd1CqvfUaQd04SFTtb1vDGTe56QSoHAqmeBoifPd6x
         8E4UPCLeafjJwflj4IbnNePnXToa5qVgMxZ8yLYY=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e003b
        by kmjvbox (DragonFly Mail Agent v0.12);
        Wed, 28 Jun 2023 16:02:20 -0700
Date:   Wed, 28 Jun 2023 16:02:20 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [e2fsprogs PATCH] resize2fs: use directio when reading superblock
Message-ID: <20230628230220.GA1918@templeofstupid.com>
References: <20230605225221.GA5737@templeofstupid.com>
 <20230607133909.GA1309044@mit.edu>
 <20230607185041.GA2023@templeofstupid.com>
 <20230609042239.GA1436857@mit.edu>
 <20230610021131.GA6134@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230610021131.GA6134@templeofstupid.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ted,

On Fri, Jun 09, 2023 at 07:11:31PM -0700, Krister Johansen wrote:
> On Fri, Jun 09, 2023 at 12:22:39AM -0400, Theodore Ts'o wrote:
> > As far as your patch is concerned, resize2fs can do both off-line
> > (unmounted) and on-line (mounted) resizes.  And turning direct I/O
> > unconditionally isn't a great idea for off-line resizes --- it will
> > really trash the performance of the resize.
> 
> Thanks for the additional detail.
> 
> I also double-checked to make sure these systems had the following patch
> applied:
> 
> 05c2c00f3769 ext4: protect superblock modifications with a buffer lock
> 
> And they do.  Not sure if that's directly applicable to the online
> resize case though.
> 
> > Does this patch work for you instead?
> 
> Thanks, it does!
> 
> > diff --git a/resize/main.c b/resize/main.c
> > index 94f5ec6d..f914c050 100644
> > --- a/resize/main.c
> > +++ b/resize/main.c
> > @@ -409,6 +409,8 @@ int main (int argc, char ** argv)
> >  
> >  	if (!(mount_flags & EXT2_MF_MOUNTED) && !print_min_size)
> >  		io_flags = EXT2_FLAG_RW | EXT2_FLAG_EXCLUSIVE;
> > +	if (mount_flags & EXT2_MF_MOUNTED)
> > +		io_flags |= EXT2_FLAG_DIRECT_IO;
> >  
> >  	io_flags |= EXT2_FLAG_64BITS | EXT2_FLAG_THREADS;
> >  	if (undo_file) {
> 
> If it counts:
> 
> Reviewed-by: Krister Johansen <kjlx@templeofstupid.com>
> Tested-by: Krister Johansen <kjlx@templeofstupid.com>

Just wanted to check back on this.  Should I send a v2 that incorporates
the changes you suggested above?

Thanks,

-K
