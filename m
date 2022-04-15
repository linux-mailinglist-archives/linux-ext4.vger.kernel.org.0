Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3301A502BE2
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Apr 2022 16:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352586AbiDOObr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 15 Apr 2022 10:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354451AbiDOObr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 15 Apr 2022 10:31:47 -0400
X-Greylist: delayed 795 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 15 Apr 2022 07:29:18 PDT
Received: from mail.urbanec.net (mail.urbanec.net [218.214.117.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62ED1A6E3D
        for <linux-ext4@vger.kernel.org>; Fri, 15 Apr 2022 07:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=urbanec.net
        ; s=dkim_rsa; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References
        :To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=vxDdzzsu7Tz1Y2PbXwfFM98Wg9YkLHJ6JlvMxp2U+PQ=; i=@urbanec.net; t=1650032958
        ; x=1650896958; b=j49xrGtp7OXZEPrybP0htqiMjTI54Y3NTdNJBIRt02S7ktuS/F70K0MQvAd
        CVyr4xKztLeenQ+XawMFJqlfveJdUjQDH/k13qBr4ZngF5ejGxU2GuZus/CB9IfSewZVToNN9ECaG
        s/pyB4WqwTp0OX5DyWVLQcLOQ3KaBNnvIf+UFzNFn7/wNnSRGL9X50Z9WYpi1Z4+X4Z8WOGZU/nJr
        4At0TAr8+oRlnWpvBEQsNrWfiUkyIGrSdapkP7M+qC+RghDAc7P2xYcFiyTexOoakwK45mZNUVat2
        IECAHMc4Fcs6XIawjZnfFAw6Wj+RQqwvgnk/GCIH2vpXq//TiHBg==;
Received: from ten.urbanec.net ([192.168.42.10])
        by mail.urbanec.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <linux-ext4.vger.kernel.org@urbanec.net>)
        id 1nfMwl-0003Pq-Qr
        for linux-ext4@vger.kernel.org; Sat, 16 Apr 2022 00:29:15 +1000
Message-ID: <3c541015-d5c3-b80a-8795-a6d783af3cd5@urbanec.net>
Date:   Sat, 16 Apr 2022 00:29:15 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: resize2fs on ext4 leads to corruption
Content-Language: en-AU
From:   Peter Urbanec <linux-ext4.vger.kernel.org@urbanec.net>
To:     linux-ext4@vger.kernel.org
References: <e2993549-6ce8-dd24-a843-ab41b404e3a0@urbanec.net>
In-Reply-To: <e2993549-6ce8-dd24-a843-ab41b404e3a0@urbanec.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 16/04/2022 00:16, Peter Urbanec wrote:
> In light of recent mailing list traffic, I suspect that the issue may 
> be caused by sparse_super2 .

Or perhaps not. It seems that issue mentioned on the list was specific 
to online resize, whereas I was attempting an offline resize.

Another difference is that in my case the operation appears to have 
completed without any reported errors or warnings on the command line or 
in dmesg.

Just silent data corruption.

I am hoping that the resize is reversible and that the change in size 
from 3,906,946,560 blocks to 5,860,419,840 blocks did not cause 32-bit 
overflows or wraparounds that would result in overwriting data.

     Peter

