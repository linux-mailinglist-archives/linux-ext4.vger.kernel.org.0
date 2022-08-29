Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E4F5A4F02
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Aug 2022 16:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiH2OT7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 29 Aug 2022 10:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiH2OT5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 29 Aug 2022 10:19:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6D51010;
        Mon, 29 Aug 2022 07:19:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 173D5B810A1;
        Mon, 29 Aug 2022 14:19:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C12DC433C1;
        Mon, 29 Aug 2022 14:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661782793;
        bh=x744xaz6Uu0xiKjbhKnojlAb0xHtl0e/ppNFN4BI+nc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JyFiJKwIDwe2R2o3L5FQtIOfZI1eMGTe8lvOOpiS2frPeZPK4h+wQEDf9jaN9CqsO
         e+IaRwTBtX1FPJAXUHtimPoyep++WAgIUSQNabSfyTfw7ZtnbV9ifSa7Wl2kK11nl9
         B4WC9DdxHBF70uCC0F/xZs81NnEAkHcRg40ewSRk=
Date:   Mon, 29 Aug 2022 16:19:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     syzbot <syzbot+4faa160fa96bfba639f8@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, hch@lst.de, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, paulmck@kernel.org,
        phil@philpotter.co.uk, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Subject: Re: [syzbot] kernel BUG at fs/ext4/inline.c:LINE!
Message-ID: <YwzLBls/xEMz4d+s@kroah.com>
References: <0000000000004c915205b1a04ad9@google.com>
 <000000000000662b4a05e7603e42@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000662b4a05e7603e42@google.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 29, 2022 at 05:17:13AM -0700, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 1045a06724f322ed61f1ffb994427c7bdbe64647
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Wed Jun 29 15:01:02 2022 +0000
> 
>     remove CONFIG_ANDROID
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16ab0893080000
> start commit:   a8ad9a2434dc Merge tag 'efi-urgent-for-v5.16-2' of git://g..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2ebd4b29568807bc
> dashboard link: https://syzkaller.appspot.com/bug?extid=4faa160fa96bfba639f8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=114ae045b00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1785e92bb00000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
> 
> #syz fix: remove CONFIG_ANDROID
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

I really doubt that ext4 has anything to do with the removal of
CONFIG_ANDROID unless the problem here was some of the other crazy RCU
delay issues around this config option.  Glad it's gone...
