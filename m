Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22E375CAA6
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jul 2023 16:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjGUOvk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Jul 2023 10:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbjGUOvj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 Jul 2023 10:51:39 -0400
Received: from mail.lichtvoll.de (lichtvoll.de [IPv6:2001:67c:14c:12f::11:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBEC171A;
        Fri, 21 Jul 2023 07:51:34 -0700 (PDT)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id E2FE274C065;
        Fri, 21 Jul 2023 16:51:31 +0200 (CEST)
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     "Alan C. Assis" <acassis@gmail.com>,
        =?ISO-8859-1?Q?Bj=F8rn?= Forsman <bjorn.forsman@gmail.com>,
        Kai Tomerius <kai@tomerius.de>, linux-embedded@vger.kernel.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        dm-devel@redhat.com
Subject: Re: Nobarrier mount option (was: Re: File system robustness)
Date:   Fri, 21 Jul 2023 16:51:31 +0200
Message-ID: <4918028.0VBMTVartN@lichtvoll.de>
In-Reply-To: <20230721133526.GF5764@mit.edu>
References: <20230717075035.GA9549@tomerius.de> <38426448.10thIPus4b@lichtvoll.de>
 <20230721133526.GF5764@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Theodore Ts'o - 21.07.23, 15:35:26 CEST:
> > At least that is what I thought was the background for not doing the
> > "nobarrier" thing anymore: Let the storage below decide whether it
> > is safe to basically ignore cache flushes by answering them (almost)
> > immediately.
> 
> The problem is that the storage below (e.g., the HDD) has no idea that
> all of this redundancy exists.  Only the system adminsitrator who is
> configuring the file sysetm will know.  And if you are runninig a
> hyper-scale cloud system, this kind of custom made system will be
> much, MUCH, cheaper than buying a huge number of $$$ EMC storage
> arrays.

Okay, that is reasonable.

Thanks for explaining.

-- 
Martin


