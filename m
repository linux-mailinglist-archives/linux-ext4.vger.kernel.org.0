Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C53F5F033C
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Sep 2022 05:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiI3DVF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Sep 2022 23:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiI3DUj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Sep 2022 23:20:39 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7687946857;
        Thu, 29 Sep 2022 20:20:11 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 28U3JoRw002480
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 23:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1664507991; bh=E4TGpfDvPfEvqhTbdO0NtQ5/bhv79PLogXliI1Q3H1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=RlfgJVn5nGHN4UBXLmAS0KAyBF3OxAH+VmWopLTNGkZKYb82vHl3p5r6Uc/9cXOBc
         t+wCCmZoU1I2JnBVKpjSTrt3nXZMah1jfObPgxYm94yiflfPyU0IaJi9PrayPFEdqo
         8pyTBnIReT9ItQ+t18EBB8dQ4wUqiK2013coK4yptSL6roBNSIN+7EQHHocaUyZNPt
         5trW/fO54BDuTH1tutupyrc1ZYnXl+TUpAk3x/XAM3Qo/0ApSsAn58OHzuczNfSfDK
         /+zzaDvGiSc1HFpPH2y6tAHxm8Fdsq+YEJxjIo8wkGQhhimb/3EYfQYZgcqPGBHD6S
         NZL6aCZ0DgZlQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9ED1415C35F1; Thu, 29 Sep 2022 23:19:47 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        yebin10@huawei.com
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH -next v2 0/2] ext4: factor out ext4_free_ext_path()
Date:   Thu, 29 Sep 2022 23:19:43 -0400
Message-Id: <166450797717.256913.9601456605503921263.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220924021211.3831551-1-yebin10@huawei.com>
References: <20220924021211.3831551-1-yebin10@huawei.com>
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

On Sat, 24 Sep 2022 10:12:09 +0800, Ye Bin wrote:
> Diff v2 vs v1:
> 1. Add one patch to remove unnecessary drop path references in
> mext_check_coverage().
> 2. Make 'ext4_ext_drop_refs()' static in fs/ext4/extents.c.
> 3. Export non-inline 'ext4_free_ext_path()' API.
> 
> Ye Bin (2):
>   ext4: remove unnecessary drop path references in mext_check_coverage()
>   ext4: factor out ext4_free_ext_path()
> 
> [...]

Applied, thanks!

[1/2] ext4: remove unnecessary drop path references in mext_check_coverage()
      commit: cc984fd387b5258fa9eb96811796e4bcadc2b272
[2/2] ext4: factor out ext4_free_ext_path()
      commit: 6863dc4b094249163172691f09a91c28f36ee824

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
