Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E7A5F0333
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Sep 2022 05:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiI3DUr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Sep 2022 23:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiI3DU3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Sep 2022 23:20:29 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688333ED71;
        Thu, 29 Sep 2022 20:20:06 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 28U3JoMh002481
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 23:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1664507991; bh=nODvBAAR4NIIGni1Zz1GRLzy8lqAVy9Tx3JrIlPQU04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=elE0Yr0g45a9wMHNJjPTOj1Hmg6Yf15LPr1MeCyI+4rD+mi84N9r2tpny8YHQGzMk
         9sAc+2Mz52erQRtUXYG5Miz0m+TSnYStUnZ1JjvziACmOwSzrHpzu/C6ZLYycK+SKj
         s4gXE7qZJWjHBQ/pmeS4Iyw7Hrfxx9O4+BYnx7VYNwYFeYhdSzPE8aDj+gHKubEcc8
         dxXD+F5WCdzsPf2TMrA1uA3v8hPsvSsvT6sM2rbbHj3nzEppVM+BKld5rrinjXw5Kx
         n55xfed1b/cc7lTy3/bVLfSg1Xmm0cpCbvzkyNzoNPvS+wHIPlTxpYOiTaOXArs2PE
         Q/zbbhaGY+/rg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9B36115C3537; Thu, 29 Sep 2022 23:19:47 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        yebin10@huawei.com
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH -next] ext4: fix miss release buffer head in ext4_fc_write_inode
Date:   Thu, 29 Sep 2022 23:19:41 -0400
Message-Id: <166450797716.256913.1001942998286788649.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220914100859.1415196-1-yebin10@huawei.com>
References: <20220914100859.1415196-1-yebin10@huawei.com>
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

On Wed, 14 Sep 2022 18:08:59 +0800, Ye Bin wrote:
> In 'ext4_fc_write_inode' function first call 'ext4_get_inode_loc' get 'iloc',
> after use it miss release 'iloc.bh'.
> So just release 'iloc.bh' before 'ext4_fc_write_inode' return.
> 
> 

Applied, thanks!

[1/1] ext4: fix miss release buffer head in ext4_fc_write_inode
      commit: 4937c59dc3958303e35f68fd345a4e063b39c20f

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
