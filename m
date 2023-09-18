Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54BEA7A559E
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Sep 2023 00:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjIRWIP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Sep 2023 18:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjIRWIO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Sep 2023 18:08:14 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7A28F
        for <linux-ext4@vger.kernel.org>; Mon, 18 Sep 2023 15:08:08 -0700 (PDT)
Received: from letrec.thunk.org (c-73-8-226-230.hsd1.il.comcast.net [73.8.226.230])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 38IM7tV0032420
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 18:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1695074878; bh=I/OPhMVwEE+FwTeKxUk3XfclqMUzxdhNE/ZJTqJbFUs=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=qVm6xg5cusG8V92imaVhpgMCM7daJ0Gxrue+ArwTiVjd0A0eFqRkP+8RttOUSgqXi
         GTfUxYvHZB6dqwm7jUZBSFa0BqtYVembC5hPIRFRu3SaEWN+gKK3yxOvinJtBKA7K9
         dgApbjcFy/AQnHDi8RSWy61LEOqLUQbVA+sfr9jEwvxAhDXH+rPKlGT8tthDIrMkNV
         ijqfCmAdCy2Kfe1KyqFztJIZHG8ZPTfdPfn7KO+GbDt7Nbgv4Xtth1BR0gUo4dGh2s
         rdZJnVvccRA/HLmGy8Rgh1rJpyXeh+RUcbkrIyMSFMC100TRumx/h1Lt2us03SXTZG
         kWf4vh3QBMPFQ==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id D4E808C02E6; Mon, 18 Sep 2023 18:07:54 -0400 (EDT)
Date:   Mon, 18 Sep 2023 18:07:54 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     linux-ext4@vger.kernel.org,
        Ricardo =?iso-8859-1?Q?Ca=F1uelo?= 
        <ricardo.canuelo@collabora.com>,
        "gustavo.padovan@collabora.com" <gustavo.padovan@collabora.com>,
        groeck@google.com, zsm@google.com, garrick@google.com,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [syzbot] INFO: task hung in ext4_fallocate
Message-ID: <ZQjKOjrjDYsoXBXj@mit.edu>
References: <d89989ef-e53b-050e-2916-a4f06433798b@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d89989ef-e53b-050e-2916-a4f06433798b@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Sep 18, 2023 at 08:13:30PM +0530, Shreeya Patel wrote:
> Hi Everyone,
> 
> syzbot has reported a task hung issue in ext4_fallocate, crash report can be
> seen at the bottom of the email.

What's the link to the syzbot dashboard URL?  This is typically the
first line of the reproducer, but it's been snipped out in your
reproducer.

> 
> When I tried to reproduce this issue on mainline linux kernel using the
> reproducer provided by syzbot, I see an endless loop of following errors :-
> 
> [   89.689751][ T3922] loop1: detected capacity change from 0 to 512
> [   89.690514][ T3916] EXT4-fs error (device loop4): ext4_map_blocks:577:
> inode #3: block 9: comm poc: lblock 0 mapped to illegal pblock 9 (length 1)
> [   89.694709][ T3890] EXT4-fs error (device loop0): ext4_map_blocks:577:

Please note that maliciously corrupted file system is considered low
priority by ext4 developers.  If this is something which is important
to Google, then it needs to fund more headcount so that we have time
to take a look at these things.  There has been plenty of discussions
about how syzbot is effectively a denial of service attack on upstream
resources, and the only way we can respond is to down-prioritize such
bug reports.

This is *especially* true when we receive reports from private syzbot
instances where we don't have any of the features provided by syzbot
console --- including convenient access to the file system image that
was mounted as part of the test, the ability to use #syz test to try
out patches --- and more importantly, so we can introduce debugging
messages and using the syzbot testing facility to run the tests.

If you really are concerned about the threat model of users picking up
random USB thumb drives that they found in the parking lot, consider
running fsck.ext4 -f on the file system first, and if the file system
checker is not able to fix the file system, refuse to mount it.
Alternatively, consider using cros-vm, and mounting the file system in
the guest-kernel so that the VMM provides an additional sandbox layer.

Anyway, please provide a link to a public Syzkaller dashboard report,
and we'll take a look at it when we have time...

Cheers,

							- Ted

