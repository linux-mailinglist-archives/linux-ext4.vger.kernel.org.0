Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D6077FC7B
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Aug 2023 19:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236267AbjHQRGN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Aug 2023 13:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353843AbjHQRGK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Aug 2023 13:06:10 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6622D7D
        for <linux-ext4@vger.kernel.org>; Thu, 17 Aug 2023 10:06:05 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-102-95.bstnma.fios.verizon.net [173.48.102.95])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37HH5w3B020705
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 13:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692291959; bh=i2xRZn3Tx5EqaAX7RnSdM0NOcmaNgFf/4Gi3GzQ45x8=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=EUITG7yrf49tMXw3vJ1GViMu1+Ybf/QrOJVtCuHLo7pIv2KF4TDRURuVV987IX7v5
         0vcUSTBp4Sts5F3BzmVf7p95ZR1L0jCC+PbAFJ5oWEvOg9tpRCkJJJdY//JTM4O9jM
         YnJn0h24MpsKgt9lfCXdRY7skdzr+9QCOYWH4mE9HIXXNt1wZTrSGVmNypPvUs5cFI
         U+Q+ziN86/Mke7H6pLD5SXcgH/H2P3cyAqgNw5EoxB5lOucfknOw3NH+2qkV7UkBQw
         N83FMt7rEV0KhTjfdoW4DWAFVkeog14bnsKJxbHIgUTTw4c93Cq/wPZV0anDpDrXgn
         8nTxHBUM2ANNg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id EF51E15C0501; Thu, 17 Aug 2023 13:05:57 -0400 (EDT)
Date:   Thu, 17 Aug 2023 13:05:57 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Wang Jianjian <wangjianjian0@foxmail.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 2/2] ext4: Add correct group descriptors and reserved GDT
 blocks to system zone
Message-ID: <20230817170557.GA3435781@mit.edu>
References: <tencent_D744D1450CC169AEA77FCF0A64719909ED05@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_D744D1450CC169AEA77FCF0A64719909ED05@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Aug 03, 2023 at 12:28:40AM +0800, Wang Jianjian wrote:
> When setup_system_zone, flex_bg is not initialzied so it is always 1.
> ext4_num_base_meta_blocks() returns the meta blocks in this group
> including reserved GDT blocks, so let's use this helper.
> 
> Signed-off-by: Wang Jianjian <wangjianjian0@foxmail.com>

Thanks for the patch.  I ended up collapsing the two patches into a
single one, and then fixed up some checkpatch errors.

       	    	     	      	   - Ted
