Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B4F5EF82C
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Sep 2022 16:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbiI2O6k (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Sep 2022 10:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234945AbiI2O6i (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Sep 2022 10:58:38 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2446D13F290;
        Thu, 29 Sep 2022 07:58:36 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 28TEwTEb008318
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 10:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1664463511; bh=kdsxJvgi7Z8/d9oueJIFBEjNALhXgg3ruarZnEnehrY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=COht9PJ4BJQDNwPNYvPM8Bvont3qq9pLG0odXK4ol21BfmGp9iDAvWtJonhnHoJAx
         PR3elX84tfCEc2eGfSqVUMPvx9iI2DJLWrQCqxTIbEnGRHBcUQ7NkX5BVnWZSLIuS6
         nqW7YNdZ/b2tyk/z6zOcJeGCua9w6K/MTPHZdJG3RhS8ZJ07eFbdB/wyc4vQkmtZmT
         34IbVgh0BdrKkoMJp28WoEW2lmTrt2aHNpWFEs/i8v4lvwatYqjH1fs5NTbiqWyUrO
         Ibk8f9/P/RCxBqzC4ZxbzgEreNZAys2D/PaiUuSEec9XFxktVOHnn5xydw1WRhyOOh
         NZDUJg1NfGvBQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 76FB015C33A3; Thu, 29 Sep 2022 10:58:29 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     dilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, lalithkraj@google.com
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] ext4: Make ext4_lazyinit_thread freezable.
Date:   Thu, 29 Sep 2022 10:58:24 -0400
Message-Id: <166446350043.149484.7219600189854097903.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220818214049.1519544-1-lalithkraj@google.com>
References: <20220818214049.1519544-1-lalithkraj@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, 18 Aug 2022 21:40:49 +0000, Lalith Rajendran wrote:
> ext4_lazyinit_thread is not set freezable. Hence when the thread calls
> try_to_freeze it doesn't freeze during suspend and continues to send
> requests to the storage during suspend, resulting in suspend failures.
> 
> 

Applied, thanks!

[1/1] ext4: Make ext4_lazyinit_thread freezable.
      commit: 5442d7d5073d1500c542ac0f2c881b738b1ef3a5

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
