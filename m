Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF97550237
	for <lists+linux-ext4@lfdr.de>; Sat, 18 Jun 2022 04:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237595AbiFRC7S (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Jun 2022 22:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238004AbiFRC7R (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Jun 2022 22:59:17 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EC26C0EF;
        Fri, 17 Jun 2022 19:59:16 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25I2x6BT024034
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jun 2022 22:59:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1655521148; bh=BRqgLdHljqKpZjJgp3EqbU/vGhT+05lRwXWHMn2SqUI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=OIDsf4GJgl4nSDq+tmMnEda6VPwuEf2cpcwMXLtgq5JBXeWufkz/mAKO/L+PoCaL4
         NkN1ZpDP0hmTMzYvxiEXk+HLxO/OK0iMyeFRwAz3pfRsfeXzTUht1MJ0qRDsGvm3x8
         y2yXHtFttOTR4xkJRf5TS/3EMSvIYx3Sh6b2bsBFRGDJhdqslI7axnW0dnshxVOVlE
         PsIEwau6kaWD8Ce9qpsgFVQQiPDW0XAmCarKXhWtjh2WQ7t9ryCnqvqq+qMZe4D5cn
         5PvWYujp51m6t4TePMuwVC9hwHejycwJhxcLrcQqeAuBlR5LbFLdz8qCaSB9N8LZzs
         ICcQpKoh0oaLA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4B9E515C42F4; Fri, 17 Jun 2022 22:59:06 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Xiang wangx <wangxiang@cdjrlc.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/ext4: Fix syntax errors in comments
Date:   Fri, 17 Jun 2022 22:59:02 -0400
Message-Id: <165552108974.634564.10372518530279275547.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220605091503.12513-1-wangxiang@cdjrlc.com>
References: <20220605091503.12513-1-wangxiang@cdjrlc.com>
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

On Sun, 5 Jun 2022 17:15:03 +0800, Xiang wangx wrote:
> Delete the redundant word 'need'.
> 
> 

Applied, thanks!

[1/1] fs/ext4: Fix syntax errors in comments
      commit: 729e657ab8d41efc2eadbb686193e888660b6253

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
