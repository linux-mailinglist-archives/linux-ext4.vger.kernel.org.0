Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84C550628B
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Apr 2022 05:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiDSDVg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Apr 2022 23:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbiDSDVf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Apr 2022 23:21:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7BF2656A;
        Mon, 18 Apr 2022 20:18:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A85EB8113A;
        Tue, 19 Apr 2022 03:18:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0840C385A7;
        Tue, 19 Apr 2022 03:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650338332;
        bh=n0VqmNp9Q/CWVDkX0UhhbO6xIAM/hOOSr1ptOPIdeoY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T/5WGBYlFp1gL2NKjukwwcRZ+bGenghfSir5xlz/lAF4nZAnqZWutAXfz9wAtVvzi
         DkuZEd0YZvOg3WoSnFIju4ScMq3nDqvNCcmfDMLtxXoDlMB8i9SinvpdQX0Vrzg4qX
         aBPaFwK47os5qhDOckOle3ldkuX35gNUN8FsqAHP0je0LnpCfyCZYOS/pKLo2dySIF
         UjBJRkaTo5RKM3QZEuTQnn6hfX2h0WjPE0JVrZl6cgESLIrhUfHNR4gWPWstl7Y7Js
         fgow71CxnmQCDuNj+cIbs+Y14N8iKvYHdOxP8wUe+ENpFPs7yXQ0xiQjZxo6gDhwjt
         5wz5NjOWC+10Q==
Date:   Mon, 18 Apr 2022 20:18:50 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     =?utf-8?B?5bi45Yek5qWg?= <changfengnan@vivo.com>
Cc:     "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "chao@kernel.org" <chao@kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: [PATCH 2/3] f2fs: notify when device not supprt inlinecrypt
Message-ID: <Yl4qGkrfMT7FqbJj@sol.localdomain>
References: <20220418063312.63181-1-changfengnan@vivo.com>
 <20220418063312.63181-2-changfengnan@vivo.com>
 <Yl0RmUoZypbVmayj@sol.localdomain>
 <KL1PR0601MB400369725474F2A2DE647057BBF39@KL1PR0601MB4003.apcprd06.prod.outlook.com>
 <Yl3lxMnZ5teL+bkU@sol.localdomain>
 <KL1PR0601MB4003A659B51814320E156C35BBF29@KL1PR0601MB4003.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <KL1PR0601MB4003A659B51814320E156C35BBF29@KL1PR0601MB4003.apcprd06.prod.outlook.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Apr 19, 2022 at 03:14:51AM +0000, 常凤楠 wrote:
> 
> Thanks for your explanation, this patchset has too many case to forget to handle...
> Back to my first thought, maybe there should have one sysfs node to indicate the 
> device support inlinecrypt or not ? So user can know it's device not support inlinecrypt
> and not for other reasons.
> 

Linux v5.18 has that.  See https://git.kernel.org/linus/20f01f1632036660
("blk-crypto: show crypto capabilities in sysfs").

- Eric
