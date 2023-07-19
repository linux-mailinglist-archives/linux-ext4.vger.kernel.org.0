Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C037758DD1
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Jul 2023 08:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjGSGcy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 19 Jul 2023 02:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjGSGcx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 19 Jul 2023 02:32:53 -0400
X-Greylist: delayed 598 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 18 Jul 2023 23:32:52 PDT
Received: from mail.lichtvoll.de (luna.lichtvoll.de [194.150.191.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A691FC8;
        Tue, 18 Jul 2023 23:32:52 -0700 (PDT)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 4FB5F747857;
        Wed, 19 Jul 2023 08:22:44 +0200 (CEST)
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     "Alan C. Assis" <acassis@gmail.com>, Theodore Ts'o <tytso@mit.edu>
Cc:     =?ISO-8859-1?Q?Bj=F8rn?= Forsman <bjorn.forsman@gmail.com>,
        Kai Tomerius <kai@tomerius.de>, linux-embedded@vger.kernel.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        dm-devel@redhat.com
Subject: Re: File system robustness
Date:   Wed, 19 Jul 2023 08:22:43 +0200
Message-ID: <4835096.GXAFRqVoOG@lichtvoll.de>
In-Reply-To: <20230718213212.GE3842864@mit.edu>
References: <20230717075035.GA9549@tomerius.de>
 <CAG4Y6eTN1XbZ_jAdX+t2mkEN=KoNOqprrCqtX0BVfaH6AxkdtQ@mail.gmail.com>
 <20230718213212.GE3842864@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Theodore Ts'o - 18.07.23, 23:32:12 CEST:
> If you get it all right, you'll be fine.  On the other hand, if you
> have crappy hardware (such as might be found for cheap in the checkout
> counter of the local Micro Center, or in a back alley vendor in
> Shenzhen, China), or if you do something like misconfigure the file
> system such as using the "nobarrier" mount option "to speed things
> up", or if you have applications that update files in an unsafe
> manner, then you will have problems.

Is "nobarrier" mount option still a thing? I thought those mount options 
have been deprecated or even removed with the introduction of cache flush 
handling in kernel 2.6.37?

Hmm, the mount option has been removed from XFS in in kernel 4.19 
according to manpage, however no mention of any deprecation or removal 
in ext4 manpage. It also does not seem to be removed in BTRFS at least 
according to manpage btrfs(5).

-- 
Martin


