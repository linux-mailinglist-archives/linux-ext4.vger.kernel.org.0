Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5EA6BDE4D
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Mar 2023 02:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjCQBxD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Mar 2023 21:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjCQBxB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Mar 2023 21:53:01 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA11217CFA
        for <linux-ext4@vger.kernel.org>; Thu, 16 Mar 2023 18:52:59 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32H1qlvr031884
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 21:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1679017968; bh=45PCY2zTAYeGGKl1FEAR2DfbnIDsd/p3zPEBRZE0IFU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YLgNEQlO/+T/yzxrekTbJMeT+QP0WvN2eH5KMxcjuBwhOeHD/dxXKvIKML/MZdP4Q
         ELtWSdQA7cchlt92u5hu5WBkhGT1dwfUGwEAWVA8n64kYneU+sfPrX2MNnY/xpEDE1
         GB1zvKdidRqZdPuzjthsafTCp6SAuvKuc5HhrUZmsQcja8FTDje0HD2wFfc8xMhK5l
         BzTU6Mg7fti8Dnv6vkMHR2IU+Ed+YTgiqfEvCJ9FTfv6VW4ag34XwfJMhGGrEu/LMT
         AcHoLY+wsX2eHRdPLQ/S2mEoyuQSnHZ2TZn/IiQbQXcAn9SrfBuabOMtZPOZO7Rx/W
         RGYfAs1tx4MyA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 22CAA15C33A7; Thu, 16 Mar 2023 21:52:47 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, adilger.kernel@dilger.ca
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] two cleanups for mballoc
Date:   Thu, 16 Mar 2023 21:52:42 -0400
Message-Id: <167901794966.3178390.7391810428387521171.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230311170949.1047958-1-shikemeng@huaweicloud.com>
References: <20230311170949.1047958-1-shikemeng@huaweicloud.com>
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

On Sun, 12 Mar 2023 01:09:47 +0800, Kemeng Shi wrote:
> pointer dereference. Thanks!
> 
> Kemeng Shi (2):
>   ext4: fix typos in mballoc
>   ext4: avoid unnecessary pointer dereference in
>     ext4_mb_normalize_request
> 
> [...]

Applied, thanks!

[1/2] ext4: fix typos in mballoc
      commit: dac2da4882d847ed83155c2809e93bc2348677c8
[2/2] ext4: avoid unnecessary pointer dereference in ext4_mb_normalize_request
      commit: e15eeffe99e11512e658f19af7952a57aede8915

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
