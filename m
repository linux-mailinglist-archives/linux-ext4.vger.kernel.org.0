Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C435501E9
	for <lists+linux-ext4@lfdr.de>; Sat, 18 Jun 2022 04:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383831AbiFRCMa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Jun 2022 22:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383832AbiFRCM3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Jun 2022 22:12:29 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60D36B7E1
        for <linux-ext4@vger.kernel.org>; Fri, 17 Jun 2022 19:12:28 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25I2CFZS005837
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jun 2022 22:12:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1655518336; bh=UVYWoYXMVu0qHK8TfQzTA0frh8dfiQsAKXPPp4/xwr4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=QSQv09bqbWbCF46SQ6tQnHGdnNL2Q1mAIbbOPy2UHLPixnMEOQcFhi35ApU4VvNDz
         b7GOO/uDdxd7dHNQSsLZXNQ/wF6XUmUv/oJhbbLXhwN/0q87WRRqTRWZaJ2fLTHP0q
         FzDgNU0WYT97IJyLm2ACFZP5pL1EE1xDdGaVAEyl9uXDAB8uzXYVwKHbh2autT7OWj
         vfiy2YruZkiBYM2qundrsQyQ41/r3VSdkCRpxbIxQYK92yVbwy1o8PEBPI6mjZMzFr
         rDedyuiBwnMnyGfdw9LesPBo005hHi6MAKfblpgHLkkcLjbUnyOMVKQVcfCXPYOgVv
         jgSTxOg2tWycQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id BC98E15C430D; Fri, 17 Jun 2022 22:12:13 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Shuqi Zhang <zhangshuqi3@huawei.com>, linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca
Subject: Re: [PATCH] ext4: Use kmemdup() to replace kmalloc + memcpy
Date:   Fri, 17 Jun 2022 22:12:09 -0400
Message-Id: <165551818832.612215.11945620005026602155.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220525030120.803330-1-zhangshuqi3@huawei.com>
References: <20220525030120.803330-1-zhangshuqi3@huawei.com>
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

On Wed, 25 May 2022 11:01:20 +0800, Shuqi Zhang wrote:
> Replace kmalloc + memcpy with kmemdup()
> 
> 

Applied, thanks!

[1/1] ext4: Use kmemdup() to replace kmalloc + memcpy
      commit: befabc8759af739ddee843a5113b25a17056b8eb

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
