Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C047C923E
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Oct 2023 03:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbjJNBzx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 13 Oct 2023 21:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbjJNBzn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 13 Oct 2023 21:55:43 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771BEF4
        for <linux-ext4@vger.kernel.org>; Fri, 13 Oct 2023 18:55:21 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-111-200.bstnma.fios.verizon.net [173.48.111.200])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 39E1srLp024472
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 21:54:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1697248496; bh=sktGs/iimbpIZyqy4tFc5WyBA1lNSHSFUNmqlNczQFM=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=hVJLP8aq1UrfT5TGbDR6qAnEssWY889xVe+Jk/B8FR8360bv8d7Fp6y40WKtT/XNu
         P22X6613wieWb8RriCGjtrY9XZYFuqLtGhAmGay+jCYde2F1bWj62Km39k0rmUwARE
         vMbfnVwgn67alem03RAMgOeXCaDlz61i4AMYPiKPDBdj0cg4ywv+EMbRCh9Ekw32UW
         A0eaXfUObyvb17k5VhqPbosASgaI/qxV1ot6c7xfE+l0lt+FU79VAVAlFme6miCSbO
         6BgU3v8b8PkA+M9fmykjLwpHU5VAWR7OTIGPg4wJS7xbR3E4K0zry8g+QTAJ0UOEs6
         fX5WbiVauisTA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 71AAA15C0255; Fri, 13 Oct 2023 21:54:53 -0400 (EDT)
Date:   Fri, 13 Oct 2023 21:54:53 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Andres Freund <andres@anarazel.de>, linux-ext4@vger.kernel.org,
        Ricardo =?iso-8859-1?Q?Ca=F1uelo?= 
        <ricardo.canuelo@collabora.com>,
        "gustavo.padovan@collabora.com" <gustavo.padovan@collabora.com>,
        groeck@google.com, zsm@google.com, garrick@google.com,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [syzbot] INFO: task hung in ext4_fallocate
Message-ID: <20231014015453.GE255452@mit.edu>
References: <d89989ef-e53b-050e-2916-a4f06433798b@collabora.com>
 <ZQjKOjrjDYsoXBXj@mit.edu>
 <20231003141138.owt6qwqyf4slgqgp@alap3.anarazel.de>
 <20231003232505.GA444157@mit.edu>
 <20231004004247.zkswbseowwwc6vvk@alap3.anarazel.de>
 <604bc623-a090-005b-cbfc-39805a8a7b20@collabora.com>
 <c9632187-bcbc-483f-8b18-1fa403b46ebb@leemhuis.info>
 <e6277feb-e444-4d47-8376-fa2909fbac96@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6277feb-e444-4d47-8376-fa2909fbac96@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Oct 13, 2023 at 02:28:52AM +0530, Shreeya Patel wrote:
> 
> Just to clarify, this issue is still seen on upstream 5.10 and earlier
> kernels.
> I can confirm that we did not see this issue being reproduced on mainline
> kernel using #sys test feature.

So I'm confused.  In the original post on this thread[1], it was stated:

> When I tried to reproduce this issue on mainline linux kernel using the 
> reproducer provided by syzbot, I see an endless loop of following errors :-

and

> #regzbot introduced: v6.6-rc1..

[1] https://lore.kernel.org/all/d89989ef-e53b-050e-2916-a4f06433798b@collabora.com/

... and now you're sayingg this *wasn't* reproduced upstream?  And of
course, because this was a private syzbot instance, there was syzbot
dashboard given, and the reproducer had the serial number filed off
(there is a URL in the comments at the beginning of the reproducer for
a *reason*), so *I* couldn't run "#syz test".

Huh?

Reading between the lines, it looks like the only similarity between
what was happening in the 5.10 kernel and the mainline kernel was that
it did not *hang* the kernel, but it was generating a stream of
EXT4-fs error messages.  Well, if you take a deliberately corrupted
kernel, and mount it with errors=continue, and then keep pounding it
with lots of file system operations, of *course* it will continually
spew ext4 errors message.  That is "Working As Intended" by
*definition*.

And this is why I maintain that irresponsible use of syzbot is
effectively a denial of service attack on upstream maintainers.

At this point, just as upstream policy is that debugging ancient LTS
kernels is not something upstream maintainers to do (and attempting to
trick them to debug it by claiming it is found in mainline is *really*
uncool), if there are bugs that are reported using private syzbot
instances, or where there isn't a URL to a public syzbot dashboard,
they should be treated as P4 priority or worse....

	      	     		       	  - Ted

