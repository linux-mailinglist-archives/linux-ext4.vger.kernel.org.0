Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBDE736EF8
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Jun 2023 16:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjFTOno (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 20 Jun 2023 10:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbjFTOnn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 20 Jun 2023 10:43:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E48E95;
        Tue, 20 Jun 2023 07:43:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02AA0612A3;
        Tue, 20 Jun 2023 14:43:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C459C433C0;
        Tue, 20 Jun 2023 14:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687272221;
        bh=5hASQGmzbEQeMcvJdKVam0t93XyPTxDj+5xfSR1TM/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ML7lzx4M5d6sI0CMaAQtRga/ceq1vouyimWGj7TH0ku0kBjJ8ZuQ7WCnCT4Rp4AKK
         yzKnA5Cc2a/7Fz07LL3Or2g3fHtpALiUaXlrhxM2ZenOHe24Z7wSe1Ug9JaSKushVY
         fiJTuS7gnL2m1WaW3+78rbE8m9TZTPL21uG/KyH/H+02y9QWfj/d/NkpTy5QjBaxzB
         Yizh108EiWp/hfoE2EXwWdOlfidKyyIbq1hvh+mO9lzzyWlAU9VNhhR7yk8gqAkUlW
         OPEaGiWx1RUOXFRs0WJQjeR0CbRwZWojm6FhuCpPQ5Ofn5yEt9VpsSiOp4XdR6Kc3y
         GmSvVf28H2ZkQ==
Date:   Tue, 20 Jun 2023 10:43:39 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.10 9/9] ext4: enable the lazy init thread when
 remounting read/write
Message-ID: <ZJG7GyeSa2xZ89/H@sashalap>
References: <20230615113917.649505-1-sashal@kernel.org>
 <20230615113917.649505-9-sashal@kernel.org>
 <ZIy60MUrKxit2tNq@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZIy60MUrKxit2tNq@duo.ucw.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jun 16, 2023 at 09:41:04PM +0200, Pavel Machek wrote:
>Hi!
>
>> [ Upstream commit eb1f822c76beeaa76ab8b6737ab9dc9f9798408c ]
>>
>> In commit a44be64bbecb ("ext4: don't clear SB_RDONLY when remounting
>> r/w until quota is re-enabled") we defer clearing tyhe SB_RDONLY flag
>> in struct super.  However, we didn't defer when we checked sb_rdonly()
>> to determine the lazy itable init thread should be enabled, with the
>> next result that the lazy inode table initialization would not be
>> properly started.  This can cause generic/231 to fail in ext4's
>> nojournal mode.
>>
>> Fix this by moving when we decide to start or stop the lazy itable
>> init thread to after we clear the SB_RDONLY flag when we are
>> remounting the file system read/write.
>>
>> Fixes a44be64bbecb ("ext4: don't clear SB_RDONLY when remounting r/w until...")
>>
>> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
>> Link: https://lore.kernel.org/r/20230527035729.1001605-1-tytso@mit.edu
>> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>Normally "Fixes" would be "Fixes:" and in the signed-off block. Plus,
>two consecutive sign-offs from tytso are probably wrong, too.

I'm really not sure what you want us to do here, or in other places
where you've commented about issues with the upstream patch...

-- 
Thanks,
Sasha
