Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435A55BCBDA
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Sep 2022 14:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiISMeG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 19 Sep 2022 08:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiISMdx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 19 Sep 2022 08:33:53 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7093019000
        for <linux-ext4@vger.kernel.org>; Mon, 19 Sep 2022 05:33:48 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 28JCXcXp000826
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 08:33:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1663590819; bh=N1QCDqjLcS/TZPt3+bCF6xmnhibzo8MYAJ47mydesL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=HJkLOkQiCT0+bJNwfnbmpH/FEzOQNTKNhGBFlQmp7C+WQ/1HD+uCoiHXcwoN0zXnc
         4ZlN9v4X7f87Ih2Kx0OGxK9rlGQEgqxS+dEcMn8cGUG57O28tqBWleyr5ZGs2YJtdx
         /dmQqoRVokD7FjSID6yb3LCVRVzwVZoZpnvr7wl1daIaSUpU+GqXnRViIY2vFaswGZ
         va5XG5jpNHjh7UK2ItR+ZUmi+IqR+xqPcUlScMV8QYKteVivGd3ylWWKzwFawlZBfQ
         BUF5r9WR4dd+0d0NS5HdpWaw+zcslce9pCNwfo8B1+skY4tZk6MBF5elqx1BbGi9BU
         gUNRkrne98m1w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 1D12E15C526C; Mon, 19 Sep 2022 08:33:38 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     j@bitron.ch, linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] create_inode: do not fail if filesystem doesn't support xattr
Date:   Mon, 19 Sep 2022 08:33:36 -0400
Message-Id: <166359080962.2823380.12377129486041494865.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220818163132.1618794-1-j@bitron.ch>
References: <20220818163132.1618794-1-j@bitron.ch>
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

On Thu, 18 Aug 2022 18:31:32 +0200, Jürg Billeter wrote:
> As `set_inode_xattr()` doesn't fail if the `llistxattr()` function is
> not available, it seems inconsistent to let `set_inode_xattr()` fail if
> `llistxattr()` fails with `ENOTSUP`, indicating that the filesystem
> doesn't support extended attributes.
> 
> 

Applied, thanks!

[1/1] create_inode: do not fail if filesystem doesn't support xattr
      commit: 985b46c55070c62153587e5b18ecb5310706546c

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
