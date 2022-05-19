Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DA052D183
	for <lists+linux-ext4@lfdr.de>; Thu, 19 May 2022 13:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235135AbiESLc2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 May 2022 07:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiESLcZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 May 2022 07:32:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C4EA7E00
        for <linux-ext4@vger.kernel.org>; Thu, 19 May 2022 04:32:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99190B823E2
        for <linux-ext4@vger.kernel.org>; Thu, 19 May 2022 11:32:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58262C385AA;
        Thu, 19 May 2022 11:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652959941;
        bh=WSNgrScdYVOb8PdRhLZZOPUGsXRXWVNeSAmafVM+6aI=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=UGmFtSrBgYjFe/4zU7wHMc7NBG/UIVMQHNY2OXI++U9C+jtLXDxSco1laf133iBu0
         RU3/xC/xBgohjg3CY/eLKJRfhoPxKmPad3eA1wxTyW0IgfxsS285p9TWtizGSvNTWK
         /Eo++nJC+o9M6L3MTt9vp5L8jziYRQ3zN7th50lg4yMIbvS3kqwAdpVJVIHQjWjEfp
         7ZaD2tPkycWVEfQnoVD6yI/K2CJJjdMCJBtlOpoMwumx0qoP90YK2BjSewtslPh0/+
         ZiNZE7mz7gE611OFqnqErVlJApOnLu90Q2v+2KMhrP3yxCH76l0OHY1nwccbBOFEUz
         Y1Lxm5if0EOPA==
Message-ID: <86fa68bb-e80d-7fc1-a96e-18595e02247d@kernel.org>
Date:   Thu, 19 May 2022 19:32:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [f2fs-dev] [PATCH v5 2/8] f2fs: Simplify the handling of cached
 insensitive names
Content-Language: en-US
From:   Chao Yu <chao@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org, ebiggers@kernel.org
Cc:     linux-ext4@vger.kernel.org, kernel@collabora.com,
        linux-f2fs-devel@lists.sourceforge.net
References: <20220518172320.333617-1-krisman@collabora.com>
 <20220518172320.333617-3-krisman@collabora.com>
 <fb8aaa09-7bfd-7e2a-4cb1-de691fdb6408@kernel.org>
In-Reply-To: <fb8aaa09-7bfd-7e2a-4cb1-de691fdb6408@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2022/5/19 19:27, Chao Yu wrote:
> On 2022/5/19 1:23, Gabriel Krisman Bertazi wrote:
>> Keeping it as qstr avoids the unnecessary conversion in f2fs_match
>>
>> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> Reviewed-by: Chao Yu <chao@kernel.org>

Oh, this should be replied to v6, sorry.

Thanks,

> 
> Thanks,
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
