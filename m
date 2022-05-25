Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB25453442B
	for <lists+linux-ext4@lfdr.de>; Wed, 25 May 2022 21:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242311AbiEYTZc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 May 2022 15:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiEYTZb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 May 2022 15:25:31 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9F84ECE9;
        Wed, 25 May 2022 12:25:29 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24PJPCbN030886
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 May 2022 15:25:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1653506714; bh=OnXWsH0KWhFR2CBSPJf7kxxHPHIm6ghnSNExF+FDp1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=kK5CMkE2hlcYZIQUEUKIeYW0uYn6heYprAWDpQE3sHKXRb6fUavex08kK71cnhmrv
         YOLGt8W/HL6yePpqOev8szvEq0YIWqWBMahpadGVW9+AabyH/ylRckLza6NGBiejnf
         ZpETaFsZs50x9uQFjzVPezq9tpbZdQd9xC4YgeWIvpWUKMMQr1U+sFWRuoFZWDV3Pj
         JY57W713QPorpdRTMmuHTHe6O8g48+3Fvi3Ccz7Ib2AqvOBlINXHuNywkIOE0ILBvo
         x37VdVM8oazk5F63EVrUNostAyJXxf8lOPDTERqAAIFlE5G8D3NF6W9/oihAdvfxa+
         G/Lc3DLtxcl/w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3F96F15C3399; Wed, 25 May 2022 15:25:12 -0400 (EDT)
Date:   Wed, 25 May 2022 15:25:12 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Joe Perches <joe@perches.com>
Cc:     Yu Zhe <yuzhe@nfschina.com>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com
Subject: Re: [PATCH] ext4: add KERN_<LEVEL> for printk()
Message-ID: <Yo6CmMYr2vBBO+Ks@mit.edu>
References: <20220525124816.86915-1-yuzhe@nfschina.com>
 <fa2a3a8041b9d814654f0dae4607e1a2f20d333d.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa2a3a8041b9d814654f0dae4607e1a2f20d333d.camel@perches.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 25, 2022 at 08:18:22AM -0700, Joe Perches wrote:
> On Wed, 2022-05-25 at 05:48 -0700, Yu Zhe wrote:
> > printk() should include KERN_<LEVEL> facility level, add them.
> 
> NACK.
> 
> checkpatch is just a guide.

checkpatch-only patches are something which I will tend to just
ignore.  (Even if the changes are correct, which they are not in this
case).

In addition to all of the other reasons why such drive-by checkpatch
patches are frowned upon, I would appreciate it if the code paths that
are changed are actually *tested*, at which point you might have
noticed that your changes werenn't doing the right thing.

(BTW I'll also note that the code involved that is almost never
enabled --- the developer would need to manually insert a "#define
DX_DEBUG" at the beginning of the fs/ext4/namei.c source file for the
code to be enabled.  It's only intended to be used by developers who
are doing surgery to the htree code.)

					- Ted
