Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23B059EDD9
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Aug 2022 22:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiHWU6b (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 23 Aug 2022 16:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiHWU6a (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 23 Aug 2022 16:58:30 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC802D59
        for <linux-ext4@vger.kernel.org>; Tue, 23 Aug 2022 13:58:27 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-49-209-117.bstnma.fios.verizon.net [108.49.209.117])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 27NKwNsU013428
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Aug 2022 16:58:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1661288304; bh=PTTm42py41yQoEsLkKxWO4eb77BAB9nCF5K8wc3FaQ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=iZ6TFj2gJCQ/9OTzghc+ir5VBXHHNNfmG0h9xAR0KPuayfVvHB7kZxzKpDs4k/RPb
         OCksfSi+NmAXb8tqEJOwpIAXLVLA0EiXlm6TEy9QhFcgqJGqB7cJbiG+qR88XdlFnL
         GA2kPcf7DiUJPahGTOhKgq3vkzSsbcs0sqAcQhRcmjuIwH+tSGfgyU5lO+PX0Cr0oO
         /FCSp6dCp33M0+/gQPQynSetVa1cDy4YnTTKz4yGJPIOGOkR0fjVx96zWcDTui3IPy
         omEheGFxrkUUxQPF8ktqIafzY3nZ8MismYJoLItBIC29tc/ryD/r8M7lPyrLT46oF9
         7fRjMd563b6tw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4F10815C3EC2; Tue, 23 Aug 2022 16:58:23 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     bongiojp@gmail.com
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v4] tune2fs: Add support for get/set UUID ioctls.
Date:   Tue, 23 Aug 2022 16:58:21 -0400
Message-Id: <166128823287.2407454.16231141308595218283.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220816205214.145632-1-bongiojp@gmail.com>
References: <20220816205214.145632-1-bongiojp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, 16 Aug 2022 13:52:14 -0700, Jeremy Bongio wrote:
> When mounted, there is a race condition between changing the filesystem
> UUID and changing other aspects of the filesystem, like mounting, resizing,
> changing features, etc. Using these ioctls to get/set the UUID ensures the
> filesystem is not being resized.
> 
> 

Applied, thanks!  I made a few changes for non-Linux portability, and
to handle some error cases correctly.  Also your patch wasn't setting
old_uuid from the value returned from the ioctl, which I fixed up.

	      	  		      	  - Ted

[1/1] tune2fs: Add support for get/set UUID ioctls.
      commit: a83e199da0ca954f7f0d63756d6eea108caf107f

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
