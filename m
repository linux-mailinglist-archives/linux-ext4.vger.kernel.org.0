Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86BF6BDE52
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Mar 2023 02:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjCQBxS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Mar 2023 21:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjCQBxQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Mar 2023 21:53:16 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5ECB3739
        for <linux-ext4@vger.kernel.org>; Thu, 16 Mar 2023 18:53:10 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32H1qlbq031889
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 21:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1679017969; bh=lHdKXc/FDJt0WWkuSj/wlF9gETWp14K7K01kNRsjoRc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=VTPQBF/1gh22bdguDGgSUgDVWlUPw+47EssFY7zlJ54vG058zkyMx8ayV9PY60SWW
         eqPpWjd5u434p5mrwN13vJAT3z8YwdxE7vglWi5qrWmNfs7q7uhhmdeW7G9p0ECzRi
         vieGz4YNaWlzD+n216PpXnIz5XtwyWxNPnsyibsryvJxtyhdasf5CKpPE+IlRiF7MN
         +uIeL9EbQG6RqfYwnTZA9oOBZ3DUUh3r+evhSoVT3EWC3ip6ZPOi0bmZTN1zXTa7L8
         GOLtHxBJNUUHj3fd2rgHYf1IiASXtaI8i5scyt8XwDvNRVEb/NrA5r22R42pAPa8ZB
         xPbJ6ghfjW51Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 248AC15C45B9; Thu, 16 Mar 2023 21:52:47 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, adilger.kernel@dilger.ca
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linfeilong@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Remove unused group parameter in bitmap checksum
Date:   Thu, 16 Mar 2023 21:52:43 -0400
Message-Id: <167901794966.3178390.3572385760525524905.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230221203027.2359920-1-shikemeng@huaweicloud.com>
References: <20230221203027.2359920-1-shikemeng@huaweicloud.com>
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

On Wed, 22 Feb 2023 04:30:23 +0800, Kemeng Shi wrote:
> checksum functions. Each function is cleaned in a separated patch.
> Thanks!
> 
> Kemeng Shi (4):
>   ext4: remove unused group parameter in ext4_inode_bitmap_csum_verify
>   ext4: remove unused group parameter in ext4_inode_bitmap_csum_set
>   ext4: remove unused group parameter in ext4_block_bitmap_csum_verify
>   ext4: remove unused group parameter in ext4_block_bitmap_csum_set
> 
> [...]

Applied, thanks!

[1/4] ext4: remove unused group parameter in ext4_inode_bitmap_csum_verify
      commit: b689b64229af15259db90652b8e99502bbb31078
[2/4] ext4: remove unused group parameter in ext4_inode_bitmap_csum_set
      commit: 96b71c52b744c17dd57b1ae842e878be921d2a80
[3/4] ext4: remove unused group parameter in ext4_block_bitmap_csum_verify
      commit: 2ad044d3a6851cb9755b56a1bcbe1f49e5175399
[4/4] ext4: remove unused group parameter in ext4_block_bitmap_csum_set
      commit: d7214a6a02a0c7447cce55ebf05de5f7c8df9adf

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
