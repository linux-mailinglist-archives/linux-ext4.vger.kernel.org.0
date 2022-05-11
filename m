Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D300352357A
	for <lists+linux-ext4@lfdr.de>; Wed, 11 May 2022 16:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235855AbiEKO32 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 May 2022 10:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244709AbiEKO3W (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 May 2022 10:29:22 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D489C5E42;
        Wed, 11 May 2022 07:29:18 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24BET0xf015006
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 10:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1652279342; bh=LIsy1MxkN1edbrF9r2Elq6kSBC8nuw+qriYfhUMLLwc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=YAy+aaJ9kAZGF+J3ys0yjJ1lHH+jEiq0KYuom1MnTvPMPKm/UsJ3+AJ055xD157Br
         ktvKRL5Oh6x1pCAmHYxWOahpNuZbz+0F2jZ8s+RD/Ch6JWxem6qzioDblwxyUS3rVT
         sQMc5yUfLvmf6fEd63Pl1dd2sNmatrXWeIbs7kxoFlVIQnncoozi+z6dVXqcVUkZch
         hVw7DHKlUtOU9DOzjNe5H6j66eqrKkKAexLal3PSJE4pXvaPolNt8MhOJj3OTDOABd
         YyHO5+EwTuXl5HvLgCOKkJBJsdkgb3TwzhGCw+OukebqTCbmTsblbouLEm/+U62Wab
         t4yq9o8myQJQg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 75F6815C3F0C; Wed, 11 May 2022 10:29:00 -0400 (EDT)
Date:   Wed, 11 May 2022 10:29:00 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ye Bin <yebin10@huawei.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, jack@suse.cz
Subject: Re: [PATCH -next v2] ext4: fix warning in ext4_handle_inode_extension
Message-ID: <YnvILNu+S9KvET0P@mit.edu>
References: <20220510122545.1770410-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510122545.1770410-1-yebin10@huawei.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

As I mentioned in the other thread, I decided to take the v1 version
of this patch.

Thanks,

					- Ted
