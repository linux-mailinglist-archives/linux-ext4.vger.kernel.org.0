Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915F877D8D9
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Aug 2023 05:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjHPDLB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Aug 2023 23:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241503AbjHPDKz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Aug 2023 23:10:55 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BA6FE
        for <linux-ext4@vger.kernel.org>; Tue, 15 Aug 2023 20:10:54 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-114-154.bstnma.fios.verizon.net [173.48.114.154])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37G3Aiqv005969
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 23:10:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692155446; bh=VMyDOCA6x1n1DorlJYq2FkviTTLMx0hstGLQi6WdJsg=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=iGYeMbBjWpvw63/G2NS90p/dUcEl0NNBkcgtnlmMr/6cPeG0GTqr+ueU/5vKtByP5
         MtxhVqR6QcxltT7LYWQRdVr9u6JHWHnWn5Ujy4ZEpw1x4eLfqBiVUXSvKZvlbGIABb
         tIEUciQvddVst9ziOrjSqlXExlWeUHz78hYKKBmFfB2gU4TfHaaU5k7+2mTVes+Uo0
         hZ+hV4oN9KnPK0bI4nnOwtphr3JdzS2OM98U2moCCWCUm7mX7pzoL5eZgJA0bwkuSk
         gcPjsonzfe+2p0XCZVqhFT2Sab0SzoCKy+EXaTY11PgjTUhMw0jco8HRr5pYFAZpWg
         zap/zdQxOLW7w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4835015C0292; Tue, 15 Aug 2023 23:10:44 -0400 (EDT)
Date:   Tue, 15 Aug 2023 23:10:44 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/13] ext4: fix typo in setup_new_flex_group_blocks
Message-ID: <20230816031044.GM2247938@mit.edu>
References: <20230629120044.1261968-1-shikemeng@huaweicloud.com>
 <20230629120044.1261968-6-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629120044.1261968-6-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jun 29, 2023 at 08:00:36PM +0800, Kemeng Shi wrote:
> grop -> group
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
